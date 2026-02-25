import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_speaker_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_video_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_flip_camera_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_mic_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/decline_button_impl.dart';

class CallActionPanelVideoWidget extends StatelessWidget {
  final bool isShow;
  final bool isVideoMode;
  final VoidCallback onDecline;
  final VoidCallback toggleCamera;
  final VoidCallback toggleCameraSwitching;
  final VoidCallback toggleMic;
  final VoidCallback toggleSpeaker;
  final bool speakerOn;
  final bool micOn;
  final bool cameraOn;
  final void Function(MediaDevice)? onDeviceSelected;
  final List<MediaDevice> audioOutputs;
  final String? portName;
  final String? portType;
  final String? portId;
  final MediaDevice? selectedDevice;

  const CallActionPanelVideoWidget({
    super.key,
    required this.onDecline,
    required this.toggleCamera,
    required this.toggleCameraSwitching,
    required this.toggleMic,
    required this.micOn,
    required this.cameraOn,
    required this.speakerOn,
    required this.toggleSpeaker,
    this.isShow = true,
    this.isVideoMode = false,
    this.audioOutputs = const [],
    this.onDeviceSelected,
    this.portName,
    this.portType,
    this.portId,
    this.selectedDevice,
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
              onPressed: () async {
                bool cameraGranted = await PermissionController.instance.requestCameraPermissionDirect(context);
                if (!cameraGranted) {
                  return;
                }
                toggleCamera();
              },
              isActive: cameraOn,
              isEnable: isShow,
            ),
            isVideoMode
                ? CallActionFlipCameraButton(
                    onPressed: toggleCameraSwitching,
                    isEnable: isShow,
                  )
                : CallActionSpeakerButton(
                    onPressed: toggleSpeaker,
                    isActive: speakerOn,
                    isEnable: isShow,
                    sheetOffset: Offset(0, -(50 * (audioOutputs.length + 1)).toDouble()),
                    sheetPosition: PopupMenuPosition.over,
                    onDeviceSelected: onDeviceSelected,
                    audioOutputs: audioOutputs,
                    selectedDevice: selectedDevice,
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
