import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/accounts_center/presentation/controllers/account_setting_controller.dart';
import 'package:uchat/features/accounts_center/presentation/views/widgets/account_info_box.dart';
import 'package:uchat/features/accounts_center/presentation/views/widgets/account_setting_box.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class AccountSettingScreen extends GetView<AccountSettingController> {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.elevationSurfaceDark,
      appBar: AppBarDefault(
        title: 'Account Setting'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
          child: Column(
            children: [
              GetBuilder<AccountSettingController>(
                id: AccountSettingIds.userBox,
                builder: (controller) {
                  return AccountInfoBox(
                    avatarUrl: controller.user.avatarUrl,
                    displayName: controller.user.displayName ?? 'UNKNOWN'.tr,
                    isCurrentAccount: controller.isCurrentAccount,
                    onTapSwitchAccount: () {
                      controller.handleSwitchAccount();
                    },
                  );
                },
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              SettingFrameContainer.withChildren(
                context: context,
                // TODO (design system) Update this when new design system is implemented.
                // customBorderRadius: AppRadius.rounded3xl,
                children: [
                  GetBuilder<AccountSettingController>(
                    id: AccountSettingIds.phoneNumberBox,
                    builder: (controller) {
                      return AccountSettingBox.arrow(
                        context: context,
                        onTap: () {
                          controller.handleOpenAccountPhoneNumber(context);
                        },
                        trailingText: controller.phoneNumber,
                        child: AppText.body1(
                          'Phone number'.tr,
                          color: context.theme.appColors.textDarkest,
                          context: context,
                        ),
                      );
                    },
                  ),
                  GetBuilder<AccountSettingController>(
                    id: AccountSettingIds.emailBox,
                    builder: (controller) {
                      return AccountSettingBox.arrow(
                        context: context,
                        onTap: () {
                          controller.handleGoToSettingEmail(context);
                        },
                        trailingText: controller.email,
                        child: AppText.body1(
                          'Email'.tr,
                          color: context.theme.appColors.textDarkest,
                          context: context,
                        ),
                      );
                    },
                  ),
                  GetBuilder<AccountSettingController>(
                    id: AccountSettingIds.passwordBox,
                    builder: (controller) {
                      return AccountSettingBox.arrow(
                        context: context,
                        onTap: () {
                          controller.handleOpenPassword(context);
                        },
                        trailingText: controller.hasPassword ? '••••••••' : 'Unregistered'.tr,
                        child: AppText.body1(
                          'Password'.tr,
                          color: context.theme.appColors.textDarkest,
                          context: context,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              SettingFrameContainer.withChildren(
                context: context,
                // TODO (design system) Update this when new design system is implemented.
                // customBorderRadius: AppRadius.rounded3xl,
                // space4 is normal padding from left for divider
                // 24 is size of icon
                // space3 is space between icon and text
                dividerPadding: const EdgeInsets.only(left: AppSpace.space4 + 24 + AppSpace.space3),
                children: [
                  GetBuilder<AccountSettingController>(
                    id: AccountSettingIds.googleBox,
                    builder: (controller) {
                      return AccountSettingBox.arrow(
                        context: context,
                        onTap: () {
                          controller.handleLinkGoogleAccount(context);
                        },
                        trailingText: controller.googleAccountLinked ? controller.googleAccount : 'Sync'.tr,
                        leading: Assets.vectors.googleIcon.svg(),
                        child: AppText.body1(
                          'Google',
                          color: context.theme.appColors.textDarkest,
                          context: context,
                        ),
                      );
                    },
                  ),
                  if (Platform.isIOS)
                    GetBuilder<AccountSettingController>(
                      id: AccountSettingIds.appleBox,
                      builder: (controller) {
                        return AccountSettingBox.arrow(
                          context: context,
                          onTap: () {
                            controller.handleLinkAppleId(context);
                          },
                          trailingText: controller.appleIdLinked ? controller.appleId : 'Sync'.tr,
                          leading: Assets.vectors.appleIcon.svg(),
                          child: AppText.body1(
                            'Apple',
                            color: context.theme.appColors.textDarkest,
                            context: context,
                          ),
                        );
                      },
                    ),
                  // Disable facebook for now
                  // GetBuilder<AccountSettingController>(
                  //   id: AccountSettingIds.facebookBox,
                  //   builder: (controller) {
                  //     return AccountSettingBox.arrow(
                  //       context: context,
                  //       onTap: controller.handleLinkFacebookAccount,
                  //       trailingText: controller.facebookAccountLinked ? controller.facebookAccount : 'Sync'.tr,
                  //       leading: Assets.vectors.facebookIcon.svg(),
                  //       child: AppText.body1(
                  //         'Facebook'.tr,
                  //         color: context.theme.appColors.textDarkest,
                  //         context: context,
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              GetBuilder<AccountSettingController>(
                id: AccountSettingIds.twoFactorAuthBox,
                builder: (controller) {
                  return AccountSettingBox.toggle(
                    onTap: () {
                      controller.handleToggleTwoFa(!controller.allowMultiFactor, context);
                    },
                    value: controller.allowMultiFactor,
                    onChanged: (value) {
                      controller.handleToggleTwoFa(value, context);
                    },
                    context: context,
                    child: AppText.body1(
                      'Two-factor authentication'.tr,
                      color: context.theme.appColors.textDarkest,
                      context: context,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              GetBuilder<AccountSettingController>(
                id: AccountSettingIds.shortcutPasscodeBox,
                builder: (controller) {
                  return Column(
                    children: [
                      SettingFrameContainer.withChildren(
                        context: context,
                        // TODO (design system) Update this when new design system is implemented.
                        // customBorderRadius: AppRadius.rounded3xl,
                        children: [
                          AccountSettingBox.toggle(
                            onTap: () {
                              controller.handleToggleShortcutPasscode(!controller.enableShortcutPasscode);
                            },
                            subtitle: AppText.body4(
                              'You can switch accounts from the PIN lock screen using a shortcut passcode'.tr,
                              color: controller.isPinLockEnable
                                  ? context.theme.appColors.textLight
                                  : context.theme.appColors.textDisable,
                              context: context,
                            ),
                            value: controller.enableShortcutPasscode,
                            onChanged: (value) {
                              controller.handleToggleShortcutPasscode(value);
                            },
                            enable: controller.isPinLockEnable,
                            context: context,
                            child: AppText.body1(
                              'Shortcut Passcode'.tr,
                              color: controller.isPinLockEnable
                                  ? context.theme.appColors.textDarkest
                                  : context.theme.appColors.textLighter,
                              context: context,
                            ),
                          ),
                          if (controller.enableShortcutPasscode)
                            AccountSettingBox.arrow(
                              context: context,
                              onTap: controller.handleChangeShortcutPasscode,
                              child: AppText.body1(
                                'Change Passcode'.tr,
                                color: context.theme.appColors.textDarkest,
                                context: context,
                              ),
                            ),
                        ],
                      ),
                      if (!controller.isPinLockEnable)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: controller.handleGoToPinLockSetting,
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: AppSpace.space2,
                                left: AppSpace.space3,
                              ),
                              child: AppText.caption1(
                                'Go to PIN lock Setting'.tr,
                                color: context.theme.appColors.textPrimary,
                                context: context,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              GetBuilder<AccountSettingController>(
                id: AccountSettingIds.hideAccountBox,
                builder: (controller) {
                  return Column(
                    children: [
                      AccountSettingBox.toggle(
                        onTap: () {
                          controller.handleToggleHideAccount(!controller.enableHideAccount);
                        },
                        value: controller.enableHideAccount,
                        onChanged: (value) {
                          controller.handleToggleHideAccount(value);
                        },
                        enable: controller.enableShortcutPasscode,
                        context: context,
                        child: AppText.body1(
                          'Hide Account'.tr,
                          color: controller.enableShortcutPasscode
                              ? context.theme.appColors.textDarkest
                              : context.theme.appColors.textLighter,
                          context: context,
                        ),
                      ),
                      if (!controller.enableShortcutPasscode)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppSpace.space2,
                            left: AppSpace.space3,
                            right: AppSpace.space3,
                          ),
                          child: AppText.caption1(
                            'Please enable the Shortcut Passcode to proceed with hiding your account'.tr,
                            color: context.theme.appColors.textLight,
                            context: context,
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              AccountSettingBox.arrow(
                context: context,
                onTap: () {
                  controller.handleGoToDevicesManager(context);
                },
                child: AppText.body1(
                  'Manage all devices'.tr,
                  color: context.theme.appColors.textDarkest,
                  context: context,
                ),
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              AccountSettingBox.arrow(
                context: context,
                onTap: controller.handleLogout,
                child: AppText.body1(
                  'Sign out from this device'.tr,
                  color: context.theme.appColors.textError,
                  context: context,
                ),
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              AccountSettingBox.arrow(
                context: context,
                onTap: () {
                  controller.onCheckDeleteAccountAuthentication(context);
                },
                child: AppText.body1(
                  'Delete Account'.tr,
                  color: context.theme.appColors.textError,
                  context: context,
                ),
              ),
              SizedBox(
                height: AppSpace.space3 + Get.mediaQuery.padding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
