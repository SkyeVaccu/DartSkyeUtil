import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';

///it's the abstract request interceptor
abstract class RequestInterceptor {
  /// intercept the request and change it
  /// @param request : Request object
  /// @return : the handled request obj
  FutureOr<Request> intercept(Request request);
}
