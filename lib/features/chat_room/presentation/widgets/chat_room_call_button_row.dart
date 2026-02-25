import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomCallButtonRow extends StatelessWidget {
  final double height;
  final VoidCallback onVoiceCallPressed;
  final VoidCallback onVideoCallPressed;

  const ChatRoomCallButtonRow({
    super.key,
    required this.height,
    required this.onVoiceCallPressed,
    required this.onVideoCallPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: (height / height).clamp(0, 1),
      child: AnimatedContainer(
        height: height,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: AppSize.size16,
                decoration: BoxDecoration(
                  color: context.theme.appColors.backgroundNeutralLighterPressed,
                  border: Border(
                    // left: BorderSide(color: context.theme.appColors.borderMenu.withValues(alpha: 0.15), width: 1.0),
                    top: BorderSide(color: context.theme.appColors.borderMenu.withValues(alpha: 0.15), width: 1.0),
                    right: BorderSide(color: context.theme.appColors.borderMenu.withValues(alpha: 0.15), width: 1.0),
                    bottom: BorderSide(color: context.theme.appColors.borderMenu.withValues(alpha: 0.15), width: 1.0),
                  ),
                ),
                child: TextButton(
                  onPressed: onVoiceCallPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.vectors.voiceCallIcon.svg(
                        colorFilter: ColorFilter.mode(
                          context.theme.appColors.iconCallChatRoom,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: AppSpace.space3),
                      AppText.body3Bold(
                        'Voice Call'.tr,
                        context: context,
                        color: context.theme.appColors.textDarker,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: AppSize.size16,
                decoration: BoxDecoration(
                  color: context.theme.appColors.backgroundNeutralLighterPressed,
                  border: Border(
                    // left: BorderSide(color: context.theme.appColors.border, width: 1.0),
                    top: BorderSide(color: context.theme.appColors.borderMenu.withValues(alpha: 0.15), width: 1.0),
                    // right: BorderSide(color: context.theme.appColors.borderMenu.withValues(alpha: 0.15), width: 1.0),
                    bottom: BorderSide(color: context.theme.appColors.borderMenu.withValues(alpha: 0.15), width: 1.0),
                  ),
                ),
                child: TextButton(
                  onPressed: onVideoCallPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.vectors.videoCallIcon.svg(
                        colorFilter: ColorFilter.mode(
                          context.theme.appColors.iconCallChatRoom,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: AppSpace.space3),
                      AppText.body3Bold(
                        'Video Call'.tr,
                        context: context,
                        color: context.theme.appColors.textDarker,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
