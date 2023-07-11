import '../system/yaml_configuration/GlobalConfiguration.dart';
import '../util/cache_util.dart';

import '../util/object_util.dart';

///it's the websocket configuration
class WebSocketConfiguration {
  late int heartBeatPeriod;
  late String baseUrl;

  // the instance
  static late WebSocketConfiguration instance;

  // the method which is used to get instance
  static WebSocketConfiguration getInstance() {
    instance = WebSocketConfiguration._();
    return instance;
  }

  WebSocketConfiguration._() {
    GlobalConfiguration configuration = CacheUtil.get("_GlobalConfiguration");
    String? prefix = configuration["identityPrefix"];
    heartBeatPeriod = configuration['heartBeatPeriod'] ?? 15;
    _Profile currentProfile = () {
      String? activeProfile = configuration["http.activeProfile"];
      if (activeProfile == null) {
        return _Profile.LOCAL;
      } else if (activeProfile == 'development') {
        return _Profile.DEVELOPMENT;
      } else {
        return _Profile.LOCAL;
      }
    }();
    //the configuration of environment
    //if it isn't the mock environment, you must add the ':' before the port
    Map<_Profile, Map<_RequestPart, String?>> _environment = {
      //Local environment
      _Profile.LOCAL: {
        _RequestPart.PROTOCOL: configuration["websocket.local.protocol"],
        _RequestPart.HOST: configuration["websocket.local.host"],
        _RequestPart.PORT: configuration["websocket.local.host"]
      },
      //Local environment
      _Profile.DEVELOPMENT: {
        _RequestPart.PROTOCOL: configuration["websocket.development.protocol"],
        _RequestPart.HOST: configuration["websocket.development.host"],
        _RequestPart.PORT: configuration["websocket.development.host"]
      }
    };
    // get the base url
    baseUrl = () {
      String? protocol = _environment[currentProfile]?[_RequestPart.PROTOCOL];
      String? host = _environment[currentProfile]?[_RequestPart.HOST];
      String? port = _environment[currentProfile]?[_RequestPart.PORT];
      if (protocol == null || host == null || port == null) {
        throw "wwebsocket lack the necessary paramter";
      } else {
        //handle the ":" problem
        if (!port.startsWith("/")) {
          port = ":$port";
        }
        if (ObjectUtil.isNotEmpty(prefix)) {
          return "$protocol://$host$port/$prefix";
        } else {
          return "$protocol://$host$port";
        }
      }
    }();
  }
}

///it's the profile of the application
enum _Profile { DEVELOPMENT, LOCAL }

///it's the request part
enum _RequestPart { PROTOCOL, HOST, PORT }
