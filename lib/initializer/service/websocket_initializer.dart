import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../configuration/auto_configuration/websocket_configuration.dart';
import '../../initializer/initializer.dart';
import '../../util/websocket/websocket_client.dart';
import '../initializer_enhance.dart';

///it's the initializer which is used to initialize the websocket client
class WebSocketInitializer extends Initializer with InitializerEnhance {
  @override
  void init(BuildContext context) {
    // if the http configuration exist and the status is true , we will initialize the http
    if (openConfiguration("websocket.status")) {
      // get the websocket configuration object
      WebSocketConfiguration instance = WebSocketConfiguration.getInstance();
      //create the websocket client
      WebSocketClient webSocketClient = WebSocketClient.uriBuilder(uri: instance.baseUrl);
      // connect to the websocket server
      webSocketClient.connect();
      //put it into the Get container
      Get.put(webSocketClient);
    }
  }
}
