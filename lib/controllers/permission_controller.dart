import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/notification/notification_manager.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class PermissionController extends GetxController {
  static PermissionController get instance => Get.find();

  AndroidDeviceInfo? androidInfo;

  void initAndroidInfo() async {
    if (!GetPlatform.isAndroid) {
      return;
    }

    try {
      androidInfo = await DeviceInfoPlugin().androidInfo;
    } catch (e, stackTrace) {
      _log.e('Cannot get android info.', e, stackTrace);
    }
  }

  Permission get videoPermission {
    Permission requiredPermission = Permission.photos;
    if (GetPlatform.isAndroid && androidInfo != null) {
      // in Android >= 13 videos permission is needed instead of storage
      if (androidInfo!.version.sdkInt >= 33) {
        requiredPermission = Permission.videos;
      } else {
        requiredPermission = Permission.storage;
      }
    }
    return requiredPermission;
  }

  Future<bool> get hasNotificationPermission async {
    final status = await Permission.notification.status;
    return status.isGranted || status.isLimited;
  }

  Future<PermissionState> getGalleryPermission() async {
    return await PhotoManager.getPermissionState(requestOption: const PermissionRequestOption());
  }

  Future<bool> checkContactsPermission() async {
    return await checkAndRequestPermission(
      requiredPermission: Permission.contacts,
      dialogIconPath: 'assets/images/v2/share_contact.png',
      dialogTitle: 'Grant contacts access'.tr,
      dialogDescription: 'Access your contacts in UChat by granting contacts permission'.tr,
      deniedMessage: 'Cannot access contacts, because permission is denied.'.tr,
    );
  }

  Future<bool> checkGalleryPermission() async {
    final permissionState = await PhotoManager.getPermissionState(requestOption: const PermissionRequestOption());

    /// User has not yet been asked for permission or denied permission
    if (permissionState == PermissionState.notDetermined || permissionState == PermissionState.denied) {
      // prevent multiple dialogs
      Get.closeAllSnackbars();
      final result = await UChatDialog.showPermissionDialog(
        iconPath: 'assets/images/v2/permission_gallery_icon.png',
        title: 'Grant photo and album access'.tr,
        description: 'Send photo from your album in UChat by granting photo and album permission'.tr,
        onGrantPressed: () {},
      );

      if (result == null) {
        return false;
      }

      if (result == true) {
        if (Platform.isAndroid) {
          if (permissionState == PermissionState.denied) {
            eventBus.fire(PasscodePreventEvent(preventActivate: true));
            final permissionProvided = await PhotoManager.requestPermissionExtend();

            if (permissionProvided == PermissionState.denied) {
              await PhotoManager.openSetting();
              return false;
            }

            if (permissionProvided == PermissionState.authorized) {
              return true;
            }
          }
        }

        if (Platform.isIOS) {
          eventBus.fire(PasscodePreventEvent(preventActivate: true));
          final permissionProvided = await PhotoManager.requestPermissionExtend();

          if (permissionProvided == PermissionState.denied) {
            await PhotoManager.openSetting();
            return false;
          }

          if (permissionProvided == PermissionState.limited) {
            return true;
          }
        }
      }
    }

    if (permissionState == PermissionState.authorized) {
      return true;
    }

    if (permissionState == PermissionState.limited) {
      /// This permission state on android only, it means user has granted permission but not all of it
      /// so add button to open select medias dialog
      /// but if user has granted limited permission, on first time dialog will be shown permission will be granted forever till user change it manually in settings
      return true;
    }

    if (permissionState == PermissionState.restricted) {
      _log.w('Permission restricted by policy');
    }

    return false;
  }

  Future<bool> checkVideoPermission() async {
    return await checkAndRequestPermission(
      requiredPermission: videoPermission,
      dialogIconPath: 'assets/images/v2/permission_gallery_icon.png',
      dialogTitle: 'Grant photo and album access'.tr,
      dialogDescription: 'Send photo from your album in UChat by granting photo and album permission'.tr,
      deniedMessage: 'Cannot access video, because permission is denied.'.tr,
    );
  }

  Future<bool> checkCameraPermission() async {
    return await checkAndRequestPermission(
      requiredPermission: Permission.camera,
      dialogIconPath: 'assets/images/v2/permission_camera_icon.png',
      dialogTitle: 'Grant camera access'.tr,
      dialogDescription: 'Use Call feature or take a picture in UChat by granting camera permission'.tr,
      deniedMessage: 'Cannot access camera, because permission is denied.'.tr,
    );
  }

  Future<bool> isNotificationPermissionGranted() async {
    final status = await Permission.notification.status;

    return status.isGranted || status.isLimited;
  }

  Future<bool> checkNotificationPermission() async {
    // For check first time permission status
    // and after accept permission will call to one signal to register notification
    final firstResult = await Permission.notification.status;
    if (firstResult.isGranted || firstResult.isLimited) {
      return true;
    }

    final result = await checkAndRequestPermission(
      requiredPermission: Permission.notification,
      dialogIconPath: 'assets/images/v2/permission_noti_icon.png',
      dialogTitle: 'Grant notification access'.tr,
      dialogDescription: 'Keep up with updates in UChat by granting notification permission'.tr,
      deniedMessage: 'Cannot show notification, because permission is denied.'.tr,
      openSettingOnDenied: true,
    );

    // Try to register notification after user accept permission
    if (result == true) {
      await GetIt.I<NotificationManager>().onAuthenticated();
    }

    return result;
  }

  Future<bool> checkMicrophonePermission() async {
    return await checkAndRequestPermission(
      requiredPermission: Permission.microphone,
      dialogIconPath: 'assets/images/v2/permission_microphone_icon.png',
      dialogTitle: 'Grant microphone access'.tr,
      dialogDescription: 'Use Call feature or record a message in UChat by granting microphone permission'.tr,
      deniedMessage: 'Cannot use microphone, because permission is denied.'.tr,
    );
  }

  Future<bool> checkPhonePermission() async {
    return await checkAndRequestPermission(
      requiredPermission: Permission.phone,
      dialogIconPath: 'assets/images/v2/permission_phone_icon.png',
      dialogTitle: 'Grant phone access'.tr,
      dialogDescription: 'Use Call feature to call your friends in UChat by granting phone permission'.tr,
      deniedMessage: 'Cannot use phone, because permission is denied.'.tr,
    );
  }

  Future<bool> checkLocationPermission() async {
    return await checkAndRequestPermission(
      requiredPermission: Permission.location,
      dialogIconPath: 'assets/images/v2/permission_location_icon.png',
      dialogTitle: 'Grant location access'.tr,
      dialogDescription: 'Send location to your friends in UChat by granting location permission'.tr,
      deniedMessage: 'Cannot use location, because permission is denied.'.tr,
    );
  }

  /// Check and request permission needed for call feature.
  /// Return whether minimum permission (microphone and phone) needed for call feature is granted or not
  Future<bool> checkPermissionBeforeCall({CallMethodType? callType}) async {
    bool microphonePerm = await checkMicrophonePermission();
    bool? cameraPerm;
    if (callType?.isVideo == true) {
      cameraPerm = await checkCameraPermission();
    }
    // ios doesn't need phone permission
    //! Deprecated, this permission required for contact access to using history phone
    //! but it bugs and being complicated.
    // bool phonePerm = true;
    // if (Platform.isAndroid) {
    //   phonePerm = await checkPhonePermission();
    // }

    return microphonePerm && (cameraPerm ?? true);
    // return microphonePerm && phonePerm;
  }

  Future<bool> checkAndRequestPermission({
    required Permission requiredPermission,
    required String dialogIconPath,
    required String dialogTitle,
    required String dialogDescription,
    required String deniedMessage,
    bool openSettingOnDenied = false,
  }) async {
    final status = await requiredPermission.status;

    // If already granted or limited, just return true
    if (status.isGranted || status.isLimited) {
      return true;
    }

    // If permission is permanently denied or simply denied in iOS (since iOS has no `don't ask again` option)
    if (status.isPermanentlyDenied) {
      await UChatDialog.showPermissionDialog(
        iconPath: dialogIconPath,
        title: dialogTitle,
        description: dialogDescription,
        onGrantPressed: () {
          eventBus.fire(PasscodePreventEvent(preventActivate: true));
          openAppSettings();
        },
      );

      return false;
    }

    if (status.isDenied || status.isProvisional) {
      final result = await requiredPermission.request();
      if (result.isGranted || result.isLimited) {
        eventBus.fire(PasscodePreventEvent(preventActivate: true));
        return true;
      }
    }

    return false;
  }

  Future<bool> getPermissionStatus(Permission perm) async {
    return await perm.status.isGranted;
  }

  Future<bool> requestPermission(Permission perm) async {
    final result = await perm.request();
    if (result.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    if (result.isDenied) {
      return false;
    }
    return true;
  }

  Future<bool> requestGalleryPermissionDirect(BuildContext context) async {
    final permission = await PhotoManager.requestPermissionExtend();

    // If already granted or limited, just return true
    if (permission == PermissionState.authorized) {
      return true;
    }

    if (permission == PermissionState.limited) {
      await PhotoManager.presentLimited();
      return true;
    }

    // If "permanently denied," we can’t show the OS dialog anymore — user must go to Settings
    if (permission == PermissionState.denied && context.mounted) {
      // You can optionally show a dialog or just open settings directly:
      _showOpenSettingsDialog(
        context,
        title: 'Allow UChat to access your camera and photos in your device’s settings.'.tr,
      );

      return false;
    }

    if (permission == PermissionState.restricted) {
      _log.w('Permission restricted by policy');
    }

    // Otherwise, request permission from the OS — this will trigger the native iOS/Android dialog:
    final result = await PhotoManager.requestPermissionExtend();
    if (result == PermissionState.authorized) {
      return true;
    }

    if (result == PermissionState.limited) {
      await PhotoManager.presentLimited();
      return true;
    }

    if (result == PermissionState.denied && context.mounted) {
      // If user selects “Don’t allow” (and checked ‘Never ask again’ on Android),
      // open settings or show a custom alert that leads to settings.
      _showOpenSettingsDialog(
        context,
        title: 'Allow UChat to access your camera and photos in your device’s settings.'.tr,
      );
    }

    return false;
  }

  Future<bool> requestCameraPermissionDirect(BuildContext context) async {
    final Permission permission = Permission.camera;
    final status = await permission.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied && context.mounted) {
      await _showOpenSettingsDialog(
        context,
        title: 'Allow UChat to access your camera and photos in your device’s settings.'.tr,
      );

      return false;
    }

    final result = await permission.request();
    if (result.isGranted) {
      return true;
    } else if (result.isPermanentlyDenied && context.mounted) {
      await _showOpenSettingsDialog(
        context,
        title: 'Allow UChat to access your camera and photos in your device’s settings.'.tr,
      );
    }

    return false;
  }

  Future<bool> requestContactPermissionDirect(BuildContext context) async {
    final Permission permission = Permission.contacts;
    final status = await permission.status;

    // If already granted or limited, just return true
    if (status.isGranted || status.isLimited) {
      return true;
    }

    // If "permanently denied," we can’t show the OS dialog anymore — user must go to Settings
    if (status.isPermanentlyDenied) {
      // You can optionally show a dialog or just open settings directly:
      _showOpenSettingsDialog(context, title: 'Allow UChat to access your contact in your device’s settings.');

      return false;
    }

    // Otherwise, request permission from the OS — this will trigger the native iOS/Android dialog:
    final result = await permission.request();
    if (result.isGranted || result.isLimited) {
      return true;
    }
    if (result.isPermanentlyDenied) {
      // If user selects “Don’t allow” (and checked ‘Never ask again’ on Android),
      // open settings or show a custom alert that leads to settings.
      _showOpenSettingsDialog(context, title: 'Allow UChat to access your contact in your device’s settings.');
    }

    return false;
  }

  Future<bool> requestLocationPermissionDirect(BuildContext context) async {
    final Permission permission = Permission.location;
    final status = await permission.status;

    // If already granted or limited, just return true
    if (status.isGranted || status.isLimited) {
      return true;
    }

    // If "permanently denied," we can’t show the OS dialog anymore — user must go to Settings
    if (status.isPermanentlyDenied) {
      // You can optionally show a dialog or just open settings directly:
      _showOpenSettingsDialog(context, title: 'Allow UChat to access your location in your device’s settings.');

      return false;
    }

    // Otherwise, request permission from the OS — this will trigger the native iOS/Android dialog:
    final result = await permission.request();
    if (result.isGranted || result.isLimited) {
      return true;
    }
    if (result.isPermanentlyDenied) {
      // If user selects “Don’t allow” (and checked ‘Never ask again’ on Android),
      // open settings or show a custom alert that leads to settings.
      _showOpenSettingsDialog(context, title: 'Allow UChat to access your location in your device’s settings.');
    }

    return false;
  }

  Future<bool> requestMicrophonePermissionDirect(BuildContext context) async {
    final Permission permission = Permission.microphone;
    final status = await permission.status;

    // If already granted or limited, just return true
    if (status.isGranted || status.isLimited) {
      return true;
    }

    // If "permanently denied," we can’t show the OS dialog anymore — user must go to Settings
    if (status.isPermanentlyDenied) {
      // You can optionally show a dialog or just open settings directly:
      await _showOpenSettingsDialog(
        context,
        title: 'Allow UChat to access your microphone under UChat in your device’s settings.'.tr,
      );

      return false;
    }

    // Otherwise, request permission from the OS — this will trigger the native iOS/Android dialog:
    final result = await permission.request();
    if (result.isGranted || result.isLimited) {
      return true;
    }
    if (result.isPermanentlyDenied) {
      // If user selects “Don’t allow” (and checked ‘Never ask again’ on Android),
      // open settings or show a custom alert that leads to settings.
      await _showOpenSettingsDialog(
        context,
        title: 'Allow UChat to access your microphone under UChat in your device’s settings.'.tr,
      );
    }

    return false;
  }

  /// Helper to display your custom dialog with "Cancel" / "Settings"
  /// when user has permanently denied permission.
  Future<void> _showOpenSettingsDialog(BuildContext context, {required String title}) async {
    await UChatNewDialog.showSettingAppDialog(
      context: context,
      title: title,
      onConfirm: () {
        // Close the dialog
        Get.back();

        // Then open settings
        openAppSettings();
      },
    );
  }
}
