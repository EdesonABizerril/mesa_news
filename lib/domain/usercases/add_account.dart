import 'package:meta/meta.dart';

import '../entity/account_entity.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams addAccountParams);
}

class AddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String birthDate;

  AddAccountParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.passwordConfirmation,
    @required this.birthDate,
  });
}
