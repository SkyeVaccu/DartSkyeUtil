import 'package:flutter/services.dart';
import 'YamlConfiguration.dart';
import '../../util/cache_util.dart';
import 'package:yaml/yaml.dart';

/// it's the yaml global configuration parser, it can parse the yaml configuration
class YamlParser {
  /// parse the configuration yaml
  /// @param filePath: the yaml file path
  /// @return : the  future includes the parsed configuration
  static Future<YamlConfiguration> parse(String filePath) async {
    // parse the yaml file
    String configurationStr = await rootBundle.loadString(filePath);
    // put the configuration instance into global mao
    return Future.value(YamlConfiguration(loadYaml(configurationStr)));
  }
}
