import 'dart:async';

import 'package:get/get.dart';
import 'package:skye_utils/store/http/configuration/http_configuration.dart';
import 'package:skye_utils/store/http/http_decoder.dart';
import 'package:skye_utils/store/http/interceptor/request_interceptor.dart';
import 'package:skye_utils/store/http/interceptor/response_interceptor.dart';
import 'package:skye_utils/util/http_util.dart';
import 'package:skye_utils/util/serialize/serializable.dart';

///it's the connect object to handle the http request
class CustomGetConnect extends GetConnect {
  // the singleton instance
  static CustomGetConnect? customGetConnect;

  ///create the single CustomGetConnect instance
  ///@return : the singleton instance
  static CustomGetConnect getInstance() {
    if (customGetConnect != null) {
      return customGetConnect!;
    } else {
      //put the getConnect into the ioc container
      customGetConnect = CustomGetConnect();
      //put it into the Get Container
      Get.put(customGetConnect);
      return customGetConnect!;
    }
  }

  @override
  void onInit() {
    //set the base url
    //it just will take effect when you use the websocket
    httpClient.baseUrl = HttpConfiguration.baseUrl;

    ///Its setting isn't authenticated in the default, when response status code is 403 , it will call the method
    /// addAuthenticator Authenticator will be called 3 times if HttpStatus is
    ///  HttpStatus.unauthorized

    ///append the token interceptor
    httpClient.addRequestModifier(RequestInterceptor.mainRequestInterceptor);

    /// it will intercept the response
    /// now it can judge the response status code.
    httpClient.addResponseModifier(ResponseInterceptor.mainResponseInterceptor);
  }

  ///to send a GET request
  ///@param uri : the request Uri
  ///@param params : the request params
  ///@param header : the params in the header
  ///@param contentType : the content type
  ///@return : the response String
  static FutureOr<String> toGet({
    required String uri,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    return HttpUtil.getBodyString(
        getInstance().get(uri, query: params, headers: headers, contentType: contentType));
  }

  ///to send a POST request
  ///@param uri : the request Uri
  ///@param body : the request body
  ///@param query : the request query params
  ///@param header : the params in the header
  ///@param contentType : the content type
  ///@return : the response String
  static FutureOr<String> toPost({
    required String uri,
    required dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    return HttpUtil.getBodyString(
        getInstance().post(uri, body, query: query, headers: headers, contentType: contentType));
  }

  ///to send a PUT request
  ///@param uri : the request Uri
  ///@param body : the request body
  ///@param query : the request query params
  ///@param header : the params in the header
  ///@param contentType : the content type
  ///@return : the response String
  static FutureOr<String> toPut({
    required String uri,
    required dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    return HttpUtil.getBodyString(
        getInstance().put(uri, body, query: query, headers: headers, contentType: contentType));
  }

  ///to send a DELETE request
  ///@param uri : the request Uri
  ///@param params : the request params
  ///@param header : the params in the header
  ///@param contentType : the content type
  ///@return : the response String
  static FutureOr<String> toDelete({
    required String uri,
    required Map<String, dynamic> params,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    return HttpUtil.getBodyString(
        getInstance().delete(uri, query: params, headers: headers, contentType: contentType));
  }

  /// to send a GET request and decode the response
  ///@param uri : the request Uri
  ///@param params : the request params
  ///@param header : the params in the header
  ///@param contentType : the content type
  ///@param modelObj : the target object
  ///@return : the response object
  static Future<E> toGetAndDecode<E, F extends Serializable>({
    required String uri,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    String? contentType,
    F? modelObj,
  }) async {
    String response =
        await toGet(uri: uri, params: params, headers: headers, contentType: contentType);
    return HttpDecoder.asyncDecode<E, F>(response, modelObj: modelObj);
  }

  /// to send a POST request and decode the response
  ///@param uri : the request Uri
  ///@param body : the request body
  ///@param query : the request query params
  ///@param header : the params in the header
  ///@param contentType : the content type
  ///@param modelObj : the target object
  ///@return : the response String
  static Future<E> toPostAndDecode<E, F extends Serializable>({
    required String uri,
    required dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? contentType,
    F? modelObj,
  }) async {
    String response = await toPost(
        uri: uri, body: body, query: query, headers: headers, contentType: contentType);
    return HttpDecoder.asyncDecode<E, F>(response, modelObj: modelObj);
  }

  /// to send a PUT request and decode the response
  ///@param uri : the request Uri
  ///@param body : the request body
  ///@param query : the request query params
  ///@param header : the params in the header
  ///@param contentType : the content type
  ///@param modelObj : the target object
  ///@return : the response String
  static Future<E> toPutAndDecode<E, F extends Serializable>({
    required String uri,
    required dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? contentType,
    F? modelObj,
  }) async {
    String response =
        await toPut(uri: uri, body: body, query: query, headers: headers, contentType: contentType);
    return HttpDecoder.asyncDecode<E, F>(response, modelObj: modelObj);
  }

  /// to send a DELETE request and decode the response
  ///@param uri : the request Uri
  ///@param params : the request query params
  ///@param header : the params in the header
  ///@param contentType : the content type
  ///@param modelObj : the target object
  ///@return : the response String
  static Future<E> toDeleteAndDecode<E, F extends Serializable>({
    required String uri,
    required Map<String, dynamic> params,
    Map<String, String>? headers,
    String? contentType,
    F? modelObj,
  }) async {
    String response =
        await toDelete(uri: uri, params: params, headers: headers, contentType: contentType);
    return HttpDecoder.asyncDecode<E, F>(response, modelObj: modelObj);
  }
}
