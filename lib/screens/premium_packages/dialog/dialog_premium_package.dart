import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/premium_packages/store/store_controller.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/utils/image/uchat_image.dart';

class DialogPremiumPackage extends GetView<PremiumPackagesStoreController> {
  const DialogPremiumPackage({super.key, required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 490,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Obx(() {
        return controller.isInitial()
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: controller.premiumPackages
                                .elementAtOrNull(level)
                                ?.packDetailTheme
                                ?.bgSubscribeBtn
                                ?.hexToColor
                                .withValues(alpha: 0.2) ??
                            Colors.white,
                        height: 300.spMin,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          child: Obx(() {
                            if (controller.premiumPackages.elementAtOrNull(level)?.dialogTheme?.linkUrl == null) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            return Image(
                              image: UChatImage.networkProvider(
                                  controller.premiumPackages.elementAtOrNull(level)?.dialogTheme?.linkUrl ?? ''),
                              width: Get.width,
                              fit: BoxFit.cover,
                            );
                          }),
                        ),
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 21.spMin),
                            Text(
                              'Welcome to the exclusive\nworld of Premium membership!'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: controller.premiumPackages
                                        .elementAtOrNull(level)
                                        ?.dialogTheme
                                        ?.titleTextColor
                                        ?.hexToColor ??
                                    Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 4.spMin),
                            Text(
                              'Explore all the amazing benefits that await you.'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: controller.premiumPackages
                                        .elementAtOrNull(level)
                                        ?.dialogTheme
                                        ?.subTitleTextColor
                                        ?.hexToColor ??
                                    Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.spMin),
                  Text(
                    'The system will automatically collect money from you.\nand will renew your membership automatically for the\nsame package period at the same price'
                        .tr
                        .tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: controller.premiumPackages
                              .elementAtOrNull(level)
                              ?.dialogTheme
                              ?.descriptionColor
                              ?.hexToColor ??
                          Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 12.spMin),
                  GestureDetector(
                    onTap: () {
                      Get.close(1);
                    },
                    child: Container(
                      width: 300.spMin,
                      height: 50.spMin,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: controller.premiumPackages.elementAtOrNull(level)?.dialogTheme?.buttonColor == null
                            ? null
                            : LinearGradient(
                                colors: listHexToColor(
                                    controller.premiumPackages.elementAtOrNull(level)?.dialogTheme?.buttonColor ?? []),
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Started'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 10.spMin),
                          Container(
                            padding: const EdgeInsets.only(left: 7, right: 7),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.white),
                            child: Text(
                              controller.premiumPackages.elementAtOrNull(level)?.name?.toUpperCase() ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: controller.premiumPackages
                                        .elementAtOrNull(level)
                                        ?.dialogTheme
                                        ?.textRightButtonColor
                                        ?.hexToColor ??
                                    Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.spMin),
                  Text(
                    'You can unsubscribe in the App Store'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: controller.premiumPackages
                              .elementAtOrNull(level)
                              ?.dialogTheme
                              ?.descriptionColor
                              ?.hexToColor ??
                          Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
      }),
    );
  }

  List<Color> listHexToColor(List<String> codes) {
    List<Color> listColor = [];

    for (final code in codes) {
      listColor.add(Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000));
    }

    return listColor;
  }
}
