import '../system/yaml_configuration/GlobalConfiguration.dart';

import '../util/cache_util.dart';
import '../util/logger_util.dart';

///it's the configuration to config the http request
class HttpConfiguration {
  late GlobalConfiguration configuration;
  late String anonymousPrefix;
  late String identityPrefix;
  late String baseUrl;

  static late HttpConfiguration instance;

  static HttpConfiguration getInstance() {
    instance = HttpConfiguration._();
    return instance;
  }

  HttpConfiguration._() {
    configuration = CacheUtil.get("GlobalConfiguration");
    //the prefix which in the front of the anonymous request path
    anonymousPrefix = configuration["http.anonymousPrefix"] ?? "annoy";
    //the prefix which in the front of the identity request path
    identityPrefix = configuration["http.identityPrefix"] ?? "user";
    //the active profile
    _Profile currentProfile = () {
      String? activeProfile = configuration["http.activeProfile"];
      if (activeProfile == null) {
        return _Profile.LOCAL;
      } else if (activeProfile == "mock") {
        return _Profile.MOCK;
      } else if (activeProfile == 'development') {
        return _Profile.DEVELOPMENT;
      } else {
        return _Profile.LOCAL;
      }
    }();
    //the configuration of environment
    //if it isn't the mock environment, you must add the ':' before the port
    Map<_Profile, Map<_RequestPart, String?>> _environment = {
      //Mock environment
      _Profile.MOCK: {
        _RequestPart.PROTOCOL: configuration["http.mock.protocol"],
        _RequestPart.HOST: configuration["http.mock.host"],
        _RequestPart.PORT: configuration["http.mock.port"],
      },
      //Local environment
      _Profile.LOCAL: {
        _RequestPart.PROTOCOL: configuration["http.local.protocol"],
        _RequestPart.HOST: configuration["http.local.host"],
        _RequestPart.PORT: configuration["http.local.host"]
      },
      //Local environment
      _Profile.DEVELOPMENT: {
        _RequestPart.PROTOCOL: configuration["http.development.protocol"],
        _RequestPart.HOST: configuration["http.development.host"],
        _RequestPart.PORT: configuration["http.development.host"]
      }
    };
    baseUrl = () {
      String? protocol = _environment[currentProfile]?[_RequestPart.PROTOCOL];
      String? host = _environment[currentProfile]?[_RequestPart.HOST];
      String? port = _environment[currentProfile]?[_RequestPart.PORT];
      if (protocol == null || host == null || port == null) {
        throw "http lack the necessary paramter";
      } else {
        //handle the ":" problem
        if (!port.startsWith("/")) {
          port = ":$port";
        }
        return "$protocol://$host$port";
      }
    }();
  }
}

///it's the profile of the application
enum _Profile { MOCK, DEVELOPMENT, LOCAL }

///it's the request part
enum _RequestPart { PROTOCOL, HOST, PORT }
