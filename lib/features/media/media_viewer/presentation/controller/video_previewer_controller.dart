import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/file_manager/file_manager.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/features/media/media_viewer/presentation/controller/mini_controller.dart';
import 'package:uchat/utils/uchat_utils.dart';
import 'package:video_player/video_player.dart';

import 'media_viewer_controller.dart';

class VideoPreviewerController extends GetxController {
  final _log = useLogger();

  String tag;
  VideoPlayerController? playerController;
  MiniController? androidMiniController;
  MediaFileModel media;

  VideoPreviewerController({
    required this.tag,
    required this.media,
  });

  final httpCaller = HttpCaller();

  final isPlaying = false.obs;
  final isPlayingBeforeInactiveApp = false.obs;
  final isError = false.obs;
  final errorMessage = ''.obs;
  final isInitialized = false.obs;
  final isBuffering = false.obs;
  final isSeeking = false.obs;

  final currentPlayingTime = const Duration(seconds: 0).obs;
  final currentPlayingTimeValue = 0.0.obs;
  final totalPlayTime = const Duration(seconds: 0).obs;
  final volume = 0.0.obs;
  final prevVolume = 0.0.obs;
  final bufferedPercentage = 0.0.obs;

  StreamSubscription? playPauseListener;

  @override
  onInit() async {
    isInitialized(false);
    totalPlayTime(Duration.zero);
    playPauseListener = eventBus.on<VideoPlayPauseEvent>().listen(onPlayPauseEvent);
    await initVideoPlayer();
    super.onInit();
  }

  @override
  onClose() async {
    if (Platform.isAndroid) {
      await androidMiniController?.dispose();
    } else {
      await playerController?.dispose();
    }
    playPauseListener?.cancel();
    super.onClose();
  }

  void onPlayPauseEvent(event) {
    if (event.tag != tag) {
      return;
    }
    if (isPlaying.value) {
      pause();
    } else {
      play();
    }
  }

  void handleVolume(double value) {
    volume(value);
    if (Platform.isAndroid) {
      androidMiniController?.setVolume(value);
    } else {
      playerController?.setVolume(value);
    }
  }

  void handleMute() {
    if (volume <= 0) {
      volume(0.5);
      if (Platform.isAndroid) {
        androidMiniController?.setVolume(0.5);
      } else {
        playerController?.setVolume(0.5);
      }
    } else {
      volume(0.0);
      if (Platform.isAndroid) {
        androidMiniController?.setVolume(0.0);
      } else {
        playerController?.setVolume(0.0);
      }
    }
  }

  MediaViewerController get mediaViewerCtl {
    return Get.find<MediaViewerController>();
  }

  bool get isLoadingVideo {
    if (isError.value) {
      return false;
    }

    return isBuffering.value == true || isInitialized.value == false;
  }

