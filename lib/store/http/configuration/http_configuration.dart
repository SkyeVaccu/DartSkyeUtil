class HttpConfiguration {
  //the prefix which in the front of the anonymous request path
  static const String AnonymousPrefix = "anony";
  //the prefix which in the front of the identity request path
  static const String IdentityPrefix = "user";

  //the active profile
  static Profile currentProfile = Profile.MOCK;

  //the active baseUrl
  static String baseUrl = () {
    String host = environment[currentProfile]![RequestPart.HOST]!;
    String port = environment[currentProfile]![RequestPart.PORT]!;
    //handle the ":" problem
    if (!port.startsWith("/")) {
      port = ":" + port;
    }
    return host + port;
  }();

  //the configuration of environment
  //if it isn't the mock environment, you must add the ':' before the port
  static Map<Profile, Map<RequestPart, String>> environment = {
    //Mock environment
    Profile.MOCK: {
      RequestPart.HOST: "https://console-mock.apipost.cn",
      RequestPart.PORT: "/app/mock/project/8deeb012-ac45-46b5-c0f1-e4cab750ddf0",
    },
    //Local environment
    Profile.LOCAL: {
      RequestPart.HOST: "http://10.0.2.2",
      RequestPart.PORT: ":10035",
    }
  };
}

///it's the profile of the application
enum Profile { MOCK, DEVELOPMENT, LOCAL }

///it's the request part
enum RequestPart { HOST, PORT }
