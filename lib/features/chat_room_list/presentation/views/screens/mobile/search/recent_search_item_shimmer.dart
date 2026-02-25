import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class RecentSearchItemShimmer extends StatelessWidget {
  const RecentSearchItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = context.theme.appColors.backgroundGrayLightest.withValues(alpha: 0.5);
    final highlightColor = context.theme.appColors.backgroundNeutralLightest.withValues(alpha: 0.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        const SizedBox(height: AppSpace.space4),
        ShimmerLoading(
          enable: true,
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            width: AppSpace.space24,
            height: AppSpace.space3,
            margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
            color: context.theme.appColors.backgroundNeutralLightest,
          ),
        ),
        const SizedBox(height: AppSpace.space4),

        // Items
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
        _buildItemShimmer(context, baseColor: baseColor, highlightColor: highlightColor),
      ],
    );
  }

  Widget _buildItemShimmer(
    BuildContext context, {
    required Color baseColor,
    required Color highlightColor,
  }) {
    return ShimmerLoading(
      enable: true,
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
        height: AppSpace.space16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar placeholder
            Container(
              width: AppSpace.space12,
              height: AppSpace.space12,
              decoration: BoxDecoration(
                color: context.theme.appColors.backgroundNeutralLightest,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpace.space4),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and time row
                  Container(
                    width: AppSpace.space28,
                    height: AppSpace.space4,
                    color: context.theme.appColors.backgroundNeutralLightest,
                  ),
                  const SizedBox(height: AppSpace.space2),
                  // Details row placeholder
                  Container(
                    width: AppSpace.space50,
                    height: AppSpace.space4,
                    color: context.theme.appColors.backgroundNeutralLightest,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
