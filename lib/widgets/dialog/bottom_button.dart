import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget buildBottomButton({
  required Function onPress,
}) {
  return Obx(() {
    return Container(
      height: 80.spMin,
      padding: EdgeInsets.symmetric(horizontal: 20.spMin, vertical: 18.spMin),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: SizedBox(
        width: Get.width,
        child: TextButton(
          onPressed: () {
            // if (controller.ableToCreate) {
            //   controller.handleConfirmCreateChatFolder;
            // }
            onPress();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
                // controller.ableToCreate ? const Color(0xff0057ff) : const Color(0xFFF2F2F2),
                const Color(0xff0057ff)),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: Text(
            'Create'.tr,
            style: const TextStyle(
                // color: controller.ableToCreate ? Colors.white : const Color(0xFFB3B3B3),
                color: Colors.white),
          ),
        ),
      ),
    );
  });
}
