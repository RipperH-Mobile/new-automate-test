import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/screens/setting_help_center/setting_help_center_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class SettingHelpCenterMobileScreen extends GetView<SettingHelpCenterController> {
  const SettingHelpCenterMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Help Center'.tr,
        leadingButton: AppControlButton.back(context: context),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space4,
        ),
        child: Column(
          spacing: AppSpace.space3,
          children: [
            SettingFrameContainer.withChildren(
              context: context,
              header: AppText.body4Bold(
                'Need Help?'.tr,
                context: context,
                color: context.theme.appColors.textDark,
              ),
              children: [
                InkWell(
                  onTap: controller.handleContactHelpCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.space4,
                      vertical: AppSpace.space3,
                    ),
                    child: Row(
                      spacing: AppSpace.space2,
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            'assets/images/v2/help_center_uchat.png',
                            width: AppSize.size10,
                            height: AppSize.size10,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.body1(
                                'Help Center'.tr,
                                context: context,
                                color: context.theme.appColors.textDarkest,
                              ),
                              AppText.body4(
                                'Contact admin to consult on usage issues'.tr,
                                context: context,
                                color: context.theme.appColors.textLight,
                              ),
                            ],
                          ),
                        ),
                        Assets.vectors.iconArrowBackIos.svg(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space3,
              ),
              child: AppText.caption1(
                'If you encounter any issues while using our app that affect your experience, you can report the problem or ask for troubleshooting guidance by adding our Help Center account as a friend to contact our admin directly'
                    .tr,
                context: context,
                color: context.theme.appColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
    // });
  }
}
