import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';

class AppFloatingBottomSheet {
  static void show({
    required BuildContext context,
    required Widget child,
    Color? barrierColor,
    Color? bottomSheetBgColor,
    EdgeInsets? padding,
    bool isBlur = true,
  }) async {
    final maxHeight = 0.8.sh;
    await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'app_bottom_sheet',
      transitionDuration: const Duration(milliseconds: 300),
      barrierColor: barrierColor ?? context.theme.appColors.backgroundBottomSheet,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final curvedValue = Curves.easeInOut.transform(animation.value);
            return Transform.translate(
              offset: Offset(
                0,
                maxHeight * (1 - curvedValue),
              ),
              child: Opacity(
                opacity: curvedValue,
                child: child,
              ),
            );
          },
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: isBlur ? 50 : 0,
            sigmaY: isBlur ? 50 : 0,
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(
                  left: AppSpace.space4,
                  right: AppSpace.space4,
                  bottom: AppSpace.space4,
                ),
                padding: padding ??
                    const EdgeInsets.only(
                      top: AppSpace.space8,
                      left: AppSpace.space4,
                      right: AppSpace.space4,
                      bottom: AppSpace.space10,
                    ),
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: maxHeight,
                ),
                decoration: BoxDecoration(
                  color: bottomSheetBgColor ?? context.theme.appColors.backgroundNeutralLightest,
                  borderRadius: BorderRadius.circular(
                    AppRadius.rounded3xl,
                  ),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
