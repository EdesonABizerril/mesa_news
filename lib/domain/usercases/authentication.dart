import 'package:meta/meta.dart';

import '../entity/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams authenticationParams);
}

class AuthenticationParams {
  final String email;
  final String secret;

  AuthenticationParams({@required this.email, @required this.secret});
}
