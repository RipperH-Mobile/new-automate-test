import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/domain/enums/camera_mode.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/camera/components/camera_taking_button.dart';
import 'package:uchat/widgets/camera/components/flash_mode_button.dart';
import 'package:uchat/widgets/camera/enum/camera_flash_mode.dart';

class CameraBottomElement extends StatelessWidget {
  final VoidCallback onTakePhoto;
  final VoidCallback onRecordVideo;
  final VoidCallback onStopRecordVideo;
  final VoidCallback onSwitchCamera;
  final VoidCallback onSwitchFlashMode;
  final bool enableSwitchingFlashMode;
  final CameraFlashMode flashMode;
  final CameraMode currentCameraMode;
  final bool isRecording;

  const CameraBottomElement({
    super.key,
    required this.onTakePhoto,
    required this.onRecordVideo,
    required this.onStopRecordVideo,
    required this.onSwitchCamera,
    required this.onSwitchFlashMode,
    required this.flashMode,
    required this.currentCameraMode,
    this.enableSwitchingFlashMode = true,
    this.isRecording = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onSwitchCamera,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.theme.appColors.icon,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpace.space4),
                child: Assets.vectors.switchCamera.svg(
                  colorFilter: ColorFilter.mode(
                    isRecording ? context.theme.appColors.iconLight : context.theme.appColors.iconPrimaryInverse,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          CameraTakingButton(
            cameraMode: currentCameraMode,
            onTakePhoto: onTakePhoto,
            onRecordVideo: onRecordVideo,
            onStopRecordVideo: onStopRecordVideo,
            isRecording: isRecording,
          ),
          FlashModeButton(
            onTap: onSwitchFlashMode,
            flashMode: flashMode,
            isEnabled: enableSwitchingFlashMode,
          ),
        ],
      ),
    );
  }
}
