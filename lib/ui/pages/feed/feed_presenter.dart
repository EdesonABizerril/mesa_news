import '../../helpers/filter_period.dart';
import 'post_viewmodel.dart';

abstract class FeedPresenter {
  List<PostViewModel> highlightsPosts;

  Stream<List<PostViewModel>> get outPostViewModelList;
  Sink<bool> get inFavoriteFilter;
  Stream<bool> get outFavoriteFilter;
  bool get getFavoriteFilter;

  Stream<FilterPeriod> get outPeriodFilter;
  FilterPeriod get getPeriodFilter;

  Future<void> loadData();
  void setFilterPosts(FilterPeriod filterPeriod);
  Future<bool> loadNextPageData();
  void resetFilterPosts();
  void reloadData();
}
