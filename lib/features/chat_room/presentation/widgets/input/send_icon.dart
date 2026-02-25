import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';

class SendIcon extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;

  const SendIcon({super.key, required this.onTap, this.enabled = true});

  static const double iconSize = 32;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: iconSize,
        width: iconSize,
        margin: const EdgeInsets.all(
          AppSpace.space1,
        ),
        decoration: BoxDecoration(
          color: enabled ? context.theme.appColors.iconSelected : context.theme.appColors.iconDisable,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Assets.vectors.send.svg(
            height: iconSize - AppSpace.space3,
            width: iconSize - AppSpace.space3,
            colorFilter: ColorFilter.mode(
              context.theme.appColors.iconInverse,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
