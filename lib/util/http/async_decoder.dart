import 'dart:async';
import 'dart:convert';

import '../../util/http/http_decoder.dart';
import '../../util/isolate_util.dart';
import '../../util/logger_util.dart';
import '../../util/object_util.dart';
import '../../util/serialize/serializable.dart';
import '../../util/serialize/serialize_util.dart';

/// it's the decoder which is used to decode the response json
class AsyncDecoder implements HttpDecoder {
  /// decode the response data to the dynamic
  /// responseStr is the raw string
  /// it won't parse the data to the PageData, if you want to get the PageData object, you should set the parameter type
  /// @param parameters : the parameter list
  /// @return : the response data
  static FutureOr<dynamic> _decodeRawResponse(List<dynamic> parameters) {
    //get the response
    String responseStr = parameters[0] as String;
    //target type
    dynamic target;
    //get the type
    if (parameters.length > 1) {
      target = parameters[1];
    }
    //response successfully, we can get the response
    Map<String, dynamic> map = jsonDecode(responseStr) as Map<String, dynamic>;
    //print the response script
    Log.d(map["script"]);
    //the response is true
    if (map["code"] == 200) {
      //get the responseData, the response data must be map
      Map<String, dynamic> responseData = map["responseData"] as Map<String, dynamic>;
      //if the E isn't map or list
      //if the type isn't the basic type
      //convert the data to the target type
      if (ObjectUtil.isNotEmpty(target)) {
        //convert the response data
        return SerializeUtil.asCustomized(responseData, target);
      } else {
        //instead return the value straightly
        //it will return a map or a list
        return responseData;
      }
    } else {
      //print the message
      Log.e("server business error");
    }
  }

  ///decode the response string and convert it to the target type obj , it's the method to exposed to http client
  /// E is the return type
  /// F is the specific type
  ///@param response : the response json data
  ///@param modelObj : the model Object to be referred
  ///@return : the object converted
  @override
  Future<E> decode<E, F extends Serializable>(String response, {F? modelObj}) async {
    //we don't need to convert it the target type
    if (modelObj == null) {
      return await IsolateUtil.builder(AsyncDecoder._decodeRawResponse)
          .setParameter(response)
          .run();
    }
    //we need to convert it the target type
    else {
      return await IsolateUtil.builder(AsyncDecoder._decodeRawResponse)
          .setParameter(response)
          .setParameter(modelObj)
          .run();
    }
  }
}
