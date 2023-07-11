import 'dart:io';

import '../../expand/data_structure/skye_table.dart';
import '../../extension/string_extension.dart';
import '../../system/websocket/websocket_client_operator.dart';
import '../../system/websocket/websocket_client_receiver.dart';
import '../../system/websocket/websocket_client_sender.dart';
import '../../system/websocket/websocket_package.dart';
import '../../util/logger_util.dart';
import '../../util/object_util.dart';
import '../../util/service/serialize/serialize_util.dart';
import '../../util/timer_util.dart';

///this is the websocket client object ,you can create an websocket client fast by this
///the ping and pong form is packaged into the WebSocket , you can see that class if you want the detail
///if the time pass the heartBeatPeriod ,the client don't receive the pong ,the client will be seen as closed
///So we start the inspector to handle this function
class WebSocketClient {
  //websocket server host
  String? host;

  //websocket server port
  String? port;

  //websocket server connection uri
  String? uri;

  //the websocket protocol
  String protocol;

  //ping and pong ,heart beat period, default value is 15
  int heartBeatPeriod;

  //reconnected threshold ,if the time pass the value ,we will started to reconnected
  int notResponseThreshold;

  //the uri param after the url
  Map<String, String>? urlParams;

  //the params in the headers
  Map<String, String>? openParams;

  //listener the open event
  void Function()? openListener;

  //listener the message event
  void Function(String)? messageListener;

  //listener the close event
  void Function()? closeListener;

  //listener the error event
  void Function(Exception)? errorListener;

  //the true WebSocket object
  WebSocket? _webSocket;

  //the status of the websocket client
  WebSocketClientStatus webSocketClientStatus = WebSocketClientStatus.WAIT;

  //it's the table store all receivers
  final SkyeTable<String, String, List<WebSocketClientReceiver>> _receiverTable = SkyeTable();

  //it's the table store all senders
  ///the builder which is used to build an WebSocketClient Object by host and port, it will use "ws" protocol
  WebSocketClient.signBuilder({
    required this.host,
    required this.port,
    this.protocol = "ws",
    this.heartBeatPeriod = 15,
    this.notResponseThreshold = 3,
    this.urlParams,
    this.openParams,
    this.openListener,
    this.messageListener,
    this.closeListener,
    this.errorListener,
  });

  final SkyeTable<String, String, List<WebSocketClientSender>> _senderTable = SkyeTable();

  ///the builder which is used to build an WebSocketClient Object by uri
  WebSocketClient.uriBuilder({
    required this.uri,
    this.protocol = "ws",
    this.heartBeatPeriod = 15,
    this.notResponseThreshold = 3,
    this.urlParams,
    this.openParams,
    this.openListener,
    this.messageListener,
    this.closeListener,
    this.errorListener,
  });

  ///register the receiver or sender into the webSocket client
  ///@param webSocketClientOperator : the webSocketClientOperator object
  void register(WebSocketClientOperator webSocketClientOperator) {
    //get the loop and subject
    String loop = webSocketClientOperator.getLoop();
    String subject = webSocketClientOperator.getSubject();
    //if it's empty. we should throw the exception
    if (ObjectUtil.isAnyEmpty([loop, subject])) {
      Log.e("don't set the loop and subject of the WebSocketClientOperator");
    }
    //register the object
    else {
      //it's the WebSocketClientReceiver
      if (webSocketClientOperator is WebSocketClientReceiver) {
        List<WebSocketClientReceiver>? webSocketClientReceiverList =
            _receiverTable.get(loop, subject);
        if (webSocketClientReceiverList == null) {
          webSocketClientReceiverList = [];
          _receiverTable.put(loop, subject, webSocketClientReceiverList);
        }
        webSocketClientReceiverList.add(webSocketClientOperator);
      }
      //it's the webSocketClientSender
      else if (webSocketClientOperator is WebSocketClientSender) {
        List<WebSocketClientSender>? webSocketClientSenderList = _senderTable.get(loop, subject);
        if (webSocketClientSenderList == null) {
          webSocketClientSenderList = [];
          _senderTable.put(loop, subject, webSocketClientSenderList);
        }
        webSocketClientSenderList.add(webSocketClientOperator);
      }
      //call the callback to provide the chance to bind the webSocket client
      webSocketClientOperator.bind(this);
    }
  }

