import 'package:mesa_news/ui/helpers/filter_period.dart';
import 'package:mesa_news/ui/pages/feed/post_viewmodel.dart';

abstract class FeedPresenter {
  List<PostViewModel> highlightsPosts;

  Stream<List<PostViewModel>> get outPostViewModelList;
  Sink<bool> get inFavoriteFilter;
  Stream<bool> get outFavoriteFilter;
  bool get getFavoriteFilter;

  Sink<FilterPeriod> get inPeriodFilter;
  Stream<FilterPeriod> get outPeriodFilter;
  FilterPeriod get getPeriodFilter;

  Future<void> loadData();
  Future<bool> loadNextPageData();
}
