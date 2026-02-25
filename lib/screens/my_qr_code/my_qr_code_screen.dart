import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uchat/features/add_contact/presentation/widgets/my_qr_code.dart';
import 'package:uchat/screens/my_qr_code/widgets/action_button.dart';

import 'my_qr_code_controller.dart';

class MyQrCodeScreen extends GetView<MyQrCodeController> {
  const MyQrCodeScreen({super.key});

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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 20),
              child: Container(
                width: 65.spMin,
                height: 6.spMin,
                decoration: ShapeDecoration(
                  color: const Color(0xFFCCCCCC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30.spMin,
              ),
              Text(
                'My QR Code'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  // fontFamily: 'newUiFont',
                  fontSize: 18.spMin,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  height: 30.spMin,
                  width: 30.spMin,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: controller.handleBack,
                    child: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Expanded(child: Container()),
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
                      return MyQrCode(
                        qrCodeData: controller.qrCodeData.value,
                        width: 300.spMin,
                        height: 300.spMin,
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Use this QR code to let other users\nScan to add you as a friend'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        // fontFamily: 'newUiFont',
                        fontSize: 14.spMin,
                        color: Colors.grey.shade500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            ActionButton(
                              onPressed: controller.handleShareQr,
                              imagePath: 'assets/images/upload_icon_2.png',
                            ),
                            Text(
                              'Share'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                // fontFamily: 'newUiFont',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ActionButton(
                              onPressed: () => controller.handleDownloadQr(context),
                              imagePath: 'assets/images/download_icon_2.png',
                            ),
                            Text(
                              'Save'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                // fontFamily: 'newUiFont',
                                fontSize: 14,
                              ),
                            ),
                          ],
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
