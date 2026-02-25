import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class EmptyNotificationScreen extends StatelessWidget {
  const EmptyNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.appColors.backgroundNeutralLightest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.vectors.emptyNotificationsIcon.svg(
            height: AppSize.size24.spMin,
            width: AppSize.size24.spMin,
          ),
          AppSpace.space4.verticalSpace,
          AppText.title3(
            'No notifications yet'.tr,
            color: context.theme.appColors.textDarkest,
            context: context,
          ),
          AppSpace.space1.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.size2),
            child: AppText.body4(
              'You will receive notifications from friend and group requests here.'.tr,
              color: context.theme.appColors.textDark,
              textAlign: TextAlign.center,
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
