import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:skye_utils/configuration/http_configuration.dart';
import 'package:skye_utils/util/http/request_interceptor.dart';

///it's the request interceptor ,you can define the handler to handle the token before sending the request
class TokenInterceptor extends RequestInterceptor {
  ///if it is anonymous, it need the token
  ///@param request : the request object
  ///@return : the handled request object
  @override
  FutureOr<Request> intercept(Request request) {
    if (!request.url.path.contains("/${HttpConfiguration.AnonymousPrefix}")) {
      //TODO get the token from the cache or request the token
      //TODO append the token info to the header like the following code
      // request.headers["Authorization"] = "Bearer " + "token";
    }
    return request;
  }
}
