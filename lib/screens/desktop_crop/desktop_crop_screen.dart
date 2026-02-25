import 'dart:io';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/desktop_crop/desktop_crop_controller.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';

class DesktopCropScreen extends GetView<DesktopCropController> {
  const DesktopCropScreen({
    super.key,
    this.title,
  });

  final String? title;
  bool get isMobile => UChatScreenUtil.instance.isMobile;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: Colors.white,
      appBar: ScaffoldBasic.appBarBasic(
        automaticallyImplyLeading: (Platform.isAndroid || Platform.isIOS) ? true : false,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 12.spMin),
          child: Text(
            title ?? 'Setting group profile.'.tr,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        isCrop: true,
      ),
      child: Column(
        children: [
          Expanded(
            child: CustomImageCrop(
              backgroundColor: Colors.black,
              pathPaint: Paint(),
              cropController: controller.cropCtl,
              image: FileImage(controller.file),
            ),
          ),
          Container(
            color: Colors.black,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.spMin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      Obx(() {
                        return SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: UTheme.color.primary,
                            inactiveTrackColor: Colors.white,
                            trackHeight: 3,
                            thumbColor: Colors.white,
                          ),
                          child: SizedBox(
                            width: Get.width * 0.3,
                            child: Slider(
                              min: 1,
                              max: 10,
                              divisions: 100,
                              value: controller.cropSize(),
                              onChanged: (double value) {
                                controller.handleAdjustSize(value);
                              },
                            ),
                          ),
                        );
                      }),
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 6),
                        child: btnText(
                          txt: 'cancel'.tr,
                          onPressed: Get.back,
                          buttonColor: const Color(0xFFE6E6E6),
                          textColor: const Color(0xFF666666),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6, right: 12),
                        child: btnText(
                          txt: 'Save'.tr,
                          onPressed: controller.handleCrop,
                          buttonColor: UTheme.color.primary,
                          textColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 15.spMin,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget btnText({required String txt, required Function onPressed, Color? buttonColor, Color? textColor}) {
    return SizedBox(
      height: 55.spMin,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            buttonColor ?? Colors.white,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(
          txt,
          style: TextStyle(
            color: textColor ?? const Color(0xFFB3B3B3),
          ),
        ),
      ),
    );
  }
}
