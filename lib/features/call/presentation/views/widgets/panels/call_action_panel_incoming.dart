import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_base.dart';
import 'package:uchat/gen/assets.gen.dart';

class CallActionPanelIncomingWidget extends StatelessWidget {
  final bool isVideo;
  final VoidCallback onAnswer;
  final VoidCallback onDecline;

  const CallActionPanelIncomingWidget({
    super.key,
    this.isVideo = false,
    required this.onAnswer,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpace.space16,
        right: AppSpace.space16,
        bottom: AppSpace.space10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CallActionButtonBase(
            label: 'End'.tr,
            svgPath: Assets.vectors.incomingCallEndButton.path,
            onPressed: onDecline,
          ),
          CallActionButtonBase(
            label: 'Accept'.tr,
            svgPath: isVideo
                ? Assets.vectors.incomingCallJoinVideoButton.path
                : Assets.vectors.incomingCallVoiceJoinButton.path,
            onPressed: onAnswer,
          ),
        ],
      ),
    );
  }
}
