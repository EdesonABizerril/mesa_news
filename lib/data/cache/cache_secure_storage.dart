import 'package:meta/meta.dart';

abstract class CacheSecureStorage {
  Future<void> delete(String key);
  Future<String> fetch(String key);
  Future<void> save({@required String key, @required String value});
}
