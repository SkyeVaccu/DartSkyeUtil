import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skye_utils/initializer/initializer.dart';

///it's the initializer to initialize some ui
class StatusBarInitializer implements Initializer {
  ///the initialize method
  @override
  void init(BuildContext context) {
    //set the status bar color and the brightness
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}
