import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'serialize/serialize_util.dart';

/// this class is used to store all cache data into the cache xml file
/// the directory path is '/data/user/0/<package name>/shared_prefs/'
/// this directory is the user private  directory , user won't visit it
class SharedPreferenceUtil {
  /// the operate object of the SharedPreferences
  /// because the get method is asynchronous , so you should init the Util when the application is starting
  static late SharedPreferences? _sharedPreferences;

  /// init the SharedPreference object
  /// @return : the future of the SharedPreference object
  static Future<SharedPreferences> init() {
    return SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }

  ///get the SharedPreference instance to operate
  ///@return : the SharedPreferences object
  static FutureOr<SharedPreferences> getInstance() async {
    if (_sharedPreferences == null) {
      return await init();
    } else {
      return _sharedPreferences!;
    }
  }

  /// put the data into the SharedPreference
  /// @param key : the data key
  /// @param value : the data value
  static void put(String key, dynamic value) {
    //if don't init the instance , it will init it and put the data
    if (_sharedPreferences == null) {
      init().then((sp) => sp.setString(key, SerializeUtil.serialize(value) ?? ""));
    } else {
      _sharedPreferences!.setString(key, SerializeUtil.serialize(value) ?? "");
    }
  }

  /// get the data from the SharedPreference
  /// @param key : the data key
  /// @param targetObj : the converted type
  /// @return : it can be future or data depends on whether init the SharedPreference instance
  static FutureOr<dynamic> get(String key, {dynamic targetObj}) async {
    //if don't init the instance , it will init it and get the data
    if (_sharedPreferences == null) {
      if (targetObj != null) {
        return init().then((sp) => SerializeUtil.deserialize(sp.getString(key) ?? "", targetObj));
      } else {
        return init().then((value) => value.getString(key)!);
      }
    } else {
      if (targetObj != null) {
        return SerializeUtil.deserialize(_sharedPreferences!.getString(key) ?? "", targetObj);
      } else {
        return _sharedPreferences!.getString(key);
      }
    }
  }
}
