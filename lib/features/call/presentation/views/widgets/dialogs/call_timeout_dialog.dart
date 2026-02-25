import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/widgets/dialog/blur_background_dialog.dart';

Future<void> callTimeoutDialog(
  void Function()? callAgain, {
  String? title,
  String? subTitle,
  String? textButton,
}) async {
  Widget animation = Center(
    child: Transform.scale(
      scale: 1.75,
      child: const Image(
        image: AssetImage('assets/images/uchat_crow.gif'),
        width: 100,
        height: 100,
      ),
    ),
  );
  Widget text = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title ?? 'No answer'.tr,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(height: 5),
      AutoSizeText(
        subTitle ?? 'No response from the destination.'.tr,
        textAlign: TextAlign.start,
        minFontSize: 5,
        maxFontSize: 11,
        maxLines: 1,
        style: const TextStyle(color: Colors.white),
      ),
    ],
  );
  Widget actionButton = Column(
    children: [
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 45),
                backgroundColor: const Color(0xFF56F5B2),
                foregroundColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Get.back();
                callAgain?.call();
              },
              child: Text(
                textButton ?? (callAgain == null ? 'Close'.tr : 'Call Again'.tr),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  await blurBgDialog(
    animation: animation,
    text: text,
    actionButton: actionButton,
  );
}
