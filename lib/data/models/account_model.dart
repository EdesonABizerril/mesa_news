import 'package:meta/meta.dart';

import '../../domain/entity/account_entity.dart';
import '../http/http_error.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel({@required this.accessToken});

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('token')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(accessToken: json['token']);
  }

  AccountEntity toEntity() => AccountEntity(token: accessToken);
}
