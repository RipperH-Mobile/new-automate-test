import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_help_center/setting_help_center_controller.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

class SettingHelpCenterDesktopScreen extends GetView<SettingHelpCenterController> {
  const SettingHelpCenterDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return ScaffoldBasic(
      appBar: buildSettingAppBar(
        centerTitle: true,
        title: 'Help Center'.tr,
      ),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SettingSpacer(),
                const SettingDivider(),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Need help?'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'If you encounter any issues using our app that affect your experience, you can report problems or seek troubleshooting guidance by adding the Help Center account as a friend to contact our admins promptly.'
                                  .tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Color(0xff999999),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.zero,
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                color: Colors.grey.shade100),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/images/v2/help_center_uchat.png',
                                    width: 56.h,
                                    height: 56.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Help Center',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Contact admin UCHAT'.tr,
                                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Obx(
                                    () {
                                      return controller.hasIdHelpCenter.value == true
                                          ? controller.isFriend() == false
                                              ? buildAddOAButton()
                                              : buildOpenChatWithOA()
                                          : Container();
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SettingDivider(),
              ],
            ),
          ),
        ],
      ),
    );
    // });
  }

  Widget buildAddOAButton() {
    return TextButton(
      onPressed: () async {
        await controller.handleAddHelpCenter();
      },
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          const Size(82, 36),
        ),
        backgroundColor: WidgetStateProperty.all(
          UTheme.color.primary,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Text(
        'Add'.tr,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildOpenChatWithOA() {
    return TextButton(
      onPressed: () {
        controller.handleOpenChatOA();
      },
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          const Size(82, 36),
        ),
        backgroundColor: WidgetStateProperty.all(
          const Color(0xFFE0EFFF),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color(0xFFD5EAFF),
            ),
          ),
        ),
      ),
      child: Text(
        'Chat'.tr,
        style: TextStyle(
          color: UTheme.color.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
