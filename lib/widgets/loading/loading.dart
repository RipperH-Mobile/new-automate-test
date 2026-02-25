import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';

abstract class IUChatLoading {
  Future<void> show({String? status});
  Future<void> hide();
  Future<void> successWithNoIcon({String? message});
  Future<void> success({String? message, Duration duration});
  void clearToast();
  Future<void> failed({String? message});
  Future<void> showProgress(double value, {String? message, EasyLoadingMaskType? markType});
  Future<void> showCustomOfflineMode();
  Future<void> showWithMessage({required String message});
  Future<void> showWithIconForManageFolder({String? status});
  Future<void> showTextAndIcon({required String status, required String assetPath});
  Future<void> showMessageAndCustomDuration({required String message, required int duration});
}

class UChatLoading {
  @visibleForTesting
  static IUChatLoading? testMode;

  static Future<void> show({String? status}) async {
    if (testMode != null) {
      return testMode!.show(status: status);
    }
    // await EasyLoading.show(
    //   status: status,
    //   maskType: EasyLoadingMaskType.custom,
    // );
    await EasyLoading.show(
      status: status,
      indicator: Container(
        color: Colors.transparent,
        width: 45,
        height: 45,
        // child: Lottie.asset(
        //   'assets/animations/loading_icon.json',
        //   frameRate: FrameRate.max,
        //   reverse: true,
        //   repeat: true,
        // ),
        child: const CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 2,
        ),
      ),
    );
  }

  static Future<void> hide() async {
    if (testMode != null) {
      return testMode!.hide();
    }
    if (EasyLoading.isShow) {
      await EasyLoading.dismiss();
    }
  }

  static Future<void> successWithNoIcon({String? message}) async {
    if (testMode != null) {
      return testMode!.successWithNoIcon(message: message);
    }
    await EasyLoading.showToast(
      message ?? '',
      duration: const Duration(seconds: 1),
    );
  }

  static Future<void> success({String? message, Duration duration = const Duration(seconds: 3)}) async {
    if (testMode != null) {
      return testMode!.success(message: message, duration: duration);
    }
    await hide();
    AppToast.showToast(
      context: Get.context!,
      message: message ?? 'Success'.tr,
      icon: Assets.vectors.check12.svg(
        width: 20.spMin,
        height: 20.spMin,
        colorFilter: ColorFilter.mode(
          Get.context!.theme.appColors.iconPrimaryInverse,
          BlendMode.srcIn,
        ),
      ),
    );
    // await EasyLoading.showSuccess(
    //   message ?? 'Success'.tr,
    //   duration: duration,
    //   dismissOnTap: true,
    // );
  }

  static void clearToast() {
    if (testMode != null) {
      return testMode!.clearToast();
    }
    AppToast.clearToast(Get.context!);
  }

  static Future<void> failed({String? message}) async {
    if (testMode != null) {
      return testMode!.failed(message: message);
    }
    await EasyLoading.showError(
      message ?? 'Failed!'.tr,
      duration: const Duration(seconds: 1),
    );
  }

  static Future<void> showProgress(
    double value, {
    String? message,
    EasyLoadingMaskType? markType,
  }) async {
    if (testMode != null) {
      return testMode!.showProgress(value, message: message, markType: markType);
    }
    await EasyLoading.showProgress(
      value,
      status: (message ?? 'Uploading (@percent)').trParams({
        'percent': (value * 100).toInt().toString(),
      }),
    );
  }

  static Future<void> showWithMessage({required String message}) async {
    if (testMode != null) {
      return testMode!.showWithMessage(message: message);
    }
    await EasyLoading.showToast(
      message,
      duration: const Duration(seconds: 1),
    );
  }

  static Future<void> showWithMessageAndCustomDuration({required String message, required int duration}) async {
    if (testMode != null) {
      return testMode!.showMessageAndCustomDuration(message: message, duration: duration);
    }
    await EasyLoading.showToast(
      message,
      duration: Duration(seconds: duration),
    );
  }

  static Future<void> showWithIconForManageFolder({String? status}) async {
    if (testMode != null) {
      return testMode!.showWithIconForManageFolder(status: status);
    }
    await EasyLoading.show(
      status: status,
      indicator: Container(
        color: Colors.transparent,
        width: 45,
        height: 45,
        child: ImageIcon(
          const AssetImage(
            'assets/images/close_with_circle_icon.png',
          ),
          color: Colors.white,
          size: 20.spMin,
        ),
      ),
    );
  }

  static Future<void> showCustomOfflineMode() async {
    if (testMode != null) {
      return testMode!.showCustomOfflineMode();
    }
    await showTextAndIcon(
      status: 'You are offline.\nPlease try again\nlater.'.tr,
      assetPath: 'assets/images/close_with_circle_icon.png',
    );
  }

  static Future<void> showTextAndIcon({required String status, required String assetPath}) async {
    if (testMode != null) {
      return testMode!.showTextAndIcon(status: status, assetPath: assetPath);
    }
    Timer timer = Timer(const Duration(seconds: 3), () => hide());

    callback(EasyLoadingStatus status) {
      if (status == EasyLoadingStatus.dismiss) {
        timer.cancel();
        EasyLoading.removeCallback(callback);
      }
    }

    EasyLoading.addStatusCallback(callback);

    await EasyLoading.show(
      status: status,
      // 'You are offline.\nPlease try again\nlater.'.tr,
      dismissOnTap: true,
      indicator: Container(
        color: Colors.transparent,
        width: 40.spMin,
        height: 40.spMin,
        child: ImageIcon(
          ResizeImage(
            // const AssetImage('assets/images/close_with_circle_icon.png'),
            AssetImage(assetPath),
            width: 65.cacheSize,
          ),
          color: Colors.white,
          size: 20.spMin,
        ),
      ),
    );
  }
}
