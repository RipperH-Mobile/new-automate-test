import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class NoChatFoundWidget extends StatelessWidget {
  const NoChatFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.vectors.iconNoChatFound.svg(),
        SizedBox(
          height: 16.spMin,
        ),
        AppText.button2Bold(
          'Start your first chat'.tr,
          context: context,
        ),
        AppText.body4(
          'Start your first conversation and connect\nwith friends right away'.tr,
          context: context,
          color: context.theme.appColors.textLight,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
