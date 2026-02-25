import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';

class PasscodeBullet extends StatelessWidget {
  final String? digit;

  const PasscodeBullet({
    super.key,
    this.digit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.spMin),
      alignment: Alignment.center,
      child: Container(
        width: 26.spMin,
        height: 26.spMin,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: digit != null ? context.theme.appColors.iconPrimary : Colors.transparent,
          border: Border.all(
            width: AppSpace.spacePx,
            color: digit != null ? context.theme.appColors.iconPrimary : context.theme.appColors.borderDark,
          ),
        ),
      ),
    );
  }
}
