import '../entity/post_entity.dart';

abstract class LoadPosts {
  Future<List<PostEntity>> load(String url);
}
