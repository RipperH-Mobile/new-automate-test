import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class NoPermissionException implements Exception {
  /// The permission that is not granted.
  ///
  /// For the camera permission
  final Permission? permission;

  /// The state of the permission.
  ///
  /// If the permission is not granted, this will be `PermissionState.denied`.
  ///
  /// For the gallery permission
  final PermissionState? permissionState;

  String get message {
    return 'Permission $permission is not granted';
  }

  NoPermissionException({this.permission, this.permissionState});
}