  Future<File> _downloadAndCache(MediaFileModel mediaFile) async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${mediaFile.fileId}');
    final isExist = await tempFile.exists();
    if (isExist) {
      return tempFile;
    } else {
      final bytes = await FileService.instance.downloadFile(mediaFile.url);
      await tempFile.writeAsBytes(bytes);
      return tempFile;
    }
  }

  /// Initialize video player
  /// and after initialized, set the total play time
  /// and set listener to the video player
  /// and play the video if the current media is the media of media viewer controller
  Future<void> initVideoPlayer() async {
    try {
      _log.d('Start initialize video player: ${media.fileName}');
      if (media.decryptedFile != null) {
        if (Platform.isAndroid) {
          androidMiniController = MiniController.file(media.decryptedFile!, viewType: VideoViewType.platformView);
        } else {
          playerController = VideoPlayerController.file(media.decryptedFile!);
        }
      } else {
        if (Platform.isAndroid) {
          androidMiniController = MiniController.network(
            '${media.url}?redirect=true',
            httpHeaders: httpCaller.apiHeader,
            viewType: VideoViewType.platformView,
          );
        } else {
          playerController = VideoPlayerController.networkUrl(
            // ?redirect=true will fix a bug when media.url return another url instead of
            // a video file.
            Uri.parse('${media.url}?redirect=true'),
            httpHeaders: httpCaller.apiHeader,
          );
        }
      }
      if (!isVideoTypeSupported(media.mimeType ?? '')) {
        isError(true);
        errorMessage('This file type "${media.mimeType}" is not supported on this device.');
        return;
      }
      if (Platform.isAndroid) {
        androidMiniController?.initialize().then(
          (_) {
            _log.d(
              'AndroidMiniController initialized successfully: ${media.fileName}',
            );
            isInitialized(true);
            totalPlayTime(androidMiniController?.value.duration ?? Duration.zero);
            androidMiniController?.setVolume(0.5);
            volume(androidMiniController?.value.volume ?? 0.0);
            androidMiniController?.addListener(onListenVideoPlayer);

            if (mediaViewerCtl.currentMediaFile.value == media) {
              play();
            }
          },
        ).catchError((e, stackTrace) {
          _log.e('Cannot initialize video player', e, stackTrace);
          isError(true);
          errorMessage('Cannot initialize video player: $e');
        });
      } else {
        _initializePlayerController();
      }
    } on PlatformException catch (e, stackTrace) {
      _log.e('PlatformException: Cannot init video player', e, stackTrace);
      isError(true);
      errorMessage('PlatformException: Cannot init video player: $e');
    } catch (e, stackTrace) {
      _log.e('Cannot init video player', e, stackTrace);
      isError(true);
      errorMessage('Cannot init video player: $e');
    }
  }

  void _initializePlayerController({bool isRetry = false}) {
    playerController?.initialize().then(
      (_) {
        _log.d(
          'VideoPlayerController initialized successfully: ${media.fileName}',
        );
        isInitialized(true);
        totalPlayTime(playerController?.value.duration ?? Duration.zero);
        playerController?.setVolume(0.5);
        volume(playerController?.value.volume ?? 0.0);
        playerController?.addListener(onListenVideoPlayer);

        if (mediaViewerCtl.currentMediaFile.value == media) {
          play();
        }
      },
    ).catchError((e, stackTrace) async {
      if (e is PlatformException &&
          !isRetry &&
          e.code == 'VideoError' &&
          e.message != null &&
          e.message?.contains('CoreMediaErrorDomain') == true) {
        errorMessage('Video player error: ${e.message}');
        final fileTemp = await _downloadAndCache(media);
        await playerController?.dispose();
        playerController = VideoPlayerController.file(fileTemp);
        _initializePlayerController(isRetry: true);
        _log.w('PlatformException: Error creating VideoPlayerController.network', e, stackTrace);
      } else {
        isError(true);
        errorMessage('Cannot initialize video player: $e');
        _log.e('Cannot initialize video player', e, stackTrace);
      }
    });
  }

  /// Listen to the video player
  /// update the isPlaying value
  /// and update the current playing time
  void onListenVideoPlayer() {
    // _log.d(
    //   'buffer: ${DateTime.now().toIso8601String()}\t'
    //   '${playerController?.value.buffered}'
    //   '- [${playerController?.value.isBuffering}] - ${media.fileName}}',
    // );

    if (mediaViewerCtl.currentMediaFile.value != media) {
      pause();
      return;
    }

    if (Platform.isAndroid) {
      // isBuffering(androidMiniController?.value.isBuffering ?? false);
      bufferedPercentage.value = calculateBufferedPercentage(androidMiniController!.value.buffered);
      if (isBuffering.value) {
        return;
      } else {
        bufferedPercentage.value = 100.0;
      }

      if (isSeeking.value == false) {
        if (androidMiniController?.value.isPlaying != isPlaying.value) {
          isPlaying(androidMiniController?.value.isPlaying ?? false);
        }
        currentPlayingTime(androidMiniController?.value.position ?? Duration.zero);
        currentPlayingTimeValue.value = currentPlayingTime.value.inMilliseconds.toDouble();
      }
    } else {
      isBuffering(playerController?.value.isBuffering ?? false);
      bufferedPercentage.value = calculateBufferedPercentage(playerController!.value.buffered);
      if (isBuffering.value) {
        return;
      } else {
        bufferedPercentage.value = 100.0;
      }

      if (isSeeking.value == false) {
        if (playerController?.value.isPlaying != isPlaying.value) {
          isPlaying(playerController?.value.isPlaying ?? false);
        }
        currentPlayingTime(playerController?.value.position ?? Duration.zero);
        currentPlayingTimeValue.value = currentPlayingTime.value.inMilliseconds.toDouble();
      }
    }
  }

  Future<void> onTapPlayButton() async {
    if (isPlaying.value) {
      await pause();
    } else {
      await play();
    }
  }

  Future<void> play() async {
    try {
      if (Platform.isAndroid) {
        if (androidMiniController?.value.isPlaying == true) {
          return;
        }
        await androidMiniController?.play();
        isPlaying(true);
      } else {
        if (playerController?.value.isPlaying == true) {
          return;
        }

        await playerController?.play();
        isPlaying(true);
      }
    } catch (e, stackTrace) {
      _log.e('Cannot play video', e, stackTrace);
      isError(true);
      errorMessage('Cannot play video: $e');
    }
  }

  Future<void> pause() async {
    try {
      if (Platform.isAndroid) {
        if (androidMiniController?.value.isPlaying == false) {
          return;
        }
        await androidMiniController?.pause();
        isPlaying(false);
      } else {
        if (playerController?.value.isPlaying == false) {
          return;
        }

        await playerController?.pause();
        isPlaying(false);
      }
    } catch (e, stackTrace) {
      _log.e('Cannot pause video', e, stackTrace);
      isError(true);
      errorMessage('Cannot pause video: $e');
    }
  }

  void seekToVideo(double milliSecondsTime) {
    final duration = Duration(milliseconds: milliSecondsTime.toInt());
    currentPlayingTimeValue.value = milliSecondsTime;
    currentPlayingTime(duration);

    if (Platform.isAndroid) {
      androidMiniController?.seekTo(duration);
    } else {
      playerController?.seekTo(duration);
    }
  }

  bool beforeSeekIsPlaying = false;
  Future<void> onSeekStart() async {
    isSeeking(true);
    beforeSeekIsPlaying = isPlaying.value;
    pause();
  }

  Future<void> onSeekEnd() async {
    isSeeking(false);
    if (beforeSeekIsPlaying) {
      play();
    }
  }

  Future<void> onAppInactive() async {
    isPlayingBeforeInactiveApp(isPlaying.value);
    await pause();
  }

  Future<void> onAppResume() async {
    if (isPlayingBeforeInactiveApp.value == false) {
      return;
    }
    await play();
  }

  double calculateBufferedPercentage(List<DurationRange> bufferedTimeRange) {
    if (bufferedTimeRange.isEmpty) {
      return 0.0;
    }

    final bufferedTime = bufferedTimeRange.last.end.inMilliseconds;
    final totalPlayTimeValue = totalPlayTime.value.inMilliseconds;
    final percentage = (bufferedTime / totalPlayTimeValue) * 100;

    if (bufferedPercentage.value > percentage) {
      return bufferedPercentage.value;
    } else {
      return percentage;
    }
  }

  Future<void> copyErrorMessageToClipboard() async {
    UChatUtils.instance.copyToClipboard(errorMessage.value);
    Get.snackbar(
      'Copied',
      'Error message copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
    );
  }
}
