import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class StickerPackListItemShimmer extends StatelessWidget {
  final bool hasTopBorderRadius;
  final bool hasBottomBorderRadius;

  const StickerPackListItemShimmer({
    super.key,
    this.hasTopBorderRadius = true,
    this.hasBottomBorderRadius = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSize.size24,
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightestPressed,
        borderRadius: BorderRadius.only(
          topLeft: hasTopBorderRadius ? const Radius.circular(AppRadius.roundedXl) : Radius.zero,
          topRight: hasTopBorderRadius ? const Radius.circular(AppRadius.roundedXl) : Radius.zero,
          bottomLeft: hasBottomBorderRadius ? const Radius.circular(AppRadius.roundedXl) : Radius.zero,
          bottomRight: hasBottomBorderRadius ? const Radius.circular(AppRadius.roundedXl) : Radius.zero,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: AppSpace.space4,
          ),
          ShimmerLoading(
            enable: true,
            child: Container(
              width: AppSize.size20,
              height: AppSize.size20,
              decoration: BoxDecoration(
                color: context.theme.appColors.backgroundNeutralLightestPressed,
                borderRadius: BorderRadius.circular(AppRadius.roundedXl),
              ),
            ),
          ),
          const SizedBox(
            width: AppSpace.space4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(
                enable: true,
                child: Container(
                  width: 0.5.sw,
                  height: AppSize.size4,
                  decoration: BoxDecoration(
                    color: context.theme.appColors.backgroundNeutralLightestPressed,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSpace.space2,
              ),
              ShimmerLoading(
                enable: true,
                child: Container(
                  width: 0.3.sw,
                  height: AppSize.size4,
                  decoration: BoxDecoration(
                    color: context.theme.appColors.backgroundNeutralLightestPressed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
