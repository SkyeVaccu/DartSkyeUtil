import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skye_utils/system/yaml_configuration/GlobalConfiguration.dart';
import '../../util/cache_util.dart';
import 'package:yaml/yaml.dart';
import '../../configuration/http_configuration.dart';
import '../../initializer/initializer.dart';
import '../../util/http/http_client.dart';

///it's the initializer which is used to initialize the http client
class HttpInitializer extends Initializer {
  @override
  void init(BuildContext context) {
    // judge whether open the http configuration
    GlobalConfiguration globalConfiguration = CacheUtil.get("_GlobalConfiguration");
    // if the http configuration exist and the status is true , we will initialize the http
    if (globalConfiguration["http"] != null && (globalConfiguration["http.status"] ?? true)) {
      // get the instance
      HttpConfiguration instance = HttpConfiguration.getInstance();
      //create the http client and init it
      //because it extends the GetConnect ,so it will init when the Get init
      HttpClient httpClient = HttpClient.uriBuilder(uri: instance.baseUrl);
      //put it into the Get container
      Get.put(httpClient);
    }
  }
}
