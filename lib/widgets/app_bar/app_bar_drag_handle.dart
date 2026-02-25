import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class AppBarDragHandle extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double? extraTop; // extra space above the actual app bar for the handle
  /// Whether to show the bottom sheet drag handle at the top of the screen.
  final bool showDragHandle;
  /// Whether to show the leading back button widget in app bar.
  final bool showLeading;
  /// Whether to show the action back button widget in app bar.
  final bool showAction;

  static const double defaultExtraTop = 16;

  const AppBarDragHandle({
    super.key,
    required this.title,
    this.extraTop = defaultExtraTop, // default spacing
    this.showDragHandle = true,
    this.showLeading = false,
    this.showAction = true,
  });

  // The total height = handle height + default AppBar height
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (extraTop ?? defaultExtraTop));

  // Simple drag handle widget
  Widget _buildDragHandle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSpace.space2),
      alignment: Alignment.center,
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: context.theme.appColors.borderDisable,
          borderRadius: BorderRadius.circular(AppRadius.roundedSm),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1) The drag handle
        if (showDragHandle) _buildDragHandle(context),

        // 2) Then the “real” AppBar
        AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leadingWidth: AppSize.size20,
          leading: showLeading
              ? GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSpace.space4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Assets.vectors.chevronBackIos.svg(
                          colorFilter: ColorFilter.mode(
                            context.theme.appColors.iconPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                        AppText.button1(
                          'Back'.tr,
                          color: context.theme.appColors.textPrimary,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                )
              : null,
          title: title,
          actions: showAction
              ? [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: AppText.body1(
                      'Close'.tr,
                      context: context,
                      color: context.theme.appColors.textPrimary,
                    ),
                  ),
                  const SizedBox(
                    width: AppSpace.space4,
                  )
                ]
              : null,
        ),
      ],
    );
  }
}
