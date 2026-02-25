import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_text_input.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/send_icon.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomAudioInput extends GetView<ChatRoomInputController> {
  final String chatInputTag;
  final void Function(FileInfoModel file) onSendAudioRecording;

  const ChatRoomAudioInput({
    super.key,
    required this.chatInputTag,
    required this.onSendAudioRecording,
  });

  @override
  String? get tag => chatInputTag;

  double get _iconSize => AppSize.size6;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ChatRoomTextInput.inputHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space2,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.cancelRecording();
            },
            child: Container(
              padding: const EdgeInsets.all(AppSpace.space2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.appColors.iconError,
              ),
              child: Assets.vectors.xClose.svg(
                width: AppSize.size4,
                height: AppSize.size4,
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.iconInverse,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: AppSpace.space3,
          ),
          GestureDetector(
            onTap: () {
              controller.handleRecordingButtonPressed();
            },
            child: Container(
              padding: const EdgeInsets.all(AppSpace.space2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.appColors.backgroundPrimary,
              ),
              child: Obx(
                () => SvgPicture.asset(
                  controller.isAudioRecordFinished()
                      ? controller.isPlayingAudioRecording()
                          ? Assets.vectors.stop.path
                          : Assets.vectors.play.path
                      : Assets.vectors.stop.path,
                  width: AppSize.size4,
                  height: AppSize.size4,
                  colorFilter: ColorFilter.mode(
                    context.theme.appColors.iconInverse,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: AppSpace.space3,
          ),
          // recording audio wave
          Expanded(
            child: SizedBox(
              width: Get.width,
              // height: double.infinity,
              child: Obx(
                () {
                  if (controller.isAudioRecordFinished()) {
                    return AudioFileWaveforms(
                      playerController: controller.audioPlayerController,
                      size: Size(
                        double.infinity,
                        _iconSize,
                      ),
                      waveformType: WaveformType.long,
                      playerWaveStyle: PlayerWaveStyle(
                        fixedWaveColor: context.theme.appColors.icon.withValues(
                          alpha: 0.5,
                        ),
                        liveWaveColor: context.theme.appColors.icon,
                        showSeekLine: false,
                        spacing: 6,
                        scaleFactor: 80,
                        waveThickness: 2,
                      ),
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                    );
                  } else {
                    return AudioWaveforms(
                      size: Size(
                        double.infinity,
                        _iconSize,
                      ),
                      recorderController: controller.recorderController,
                      enableGesture: true,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      waveStyle: WaveStyle(
                        spacing: 6,
                        extendWaveform: true,
                        showMiddleLine: false,
                        waveColor: context.theme.appColors.icon,
                        waveThickness: 2,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          SizedBox(
            width: AppSize.size12,
            child: Center(
              child: Obx(
                () => AppText.body3(
                  controller.audioDurationText,
                  context: context,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          SendIcon(
            onTap: () {
              controller.onSendAudio(
                onSendAudioRecording,
              );
            },
          )
        ],
      ),
    );
  }
}
