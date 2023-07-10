import 'package:flutter/services.dart';
import '../util/cache_util.dart';
import 'package:yaml/yaml.dart';

class YamlParser {
  /// parse the configuration yaml, and store the configuration into the global cache
  /// @return : the empty future
  static Future<void> parse() async {
    // parse the yaml file
    String configurationStr = await rootBundle.loadString('resource/application.yaml');
    // put the configuration into global mao
    CacheUtil.put("GlobalConfiguration", loadYaml(configurationStr));
    return Future.value();
  }
}
