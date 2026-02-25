import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/domain/enums/camera_mode.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';

class CameraTakingButton extends StatelessWidget {
  final CameraMode cameraMode;
  final VoidCallback onTakePhoto;
  final VoidCallback onRecordVideo;
  final VoidCallback onStopRecordVideo;
  final bool isRecording;

  const CameraTakingButton({
    super.key,
    required this.cameraMode,
    required this.onTakePhoto,
    required this.onRecordVideo,
    required this.onStopRecordVideo,
    this.isRecording = false,
  });

  factory CameraTakingButton.photo({
    required VoidCallback onTakePhoto,
  }) {
    return CameraTakingButton(
      cameraMode: CameraMode.photo,
      onTakePhoto: onTakePhoto,
      onRecordVideo: () {},
      onStopRecordVideo: () {},
    );
  }

  factory CameraTakingButton.video({
    required VoidCallback onRecordVideo,
    required VoidCallback onStopRecordVideo,
    bool isRecording = false,
  }) {
    return CameraTakingButton(
      cameraMode: CameraMode.video,
      onTakePhoto: () {},
      onRecordVideo: onRecordVideo,
      onStopRecordVideo: onStopRecordVideo,
      isRecording: isRecording,
    );
  }

  double get borderWidth {
    return 2.5;
  }

  double get buttonSize {
    return AppSize.size20;
  }

  @override
  Widget build(BuildContext context) {
    if (cameraMode == CameraMode.video) {
      return GestureDetector(
        onTap: isRecording ? onStopRecordVideo : onRecordVideo,
        child: SizedBox(
          height: buttonSize,
          width: buttonSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.theme.appColors.backgroundGrayLightest,
            ),
            child: Builder(
              builder: (context) {
                if (isRecording) {
                  return Padding(
                    padding: const EdgeInsets.all(28),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.theme.appColors.backgroundError,
                        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded)),
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(AppSpace.space1),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.appColors.backgroundError,
                      border: Border.all(
                        color: context.theme.appColors.icon,
                        width: borderWidth,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTakePhoto,
      child: SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.theme.appColors.backgroundGrayLightest,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.space1),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.appColors.backgroundGrayLightest,
                border: Border.all(
                  color: context.theme.appColors.icon,
                  width: borderWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
