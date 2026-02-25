import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/themes/themes.dart';

class ModalBottomSheetNew {
  static const barHeight = 6.0;
  static const barPadding = AppSpace.space4;
  static const headerHeight = barHeight + (barPadding * 2);
  /// Shows a customizable modal bottom sheet with various configuration options
  static Future<void> showBottomSheetFixHeight({
    required BuildContext context,
    required List<Widget> children,
    double? height,
    bool isDismissible = true,
    bool enableDrag = true,
  }) async {
    final child = _buildBottomSheetContent(
      context: context,
      children: children,
    );

    await Get.bottomSheet(
      SizedBox(
        height: height ?? Get.height * 0.7,
        child: Scaffold(
          body: child,
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
        ),
      ),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: context.theme.appColors.backgroundNeutralLightest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppRadius.rounded2xl,
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  /// Builds the content of the bottom sheet
  static Widget _buildBottomSheetContent({
    required BuildContext context,
    required List<Widget> children,
  }) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the header line indicator
  static Widget _buildHeader() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: barPadding,
        ),
        child: Container(
          width: 65.spMin,
          height: barHeight,
          decoration: BoxDecoration(
            color: UTheme.color.bottomSheetBar,
            borderRadius: BorderRadius.circular(
              AppRadius.roundedFull,
            ),
          ),
        ),
      ),
    );
  }
}
