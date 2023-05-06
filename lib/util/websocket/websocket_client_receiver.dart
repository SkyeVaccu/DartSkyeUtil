import '../../util/websocket/websocket_client_operator.dart';
import '../../util/websocket/websocket_package.dart';

///it's the abstract WebSocketClientReceiver to standard the receiver
abstract class WebSocketClientReceiver extends WebSocketClientOperator {
  ///the receiver will receiver the assign webSocketPackage
  ///@param webSocketPackage : the receive webSocketPackage
  void receive(WebSocketPackage webSocketPackage);
}
