import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/utils/extension/extension.dart';

class CircleCloseButton extends StatelessWidget {
  final double? size;
  final VoidCallback? onTap;
  final Color? closeIconColor;
  final Color? closeIconBackgroundColor;

  const CircleCloseButton({
    super.key,
    this.size,
    this.onTap,
    this.closeIconColor,
    this.closeIconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap ??
          () {
            Get.back<bool>(result: false);
          },
      child: Container(
        width: (size ?? 25).spMin,
        height: (size ?? 25).spMin,
        padding: EdgeInsets.all(7.spMin),
        decoration: BoxDecoration(
          color: closeIconBackgroundColor ?? const Color(0xFFcccccc),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          UChatAssetPath.crossIcon,
          height: 5.spMin,
          width: 5.spMin,
          cacheWidth: 50.cacheSize,
          color: closeIconColor ?? Colors.white,
        ),
      ),
    );
  }
}
