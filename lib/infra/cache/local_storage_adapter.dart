import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../data/cache/cache_storage.dart';

class LocalStorageAdapter implements CacheStorage {
  @override
  Future<bool> isContains({@required String key}) async {
    var shared = await SharedPreferences.getInstance();
    return shared.containsKey(key);
  }

  @override
  Future<void> delete({@required String key}) async {
    debugPrint("&app SharedStorage - delete from $key");
    var shared = await SharedPreferences.getInstance();
    shared.remove(key);
  }

  @override
  Future get({@required String key}) async {
    debugPrint("&app SharedStorage - get to $key");
    var shared = await SharedPreferences.getInstance();
    return shared.get(key);
  }

  @override
  Future<dynamic> getIfExists({@required String key, @required dynamic valueIfNoExists}) async {
    bool exists = await isContains(key: key);
    if (exists) return get(key: key);
    return valueIfNoExists;
  }

  @override
  Future put({String key, dynamic value}) async {
    debugPrint("&app SharedStorage - put: key: $key, value: $value");
    var shared = await SharedPreferences.getInstance();
    if (value is bool) {
      shared.setBool(key, value);
    } else if (value is String) {
      shared.setString(key, value);
    } else if (value is int) {
      shared.setInt(key, value);
    } else if (value is double) {
      shared.setDouble(key, value);
    }
  }

  @override
  Future<bool> isFirstAccess({bool saveFirstAccess = true}) async {
    bool isContainsKey = await isContains(key: "firstAccess");
    if (saveFirstAccess && !isContainsKey) await put(key: "firstAccess", value: 1);
    debugPrint("&app SharedStorage - Is first Access: ${!isContainsKey}");
    return !isContainsKey;
  }
}
