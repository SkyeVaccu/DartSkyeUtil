import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'package:skye_utils/store/http/interceptor/request_interceptor/token_interceptor.dart';
import 'package:skye_utils/store/http/interceptor/response_interceptor/error_interceptor.dart';

/// it's used to config all interceptors
class InterceptorConfiguration {
  ///all request interceptors
  static final List<RequestModifier> requestInterceptors = [
    TokenInterceptor().intercept,
  ];

  ///all response interceptors
  static final List<ResponseModifier> responseInterceptors = [
    ErrorInterceptor().intercept,
  ];
}
