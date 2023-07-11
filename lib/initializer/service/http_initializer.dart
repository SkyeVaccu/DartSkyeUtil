import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../configuration/auto_configuration/http_configuration.dart';
import '../../initializer/initializer.dart';
import '../../util/http/http_client.dart';
import '../initializer_enhance.dart';

///it's the initializer which is used to initialize the http client
class HttpInitializer extends Initializer with InitializerEnhance {
  @override
  void init(BuildContext context) {
    // if the http configuration exist and the status is true , we will initialize the http
    if (openConfiguration("http.status")) {
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
