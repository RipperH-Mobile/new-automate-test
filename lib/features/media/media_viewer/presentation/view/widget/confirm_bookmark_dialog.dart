import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';

class ConfirmUnBookmarkDialog {
  static Future<bool> show() async {
    final result = await UChatDialog.showDialog(
      backgroundColor: Colors.white,
      title: 'Unbookmark'.tr,
      titleTextStyle: TextStyle(
        fontSize: 18.spMin,
        fontWeight: FontWeight.w600,
      ),
      customDescription: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'You want to save bookmark '.tr,
          style: DefaultTextStyle.of(Get.context!).style.copyWith(
                color: const Color(0xFF808080),
                fontWeight: FontWeight.w400,
                fontSize: 14.spMin,
              ),
          children: [
            TextSpan(
              text: '@by deleting @count message@s'.trParams(
                {
                  'by ': 'by ',
                  'count': '1',
                  's': '',
                },
              ),
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const TextSpan(
              text: ' ?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      confirmText: 'Confirm'.tr,
      confirmButtonColor: UTheme.color.primary,
      cancelButtonTextStyle: TextStyle(
        color: Colors.grey,
        fontSize: 14.spMin,
        fontWeight: FontWeight.w600,
      ),
      showCloseButton: true,
    );

    return result;
  }
}
