import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';

class RecentListItemShimmer extends StatelessWidget {
  const RecentListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey[300]!;
    final highlightColor = Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space2),
        height: 60.spMin,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: AppSpace.space10,
              height: AppSpace.space10,
              decoration: BoxDecoration(
                color: context.theme.appColors.backgroundNeutralLightest,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpace.space2),
            // Name and details placeholder
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: AppSpace.space28,
                    height: AppSpace.space4,
                    color: context.theme.appColors.backgroundNeutralLightest,
                  ),
                  const SizedBox(height: AppSpace.space1),
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
