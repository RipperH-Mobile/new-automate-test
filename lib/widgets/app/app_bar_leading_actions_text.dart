import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/dimensions.dart';
import 'package:uchat/widgets/app/app_bar_sliver_basic.dart';

class AppBarLeadingActionsText extends StatelessWidget {
  final void Function()? onLeadingPressed;
  final void Function()? onActionPressed;
  final String? leadingText;
  final String? titleText;
  final String? actionText;
  final double? expandedHeight;
  final double? collapsedHeight;
  final double? leadingWidth;

  const AppBarLeadingActionsText({
    super.key,
    this.onLeadingPressed,
    this.onActionPressed,
    this.leadingText,
    this.titleText,
    this.actionText,
    this.expandedHeight,
    this.collapsedHeight,
    this.leadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarSliverBasic(
      collapsedHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      leadingWidth: leadingWidth ?? 80.wr,
      leading: TextButton(
        onPressed: onLeadingPressed,
        child: Text(
          leadingText ?? 'Cancel'.tr,
          style: const TextStyle(color: Colors.red),
          maxLines: 1,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onActionPressed,
          child: Text(
            actionText ?? 'Save'.tr,
            style: TextStyle(
              color: onActionPressed != null ? UTheme.color.primary : Colors.grey,
            ),
          ),
        )
      ],
      title: Text(titleText ?? 'Title'),
      centerTitle: true,
    );
  }
}
