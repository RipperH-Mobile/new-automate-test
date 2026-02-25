import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class ChatRoomDetailMemberListShimmer extends StatelessWidget {
  const ChatRoomDetailMemberListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ChatRoomDetailMemberItemShimmer(),
        SizedBox(height: AppSpace.space4),
        ChatRoomDetailMemberItemShimmer(),
        SizedBox(height: AppSpace.space4),
        ChatRoomDetailMemberItemShimmer(),
        SizedBox(height: AppSpace.space4),
        ChatRoomDetailMemberItemShimmer(),
        SizedBox(height: AppSpace.space4),
        ChatRoomDetailMemberItemShimmer(),
      ],
    );
  }
}

class ChatRoomDetailMemberItemShimmer extends StatelessWidget {
  const ChatRoomDetailMemberItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerLoading(
          enable: true,
          child: Container(
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundNeutralLightest,
              shape: BoxShape.circle,
            ),
            width: 50,
            height: 50,
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
    );
  }
}
