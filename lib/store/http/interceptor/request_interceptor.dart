import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:skye_utils/store/http/configuration/interceptor_configuration.dart';

///it's the abstract request interceptor
abstract class RequestInterceptor {
  /// intercept the request and change it
  /// @param request : Request object
  /// @return : the handled request obj
  FutureOr<Request> intercept(Request request);

  ///it's used to call all request interceptors
  ///@param request : the Request object
  ///@return : the handled request
  static FutureOr<Request> mainRequestInterceptor(Request request) async {
    //traverse all request interceptors
    for (var interceptor in InterceptorConfiguration.requestInterceptors) {
      request = await interceptor.call(request);
    }
    return request;
  }
}
