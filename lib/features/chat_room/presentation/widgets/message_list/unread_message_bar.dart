import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class UnreadMessageBar extends StatelessWidget {
  const UnreadMessageBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundGrayLightest,
          borderRadius: BorderRadius.circular(AppRadius.roundedMd),
        ),
        margin: const EdgeInsets.only(bottom: AppSpace.space3, left: AppSpace.space4, right: AppSpace.space4),
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space2, vertical: AppSpace.space05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.vectors.unreadMessage.svg(),
            AppSpace.space1.horizontalSpace,
            AppText.caption2Bold(
              'Unread messages'.tr,
              context: context,
              color: context.theme.appColors.textDark,
              lineHeight: 1,
            ),
          ],
        ),
      ),
    );
  }
}
