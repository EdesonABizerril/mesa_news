import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mesa_news/domain/helpers/domain_error.dart';
import 'package:mesa_news/domain/usercases/load_posts.dart';
import 'package:mesa_news/domain/usercases/load_posts_highlights.dart';
import 'package:mesa_news/ui/helpers/ui_errors.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';
import 'package:mesa_news/ui/pages/feed/post_viewmodel.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'mixins/mixin_modular_loading_stream.dart';

class ModularFeedPresenter extends Disposable with ModularLoadingStream implements FeedPresenter {
  final LoadPosts loadPosts;
  final LoadPostsHighlights loadPostsHighlights;

  ModularFeedPresenter({@required this.loadPosts, @required this.loadPostsHighlights});

  @override
  List<PostViewModel> highlightsPosts = [];

  final _postViewModelList = BehaviorSubject<List<PostViewModel>>.seeded([]);
  @override
  Stream<List<PostViewModel>> get outPostViewModelList => _postViewModelList.stream;

  Future<void> _loadPostsHighlights() async {
    try {
      final _listPostHighlights = await loadPostsHighlights.load();
      highlightsPosts = _requestDataModel(_listPostHighlights);
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        _postViewModelList.addError(UIError.sessionExpired);
      } else {
        _postViewModelList.addError(UIError.unexpected);
      }
    }
  }

  Future<void> loadData() async {
    try {
      inIsLoading.add(true);
      await _loadPostsHighlights();

      final _listPosts = await loadPosts.load();

      _postViewModelList.sink.add(_requestDataModel(_listPosts));
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

  List<PostViewModel> _requestDataModel(List listData) => listData
      .map((post) => PostViewModel(
            title: post.title,
            imageUrl: post.imageUrl,
            content: post.content,
            author: post.author,
            description: post.description,
            highlight: post.highlight,
            url: post.url,
            publishedAt: DateFormat('dd MMM yyyy').format(post.publishedAt),
          ))
      .toList();

  @override
  void dispose() {
    _postViewModelList?.close();
    loadingDispose();
  }
}
