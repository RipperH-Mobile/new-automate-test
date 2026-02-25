import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/utils/dimensions.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';

import 'setting_friends_controller.dart';

@Deprecated('Use FriendSetting instead')
class SettingFriendsScreen extends GetView<SettingFriendsController> {
  const SettingFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return ScaffoldBasic(
      appBar: buildSettingAppBar(centerTitle: !isMobile, title: 'Friends'.tr),
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
                  const SettingSpacer(),
                  Obx(
                    () {
                      return UChatSwitchRowMenu(
                        height: 100.spMin,
                        title: 'Allow others to add friends'.tr,
                        subTitle: 'you can turn off searching or adding \nfriends from other people'.tr,
                        value: controller.isAllowAddFriendsByUsername.value,
                        onTap: controller.handleToggleAllowAddFriend,
                        hasVerticalBorder: true,
                        hasHorizontalBorder: !isMobile,
                        borderRadius: !isMobile
                            ? controller.isAllowAddFriendsByUsername.value
                                ? 0
                                : 10
                            : 0,
                        borderRadiusTop: !isMobile ? controller.isAllowAddFriendsByUsername.value : false,
                      );
                    },
                  ),
                  Obx(
                    () {
                      if (controller.isAllowAddFriendsByUsername.value) {
                        return UChatSwitchRowMenu(
                          title: 'Allow others to add friends \nby phone number'.tr,
                          height: 80.hr,
                          value: controller.isAllowAddFriendsByUsername()
                              ? controller.isAllowAddFriendsByPhoneNumber()
                              : false,
                          onTap: controller.isAllowAddFriendsByUsername()
                              ? controller.handleToggleAllowAddFriendByPhoneNumber
                              : null,
                          hasBottomBorder: true,
                          hasHorizontalBorder: !isMobile,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Obx(
                    () {
                      if (controller.isAllowAddFriendsByUsername.value) {
                        return UChatSwitchRowMenu(
                          title: 'Allow group member to add friend'.tr,
                          value: controller.isAllowAddFriendsByUsername()
                              ? controller.isAllowGroupMembersToAddFriends()
                              : false,
                          onTap: controller.isAllowAddFriendsByUsername()
                              ? controller.handleToggleAllowGroupMemberToAddFriends
                              : null,
                          hasBottomBorder: true,
                          hasHorizontalBorder: !isMobile,
                          borderRadiusBottom: !isMobile,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SettingSpacer(),
                  UChatRowMenu(
                    title: 'Hidden accounts'.tr,
                    onTap: controller.handleHiddenAccount,
                    hasVerticalBorder: true,
                    hasHorizontalBorder: !isMobile,
                    borderRadiusTop: !isMobile,
                  ),
                  UChatRowMenu(
                    title: 'Blocked accounts'.tr,
                    onTap: controller.handleBlockAccount,
                    hasBottomBorder: true,
                    hasHorizontalBorder: !isMobile,
                    borderRadiusBottom: !isMobile,
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
