import 'package:skye_utils/util/websocket/websocket_client_operator.dart';
import 'package:skye_utils/util/websocket/websocket_package.dart';

///it's the abstract WebSocketClientSender to standard the sender
abstract class WebSocketClientSender extends WebSocketClientOperator {
  ///the send will send the webSocketPackage
  ///@param webSocketPackage : the receive webSocketPackage
  void send(WebSocketPackage webSocketPackage);
}
