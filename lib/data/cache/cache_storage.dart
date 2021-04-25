abstract class CacheStorage {
  Future get({String key});
  Future<void> delete({String key});
  Future put({String key, dynamic value});
  Future<bool> isContains({String key});

  /// Returns a value if it exists. The [valeuIfNoExists] parameter is the value returned if it does not exist
  Future<dynamic> getIfExists({String key, dynamic valueIfNoExists});

  /// Checks if the app has ever been accessed and returns 'true' if first accessed.
  /// The [saveFirstAccess] parameter defines whether to save the first access or not, by default 'true'
  Future<bool> isFirstAccess({bool saveFirstAccess = true});
}
