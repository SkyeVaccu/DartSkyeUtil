import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';

///it's the abstract response interceptor
abstract class ResponseInterceptor {
  /// intercept the response and change it
  /// @param request : Request object
  /// @param response : response object
  /// @return : the handled response obj
  FutureOr<Response> intercept(Request request, Response response);
}
