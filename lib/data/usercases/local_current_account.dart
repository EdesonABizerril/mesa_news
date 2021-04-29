import 'package:meta/meta.dart';

import '../../domain/entity/account_entity.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/usercases/current_account.dart';
import '../cache/cache_secure_storage.dart';

class LocalCurrentAccount implements CurrentAccount {
  final CacheSecureStorage cacheSecureStorage;

  LocalCurrentAccount({@required this.cacheSecureStorage});

  Future<void> save(AccountEntity account) async {
    try {
      await cacheSecureStorage.save(key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  @override
  Future<AccountEntity> load() async {
    try {
      final token = await cacheSecureStorage.fetch('token');
      return AccountEntity(token: token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
