import 'dart:async';

import '../../util/serialize/serializable.dart';

///it's the abstract http decoder to define an standard response decoder
abstract class HttpDecoder {
  ///it's the function which is used to decode the response
  ///@param response : raw response string
  ///@param modelObj : target Object
  ///@return : the result Object
  FutureOr<E> decode<E, F extends Serializable>(String response, {F? modelObj});
}
