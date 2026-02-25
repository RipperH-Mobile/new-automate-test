import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

const _kAppBarMaxHeightRatio = 0.48;

class ProfileSkeletonLoading extends StatelessWidget {
  const ProfileSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final maxHeight = (Get.height * _kAppBarMaxHeightRatio);

    return Container(
      color: context.theme.appColors.border,
      child: Column(
        children: [
          // Profile header skeleton
          Container(
            height: maxHeight,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundGrayLighter,
            ),
            child: ShimmerLoading(
              enable: true,
              baseColor: context.theme.appColors.backgroundGrayLighter,
              highlightColor: context.theme.appColors.backgroundGrayLightest,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.theme.appColors.backgroundGrayLighter,
                      context.theme.appColors.backgroundGrayLightest,
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSpace.space6,
          ),
          // Menu items skeleton
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
            ),
            child: ShimmerLoading(
              enable: true,
              baseColor: context.theme.appColors.backgroundGrayLighter,
              highlightColor: context.theme.appColors.backgroundGrayLightest,
              child: Column(
                children: [
                  // First menu box skeleton
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.only(
                      bottom: AppSpace.space4,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundGrayLighter,
                      borderRadius: BorderRadius.circular(
                        AppRadius.roundedXl,
                      ),
                    ),
                  ),
                  // Second menu box skeleton
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: AppSpace.space4),
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundGrayLighter,
                      borderRadius: BorderRadius.circular(
                        AppRadius.roundedXl,
                      ),
                    ),
                  ),
                  // Third menu box skeleton
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundGrayLighter,
                      borderRadius: BorderRadius.circular(
                        AppRadius.roundedXl,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
