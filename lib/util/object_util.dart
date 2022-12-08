import 'package:skye_utils/util/serialize/serialize_util.dart';

///it's used to complete some judges
class ObjectUtil {
  ///judge the obj is empty
  ///@param obj : the judge object
  ///@return : whether it's empty
  static bool isEmpty(dynamic obj) {
    if (obj is List || obj is Map || obj is String) {
      return obj.isEmpty;
    }
    return obj == null;
  }

  ///judge the obj is not empty
  ///@param obj : the judge object
  ///@return : whether it isn't empty
  static bool isNotEmpty(dynamic obj) {
    return !isEmpty(obj);
  }

  ///the list exist all empty value
  ///@param objList : the object list
  ///@return : all objects are empty
  static bool isAllEmpty(List<dynamic> objList) {
    if (objList.isEmpty) {
      return true;
    } else {
      bool result = false;
      for (var value in objList) {
        result = result || isNotEmpty(value);
      }
      return !result;
    }
  }

  ///the list exists empty value
  ///@param objList : the object list
  ///@return : list exists empty object
  static bool isAnyEmpty(List<dynamic> objList) {
    if (objList.isEmpty) {
      return true;
    } else {
      return !isAllEmpty(objList);
    }
  }

  ///judge whether the object is default value , it includes "null" value
  ///@param objList : the object
  ///@return : whether it is default value
  static bool isDefaultValue(dynamic obj) {
    if (obj == null) {
      return true;
    } else {
      switch (obj.runtimeType) {
        case double:
          return obj == 0.0;
        case int:
          return obj == 0;
        case String:
          return obj == "";
        case List:
          return obj == [];
        case Map:
          return obj == {};
        case Set:
          return obj == {};
        default:
          throw "can't handle the data type";
      }
    }
  }

  ///judge whether all attributes are default value .
  ///It normally will be used to judge the object is created in the error serialize situation
  ///@param obj : the target obj
  ///@return : whether all values are default value
  static bool isAllDefaultValue(dynamic obj) {
    if (obj == null) {
      return true;
    } else {
      bool result = true;
      Map<String, dynamic> dataMap = SerializeUtil.asBasic(obj);
      for (var entry in dataMap.entries) {
        result = result && isDefaultValue(dataMap[entry.key]);
      }
      return result;
    }
  }
}
