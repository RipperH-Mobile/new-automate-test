import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class AppBarBackButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool? isShowTextBack;

  const AppBarBackButton({super.key, this.onPressed, this.isShowTextBack});

  @override
  Widget build(BuildContext context) {
    return AppBarIconLeadingButton(
      icon: isShowTextBack == true
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 24.spMin,
                  color: context.theme.appColors.linkText,
                ),
                AppText.title1(
                  'Back'.tr,
                  context: context,
                  color: context.theme.appColors.linkText,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Icon(
              Icons.arrow_back_ios,
              size: 24.spMin,
            ),
      onPressed: () {
        onPressed?.call();
      },
    );
  }
}
