import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_apple_id/setting_account_update_apple_id_syncing_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/setting_menu_box.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class SettingAccountUpdateAppleIdSyncingScreen extends GetView<SettingAccountUpdateAppleIdSyncingController> {
  const SettingAccountUpdateAppleIdSyncingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isSyncedWithAppleId.value ? _buildUpdateScreen(context) : _buildUnregisteredScreen(context);
    });
  }

  Widget _buildUpdateScreen(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Apple ID'.tr,
        leadingButton: AppControlButton.back(context: context),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space6),
        child: Column(
          children: [
            SettingMeuBox(
              padding: const EdgeInsets.only(left: AppSpace.space4, top: AppSpace.space3),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body3(
                      'Registered'.tr,
                      color: context.theme.appColors.textLight,
                      context: context,
                    ),
                    const SizedBox(height: AppSpace.space1),
                    AppText.body1(
                      controller.appleId.value,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      context: context,
                    ),
                    const SizedBox(height: AppSpace.space3),
                    Container(
                      height: 1,
                      color: context.theme.appColors.border,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.onContinue(isUnlink: true);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.theme.appColors.backgroundNeutralLightestPressed,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(AppRadius.rounded2xl),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          top: AppSpace.space2,
                          right: AppSpace.space4,
                          bottom: AppSpace.space3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText.body1(
                              'Unsync this Apple ID'.tr,
                              color: context.theme.appColors.textError,
                              context: context,
                            ),
                            Assets.vectors.chevronForwardIos.svg(
                              height: 20,
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                context.theme.appColors.iconLighter,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpace.space4),
            SettingMeuBox.textWithArrow(
              context: context,
              text: 'Change to new Apple ID'.tr,
              onTap: controller.onContinue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnregisteredScreen(BuildContext context) {
    return ScaffoldBasic(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.appleIdLinkV2.image(
              width: AppSize.size24,
              height: AppSize.size24,
            ),
            const SizedBox(height: AppSpace.space6),
            AppText.heading4(
              'Confirm to sync the account to a new Apple ID?'.tr,
              textAlign: TextAlign.center,
              context: context,
            ),
            const SizedBox(height: AppSpace.space2),
            AppText.body3(
              'Do you want to sync your account with Apple ID account?'.tr,
              color: context.theme.appColors.textLight,
              textAlign: TextAlign.center,
              context: context,
            ),
            const SizedBox(height: AppSpace.space6),
            AppFilledButton.primary(
              label: 'Confirm'.tr,
              onTap: controller.onContinue,
              context: context,
            ),
            const SizedBox(height: AppSize.size4),
            AppOutlinedButton.defaultButton(
              label: 'Back'.tr,
              context: context,
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
