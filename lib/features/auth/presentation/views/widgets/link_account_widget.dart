import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';

class LinkAccountWidget extends StatelessWidget {
  const LinkAccountWidget({
    super.key,
    required this.image,
    required this.title,
    required this.email,
    required this.onContinue,
    required this.onClose,
  });

  final String image;
  final String title;
  final String email;
  final void Function() onContinue;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space14,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: AppSize.size24,
            height: AppSize.size24,
          ),
          const SizedBox(
            height: AppSpace.space6,
          ),
          AppText.heading4(
            title,
            context: context,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSpace.space2,
          ),
          AppText.body3(
            'Do you want to link your account with $email'.tr,
            context: context,
            color: context.theme.appColors.textLight,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSpace.space6,
          ),
          AppFilledButton.primary(
            context: context,
            onTap: onContinue,
            label: 'Confirm'.tr,
          ),
          const SizedBox(
            height: AppSize.size4,
          ),
          AppOutlinedButton.defaultButton(
            context: context,
            onTap: onClose,
            label: 'Not now'.tr,
          ),
        ],
      ),
    );
  }
}
