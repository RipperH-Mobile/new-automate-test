import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabbarWithArrowsDesktop extends StatelessWidget {
  final Color? arrowColor;
  final Color? borderColor;

  const TabbarWithArrowsDesktop({
    super.key,
    required this.tabController,
    required this.child,
    required this.width,
    this.arrowColor,
    this.borderColor,
    active,
  });

  final TabController tabController;
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    final iconSize = 16.spMin;
    final iconPadding = 4.spMin;
    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (tabController.index > 0) {
              tabController.animateTo(
                tabController.index - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: iconPadding,
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: arrowColor ?? Colors.white,
              size: iconSize,
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(
                  color: borderColor ?? Colors.white.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: child,
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (tabController.index < tabController.length - 1) {
              tabController.animateTo(
                tabController.index + 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: iconPadding,
            ),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: arrowColor ?? Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
