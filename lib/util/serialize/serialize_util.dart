import 'dart:convert';

import 'package:skye_utils/util/serialize/serializable.dart';

/// the class which handle the serialize thing, like serializing or deserializing
class SerializeUtil {
  ///convert the customized class to the basic class
  ///@param oldObj : the customized object
  ///@return : the converted customized object
  static dynamic asBasic(dynamic oldObj) {
    //if the target can serializable
    if (oldObj is Serializable) {
      //convert it to map
      return oldObj.toJson();
    }
    //if the object is list and convert it
    else if (oldObj is List) {
      List<dynamic> result = [];
      for (var value in oldObj) {
        if (value is Serializable) {
          result.add(asBasic(value.toJson()));
        } else if (value is List) {
          result.add(asBasic(value));
        } else if (value is Map) {
          result.add(asBasic(value));
        } else {
          result.add(value);
        }
      }
      return result;
    }
    //if the object is map and convert it
    else if (oldObj is Map) {
      Map<dynamic, dynamic> result = {};
      for (var entry in oldObj.entries) {
        if (entry.value is Serializable) {
          result[entry.key] = asBasic((entry.value as Serializable).toJson());
        } else if (entry.value is List) {
          result[entry.key] = asBasic(entry.value);
        } else if (entry.value is Map) {
          result[entry.key] = asBasic(entry.value);
        } else {
          result[entry.key] = entry.value;
        }
      }
      return result;
    }
    //return it straightly
    return oldObj;
  }

  ///deserialize the basic data to the customized
  ///@param object : the object which need to be converted
  ///@param targetObj : the object which is referred by the type
  ///@return : the converted basic object
  static dynamic asCustomized<T>(dynamic object, T targetObj) {
    //if the target class implements Serializable
    if (targetObj is Serializable) {
      //current obj is List
      if (object is List) {
        List<T> result = [];
        for (var value in object) {
          result.add(asCustomized(value, targetObj) as T);
        }
        return result;
      }
      //current obj is a Map
      //it will recursive to find the correct class to convert it
      else if (object is Map) {
        if (targetObj.mapPair(object as Map<String, dynamic>)) {
          //we will think it's a object,then try to deserialize the map
          return targetObj.fromJson(object) as T;
        } else {
          //if we can't do it , then it shows we need to continue to traverse the map
          Map<String, dynamic> result = {};
          for (var entry in object.entries) {
            result[entry.key] = asCustomized(entry.value, targetObj);
          }
          return result;
        }
      }
    }
    //it's the basic class
    else {
      return object;
    }
  }

  ///convert the obj to json String
  ///@param obj : the origin object
  ///@return  : the conversion string
  static String? serialize(dynamic obj) {
    return jsonEncode(asBasic(obj));
  }

  ///convert the json string to object typed T
  ///@param json : the json string
  ///@param targetObj : the target obj
  ///@return : the converted object
  static dynamic deserialize<T>(String json, T targetObj) {
    return asCustomized(jsonDecode(json), targetObj);
  }

  ///convert the value to the target type
  ///@param value : the origin value
  ///@return : the converted value can be null
  static T? asT<T>(dynamic value) {
    dynamic returnValue;
    //if it is the target , convert it straightly
    if (value is T) {
      returnValue = value;
    }
    //if the value is the String
    else if (value is String) {
      switch (T) {
        case double:
          returnValue = double.parse(value);
          break;
        case int:
          returnValue = int.parse(value);
          break;
      }
    }
    //if the value is the int
    else if (value is int) {
      switch (T) {
        case double:
          returnValue = value.toDouble();
          break;
        case String:
          returnValue = value.toString();
          break;
      }
    }
    //if the value is the double
    else if (value is double) {
      switch (T) {
        case int:
          //it's round
          returnValue = value.round();
          break;
        case String:
          returnValue = value.toString();
          break;
      }
    }
    // if the value is null , return the default value
    if (value == null) {
      switch (T) {
        case double:
          returnValue = 0.0;
          break;
        case int:
          returnValue = 0;
          break;
        case String:
          returnValue = "";
          break;
        case List:
          returnValue = [];
          break;
        case Map:
          returnValue = {};
          break;
        case Set:
          returnValue = {};
          break;
      }
    }
    //convert heavily the value to the target type
    return returnValue as T;
  }
}
