///it provides the cache to entire project
///it just use the map to store the data
class CacheUtil {
  /// this map is for to cache all data into the cache
  /// the value can be null
  static Map<String, dynamic> cache = {};

  ///store the value into the map
  ///@param key: the data key
  ///@param value : the data value
  static void put(String key, dynamic value) {
    cache[key] = value;
  }

  ///get the data from the cache by the key
  ///@param key : the data key
  ///@return : the value
  static dynamic get(String key) {
    return cache[key];
  }

  ///remove the data from the cache
  ///@param key : the data key
  static void remove(String key) {
    cache.remove(key);
  }
}
