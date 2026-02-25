import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_shadow.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class BackToReplyButton extends StatelessWidget {
  final Function onPressed;

  const BackToReplyButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundNeutralLighter,
          borderRadius: BorderRadius.circular(AppRadius.roundedFull),
          boxShadow: [AppShadow.shadowBlack12],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.roundedFull),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space3,
              vertical: AppSpace.space1,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.vectors.uTurnRight.svg(
                    colorFilter: ColorFilter.mode(
                      context.theme.appColors.icon,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: AppSpace.space1),
                  AppText.body3(
                    'Go back to reply'.tr,
                    context: context,
                    color: context.theme.appColors.textDarkest,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
