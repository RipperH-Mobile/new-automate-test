import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class CallActionButtonBase extends StatelessWidget {
  final String svgPath;
  final String label;
  final VoidCallback onPressed;
  final bool isEnable;
  final bool hideLabel;

  const CallActionButtonBase({
    super.key,
    required this.svgPath,
    required this.label,
    required this.onPressed,
    this.isEnable = true,
    this.hideLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: GestureDetector(
        onTap: isEnable ? onPressed : null,
        behavior: HitTestBehavior.translucent,
        child: LayoutBuilder(builder: (context, ct) {
          return SizedBox(
            width: min(62, ct.maxWidth),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: SvgPicture.asset(
                    svgPath,
                  ),
                ),
                if (hideLabel == false) ...[
                  const SizedBox(
                    height: AppSpace.space2,
                  ),
                  AppText.caption1(
                    label,
                    context: context,
                    color: context.theme.appColors.textPrimaryInverse,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ]
              ],
            ),
          );
        }),
      ),
    );
  }
}
