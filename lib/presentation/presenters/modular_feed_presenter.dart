import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mesa_news/domain/entity/post_entity.dart';
import 'package:mesa_news/domain/helpers/domain_error.dart';
import 'package:mesa_news/domain/usercases/load_posts.dart';
import 'package:mesa_news/infra/http/base_data.dart';
import 'package:mesa_news/ui/helpers/filter_period.dart';
import 'package:mesa_news/ui/helpers/timer_converter.dart';
import 'package:mesa_news/ui/helpers/ui_errors.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';
import 'package:mesa_news/ui/pages/feed/post_viewmodel.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'mixins/mixin_modular_loading_stream.dart';

class ModularFeedPresenter extends Disposable with ModularLoadingStream implements FeedPresenter {
  final LoadPosts loadPosts;

  ModularFeedPresenter({@required this.loadPosts});

  List<PostViewModel> highlightsPosts = [];

  bool isGettingMoreItemsThemes = false;
  bool isMoreItemsThemesAvailable = true;
  int numberItemsForPage = 20;
  int numberCurrentPage = 1;
  int _numberOfRequestsEmpty = 0;

  final _postViewModelList = BehaviorSubject<List<PostViewModel>>.seeded([]);
  Stream<List<PostViewModel>> get outPostViewModelList => _postViewModelList.stream;

  final _favoriteFilter = BehaviorSubject<bool>.seeded(false);
  Sink<bool> get inFavoriteFilter => _favoriteFilter.sink;
  Stream<bool> get outFavoriteFilter => _favoriteFilter.stream;
  bool get getFavoriteFilter => _favoriteFilter.valueWrapper.value;

  final _periodFilter = BehaviorSubject<FilterPeriod>.seeded(FilterPeriod.all);
  Sink<FilterPeriod> get inPeriodFilter => _periodFilter.sink;
  Stream<FilterPeriod> get outPeriodFilter => _periodFilter.stream;
  FilterPeriod get getPeriodFilter => _periodFilter.valueWrapper.value;

  // TODO: false a logica dos filtros

  Future<void> _loadPostsHighlights() async {
    try {
      final _listPostHighlights = await loadPosts.load(makeApiNewsUrl('news/highlights'));
      highlightsPosts = _requestDataModel(_listPostHighlights);
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        _postViewModelList.addError(UIError.sessionExpired);
      } else {
        _postViewModelList.addError(UIError.unexpected);
      }
    }
  }

  String _periodQuery() {
    DateTime dateTimeResult;
    // TODO: Em uso real deve ser: dateTimeNow = DateTime.now()
    final dateTimeNow = DateTime(2020, 07, 9); // SIMULACAO

    if (getPeriodFilter == FilterPeriod.all)
      return '';
    else if (getPeriodFilter == FilterPeriod.thisWeek)
      dateTimeResult = DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 7);
    else if (getPeriodFilter == FilterPeriod.lastWeek)
      dateTimeResult = DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 14);
    else if (getPeriodFilter == FilterPeriod.thisMonth)
      dateTimeResult = DateTime(dateTimeNow.year, dateTimeNow.month - 1, dateTimeNow.day);

    return DateFormat('y/MM/dd').format(dateTimeResult);
  }

  String _queryPaginationManager(String base) {
    String resultQuery = '$base?current_page=$numberCurrentPage&per_page=$numberItemsForPage';

    String publishedAtText = _periodQuery();

    if (publishedAtText != '') resultQuery = resultQuery + '&published_at=$publishedAtText';
    return resultQuery;
  }

  Future<void> loadData() async {
    try {
      inIsLoading.add(true);
      await _loadPostsHighlights();

      final _listPosts = await loadPosts.load(makeApiNewsUrl(_queryPaginationManager('news')));

      _postViewModelList.sink.add(_requestDataModel(_listPosts));
      numberCurrentPage = 1;
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        _postViewModelList.addError(UIError.sessionExpired);
      } else {
        _postViewModelList.addError(UIError.unexpected);
      }
    } finally {
      inIsLoading.add(false);
    }
  }

  void _addPostsForListInfinity(List<PostViewModel> newListItems) {
    if (newListItems == null) return;

    List<PostViewModel> listItems = List.from(_postViewModelList.valueWrapper.value);
    listItems.addAll(newListItems);
    _postViewModelList.sink.add(listItems);
  }

  Future<bool> loadNextPageData() async {
    try {
      bool isLimitOfRequestsReached = _numberOfRequestsEmpty > 3;
      int currentListLength = _postViewModelList.valueWrapper.value.length;

      if (!isMoreItemsThemesAvailable ||
          isGettingMoreItemsThemes ||
          currentListLength < numberItemsForPage ||
          isLimitOfRequestsReached) {
        // Quando não há mais posts disponiveis
        debugPrint("!isMoreItemsThemesAvailable: ${!isMoreItemsThemesAvailable}");
        debugPrint("isGettingMoreItemsThemes: $isGettingMoreItemsThemes");
        debugPrint(
            "currentListLength ($currentListLength) < numberItemsForPage ($numberItemsForPage): ${currentListLength < numberItemsForPage}");
        debugPrint("isLimitOfRequestsReached: $isLimitOfRequestsReached");

        debugPrint("Não há mais posts para baixar");
        return true;
      }
      numberCurrentPage++;
      isGettingMoreItemsThemes = true;

      final listNewPosts = await loadPosts.load(makeApiNewsUrl(_queryPaginationManager("news")));

      if (listNewPosts.isEmpty) {
        _addPostsForListInfinity([]);
        isGettingMoreItemsThemes = false;
        debugPrint("Foi retornado dados via cache. Retorno negado!");
        return false;
      }

      bool hasItems = listNewPosts.length > 0;

      if (!hasItems) {
        if (currentListLength == 0 || currentListLength % numberItemsForPage == 0) {
          isGettingMoreItemsThemes = isLimitOfRequestsReached;
          _numberOfRequestsEmpty++;
        } else
          isGettingMoreItemsThemes = currentListLength < numberItemsForPage;

        debugPrint("Não foi possível retornar dados. Retorno vazio.");
        return false;
      }

      _numberOfRequestsEmpty = 0;

      isMoreItemsThemesAvailable = listNewPosts.length == numberItemsForPage;

      _addPostsForListInfinity(_requestDataModel(listNewPosts));

      isGettingMoreItemsThemes = false;

      debugPrint("Foram recebidos ${listNewPosts.length} novos itens");
      return true;
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        _postViewModelList.addError(UIError.sessionExpired);
      } else {
        _postViewModelList.addError(UIError.unexpected);
      }
      return false;
    }

    //TODO: Descomentar esse tratamento de erros acima
  }

  List<PostViewModel> _requestDataModel(List<PostEntity> listData) => listData
      .map((post) => PostViewModel(
            title: post.title,
            imageUrl: post.imageUrl,
            content: post.content,
            author: post.author,
            description: post.description,
            highlight: post.highlight,
            url: post.url,
            relativePublishedAt:
                TimeConvert.convertTimeStampToString(post.publishedAt.millisecondsSinceEpoch, 'pt')['msg'],
            publishedAt: DateFormat('dd/MM/y hh:mm').format(post.publishedAt),
          ))
      .toList();

  @override
  void dispose() {
    _postViewModelList?.close();
    _periodFilter?.close();
    _favoriteFilter?.close();

    loadingDispose();
  }
}
