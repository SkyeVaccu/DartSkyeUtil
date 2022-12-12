import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skye_utils/configuration/websocket_configuration.dart';
import 'package:skye_utils/initializer/initializer.dart';
import 'package:skye_utils/util/websocket/websocket_client.dart';

///it's the initializer which is used to initialize the websocket client
class WebSocketInitializer extends Initializer {
  @override
  void init(BuildContext context) {
    //create the websocket client
    WebSocketClient webSocketClient =
        WebSocketClient.uriBuilder(uri: WebSocketConfiguration.baseUrl);
    // connect to the websocket server
    webSocketClient.connect();
    //put it into the Get container
    Get.put(webSocketClient);
  }
}
