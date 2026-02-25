import 'dart:async';
import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/camera/app_camera_view.dart';
import 'package:uchat/widgets/camera/app_take_photo_preview.dart';
import 'package:uchat/widgets/camera/app_take_video_preview.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class AppTakePhotoAndVideo {
  static Future<File?> show({
    required bool Function(Route<dynamic>) untilPredicate,
    bool isHideVideo = false,
  }) async {
    final result = await Get.to(
      () => const AppCameraView(),
      routeName: Routes.takePhotoAndVideoPath,
    );
    if (result != null && result is File) {
      return result;
    }
    return null;
  }

  static Future<File?> showOldCameraVersion({
    required bool Function(Route<dynamic>) untilPredicate,
    bool isHideVideo = false,
  }) async {
    final result = await Get.to(
      () => AppTakePhotoAndVideoBuild(
        untilPredicate: untilPredicate,
        isHideVideo: isHideVideo,
      ),
      routeName: Routes.takePhotoAndVideoPath,
    );
    if (result != null && result is File) {
      return result;
    }
    return null;
  }
}

class AppTakePhotoAndVideoBuild extends StatefulWidget {
  final bool Function(Route<dynamic>) untilPredicate;
  final bool isHideVideo;

  const AppTakePhotoAndVideoBuild({
    super.key,
    required this.untilPredicate,
    required this.isHideVideo,
  });

  @override
  State<AppTakePhotoAndVideoBuild> createState() => _AppTakePhotoAndVideoBuildState();
}

class _AppTakePhotoAndVideoBuildState extends State<AppTakePhotoAndVideoBuild> {
  late StreamSubscription _callIncomingSubscription;

  @override
  void initState() {
    super.initState();

    _callIncomingSubscription = eventBus.on<CallIncomingEvent>().listen(
      (event) async {
        Get.until(widget.untilPredicate);
      },
    );
  }

  @override
  void dispose() {
    _callIncomingSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photoAndVideo(
          videoOptions: VideoOptions(
            enableAudio: true,
            quality: VideoRecordingQuality.hd,
            ios: CupertinoVideoOptions(
              fps: 30,
            ),
            android: AndroidVideoOptions(
              bitrate: 6000000,
              fallbackStrategy: QualityFallbackStrategy.higher,
            ),
          ),
        ),
        sensorConfig: SensorConfig.single(
          aspectRatio: CameraAspectRatios.ratio_4_3,
        ),
        previewFit: CameraPreviewFit.contain,
        theme: AwesomeTheme(
          buttonTheme: AwesomeButtonTheme(
            iconSize: AppSize.size8,
            padding: const EdgeInsets.all(
              AppSpace.space3,
            ),
          ),
          bottomActionsBackgroundColor: Colors.black,
        ),
        topActionsBuilder: (state) {
          return Padding(
            padding: const EdgeInsets.only(
              top: AppSpace.space6,
              left: AppSpace.space4,
              right: AppSpace.space4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppSpace.space3,
                    ),
                    child: Assets.vectors.xClose.svg(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                AppText.title2(
                  state.captureMode == CaptureMode.video ? 'Take Video'.tr : 'Take Photo'.tr,
                  color: Colors.white,
                  context: context,
                ),
                const SizedBox(
                  width: 36,
                ),
              ],
            ),
          );
        },
        middleContentBuilder: (state) {
          return const SizedBox();
        },
        bottomActionsBuilder: (state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: AppSpace.space4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AwesomeCameraSwitchButton(
                      state: state,
                      theme: AwesomeTheme(
                        buttonTheme: AwesomeButtonTheme(
                          buttonBuilder: (child, onTap) {
                            return GestureDetector(
                              onTap: onTap,
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                padding: const EdgeInsets.all(
                                  AppSpace.space3,
                                ),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Assets.vectors.switchCamera.svg(
                                  width: AppSize.size8,
                                  height: AppSize.size8,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    AwesomeCaptureButton(
                      state: state,
                    ),
                    AwesomeFlashButton(
                      state: state,
                      theme: AwesomeTheme(
                        buttonTheme: AwesomeButtonTheme(
                          iconSize: AppSize.size8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSpace.space4,
                ),
                Visibility(
                  visible: !widget.isHideVideo && !(state is VideoRecordingCameraState || state.saveConfig == null),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: CameraModePager(
                    initialMode: state.captureMode,
                    availableModes: state.saveConfig!.captureModes,
                    onChangeCameraRequest: (mode) {
                      state.setState(mode);
                    },
                  ),
                ),
                SizedBox(
                  height: AppSpace.space4 + Get.mediaQuery.padding.bottom,
                ),
              ],
            ),
          );
        },
        onMediaCaptureEvent: (event) {
          switch ((event.status, event.isPicture, event.isVideo)) {
            case (MediaCaptureStatus.capturing, true, false):
              debugPrint('Capturing picture...');
            case (MediaCaptureStatus.success, true, false):
              event.captureRequest.when(
                single: (single) async {
                  debugPrint('Picture saved: ${single.file?.path}');
                  if (single.file != null) {
                    if (widget.isHideVideo) {
                      Get.back(result: File(single.file!.path));
                    } else {
                      final result = await Get.to(
                        () => AppTakeImagePreview(
                          image: File(single.file!.path),
                        ),
                      );
                      if (result != null && result is File) {
                        Get.back(result: result);
                      }
                    }
                  }
                },
              );
            case (MediaCaptureStatus.failure, true, false):
              debugPrint('Failed to capture picture: ${event.exception}');
            case (MediaCaptureStatus.capturing, false, true):
              debugPrint('Capturing video...');
            case (MediaCaptureStatus.success, false, true):
              event.captureRequest.when(
                single: (single) async {
                  debugPrint('Video saved: ${single.file?.path}');
                  if (single.file != null) {
                    final result = await Get.to(
                      () => AppTakeVideoPreview(
                        video: File(single.file!.path),
                      ),
                    );
                    if (result != null && result is File) {
                      Get.back(result: result);
                    }
                  }
                },
              );
            case (MediaCaptureStatus.failure, false, true):
              debugPrint('Failed to capture video: ${event.exception}');
            default:
              debugPrint('Unknown event: $event');
          }
        },
      ),
    );
  }
}
