import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../system/http/response_interceptor.dart';
import '../../../util/logger_util.dart';

///it's the response interceptor , you can handle the response
class ErrorInterceptor extends ResponseInterceptor {
  ///handle the response, if the http status code is error , we will handle the error
  ///@param request : the http request object
  ///@param response : the http response object
  ///@return : the handled response object
  @override
  FutureOr<Response> intercept(Request request, Response response) {
    //judge the request whether is true
    if (response.hasError) {
      Log.e("status code:${response.statusCode}");
    }
    //if it is ok , return the error
    return response;
  }
}
