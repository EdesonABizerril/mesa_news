import 'package:meta/meta.dart';

import '../../domain/entity/account_entity.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/usercases/add_account.dart';
import '../http/http_client.dart';
import '../http/http_error.dart';
import '../models/account_model.dart';

class RemoteAddAccount implements AddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({@required this.httpClient, @required this.url});

  Future<AccountEntity> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden ? DomainError.emailInUse : DomainError.unexpected;
    }
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;

  RemoteAddAccountParams({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) => RemoteAddAccountParams(
        name: params.name,
        email: params.email,
        password: params.password,
      );

  Map toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}
