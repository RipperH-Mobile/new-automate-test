import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';

class ChatRoomAppBarButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? radius;
  final Color? backgroundColor;
  final void Function()? onPressed;

  const ChatRoomAppBarButton({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpace.space2,
          horizontal: AppSpace.space3,
        ),
        decoration: BoxDecoration(
          color: onPressed != null
              ? backgroundColor ?? context.theme.appColors.backgroundNeutralLighterPressed
              : context.theme.appColors.backgroundNeutralLighterPressed,
          borderRadius: BorderRadius.circular(radius ?? AppSize.size6),
        ),
        // width: width ?? AppSize.size12,
        height: height ?? AppSize.size10,
        child: child,
      ),
    );
  }
}
