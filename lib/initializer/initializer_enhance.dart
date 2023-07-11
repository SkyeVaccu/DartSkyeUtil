import '../system/resource/yaml/yaml_configuration.dart';
import '../util/cache_util.dart';

/// it's the enhanced mixin which can help you to check the configuration
mixin InitializerEnhance {
  ///check whether auto configuration status is open
  ///@param key: the check key
  ///@return : whether the status is open
  bool openConfiguration(String key) {
    YamlConfiguration globalConfiguration = CacheUtil.get("_GlobalConfiguration");
    List<String> keys = key.split(".");
    for (int i = 0; i < keys.length; i++) {
      String key = keys[i];
      if (i != keys.length - 1) {
        if (globalConfiguration[key] == null) {
          return false;
        } else {
          return globalConfiguration[key] ?? true;
        }
      }
    }
    return false;
  }
}
