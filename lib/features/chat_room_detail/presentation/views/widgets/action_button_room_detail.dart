import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/widgets/app_text.dart';

class ActionButtonRoomDetail extends StatelessWidget {
  final String text;
  final Widget icon;
  final Function onTap;
  final Color? textColor;

  const ActionButtonRoomDetail({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 125.spMin,
        height: 75.spMin,
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundNeutralLightest,
          borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: AppSize.size6, height: AppSize.size6, child: icon),
            SizedBox(
              height: 4.spMin,
            ),
            AppText.body3(
              text,
              color: textColor ?? context.theme.appColors.textDarkest,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
