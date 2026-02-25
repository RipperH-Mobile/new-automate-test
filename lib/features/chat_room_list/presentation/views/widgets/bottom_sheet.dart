import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class BottomSheetUChat {
  static Future<void> bottomSheet(
    BuildContext context, {
    String? title,
    Widget? description,
    Widget? child,
    bool hasKnob = true,
    Color? backgroundColor,
    Color? childBackgroundColor,
  }) async {
    Get.bottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space8),
        decoration: BoxDecoration(
          color: backgroundColor ?? context.theme.appColors.backgroundNeutralLight,
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded3xl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasKnob)
              Container(
                width: AppSpace.space10,
                height: AppSpace.space1,
                margin: const EdgeInsets.only(top: AppSpace.space4, bottom: AppSpace.space3),
                decoration: BoxDecoration(
                  color: context.theme.appColors.backgroundGrayLighterPressed,
                  borderRadius: BorderRadius.circular(
                    AppRadius.roundedSm,
                  ),
                ),
              ),
            if (title != null)
              AppText.title2(
                title,
                context: context,
                color: context.theme.appColors.textDark,
              ),
            if (description != null) description,
            Container(
              margin: const EdgeInsets.all(AppSpace.space4),
              decoration: BoxDecoration(
                color: childBackgroundColor ?? context.theme.appColors.backgroundNeutralLightestPressed,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppRadius.rounded2xl,
                  ),
                ),
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
