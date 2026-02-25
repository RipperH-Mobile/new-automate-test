import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/screens/setting_friends/setting_friends_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class FriendSetting extends GetView<SettingFriendsController> {
  const FriendSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpace.space4,
      children: [
        SettingFrameContainer.withChildren(
          context: context,
          header: AppText.body4Bold(
            'Friend setting'.tr,
            context: context,
            color: context.theme.appColors.textDark,
          ),
          children: [
            Obx(
              () {
                return UChatSwitchRowMenu(
                  title: 'Allow others to add friends'.tr,
                  subTitle: 'You can turn off friend search or add you\nas a friend from other users.'.tr,
                  value: controller.isAllowAddFriendsByUsername.value,
                  onTap: controller.handleToggleAllowAddFriend,
                  hasBorder: false,
                  padding: const EdgeInsets.only(
                    left: AppSpace.space4,
                    right: AppSpace.space3,
                    top: AppSpace.space3,
                    bottom: AppSpace.space3,
                  ),
                  titleTextStyle: context.theme.appTexts.body1.copyWith(
                    color: context.theme.appColors.textDarkest,
                  ),
                  subTitleTextStyle: context.theme.appTexts.body4.copyWith(
                    color: context.theme.appColors.textLight,
                  ),
                );
              },
            ),
            Obx(
              () {
                if (controller.isAllowAddFriendsByUsername.value) {
                  return UChatSwitchRowMenu(
                    title: 'Allow to add friends by phone number'.tr,
                    value:
                        controller.isAllowAddFriendsByUsername() ? controller.isAllowAddFriendsByPhoneNumber() : false,
                    onTap: controller.isAllowAddFriendsByUsername()
                        ? controller.handleToggleAllowAddFriendByPhoneNumber
                        : null,
                    hasBorder: false,
                    padding: const EdgeInsets.only(
                      left: AppSpace.space4,
                      right: AppSpace.space3,
                      top: AppSpace.space3,
                      bottom: AppSpace.space3,
                    ),
                    titleTextStyle: context.theme.appTexts.body1.copyWith(
                      color: context.theme.appColors.textDarkest,
                    ),
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
                    value:
                        controller.isAllowAddFriendsByUsername() ? controller.isAllowGroupMembersToAddFriends() : false,
                    onTap: controller.isAllowAddFriendsByUsername()
                        ? controller.handleToggleAllowGroupMemberToAddFriends
                        : null,
                    hasBorder: false,
                    padding: const EdgeInsets.only(
                      left: AppSpace.space4,
                      right: AppSpace.space3,
                      top: AppSpace.space3,
                      bottom: AppSpace.space3,
                    ),
                    titleTextStyle: context.theme.appTexts.body1.copyWith(
                      color: context.theme.appColors.textDarkest,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        SettingFrameContainer.withChildren(
          context: context,
          children: [
            UChatRowMenu(
              title: 'Hidden accounts'.tr,
              onTap: controller.handleHiddenAccount,
              hasBorder: false,
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
                right: AppSpace.space3,
                top: AppSpace.space3,
                bottom: AppSpace.space3,
              ),
              titleTextStyle: context.theme.appTexts.body1.copyWith(
                color: context.theme.appColors.textDarkest,
              ),
            ),
          ],
        ),
        SettingFrameContainer.withChildren(
          context: context,
          children: [
            UChatRowMenu(
              title: 'Blocked accounts'.tr,
              onTap: controller.handleBlockAccount,
              hasBorder: false,
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
                right: AppSpace.space3,
                top: AppSpace.space3,
                bottom: AppSpace.space3,
              ),
              titleTextStyle: context.theme.appTexts.body1.copyWith(
                color: context.theme.appColors.textDarkest,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
