import 'dart:async';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:skye_utils/store/http/configuration/http_configuration.dart';

///it's the util to handle the http
class HttpUtil {
  /// join the http part to a request path
  /// @param apiPrefix : the apiPrefix on the first assign the function part
  /// @param requestPath : the request path assign the single function
  /// @param isAnonymous : whether the request path is anonymous
  /// @return : the joined request path
  static String join(String apiPrefix, String requestPath, {bool isAnonymous = false}) {
    return "/" +
        (isAnonymous ? HttpConfiguration.AnonymousPrefix : HttpConfiguration.IdentityPrefix) +
        "/" +
        apiPrefix +
        "/" +
        requestPath;
  }

  ///get the bodyString from the response
  ///@param response : the response object
  ///@return : the response body string
  static Future<String> getBodyString(Future<Response> response) async {
    return (await response).bodyString!;
  }
}
