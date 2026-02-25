import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/helpers/extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/domain/enums/camera_mode.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension_duration.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/camera/app_take_photo_preview.dart';
import 'package:uchat/widgets/camera/app_take_video_preview.dart';
import 'package:uchat/widgets/camera/components/camera_bottom_element.dart';
import 'package:uchat/widgets/camera/components/camera_mode_selection.dart';
import 'package:uchat/widgets/camera/enum/camera_flash_mode.dart';
import 'package:uchat/widgets/camera/handler/camera_zoom_handler.dart';

final _log = useLogger();

class AppCameraView extends StatelessWidget {
  const AppCameraView({super.key});

  double get focusBoxSize => 80.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<AppCameraController>(
        init: AppCameraController(),
        builder: (ctl) {
          if (ctl.isInitializing) {
            return const Center(child: CircularProgressIndicator());
          }

          if (ctl.cameraController.value.isInitialized == false) {
            return const Center(child: Text('Camera is not initialized'));
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              if (!ctl.isSwitchingCamera)
                Positioned(
                  top: UChatConstant.cameraPreviewPaddingFromTop,
                  child: GestureDetector(
                    onTapDown: (detail) => ctl.handleTapToFocus(context, detail),
                    onScaleStart: (_) => ctl.zoomHandler.handleScaleStart(),
                    onScaleUpdate: (details) => ctl.zoomHandler.handleScaleUpdate(
                      details.scale,
                      ctl.cameraController,
                      onZoomChanged: () => ctl.update(),
                    ),
                    onScaleEnd: (_) => ctl.zoomHandler.handleScaleEnd(),
                    onDoubleTap: () => ctl.zoomHandler.resetZoom(
                      ctl.cameraController,
                      onZoomChanged: () => ctl.update(),
                    ),
                    child: SizedBox(
                      width: 1.sw,
                      child: CameraPreview(ctl.cameraController),
                    ),
                  ),
                ).animate().fadeIn(),

              // Focus box
              // This will show a focus box animation when user taps to focus
              Positioned(
                top: ctl.currentFocusPoint.dy - (focusBoxSize / 2),
                left: ctl.currentFocusPoint.dx - (focusBoxSize / 2),
                child: Assets.vectors.cameraFocus.svg(
                  width: focusBoxSize.spMin,
                  height: focusBoxSize.spMin,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              )
                  .animate(controller: ctl.focusBoxAnimationController, autoPlay: false)
                  .fadeIn(duration: const Duration(milliseconds: 150)),

              // Close button
              Positioned(
                left: AppSpace.space4,
                top: AppSpace.space4,
                child: SafeArea(
                  child: IconButton(
                    icon: Assets.vectors.xClose.svg(
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: ctl.onCloseCamera,
                  ),
                ),
              ),

              Positioned(
                top: AppSpace.space6,
                child: SafeArea(
                  child: AppText.title2(
                    ctl.currentCameraMode == CameraMode.video ? 'Take Video'.tr : 'Take Photo'.tr,
                    context: context,
                    color: context.theme.appColors.textPrimaryInverse,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CameraBottomElement(
                        currentCameraMode: ctl.currentCameraMode,
                        isRecording: ctl.isRecording,
                        onTakePhoto: ctl.onTakePhoto,
                        onRecordVideo: ctl.onRecordVideo,
                        onStopRecordVideo: ctl.onStopRecordVideo,
                        onSwitchCamera: ctl.onSwitchCamera,
                        onSwitchFlashMode: ctl.onSwitchFlashMode,
                        flashMode: ctl.currentFlashMode,
                      ),
                      Column(
                        children: [
                          AppSpace.space3.verticalSpace,
                          AppText.subtitle1(
                            ctl.recordingDuration.toHumanReadable(),
                            context: context,
                            color: context.theme.appColors.textPrimaryInverse,
                          ),
                        ],
                      ).animate(target: ctl.isRecording ? 1 : 0).fadeIn(duration: const Duration(milliseconds: 150)),
                      AppSpace.space6.verticalSpace,
                      RepaintBoundary(
                        child: CameraModeSelection(
                          currentMode: ctl.currentCameraMode,
                          onModeChanged: ctl.onChangedMode,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AppCameraController extends FullLifeCycleController with FullLifeCycleMixin, GetSingleTickerProviderStateMixin {
  CameraController get cameraController {
    return _cameraController!;
  }

  CameraController? _cameraController;

  final CameraZoomHandler zoomHandler = CameraZoomHandler();

  AppCameraController({
    this.cameraMode = CameraMode.takePhotoAndVideo,
  }) {
    if (cameraMode == CameraMode.video) {
      currentCameraMode = CameraMode.video;
    } else {
      currentCameraMode = CameraMode.photo;
    }
  }

  final CameraMode cameraMode;
  CameraDescription? lastCamera;
  bool isInitializing = true;
  bool preventDuplicateCall = false;
  bool isFileProcessing = false;
  bool isSwitchingCamera = false;
  List<CameraDescription> _cameras = [];
  CameraMode currentCameraMode = CameraMode.photo;
  CameraFlashMode currentFlashMode = CameraFlashMode.auto;
  bool isRecording = false;
  Duration recordingDuration = const Duration();
  Offset currentFocusPoint = const Offset(0.5, 0.5);
  late AnimationController focusBoxAnimationController;
  Timer? _focusBoxHideTimer;
  double currentZoomLevel = 1.0;

  List<CameraFlashMode> get flashModes => [
        CameraFlashMode.off,
        CameraFlashMode.auto,
        CameraFlashMode.always,
        CameraFlashMode.torch,
      ];

  CameraDescription get frontCamera => _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );

  CameraDescription get backCamera => _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.first,
      );

  List<CameraDescription> get backCameras => _cameras
      .where(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      )
      .toList();

  // Add your controller logic here
  @override
  void onInit() {
    super.onInit();

    focusBoxAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    initializeCamera();
  }

  @override
  Future<void> onClose() async {
    // Cancel focus box timer
    _focusBoxHideTimer?.cancel();

    try {
      if (cameraController.value.isInitialized) {
        if (cameraController.value.isRecordingVideo) {
          isRecording = false;
          isInitializing = true;
          await cameraController.stopVideoRecording();
        }
        await cameraController.dispose();
      }
    } on TypeError catch (e, stackTrace) {
      _log.w('Camera controller was null during onClose', e, stackTrace);
    }

    focusBoxAnimationController.dispose();
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {
    if (cameraController.value.isInitialized) {
      // App is hidden (not visible)
      // Then dispose the camera to free up resources and set
      // isRecording to false if recording
      // isInitializing to true to re-initialize when app is resumed
      isRecording = false;
      isInitializing = true;
      cameraController.dispose();
    }
  }

  @override
  Future<void> onInactive() async {
    if (cameraController.value.isInitialized && !isInitializing) {
      // App is inactive (may be transitioning to background)
      // Pause the camera preview to save resources
      // Also stop recording if recording
      if (cameraController.value.isRecordingVideo) {
        isRecording = false;
        await cameraController.stopVideoRecording();
        recordingDuration = const Duration();
      }
      await cameraController.pausePreview();
    }
  }

  @override
  void onPaused() {
    /// This action process when app is in background
  }

  @override
  void onResumed() {
    // App is resumed (visible and active)
    // Re-initialize the camera if it was disposed
    // if not then resume the preview
    if (isInitializing) {
      initializeCamera(firstInit: false);
    } else {
      cameraController.resumePreview();
    }
  }

  Future<void> initializeCamera({bool firstInit = true}) async {
    if (preventDuplicateCall) {
      useLogger().d('initializeCamera already in progress, skipping');
      return;
    }
    try {
      isInitializing = true;
      preventDuplicateCall = true;
      if (firstInit) {
        _cameras = await availableCameras();
      }
      if (_cameras.isNotEmpty) {
        lastCamera ??= backCameras.first;
        _cameraController = CameraController(
          lastCamera!,
          ResolutionPreset.max,
          enableAudio: true,
          imageFormatGroup: ImageFormatGroup.jpeg,
          fps: 30,
          videoBitrate: 6000000,
        );
        await cameraController.initialize();
        await zoomHandler.initializeZoomLevels(cameraController);
        currentZoomLevel = zoomHandler.getCurrentZoomValue();
        currentFlashMode = CameraFlashMode.auto;
        await cameraController.setFlashMode(CameraFlashMode.auto.mode);
        isInitializing = false;

        if (currentCameraMode == CameraMode.video) {
          prepareForVideoRecording();
        }
        update();
      } else {
        _log.w('No cameras found');
        Get.back();
      }
    } catch (e, stackTrace) {
      _log.e('Failed to initialize camera', e, stackTrace);
      Get.back();
      if (kDebugMode) {
        Get.snackbar('Error', 'Failed to initialize camera: $e');
      }
    } finally {
      isInitializing = false;
      preventDuplicateCall = false;
      update();
    }
  }

  void onChangedMode(CameraMode mode) {
    recordingDuration = const Duration();
    if (cameraController.value.isRecordingVideo) {
      isRecording = false;
      cameraController.stopVideoRecording();
    }
    if (mode == currentCameraMode) {
      return;
    }

    HapticFeedback.lightImpact();
    if (mode == CameraMode.video) {
      currentCameraMode = CameraMode.video;
      prepareForVideoRecording();
    } else {
      isRecording = false;
      currentCameraMode = CameraMode.photo;
    }
    update();
  }

  Future<void> onTakePhoto() async {
    if (!cameraController.value.isInitialized) {
      _log.w('Camera is not initialized');
      return;
    }

    if (isFileProcessing) {
      return;
    }

    try {
      isFileProcessing = true;
      HapticFeedback.lightImpact();
      final file = await cameraController.takePicture();
      final capturedFile = File(file.path);
      isFileProcessing = false;
      update();

      isInitializing = true;
      await cameraController.dispose();
      final photo = await Get.to(() => AppTakeImagePreview(image: capturedFile), fullscreenDialog: true);

      if (photo != null && photo is File) {
        Get.back(result: photo);
      } else {
        await initializeCamera();
      }
    } catch (e, stackTrace) {
      _log.e('Failed to take picture', e, stackTrace);
      if (kDebugMode) {
        Get.snackbar('Error', 'Failed to take picture: $e');
      }
    }
  }

  Future<void> onSwitchCamera() async {
    if (!cameraController.value.isInitialized) {
      _log.w('Camera is not initialized');
      return;
    }

    if (isRecording) {
      _log.w('Cannot switch camera while recording');
      return;
    }

    final currentCamera = cameraController.description;
    final newCamera = currentCamera.lensDirection == CameraLensDirection.back ? frontCamera : backCamera;

    try {
      HapticFeedback.lightImpact();
      isSwitchingCamera = true;
      lastCamera = newCamera;
      _cameraController = CameraController(
        lastCamera!,
        ResolutionPreset.max,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg,
        fps: 30,
        videoBitrate: 6000000,
      );
      await cameraController.initialize();
      await cameraController.setFocusMode(FocusMode.auto);
      isSwitchingCamera = false;
      if (isRecording) {
        await cameraController.startVideoRecording();
      }
      update();
    } catch (e, stackTrace) {
      _log.e('Failed to switch camera', e, stackTrace);
      if (kDebugMode) {
        Get.snackbar('Error', 'Failed to switch camera: $e');
      }
    } finally {
      isSwitchingCamera = false;
      update();
    }
  }

  Future<void> onSwitchFlashMode() async {
    if (!cameraController.value.isInitialized) {
      Get.snackbar('Error', 'Camera is not initialized');
      return;
    }

    CameraFlashMode newFlashMode;
    final flashModeIndex = flashModes.indexOf(currentFlashMode);
    if (flashModeIndex == -1) {
      newFlashMode = CameraFlashMode.off;
    } else {
      newFlashMode = flashModes[(flashModeIndex + 1) % flashModes.length];
    }

    try {
      if (lastCamera?.lensDirection == CameraLensDirection.front && newFlashMode == CameraFlashMode.torch) {
        currentFlashMode = newFlashMode;
        onSwitchFlashMode();
      } else {
        HapticFeedback.lightImpact();
        await cameraController.setFlashMode(newFlashMode.mode);
        currentFlashMode = newFlashMode;
        update();
      }
    } catch (e, stackTrace) {
      if (e is CameraException) {
        if (e.code == 'setFlashModeFailed') {
          currentFlashMode = newFlashMode;
          onSwitchFlashMode();
        }
      } else {
        _log.e('Failed to switch flash mode', e, stackTrace);
        if (kDebugMode) {
          Get.snackbar('Error', 'Failed to switch flash mode: $e');
        }
      }
    }
  }

  Future<void> onCloseCamera() async {
    if (cameraController.value.isInitialized) {
      if (cameraController.value.isRecordingVideo) {
        isRecording = false;
        isInitializing = true;
        update();
        await cameraController.stopVideoRecording();
      }
      await cameraController.dispose();
    }
    Get.back();
  }

  void prepareForVideoRecording() {
    cameraController.prepareForVideoRecording();
  }

  Future<void> onRecordVideo() async {
    if (!cameraController.value.isInitialized) {
      _log.w('Camera is not initialized');
      return;
    }

    if (isRecording) {
      _log.w('Already recording video');
      return;
    }

    try {
      isRecording = true;
      HapticFeedback.lightImpact();
      await cameraController.startVideoRecording();
      update();

      // Start a timer to update recording duration
      recordingDuration = const Duration();
      while (isRecording) {
        await Future.delayed(const Duration(seconds: 1));
        recordingDuration += const Duration(seconds: 1);
        update();
      }
    } catch (e, stackTrace) {
      _log.e('Failed to start video recording', e, stackTrace);
      if (kDebugMode) {
        Get.snackbar('Error', 'Failed to start video recording: $e');
      }
    }
  }

  Future<void> onStopRecordVideo() async {
    if (!cameraController.value.isInitialized) {
      _log.w('Camera is not initialized');
      return;
    }

    if (!isRecording) {
      _log.w('Not currently recording video');
      return;
    }

    try {
      isRecording = false;
      HapticFeedback.lightImpact();
      final file = await cameraController.stopVideoRecording();
      recordingDuration = const Duration();
      File videoFile = File(file.path);
      final List<int> header = videoFile.openSync().readSync(256);
      final String? mimeType = lookupMimeType(videoFile.path, headerBytes: header);
      if (mimeType != null) {
        final String? fileExtension = extensionFromMime(mimeType);
        if (fileExtension != null) {
          // Replace the .temp extension with the correct extension
          videoFile = File(videoFile.renameSync(videoFile.path.replaceAll(RegExp(r'\.temp'), '.$fileExtension')).path);
        }
      }

      isFileProcessing = false;
      update();

      isInitializing = true;
      await cameraController.dispose();
      final video = await Get.to(() => AppTakeVideoPreview(video: videoFile), fullscreenDialog: true);
      if (video != null && video is File) {
        Get.back(result: video);
      } else {
        await initializeCamera();
      }
    } catch (e, stackTrace) {
      _log.e('Failed to stop video recording', e, stackTrace);
      if (kDebugMode) {
        Get.snackbar('Error', 'Failed to stop video recording: $e');
      }
    }
  }

  void handleTapToFocus(BuildContext context, TapDownDetails detail) {
    if (!cameraController.value.isInitialized) {
      _log.w('Camera is not initialized');
      return;
    }

    currentFocusPoint = detail.globalPosition;
    final RenderBox box = context.findRenderObject() as RenderBox;
    showFocusBox();

    // find the tap position relative to the camera preview
    final Offset localPosition = box.globalToLocal(currentFocusPoint);
    final double dx = localPosition.dx / box.size.width;
    final double dy = localPosition.dy / box.size.height;

    // set the focus point and then set the focus mode to auto to trigger the focus
    cameraController.setFocusPoint(Offset(dx, dy)).then((_) {
      cameraController.setFocusMode(FocusMode.auto);
    });

    update();
  }

  void showFocusBox() {
    // Cancel any existing timer to prevent reverse animation from previous taps
    _focusBoxHideTimer?.cancel();

    // Show the focus box
    focusBoxAnimationController.resetAndForward();
    update();

    // Set a new timer to hide the focus box after 1 second
    _focusBoxHideTimer = Timer(const Duration(seconds: 1), () {
      if (focusBoxAnimationController.isCompleted) {
        focusBoxAnimationController.reverse();
        update();
      }
    });
  }
}
