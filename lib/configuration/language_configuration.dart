import 'package:get/get.dart';
import 'package:skye_utils/extension/list_extension.dart';

///it's use to register all i18n file
class LanguageConfiguration extends Translations {
  //it's used to config the i18n map
  @override
  Map<String, Map<String, String>> get keys => {
        "zh_CN": [].flatMapToMap(),
        "en_US": [].flatMapToMap(),
      };
}
