import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/setting/presentation/controllers/setting_account_phone_number_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class SettingAccountPhoneNumberScreen extends GetView<SettingAccountPhoneNumberController> {
  const SettingAccountPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Phone number'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () => Get.back(),
        ),
      ),
      child: Column(
        children: [
          _buildCountryAndPhoneNumber(context),
          const SizedBox(height: AppSpace.space4),
          _buildChangePhoneNumberMenu(context),
        ],
      ),
    );
  }

  Widget _buildCountryAndPhoneNumber(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightest,
        borderRadius: BorderRadius.circular(
          AppRadius.rounded2xl,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.space1,
        children: [
          AppText.body3(
            'Registered'.tr,
            context: context,
            color: context.theme.appColors.textLight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => AppText.body1(
                  controller.currentCountry.value?.countryName ?? 'Thailand'.tr,
                  context: context,
                ),
              ),
              const SizedBox(width: AppSpace.space1),
              AppText.body1(
                '|',
                context: context,
                color: context.theme.appColors.textLightest,
              ),
              const SizedBox(width: AppSpace.space1),
              Obx(
                () => AppText.body1(
                  controller.currentPhoneNumber.value,
                  context: context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChangePhoneNumberMenu(BuildContext context) {
    return GestureDetector(
      onTap: controller.onContinue,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundNeutralLightest,
          borderRadius: BorderRadius.circular(
            AppRadius.rounded2xl,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText.body1(
              'Change to new phone number'.tr,
              context: context,
              color: context.theme.appColors.textDarkest,
            ),
            Assets.vectors.iconArrowBackIos.svg(),
          ],
        ),
      ),
    );
  }
}
