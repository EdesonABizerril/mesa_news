import 'package:mesa_news/ui/pages/feed/post_viewmodel.dart';

abstract class FeedPresenter {
  List<PostViewModel> highlightsPosts;

  Stream<List<PostViewModel>> get outPostViewModelList;

  Future<void> loadData();
}