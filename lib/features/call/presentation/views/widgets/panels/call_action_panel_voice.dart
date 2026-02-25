import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_video_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_mic_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_speaker_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/decline_button_impl.dart';

class CallActionPanelVoiceWidget extends StatelessWidget {
  final bool isVideo;
  final bool isShow;
  final VoidCallback onDecline;
  final VoidCallback toggleCamera;
  final VoidCallback toggleSpeaker;
  final VoidCallback toggleMic;
  final void Function(MediaDevice)? onDeviceSelected;
  final List<MediaDevice> audioOutputs;

  final bool micOn;
  final bool cameraOn;
  final bool speakerOn;

  const CallActionPanelVoiceWidget({
    super.key,
    this.isVideo = false,
    required this.onDecline,
    required this.toggleCamera,
    required this.toggleSpeaker,
    required this.toggleMic,
    this.isShow = true,
    required this.micOn,
    required this.cameraOn,
    required this.speakerOn,
    this.audioOutputs = const [],
    this.onDeviceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSpace.space8,
          right: AppSpace.space8,
          bottom: AppSpace.space1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CallActionVideoButton(
              onPressed: toggleCamera,
              isActive: cameraOn,
              isEnable: isShow,
            ),
            CallActionSpeakerButton(
              onPressed: toggleSpeaker,
              isActive: speakerOn,
              isEnable: isShow,
              sheetOffset: const Offset(0, -150),
              sheetPosition: PopupMenuPosition.over,
              onDeviceSelected: onDeviceSelected,
              audioOutputs: audioOutputs,
            ),
            CallActionMicButton(
              onPressed: toggleMic,
              isEnable: isShow,
              isActive: micOn,
            ),
            DeclineButton(
              onPressed: onDecline,
            ),
          ],
        ),
      ),
    );
  }
}
