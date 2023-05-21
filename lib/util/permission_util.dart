import 'package:permission_handler/permission_handler.dart';

import 'logger_util.dart';

class PermissionUtil {
  ///request the single permission
  ///@permission : the target permission
  ///@grantCallback : the granted permission callback function
  ///@denyCallback : the denied permission callback function
  ///@needOpenSetting : whether open the app permission  request page when the request is denied
  static void request(Permission permission,
      {void Function()? grantCallback,
      void Function()? denyCallback,
      bool needOpenSetting = false}) {
    permission.request().then((status) {
      switch (status) {
        case PermissionStatus.granted:
        case PermissionStatus.limited:
          grantCallback?.call();
          break;
        case PermissionStatus.denied:
        case PermissionStatus.permanentlyDenied:
          denyCallback?.call();
          if (needOpenSetting) {
            // open the permission setting page
            openAppSettings();
          }
          break;
        case PermissionStatus.restricted:
          Log.e("can't use the permission in the phone");
          break;
      }
    });
  }

  ///request multi permission and handle the result
  ///@permissions : the request permission list
  ///@callback : the handle callback function
  ///@needOpenSetting : whether open the application permission setting page when the request the permission fail
  static void requestMultiPermission(List<Permission> permissions,
      {void Function(Map<Permission, PermissionStatus>)? callback, bool needOpenSetting = false}) {
    permissions.request().then((statusMap) {
      callback?.call(statusMap);
      statusMap.forEach((permission, status) {
        if (needOpenSetting) {
          if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
            openAppSettings();
          }
        }
      });
    });
  }
}
