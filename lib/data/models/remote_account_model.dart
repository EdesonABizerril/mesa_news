import 'package:mesa_news/data/http/http_error.dart';
import 'package:mesa_news/domain/entity/account_entity.dart';
import 'package:meta/meta.dart';

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
