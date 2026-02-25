import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/presentation/views/widgets/livekit/participant_image_background.dart';
import 'package:uchat/features/call/presentation/views/screens/mobile/direct_call_layout.dart';
import 'package:uchat/features/call/presentation/views/widgets/element/avatar.dart';
import 'package:uchat/features/call/presentation/views/widgets/app_bar/app_bar_mobile.dart';
import 'package:uchat/features/call/presentation/views/widgets/element/call_title.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class EndCallScreen extends StatelessWidget {
  final RoomCallModel callData;
  final String duration;

  const EndCallScreen({
    super.key,
    required this.callData,
    required this.duration,
  });

  final avatarSize = 120.0;

  @override
  Widget build(BuildContext context) {
    return DirectCallLayout(
      body: Stack(
        children: [
          ParticipantImageBackground(
            image: callData.imageUrl ?? '',
            blurHash: callData.imageBlurHash ?? '',
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.theme.appColors.borderLighter,
                      width: 1,
                    ),
                  ),
                  child: AvatarWidget(
                    blurHash: callData.imageBlurHash,
                    radius: avatarSize / 2,
                    avatar: callData.imageUrl,
                  ),
                ),
                const SizedBox(
                  height: AppSpace.space12,
                ),
                AppText.title1(
                  'Call ended'.tr,
                  context: context,
                  color: context.theme.appColors.textPrimaryInverse,
                ),
                const SizedBox(
                  height: AppSpace.space3,
                ),
                AppText.heading3(
                  duration,
                  context: context,
                  color: context.theme.appColors.textPrimaryInverse,
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: CallAppBarMobile(
        title: CallTitleWidget(
          title: callData.title ?? 'Unknown user'.tr,
        ),
        showBackButton: false,
        action: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Get.back();
          },
          child: Assets.vectors.xClose.svg(
            colorFilter: ColorFilter.mode(
              context.theme.appColors.iconPrimaryInverse,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
