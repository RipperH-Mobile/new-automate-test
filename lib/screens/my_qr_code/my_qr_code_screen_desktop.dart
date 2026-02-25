import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uchat/screens/my_qr_code/widgets/action_button.dart';

import 'my_qr_code_controller.dart';

class MyQrCodeScreenDesktop extends GetView<MyQrCodeController> {
  const MyQrCodeScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  'My QR Code'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: controller.handleBack,
                    child: const Icon(
                      Icons.cancel,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              height: 1,
              color: Color(0xffe6e6e6),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
            width: Get.width,
            color: Colors.grey.shade100,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Screenshot(
                    controller: controller.screenshotController,
                    child: Obx(() {
                      return QrImageView(
                        key: controller.qrCodeGlobalKey,
                        backgroundColor: Colors.white,
                        data: controller.qrCodeData(),
                        version: QrVersions.auto,
                        size: 280,
                        embeddedImage: const AssetImage(
                          'assets/images/uchat_logo_with_bg.png',
                        ),
                        errorCorrectionLevel: controller.errorCorrectionLevel(),
                        padding: const EdgeInsets.all(15),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 4.spMin,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Use this QR code to let other users\nScan to add you as a friend'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        ActionButton(
                          onPressed: () => controller.handleDownloadQr(context),
                          imagePath: 'assets/images/download_icon_2.png',
                        ),
                        Text(
                          'Save'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
