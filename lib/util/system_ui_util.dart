import 'package:flutter/services.dart';

///it's used to control the application UI layer
class SystemUiUtil {
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
