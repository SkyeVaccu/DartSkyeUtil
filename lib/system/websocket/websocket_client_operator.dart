import '../../system/websocket/websocket_client.dart';

///the most top websocket client form
abstract class WebSocketClientOperator {
  ///it's the callback method which is used to bind the webSocketClient
  ///@param webSocketClient : bind websocketClient object
  void bind(WebSocketClient webSocketClient);

  ///it's used to provide the assigned loop
  ///@return : the loop
  String getLoop();

  ///it's used to provide the assigned subject
  ///@return : the subject
  String getSubject();
}
