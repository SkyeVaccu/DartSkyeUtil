import 'package:skye_utils/util/object_util.dart';

///it's the websocket configuration
class WebSocketConfiguration {
  //it's the websocket request prefix
  static const String _Prefix = "socket";
  //the interval between two ping messages
  static int hearBeatPeriod = 15;
  //the active profile
  static _Profile currentProfile = _Profile.DEVELOPMENT;

  //the active baseUrl
  static String baseUrl = () {
    String protocol = _environment[currentProfile]![_RequestPart.PROTOCOL]!;
    String host = _environment[currentProfile]![_RequestPart.HOST]!;
    String port = _environment[currentProfile]![_RequestPart.PORT]!;
    //handle the ":" problem
    if (!port.startsWith("/")) {
      port = ":" + port;
    }
    if (ObjectUtil.isNotEmpty(_Prefix)) {
      return protocol + "://" + host + port + "/" + _Prefix;
    } else {
      return protocol + "://" + host + port;
    }
  }();
  //the configuration of environment
  //if it isn't the mock environment, you must add the ':' before the port
  static Map<_Profile, Map<_RequestPart, String>> _environment = {
    //Mock environment
    _Profile.DEVELOPMENT: {
      _RequestPart.PROTOCOL: "ws",
      _RequestPart.HOST: "console-mock.apipost.cn",
      _RequestPart.PORT: "/app/mock/project/8deeb012-ac45-46b5-c0f1-e4cab750ddf0",
    },
    //Local environment
    _Profile.LOCAL: {
      _RequestPart.PROTOCOL: "ws",
      _RequestPart.HOST: "10.0.2.2",
      _RequestPart.PORT: "10035",
    }
  };
}

///it's the profile of the application
enum _Profile { DEVELOPMENT, LOCAL }

///it's the request part
enum _RequestPart { PROTOCOL, HOST, PORT }
