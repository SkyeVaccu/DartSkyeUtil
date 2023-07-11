import 'package:flutter/services.dart';
import 'GlobalConfiguration.dart';
import '../../util/cache_util.dart';
import 'package:yaml/yaml.dart';

/// it's the yaml global configuration parser, it can parse the yaml configuration
/// store the configuration into the `GlobalConfiguration` class
class YamlParser {
  /// parse the configuration yaml, and store the configuration into the global cache
  /// @return : the empty future
  static Future<void> parse() async {
    // parse the yaml file
    String configurationStr = await rootBundle.loadString('resource/application.yaml');
    // put the configuration instance into global mao
    CacheUtil.put("_GlobalConfiguration", GlobalConfiguration(loadYaml(configurationStr)));
    return Future.value();
  }
}
