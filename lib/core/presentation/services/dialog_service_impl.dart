import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/services/dialog_service.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/accounts_center/domain/services/accounts_center_service.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/utils/screen_size.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class DialogServiceImpl implements DialogService {
  static const sessionExpireDialogRouteName = 'SESSION_EXPIRE_DIALOG';

  bool _isUpdateDialogShowing = false;

  @override
  Future<bool> showAppUpdateDialog({bool forceUpdate = false}) async {
    if (_isUpdateDialogShowing) {
      Get.back();
    }

    _isUpdateDialogShowing = true;

    if (forceUpdate) {
      final completion = Completer<bool>();

      UChatDialog.showAlertDialog(
        title: 'New update available'.tr,
        description: 'New version is available. Please update to the latest version to use application'.tr,
        buttonText: 'Update'.tr,
        closeDialogOnConfirm: false,
        barrierDismissible: false,
        onPressed: () async {
          await UChatCallController.instance.removeExistingCall();
          if (!completion.isCompleted) completion.complete(true);
          Get.back();
          _isUpdateDialogShowing = false;
        },
        descriptionTextStyle: _getDescriptionTextStyle(),
        buttonTextStyle: _getButtonTextStyle(),
        canPopScope: false,
      );

      return completion.future;
    }

    final result = await UChatDialog.showDialog(
      title: 'New update available'.tr,
      description: 'New version is available. Please update to the latest version for best experience'.tr,
      confirmText: 'Update now !'.tr,
      cancelText: 'Later'.tr,
      closeDialogOnConfirm: false,
      onConfirm: () async {
        await UChatCallController.instance.removeExistingCall();
      },
      descriptionTextStyle: _getDescriptionTextStyle(),
      confirmButtonTextStyle: _getConfirmButtonTextStyle(),
      cancelButtonTextStyle: _getCancelButtonTextStyle(),
    );

    _isUpdateDialogShowing = false;
    return result;
  }

  @override
  Future<void> showSessionExpireDialog({Function? customOnConfirm}) async {
    // Prevent duplicate dialogs
    if (Get.isDialogOpen == true && Get.routing.route?.settings.name == sessionExpireDialogRouteName) {
      return;
    }
    // If there isn't any user logged in do nothing.
    if (UserController.instance.currentUser.value == null) {
      return;
    }

    UChatNewDialog.showSingleButtonDialog(
      context: Get.context!,
      title: 'You cannot access account'.tr,
      description: 'Due to your account being forced to sign out. You cannot access accounts'.tr,
      confirmText: 'Continue'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      barrierDismissible: false,
      routeSettings: const RouteSettings(name: sessionExpireDialogRouteName),
      onConfirm: () async {
        if (customOnConfirm != null) {
          customOnConfirm();
          return;
        }
        await GetIt.I<AccountsCenterService>().logoutCurrentUser(showDialog: false);
      },
    );
  }

  TextStyle _getDescriptionTextStyle() {
    return UChatDialog.defaultDescriptionTextStyle.copyWith(
      fontSize: isSmallScreen ? 10 : null,
    );
  }

  TextStyle _getButtonTextStyle() {
    return UChatDialog.defaultCancelButtonTextStyle.copyWith(
      fontSize: isSmallScreen ? 10 : null,
      color: Colors.white,
    );
  }

  TextStyle _getConfirmButtonTextStyle() {
    return UChatDialog.defaultDescriptionTextStyle.copyWith(
      fontSize: isSmallScreen ? 12 : null,
      color: Colors.white,
    );
  }

  TextStyle _getCancelButtonTextStyle() {
    return UChatDialog.defaultDescriptionTextStyle.copyWith(
      fontSize: isSmallScreen ? 12 : null,
    );
  }
}
