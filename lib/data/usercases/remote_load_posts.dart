import 'package:mesa_news/data/http/http_client.dart';
import 'package:mesa_news/data/http/http_error.dart';
import 'package:mesa_news/data/models/remote_post_model.dart';
import 'package:mesa_news/domain/entity/post_entity.dart';
import 'package:mesa_news/domain/helpers/domain_error.dart';
import 'package:mesa_news/domain/usercases/load_posts.dart';
import 'package:mesa_news/domain/usercases/load_posts_highlights.dart';
import 'package:meta/meta.dart';

class RemoteLoadPosts implements LoadPosts, LoadPostsHighlights {
  final String url;
  final HttpClient httpClient;

  RemoteLoadPosts({@required this.url, @required this.httpClient});

  @override
  Future<List<PostEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: "get");
      return httpResponse
          .map<PostEntity>((json) => RemotePostModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
