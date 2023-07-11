import 'package:yaml/yaml.dart';

/// the global Configuration which includes all configurations which is defined in the yaml file
class YamlConfiguration {
  // the parsed configuration bean
  late YamlMap globalYamlConfiguration;

  // the constructor function
  YamlConfiguration(this.globalYamlConfiguration);
}

/// the extension class which is used to get the str straightly
extension GlobalConfigurationExtension on YamlConfiguration {
  /// overloading the []
  dynamic operator [](String key) {
    List<String> keys = key.split(".");
    YamlMap currentConfiguration = globalYamlConfiguration;
    for (int i = 0; i < keys.length; i++) {
      String value = keys[i];
      if (currentConfiguration[value] != null) {
        if (i != keys.length - 1) {
          currentConfiguration = currentConfiguration[value];
        } else {
          return currentConfiguration[value];
        }
      }
    }
    return null;
  }
}
