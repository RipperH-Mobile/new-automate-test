import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/domain/enums/camera_mode.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class CameraModeSelection extends StatefulWidget {
  final CameraMode currentMode;
  final Function(CameraMode mode) onModeChanged;

  const CameraModeSelection({
    super.key,
    required this.onModeChanged,
    required this.currentMode,
  });

  @override
  State<CameraModeSelection> createState() => _CameraModeSelectionState();
}

class _CameraModeSelectionState extends State<CameraModeSelection> {
  Duration get animationDuration => const Duration(milliseconds: 100);
  double get centerPosition => .148.sw;
  double get maxLeftPosition => .08.sw;
  double get maxRightPosition => .52.sw;

  double get videoModePosition => centerPosition + .282.sw;
  double get photoModePosition {
    if (Platform.isAndroid) {
      return centerPosition + .01.sw;
    }
    return centerPosition;
  }

  CameraMode _currentMode = CameraMode.photo;

  @override
  initState() {
    super.initState();

    setState(() {
      _currentMode = widget.currentMode;
      selectionPosition = widget.currentMode == CameraMode.video ? videoModePosition : photoModePosition;
    });
  }

  double? selectionPosition = 0.0;

  void _onMovingSelection(CameraMode mode, double dx) {
    if (dx < .1.sw || dx > .9.sw) {
      return;
    }

    if (mode == CameraMode.photo) {
      final updatePosition = dx - centerPosition - .2.sw;
      if (updatePosition > maxLeftPosition && updatePosition < maxRightPosition) {
        selectionPosition = updatePosition;
      }
    } else {
      final updatePosition = dx - centerPosition + .1.sw;
      if (updatePosition > maxLeftPosition && updatePosition < maxRightPosition) {
        selectionPosition = updatePosition;
      }
    }

    setState(() {});
  }

  void _onMovingSelectionEnd(CameraMode mode, double dx) {
    if (mode == CameraMode.photo) {
      if (dx > maxRightPosition + 80.spMin) {
        selectionPosition = videoModePosition;
        _currentMode = CameraMode.video;
      } else {
        selectionPosition = photoModePosition;
        _currentMode = CameraMode.photo;
      }
    } else {
      if (dx < maxLeftPosition + 80.spMin) {
        selectionPosition = photoModePosition;
        _currentMode = CameraMode.photo;
      } else {
        selectionPosition = videoModePosition;
        _currentMode = CameraMode.video;
      }
    }

    widget.onModeChanged(_currentMode);
    setState(() {});
  }

  void _onSelectMode(CameraMode mode) {
    if (mode == CameraMode.photo) {
      selectionPosition = photoModePosition;
      _currentMode = CameraMode.photo;
    } else {
      selectionPosition = videoModePosition;
      _currentMode = CameraMode.video;
    }
    widget.onModeChanged(_currentMode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.spMin,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Border around the selection
          const RepaintBoundary(
            child: Align(
              alignment: Alignment.center,
              child: _RoundedSelection(),
            ),
          ),

          // Photo mode button
          AnimatedPositioned(
            duration: animationDuration,
            onEnd: () {
              widget.onModeChanged(_currentMode);
            },
            left: selectionPosition,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _CameraModeText(
                  mode: CameraMode.video,
                  onTap: () => _onSelectMode(CameraMode.video),
                  onMoving: _onMovingSelection,
                  onMovingEnd: _onMovingSelectionEnd,
                ),
                .145.sw.horizontalSpace,
                _CameraModeText(
                  mode: CameraMode.photo,
                  onTap: () => _onSelectMode(CameraMode.photo),
                  onMoving: _onMovingSelection,
                  onMovingEnd: _onMovingSelectionEnd,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundedSelection extends StatelessWidget {
  const _RoundedSelection();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.roundedFull),
        border: Border.all(
          color: context.theme.appColors.textPrimaryInverse,
          width: 2,
        ),
      ),
      child: SizedBox(
        height: 32.spMin,
        width: 80.spMin,
      ),
    );
  }
}

class _CameraModeText extends StatelessWidget {
  final CameraMode mode;
  final VoidCallback onTap;
  final Function(CameraMode mode, double dx) onMoving;
  final Function(CameraMode mode, double dx) onMovingEnd;

  const _CameraModeText({
    required this.mode,
    required this.onTap,
    required this.onMoving,
    required this.onMovingEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onHorizontalDragUpdate: (detail) => onMoving(mode, detail.globalPosition.dx),
      onHorizontalDragEnd: (detail) => onMovingEnd(mode, detail.globalPosition.dx),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space2,
            vertical: AppSpace.space1,
          ),
          child: AppText.body2Bold(
            mode == CameraMode.photo ? 'Photo' : 'Video',
            context: context,
            color: context.theme.appColors.textPrimaryInverse,
            lineHeight: 1.2,
          ),
        ),
      ),
    );
  }
}
