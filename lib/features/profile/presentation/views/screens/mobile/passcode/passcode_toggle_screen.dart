import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/profile/presentation/views/widgets/corner_box_menu.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class PasscodeToggleScreen extends GetView<UserController> {
  const PasscodeToggleScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize passcode status when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.checkPasscodeSetup();
    });

    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: 'PIN lock'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: context.theme.appColors.surfaceDark,
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(
      () {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CornerBoxMenu(
                children: [
                  // PIN Lock Toggle (Always visible)
                  CornerBoxMenuItemListTitle.toggle(
                    context: context,
                    title: AppText.body1(
                      'PIN lock'.tr,
                      context: context,
                    ),
                    value: controller.isPasscodeSet.value,
                    onChanged: controller.handlePasscodeToggle,
                  ),

                  // Show additional menus only if passcode is set
                  if (controller.isPasscodeSet.value)
                    // Set a new Passcode menu
                    CornerBoxMenuItemListTitle(
                      title: AppText.body1(
                        'Set a new PIN'.tr,
                        context: context,
                      ),
                      trailing: Assets.vectors.iconArrowBackIos.svg(),
                      onTap: controller.handleSetNewPasscode,
                    ),

                  // Biometric menu (only if supported)
                  if (controller.isPasscodeSet.value && controller.isBiometricSupported.value) ...[
                    CornerBoxMenuItemListTitle.toggle(
                      context: context,
                      title: AppText.body1(
                        'Use with Touch ID or Face ID'.tr,
                        context: context,
                      ),
                      subtitle: AppText.body4(
                        'All Touch ID or Face ID used will be based on your device settings only.'.tr,
                        color: context.theme.appColors.textLight,
                        context: context,
                      ),
                      trailing: Assets.vectors.iconArrowBackIos.svg(),
                      value: controller.isBiometricEnabled.value,
                      onChanged: (value) => controller.handleToggleBiometric(),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
