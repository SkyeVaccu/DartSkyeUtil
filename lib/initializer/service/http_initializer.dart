import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skye_utils/configuration/http_configuration.dart';
import 'package:skye_utils/initializer/initializer.dart';
import 'package:skye_utils/util/http/http_client.dart';

///it's the initializer which is used to initialize the http client
class HttpInitializer extends Initializer {
  @override
  void init(BuildContext context) {
    //create the http client and init it
    //because it extends the GetConnect ,so it will init when the Get init
    HttpClient httpClient = HttpClient.uriBuilder(uri: HttpConfiguration.baseUrl);
    //put it into the Get container
    Get.put(httpClient);
  }
}
