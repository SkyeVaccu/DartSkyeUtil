import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as FlutterScreenUtil;
import 'package:get/get.dart';

class ScreenUtil {
  //default app bar height
  //@return : the appbar height
  static double getAppBarHeight() {
    return 56.0;
  }

  ///get the height of the status bar
  ///@return : the height of the status bar
  static double getStatusBarHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }

  //get the ScaffoldBody Height which don't contain the height of the appbar
  //@return : the body height which will be used to contain the content
  static double getScaffoldBodyHeight() {
    return FlutterScreenUtil.ScreenUtil().screenHeight - getAppBarHeight() - getStatusBarHeight();
  }

  ///get the height of the soft key board , but it just can be valid when the soft key board is open
  ///@return : the height of the soft keyboard
  static double getSoftKeyboardHeight() =>
      (Get.context as BuildContext).mediaQueryViewInsets.bottom;
}
