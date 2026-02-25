import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class BannerNotification extends StatelessWidget {
  final Color? bgBoxColor;
  final Color? bgColor;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  const BannerNotification({
    super.key,
    this.bgBoxColor,
    this.bgColor,
    this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpace.space14,
      color: bgColor ?? context.theme.appColors.backgroundNeutralLighter,
      padding: padding ??
          const EdgeInsets.only(
            left: AppSpace.space3,
            right: AppSpace.space3,
            top: AppSpace.space1,
            bottom: AppSpace.space1,
          ),
      child: buildWidget(context),
    );
  }

  Widget buildWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
      decoration: BoxDecoration(
        color: bgBoxColor ?? context.theme.appColors.backgroundNeutralBolder,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSpace.space3,
          ),
        ),
      ),
      child: Row(
        children: [
          Assets.vectors.iconBannerBell.svg(),
          const SizedBox(
            width: AppSpace.space2,
          ),
          Expanded(
            child: AppText.body3Bold(
              'Allow us to access notifications.'.tr,
              context: context,
              textOverflow: TextOverflow.ellipsis,
              color: context.theme.appColors.backgroundNeutralLightestPressed,
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpace.space2,
                horizontal: AppSpace.space3,
              ),
              decoration: BoxDecoration(
                color: context.theme.appColors.backgroundNeutralLightestPressed,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSpace.space3),
                ),
              ),
              child: AppText.body3Bold(
                'Allow'.tr,
                context: context,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
