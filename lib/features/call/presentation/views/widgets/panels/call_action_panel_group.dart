import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_video_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_flip_camera_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_mic_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_speaker_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/decline_button_impl.dart';
import 'package:uchat/features/call/utils/constant.dart';

class GroupCallActionPanelWidget extends StatelessWidget {
  final bool isVideo;
  final bool isShow;
  final VoidCallback onDecline;
  final VoidCallback toggleCamera;
  final VoidCallback toggleCameraSwitching;
  final VoidCallback toggleSpeaker;
  final VoidCallback toggleMic;
  final void Function(MediaDevice)? onDeviceSelected;
  final List<MediaDevice> audioOutputs;
  final String? participantMicMute;
  final String? participantNetworkUnstable;
  final bool noAnimate;
  final bool micOn;
  final bool cameraOn;
  final bool speakerOn;
  final Widget Function(BuildContext context, Widget child)? speakerSelector;
  final String? portName;
  final String? portType;
  final String? portId;
  final MediaDevice? selectedDevice;

  const GroupCallActionPanelWidget({
    super.key,
    this.isVideo = false,
    required this.onDecline,
    required this.toggleCamera,
    required this.toggleCameraSwitching,
    required this.toggleSpeaker,
    required this.toggleMic,
    required this.micOn,
    required this.cameraOn,
    required this.speakerOn,
    this.participantMicMute,
    this.participantNetworkUnstable,
    this.isShow = true,
    this.noAnimate = false,
    this.speakerSelector,
    this.audioOutputs = const [],
    this.onDeviceSelected,
    this.portName,
    this.portType,
    this.portId,
    this.selectedDevice,
  });

  bool get pNetworkUnstable => participantNetworkUnstable?.isNotEmpty == true;

  bool get pMicMute => participantMicMute?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final spacingHorizontal = 10.horizontalSpace;
      final delay = noAnimate ? 0 : 200;
      return Padding(
        padding: const EdgeInsets.fromLTRB(
          8.0,
          8.0,
          8.0,
          10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: delay),
              child: !isShow
                  ? SizedBox(
                      height: UChatCallConstant.videoPanelHeight,
                    )
                  : FadeInRight(
                      delay: Duration(milliseconds: delay),
                      duration: Duration(milliseconds: delay),
                      child: ZoomIn(
                        delay: Duration(milliseconds: (delay * 2.0).floor()),
                        duration: Duration(milliseconds: delay),
                        child: Container(
                          height: 110.spMin,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              spacingHorizontal,
                              Expanded(
                                child: CallActionVideoButton(
                                  onPressed: toggleCamera,
                                  isActive: cameraOn,
                                ),
                              ),
                              spacingHorizontal,
                              if (isVideo)
                                Expanded(
                                  child: CallActionFlipCameraButton(
                                    onPressed: toggleCameraSwitching,
                                  ),
                                )
                              else
                                Expanded(
                                  child: CallActionSpeakerButton(
                                    onPressed: toggleSpeaker,
                                    isActive: speakerOn,
                               
                                    sheetOffset: const Offset(0, -150),
                                    sheetPosition: PopupMenuPosition.over,
                                    onDeviceSelected: onDeviceSelected,
                                    audioOutputs: audioOutputs,
                                    selectedDevice: selectedDevice,
                                  ),
                                ),
                              spacingHorizontal,
                              Expanded(
                                child: CallActionMicButton(
                                  onPressed: toggleMic,
                                  isActive: micOn,
                                ),
                              ),
                              spacingHorizontal,
                              Expanded(
                                child: DeclineButton(
                                  onPressed: onDecline,
                                ),
                              ),
                              spacingHorizontal,
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }
}
