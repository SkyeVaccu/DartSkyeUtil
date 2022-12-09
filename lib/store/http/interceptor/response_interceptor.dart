import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:skye_utils/store/http/configuration/interceptor_configuration.dart';

///it's the abstract response interceptor
abstract class ResponseInterceptor {
  /// intercept the response and change it
  /// @param request : Request object
  /// @param response : response object
  /// @return : the handled response obj
  FutureOr<Response> intercept(Request request, Response response);

  ///it's used to call all response interceptors
  ///@param request : the Request object
  ///@param response : the response object
  ///@return : the handled response
  static FutureOr<Response> mainResponseInterceptor(Request request, Response response) async {
    for (var interceptor in InterceptorConfiguration.responseInterceptors) {
      response = await interceptor.call(request, response);
    }
    return response;
  }
}
