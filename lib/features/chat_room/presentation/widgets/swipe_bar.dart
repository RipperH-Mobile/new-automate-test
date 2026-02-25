import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';

class SwipeBar extends StatelessWidget {
  const SwipeBar({
    super.key,
    required this.onVerticalPositionUpdate,
    required this.onVerticalDragEnd,
    this.offsetHeight = 0,
  });

  final void Function(double inversePositionDy) onVerticalPositionUpdate;
  final void Function(double inversePositionDy) onVerticalDragEnd;
  final double offsetHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      onVerticalDragUpdate: (DragUpdateDetails details) {
        double positionY = details.globalPosition.dy;
        final position = 1.sh - positionY;
        onVerticalPositionUpdate(position);
      },
      onVerticalDragEnd: (details) {
        double positionY = details.globalPosition.dy;
        onVerticalDragEnd(1.sh - positionY);
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: AppSpace.space2,
          bottom: AppSpace.space2,
        ),
        child: Center(
          child: Container(
            height: AppSize.size1,
            width: AppSize.size12,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundNeutralLightPressed,
              borderRadius: BorderRadius.circular(AppRadius.roundedFull),
            ),
          ),
        ),
      ),
    );
  }
}
