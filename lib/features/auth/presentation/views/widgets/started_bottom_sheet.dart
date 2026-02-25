import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/welcome/welcome_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';

class StartedBottomSheet extends GetView<WelcomeController> {
  final bool isAddAccount;

  const StartedBottomSheet({super.key, this.isAddAccount = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.heading3(
            isAddAccount ? 'Add a new account'.tr : 'Get started with UChat'.tr,
            context: context,
          ),
          const SizedBox(
            height: AppSpace.space2,
          ),
          AppText.body1(
            'Sign up to start chatting with\nUChat Messenger'.tr,
            context: context,
            color: context.theme.appColors.textLight,
          ),
          if (!AppEnv.isProd)
            Container(
              margin: const EdgeInsets.only(
                top: AppSpace.space2,
              ),
              child: AppText.body3(
                '(In @env Mode)'.trParams(
                  {
                    'env': AppEnv.serverEnvType,
                  },
                ),
                context: context,
                color: context.theme.appColors.textLight,
              ),
            ),
          const SizedBox(
            height: AppSpace.space4,
          ),
          AppFilledButton.primary(
            context: context,
            label: 'Continue with email'.tr,
            onTap: () {
              controller.signInWithEmail();
            },
          ),
          // TODO: implement QR code login
          // SizedBox(
          //   height: AppSpace.space4,
          // ),
          // AppOutlinedButton.defaultButton(
          //   context: context,
          //   label: 'Continue with QR Code'.tr,
          //   onTap: () {

          //   },
          // ),
          const SizedBox(
            height: AppSpace.space4,
          ),
          AppOutlinedButton.defaultButton(
            context: context,
            label: 'Continue with phone number'.tr,
            onTap: () {
              controller.signInWithPhoneNumber();
            },
          ),
          const SizedBox(
            height: AppSpace.space8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: controller.onSignInByGoogleAccount,
                child: Assets.images.googleLogo.image(
                  width: AppSize.size12,
                  height: AppSize.size12,
                ),
              ),
              if (Platform.isIOS) ...[
                const SizedBox(
                  width: AppSpace.space8,
                ),
                GestureDetector(
                  onTap: controller.onSignInByAppleId,
                  child: Assets.images.appleLogo.image(
                    width: AppSize.size12,
                    height: AppSize.size12,
                  ),
                )
              ],
              //NOTE.comment facebook login for now
              // const SizedBox(
              //   width: AppSpace.space8,
              // ),
              // GestureDetector(
              //   onTap: controller.signInWithFacebook,
              //   child: Assets.images.facebookLogo.image(
              //     width: AppSize.size12,
              //     height: AppSize.size12,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
