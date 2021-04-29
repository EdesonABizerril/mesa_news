import 'package:meta/meta.dart';

import '../../domain/entity/post_entity.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/usercases/load_posts.dart';
import '../cache/cache_secure_storage.dart';
import '../http/http_client.dart';
import '../http/http_error.dart';
import '../models/post_model.dart';

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
      final httpResponse = await httpClient.request(url: url, method: "get", headers: authorizedHeaders);
      return httpResponse['data'].map<PostEntity>((json) => RemotePostModel.fromJson(json).toEntity()).toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
}
