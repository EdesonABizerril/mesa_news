import 'package:meta/meta.dart';

import '../../domain/helpers/domain_error.dart';
import '../../domain/entity/account_entity.dart';
import '../../domain/usercases/authentication.dart';

import '../models/account_model.dart';
import '../http/http_error.dart';
import '../http/http_client.dart';

class RemoteAuthentication extends Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  @override
  Future<AccountEntity> auth(AuthenticationParams authenticationParams) async {
    final body = RemoteAuthenticationParams.fromDomain(authenticationParams).toJson();

    try {
      final httpResponse = await httpClient.request(url: url, method: "post", body: body);

      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({@required this.email, @required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams authenticationParams) =>
      RemoteAuthenticationParams(
        email: authenticationParams.email,
        password: authenticationParams.secret,
      );

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
