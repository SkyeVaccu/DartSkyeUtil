///it's the configuration to config the http request
class HttpConfiguration {
  //the prefix which in the front of the anonymous request path
  static const String AnonymousPrefix = "anony";

  //the prefix which in the front of the identity request path
  static const String IdentityPrefix = "user";

  //the active profile
  static _Profile currentProfile = _Profile.MOCK;

  //the configuration of environment
  //if it isn't the mock environment, you must add the ':' before the port
  static final Map<_Profile, Map<_RequestPart, String>> _environment = {
    //Mock environment
    _Profile.MOCK: {
      _RequestPart.PROTOCOL: "https",
      _RequestPart.HOST: "console-mock.apipost.cn",
      _RequestPart.PORT: "/app/mock/project/8deeb012-ac45-46b5-c0f1",
    },
    //Local environment
    _Profile.LOCAL: {
      _RequestPart.PROTOCOL: "http",
      _RequestPart.HOST: "10.0.2.2",
      _RequestPart.PORT: "10035",
    },
    //Local environment
    _Profile.DEVELOPMENT: {
      _RequestPart.PROTOCOL: "http",
      _RequestPart.HOST: "vaccum.ltd",
      _RequestPart.PORT: "10035",
    }
  };

  //the active baseUrl
  static String baseUrl = () {
    String protocol = _environment[currentProfile]![_RequestPart.PROTOCOL]!;
    String host = _environment[currentProfile]![_RequestPart.HOST]!;
    String port = _environment[currentProfile]![_RequestPart.PORT]!;
    //handle the ":" problem
    if (!port.startsWith("/")) {
      port = ":$port";
    }
    return "$protocol://$host$port";
  }();
}

///it's the profile of the application
enum _Profile { MOCK, DEVELOPMENT, LOCAL }

///it's the request part
enum _RequestPart { PROTOCOL, HOST, PORT }
