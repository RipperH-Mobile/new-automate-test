import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uchat/api/payloads/premium_package/send_reason_cancel.dart';
import 'package:uchat/api/services/premium_package_service.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PremiumCancelController extends SubscriptionController {
  final isCheck = 0.obs;
  final txtReason = ''.obs;
  final expiredDate = ''.obs;

  UserEntity? get currentUser => UserController.instance.currentUser();

  @override
  onInit() {
    DateTime? expiredAt = currentUser?.premiumPackage?.expireAt ?? DateTime.now();
    expiredDate.value = DateFormat('d MMM yyyy').format(expiredAt);
    super.onInit();
  }

  void handleBack() {
    Get.back();
  }

  Future<bool> handleConfirm() {
    return UChatDialog.showDialog(
      showCloseButton: true,
      title: 'Finish cancelling in manage subscription setting'.tr,
      titleTextStyle: TextStyle(
        fontSize: 18.spMin,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF333333),
      ),
      description: 'We\'ll take you to manage subscription setting.'.tr,
      descriptionTextStyle: TextStyle(
        fontSize: 12.spMin,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF808080),
      ),
      confirmText: 'Go to setting'.tr,
      confirmButtonColor: const Color(0xFFFF1552),
      onConfirm: onConfirmDialog,
      cancelText: 'Keep Premium'.tr,
      cancelButtonColor: const Color(0xFFF2F2F2),
      buttonDirection: Axis.vertical,
    );
  }

  void onConfirmDialog() async {
    await PremiumPackageService().sendReasonCancel(
      request: SendReasonCancelRequest(
        reason: txtReason.value,
        description: '',
      ),
    );
    openSubscriptionSettings();
  }

  void openSubscriptionSettings() async {
    try {
      if (Platform.isIOS) {
        await handleIosManageSubscription();
      } else {
        // TODO: added android subscription setting.
        throw 'Not supported platform';
      }
    } catch (e) {
      // Using deep link instead of platform channel.
      String url = '';
      if (Platform.isIOS) {
        url = 'https://apps.apple.com/account/subscriptions';
      } else if (Platform.isAndroid) {
        url = 'https://play.google.com/store/account/subscriptions';
      }
      if (await canLaunchUrlString(url)) {
        await launchUrlString(
          url,
        ); // Opens the URL in Safari for iOS
      } else {
        throw 'Could not launch $url';
      }
    } finally {
      Get.until((r) => r.settings.name == Routes.settingPremiumPackage);
    }
  }
}
