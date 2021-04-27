import 'package:meta/meta.dart';

import '../entity/account_entity.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams addAccountParams);
}

class AddAccountParams {
  final String name;
  final String email;
  final String password;

  AddAccountParams({
    @required this.name,
    @required this.email,
    @required this.password,
  });
}
