import 'package:mesa_news/data/cache/cache_secure_storage.dart';
import 'package:mesa_news/data/http/http_client.dart';
import 'package:mesa_news/data/http/http_error.dart';
import 'package:mesa_news/data/models/post_model.dart';
import 'package:mesa_news/domain/entity/post_entity.dart';
import 'package:mesa_news/domain/helpers/domain_error.dart';
import 'package:mesa_news/domain/usercases/load_posts.dart';
import 'package:meta/meta.dart';

class RemoteLoadPosts implements LoadPosts {
  final HttpClient httpClient;
  final CacheSecureStorage cacheSecureStorage;

  RemoteLoadPosts({
    @required this.httpClient,
    @required this.cacheSecureStorage,
  });

  @override
  Future<List<PostEntity>> load(String url) async {
    try {
      final _token = await cacheSecureStorage.fetch('token');
      final authorizedHeaders = {}..addAll({'Authorization': 'Bearer $_token'});
      final httpResponse =
          await httpClient.request(url: url, method: "get", headers: authorizedHeaders);
      return httpResponse['data'].map<PostEntity>((json) => RemotePostModel.fromJson(json).toEntity()).toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden ? DomainError.accessDenied : DomainError.unexpected;
    }
  }


}
