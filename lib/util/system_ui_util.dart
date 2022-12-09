import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

///it's used to control the application UI layer
class SystemUiUtil {
  /// judge whether the orientation
  /// it just can be used to adapt the simple page
  /// @param context : the context object
  /// @return : whether it's portrait
  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  ///set the screen direction
  ///@param screenDirection : the target screen direction
  static void setScreenDirection(ScreenDirection screenDirection) {
    switch (screenDirection) {
      case ScreenDirection.Portrait:
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        break;
      case ScreenDirection.Landscape:
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
        break;
    }
  }

  ///set the operation state
  ///@param operationBarState : set the status bar
  static void setOperationBarState(OperationBarState operationBarState) {
    switch (operationBarState) {
      case OperationBarState.Hide:
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
        break;
      case OperationBarState.Show:
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
        break;
    }
  }

  ///make status bar be transparent
  static void makeStatusBarTransparent() {
    //set the status bar color and the brightness
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  ///close the soft keyboard, its truth is make the input lose the focus node
  static void closeSoftKeyboard() {
    //FocusManager is used to manage the focus node
    //we will make the widget which get the current `focus` dismiss focus.
    //So it can close the softKeyboard
    FocusManager.instance.primaryFocus!.unfocus();
  }

  ///judge whether the soft key board is open
  ///@return : whether the soft keyboard is open
  static bool softKeyboardIsOpen() => (Get.context as BuildContext).mediaQueryViewInsets.bottom > 0;

  ///show the toast by the the state
  ///@param errorMsg : if state is error or false , it will show the message
  ///@param successMsg : if state is successfully or true , it will show the message
  ///@param state : the state which will be judged
  static void showToast(String errorMsg, {String? successMsg, dynamic state}) {
    //if the state is null , we will show the toast
    if (state == null) {
      SmartDialog.showToast(errorMsg);
    }
    //if the state is false, we will show the toast
    else if (state is bool && !state) {
      SmartDialog.showToast(errorMsg);
    } else if (successMsg != null) {
      SmartDialog.showToast(successMsg);
    }
  }
}

/// the screen direction
enum ScreenDirection {
  Portrait,
  Landscape,
}

/// the status bar state
enum OperationBarState {
  Hide,
  Show,
}
