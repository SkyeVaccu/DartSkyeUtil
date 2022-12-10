import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:skye_utils/configuration/initializer_configuration.dart';
import 'package:skye_utils/configuration/language_configuration.dart';
import 'package:skye_utils/configuration/route_configuration.dart';
import 'package:skye_utils/util/color/color_util.dart';

import 'configuration/flutter_screenutil_configuration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //call all initializer
    InitializerConfiguration.initializerList.forEach((initializer) => initializer.init(context));
    //create the GetMaterial App
    return GetMaterialApp(
        //set the default light theme
        theme: ColorUtil.getThemeData(),
        //set the default deep theme
        darkTheme: ColorUtil.getThemeData(isDark: true),
        //set the languageConfiguration file
        translations: LanguageConfiguration(),
        //set the default the language
        locale: ui.window.locale,
        //the alternative language
        fallbackLocale: Locale('zh', 'CN'),
        //close the debug info show
        debugShowCheckedModeBanner: false,
        //set the entrance router page
        initialRoute: "",
        //set the page list
        getPages: RouteConfig.pages,
        //set the observer of the  navigator
        //make the plugin can observe the navigation
        navigatorObservers: [FlutterSmartDialog.observer],
        //build function , you can do something before the build the page
        builder: (context, child) {
          //set the canvas size by the orientation
          FlutterScreenUtilConfiguration.initScreenSize(context);
          //return the package build of the smart dialog
          return FlutterSmartDialog(child: child);
        });
  }
}
