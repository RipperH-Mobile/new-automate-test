import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';

class CallLogListItemShimmer extends StatelessWidget {
  const CallLogListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Define shimmer base and highlight colors.
    final baseColor = Colors.grey[300]!;
    final highlightColor = Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space2),
        height: AppSpace.space20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar placeholder
            Container(
              width: AppSpace.space16,
              height: AppSpace.space16,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: AppSpace.space28,
                        height: AppSpace.space4,
                        color: context.theme.appColors.backgroundNeutralLightest,
                      ),
                      Container(
                        width: AppSpace.space10,
                        height: AppSpace.space4,
                        color: context.theme.appColors.backgroundNeutralLightest,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpace.space1),
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