  ///send the message to websocket server
  ///@param webSocketPackage : the send websocket package
  void send(WebSocketPackage webSocketPackage) {
    _webSocket?.add(SerializeUtil.serialize(webSocketPackage));
  }

  ///close the websocket
  ///@param code : the close code
  ///@param reason : the close reason
  void close({int? code, String? reason}) {
    //close the websocket
    _webSocket?.close(code, reason);
    Log.e("close the webSocketClient");
    //call the close listener
    closeListener?.call();
  }

  ///connect the websocket sever
  ///@return : the connected WebSocketClient object
  void connect() async {
    _connect();
    //start the inspector
    TimerUtil.periodExecuteTask(
        intervalSeconds: heartBeatPeriod * notResponseThreshold,
        function: (timer) async {
          //the _webSocket has closed
          if (_webSocket!.closeCode != null) {
            //we need to keep the connection
            if (webSocketClientStatus == WebSocketClientStatus.OPEN) {
              Log.e("try to reconnect to the websocket server");
              //restart connect it
              _connect();
            }
            //we close the connection by myself
            else if (webSocketClientStatus == WebSocketClientStatus.CLOSE) {
              //cancel the inspector
              timer.cancel();
            }
          }
        });
  }

  ///the true connect method
  void _connect() async {
    if (ObjectUtil.isAnyEmpty([host, port]) && ObjectUtil.isEmpty(uri)) {
      Log.e("websocket server information can't be empty");
      throw "websocket server information can't be empty";
    } else {
      //handle the sign builder
      if (ObjectUtil.isEmpty(uri)) {
        uri = "$protocol://${host!}:${port!}";
      }
      //concat the url params
      String urlParamsString = "";
      if (ObjectUtil.isNotEmpty(urlParams)) {
        int cnt = 0;
        urlParams!.forEach((key, value) {
          if (ObjectUtil.isNotEmpty(value)) {
            if (cnt == 0) {
              urlParamsString += ("?$key=$value");
            } else {
              urlParamsString += ("&$key=$value");
            }
            cnt++;
          }
        });
      }
      //connect the websocket server
      _webSocket = await WebSocket.connect(uri! + urlParamsString, headers: openParams)
        //set the ping interval , the client will automatically send the ping message
        // you can see the source code annotation to get the detail
        ..pingInterval = Duration(seconds: heartBeatPeriod);
      //set the webStatus is open
      webSocketClientStatus = WebSocketClientStatus.OPEN;
      //call the open listener
      openListener?.call();
      //print the message
      Log.d("connect the websocket server , the relativeUrl".join(uri));
      //listener the data
      _webSocket!.listen((message) {
        //call the message listener
        messageListener?.call(message);
        //deserialize the response message
        WebSocketPackage webSocketPackage = SerializeUtil.deserialize(message, WebSocketPackage());
        //get all assigned websocket client receiver
        List<WebSocketClientReceiver>? webSocketClientReceiverList =
            _receiverTable.get(webSocketPackage.loop!, webSocketPackage.subject!);
        //call all receive method of the websocket client receiver
        webSocketClientReceiverList?.forEach((webSocketClientReceiver) {
          webSocketClientReceiver.receive(webSocketPackage);
        });
      });
    }
  }
}

///the webSocketClient status
enum WebSocketClientStatus {
  //just create id but not connect to the server
  WAIT,
  //the connection is open
  OPEN,
  //the connection is close
  CLOSE,
}
