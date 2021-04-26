
import '../../domain/entity/account_entity.dart';

abstract class CurrentAccount {
  Future<void> save(AccountEntity account);
  Future<AccountEntity> load();
}