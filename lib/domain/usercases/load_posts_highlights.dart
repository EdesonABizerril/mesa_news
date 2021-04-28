import 'package:mesa_news/domain/entity/post_entity.dart';

abstract class LoadPostsHighlights {
  Future<List<PostEntity>> load();
}