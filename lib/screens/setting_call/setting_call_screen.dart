import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

// import 'package:uchat/utils/app_env.dart';
import 'package:uchat/widgets.dart';

import 'setting_call_controller.dart';

class SettingCallScreen extends GetView<SettingCallController> {
  const SettingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return ScaffoldBasic(
      appBar: buildSettingAppBar(centerTitle: !isMobile, title: 'Call'.tr),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: !isMobile
                  ? EdgeInsets.symmetric(
                      horizontal: 31.spMin,
                      vertical: 20.spMin,
                    )
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._buildMenus(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenus(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return [
      const SettingSpacer(),
      Obx(() {
        return UChatSwitchRowMenu(
          height: 100.spMin,
          title: 'Allow incoming call'.tr,
          subTitle: 'You can disable call if you don\'t need to get an incoming call or any messages about calling'.tr,
          value: controller.isAllowIncomingCall.value,
          onTap: controller.toggleAllowIncomingCall,
          hasVerticalBorder: true,
          hasHorizontalBorder: !isMobile,
          borderRadius: !isMobile
              ? controller.isAllowIncomingCall()
                  ? 10
                  : 10
              : 0,
        );
      }),
      if (isMobile)
        Obx(() {
          String platform = '';
          if (GetPlatform.isIOS) {
            platform = 'iPhone';
          }
          if (GetPlatform.isAndroid) {
            platform = 'Call system';
          }
          if (controller.isAllowIncomingCall()) {
            return Column(
              children: [
                UChatSwitchRowMenu(
                  height: 100.spMin,
                  title: 'Make a call with @platform'.trParams({
                    'platform': platform,
                  }),
                  subTitle: 'Enable call as a system call and get call history information from @platform'.trParams({
                    'platform': platform,
                  }),
                  value: controller.isAllowCallkit.value,
                  onTap: controller.toggleAllowCallkit,
                  hasBottomBorder: true,
                  hasHorizontalBorder: !isMobile,
                  borderRadiusBottom: !isMobile,
                ),
              ],
            );
          }
          return const SizedBox();
        }),
      // if (AppEnv.isTest) ...[
      //   const SettingSpacer(),
      //   UChatRowMenu(
      //     title: 'Call log (Debug)'.tr,
      //     onTap: controller.openCallLogFile,
      //   )
      // ]
    ];
  }
}
