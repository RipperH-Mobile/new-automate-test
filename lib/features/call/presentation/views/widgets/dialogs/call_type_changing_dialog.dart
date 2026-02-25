import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/widgets/dialog/blur_background_dialog.dart';

Future<void> callTypeChangeDialog(void Function()? buttonAction, void Function()? onClose) async {
  Widget animation = Stack(
    alignment: AlignmentDirectional.centerStart,
    children: [
      Center(
        child: Transform.scale(
          scale: 1.75,
          child: const Image(
            image: AssetImage('assets/images/uchat_dino_background.png'),
            width: 100,
            height: 100,
          ),
        ),
      ),
      Transform.scale(
        scale: 1.75,
        child: const Image(
          image: AssetImage('assets/images/uchat_dino.gif'),
          width: 100,
          height: 100,
        ),
      ),
    ],
  );
  Widget text = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Internet unstable'.tr,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      const SizedBox(height: 5),
      AutoSizeText(
        'Please check your internet connection'.tr,
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
                backgroundColor: const Color(0xFF666666),
                foregroundColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Get.back();
                buttonAction?.call();
                onClose?.call();
              },
              child: Text(
                'Change to voice call'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 13),
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
    onClose: onClose,
    barrierDismissible: true,
  );
}
