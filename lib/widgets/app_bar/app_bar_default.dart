import 'package:flutter/material.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDefault({
    super.key,
    this.title,
    this.leadingButton,
    this.actionButton,
    this.automaticallyImplyLeading = true,
    this.leadingWidth = AppSpace.space24,
    this.appBarHeight = 65,
    this.backgroundColor,
    this.titleColor,
    this.maxTitleWidth,
  });

  final String? title;
  final AppControlButton? leadingButton;
  final Widget? actionButton;
  final bool automaticallyImplyLeading;
  final double leadingWidth;
  final double appBarHeight;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? maxTitleWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: title != null
          ? Container(
              constraints: maxTitleWidth != null ? BoxConstraints(maxWidth: maxTitleWidth!) : null,
              child: AppText.title3(
                title!,
                context: context,
                color: titleColor,
              ),
            )
          : null,
      leading: leadingButton != null
          ? Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
              ),
              child: leadingButton,
            )
          : null,
      leadingWidth: leadingWidth,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: true,
      actions: [
        if (actionButton != null)
          SizedBox(
            width: AppSpace.space28,
            child: Padding(
              padding: const EdgeInsets.only(
                right: AppSpace.space4,
              ),
              child: actionButton,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
