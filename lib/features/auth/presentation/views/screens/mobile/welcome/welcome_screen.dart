import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

import '../../../../controllers/welcome/welcome_controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDefault(
        title: 'UChat Messenger',
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: controller.handleToggleTestMode,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        Container(
                          width: 1.sw,
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            shadows: [
                              BoxShadow(
                                color: context.theme.appColors.backgroundNeutralLightPressed,
                                blurRadius: 200,
                              ),
                            ],
                          ),
                        ),
                        Positioned.fill(
                          child: Assets.images.welcomeBackground1.image(),
                        ),
                        Positioned.fill(
                          child: Assets.images.welcomeBackground2.image(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
                right: AppSpace.space4,
                bottom: AppSpace.space4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.heading2(
                    'Best communication hub'.tr,
                    context: context,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: AppSpace.space2,
                  ),
                  AppText.body4(
                    'Stay connected with your friends anytime, anywhere with UChat. Enjoy secure messaging and calling features.'
                        .tr,
                    context: context,
                    textAlign: TextAlign.center,
                    color: context.theme.appColors.textLight,
                  ),
                  const SizedBox(
                    height: AppSpace.space4,
                  ),
                  Obx(() {
                    return AppFilledButton.primary(
                      context: context,
                      label: controller.isAddAccount() ? 'Add a new account'.tr : 'Get Started'.tr,
                      onTap: () => controller.handleLogin(context),
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
