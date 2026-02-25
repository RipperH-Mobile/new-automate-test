import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:get/get.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/storage/storage.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class MessageTypeAudioV2Controller extends MessageTypeController {
  MessageTypeAudioV2Controller({required super.initMessage});

  // Path of audio file
  final filePath = ''.obs;

  // Id of audio file
  final fileId = ''.obs;

  // Scale or size of play button (used for pressed animation)
  final playButtonScale = 1.0.obs;

  // Current time when audio is playing
  final currentTime = const Duration(seconds: 0).obs;

  // Total duration time of audio
  final audioDuration = const Duration(seconds: 0).obs;

  // This will be true when audio is playing
  final isPlaying = false.obs;

  // This will be true when on init state
  final isInit = false.obs;

  // This will be true when file is already existed and player is ready to play
  final isFileReadyToPlay = false.obs;

  //  If there is any error, this will be true
  final isError = false.obs;

  // This will be true when download file to local at the first time pressed
  final isDownloading = false.obs;

  // If this is true, the waveforms will showed with full width
  final isShowFitWidth = true.obs;

  // Controller for audio player
  final playerController = PlayerController();

  @override
  void onInit() async {
    /// get file path
    Directory directory = await UChatStorage.instance.getRoomDirectory(roomId: initMessage.roomId ?? 'UNKNOWN');
    filePath.value = directory.path;

    /// Check if file is already existed or not, and init the player
    await checkIsAudioDownloaded(isCallOnInit: true);

    super.onInit();
  }

  @override
  void onClose() async {
    await playerController.stopAllPlayers();
    playerController.dispose();

    super.onClose();
  }

  Future<void> checkIsAudioDownloaded({bool isCallOnInit = false}) async {
    String id = initMessage.file?.id ?? 'UNKNOWN';
    final file = File('${filePath.value}/$id');
    final fileExisted = await file.exists();
    final duration = initMessage.file?.duration;
    _log.d('Checking file: ${file.path}...');

    if (duration != null) {
      /// Set total duration of audio
      audioDuration.value = Duration(milliseconds: duration.toInt());
    }

    if (fileExisted) {
      /// If file is already existed, then init player to get ready to play

      fileId.value = id;
      await initAudioPlayer(playOnInit: !isCallOnInit);
    } else if (!isCallOnInit) {
      try {
        /// If file isn't exist yet, then download it to local

        await startLoadingAudio();
      } catch (e, stacktrace) {
        _log.e('Call checkIsAudioDownloaded error:', e, stacktrace);
      }
    }
  }

  Future<void> initAudioPlayer({String? file, bool playOnInit = true}) async {
    try {
      isError.value = false;
      isInit.value = true;
      isFileReadyToPlay.value = false;

      final filePath = file ?? '${this.filePath.value}/${fileId.value}';

      /// Prepare player and set finish mode to 'pause'
      /// Because if it is 'stop', the player will can not be played over again
      await playerController.preparePlayer(path: filePath);
      playerController.setFinishMode(finishMode: FinishMode.pause);

      /// Listener for player state change (playing, pause)
      playerController.onPlayerStateChanged.listen((PlayerState playerState) {
        if (playerState.isPlaying) {
          isPlaying.value = true;
        } else {
          isPlaying.value = false;
        }
      });

      /// Listener for duration change (counting duration time)
      playerController.onCurrentDurationChanged.listen((duration) {
        currentTime.value = audioDuration.value - Duration(milliseconds: duration);
      });

      await updateAudioPlayerDuration();

      /// Set [isFileReadyToPlay] to true, because file is already existed
      isFileReadyToPlay.value = true;
    } catch (e, stackTrace) {
      _log.e('Call initAudioPlayer error.', e, stackTrace);
      isError.value = true;
    }
  }

  Future<void> updateAudioPlayerDuration() async {
    /// Get duration from downloaded file
    /// then set it to total duration and current time
    final duration = await playerController.getDuration(DurationType.max);

    audioDuration.value = Duration(milliseconds: duration);
    currentTime.value = audioDuration.value;
  }

  Future<void> startLoadingAudio() async {
    /// Start download state
    isDownloading.value = true;

    String fileUrl = initMessage.file?.apiFileUrl ?? '';
    String fileId = initMessage.file?.id ?? '';

    if (fileUrl.isNotEmpty && fileId.isNotEmpty) {
      final task = DownloadTask(
        url: fileUrl,
        filename: fileId,
        headers: HttpCaller().apiHeader,
        directory: UChatStorage.instance.getRoomFolderPath(initMessage.roomId ?? 'UNKNOWN'),
        baseDirectory: BaseDirectory.applicationSupport,
        updates: Updates.status,
      );

      final result = await FileDownloader().download(task);

      switch (result.status) {
        case TaskStatus.complete:

          /// If completed, check and init player again
          await checkIsAudioDownloaded();
          break;
        case TaskStatus.failed:

          /// There are some errors
          isError.value = true;
          _log.w('download audio failed with exception ${result.exception}');
          break;
        default:

          /// There are some errors
          isError.value = true;
          _log.w('download audio is not completed with status ${result.status}');
          break;
      }

      /// End download state
      isDownloading.value = false;
    }
  }

  Future<void> stopPreviousPlayer() async {
    /// Check if any player still playing
    final previousMsgId = AudioController.to.playerMsgId.value;

    if (initMessage.ref != previousMsgId) {
      try {
        final tag = '${initMessage.type?.value}-$previousMsgId';
        if (Get.isRegistered<MessageTypeAudioV2Controller>(tag: tag)) {
          final previousCtl = Get.find<MessageTypeAudioV2Controller>(tag: tag);

          if (previousCtl.playerController.playerState.isPlaying) {
            /// Stop this player before play the new one
            await previousCtl.playerController.pausePlayer();
          }
        }
      } catch (e, stacktrace) {
        _log.e('stopPreviousPlayer error.', e, stacktrace);
      }
    }
  }

  void handlePlayButtonPressed() async {
    try {
      final isDuringCall = await UChatCallController.instance.isDuringCall;
      final context = Get.context;

      if (isDuringCall) {
        if (context != null && context.mounted) {
          UChatNewDialog.showPreventPlayAudioDuringCall(context: context);
        }

        return;
      }

      /// Set button scale smaller (for animation)
      playButtonScale.value = 0.9;

      if (!isInit.value) {
        /// If it's not on init state, check if file is ready or not
        await checkIsAudioDownloaded();
      }

      /// If there is any other player is playing on central controller
      /// stop it before play the new selected file
      await stopPreviousPlayer();

      /// Assign the new file to central controller
      AudioController.to.playerMsgId(initMessage.ref);

      if (playerController.playerState.isPlaying) {
        await playerController.pausePlayer();
      } else {
        isShowFitWidth.value = false;
        await playerController.startPlayer();
      }

      /// Set button scale to normal (for animation)
      Future.delayed(const Duration(milliseconds: 100), () {
        playButtonScale.value = 1.0;
      });
    } catch (e, stacktrace) {
      _log.e('handlePlayPauseAudio error.', e, stacktrace);
      playButtonScale.value = 1.0;
    }
  }

  String getCurrentTime() {
    /// Get current time of audio
    return getFormattedTime(currentTime.value, isVideo: true);
  }

  String getAudioDuration() {
    /// Get total duration time of audio
    return getFormattedTime(audioDuration.value, isVideo: true);
  }

  /// This will manage duration time that's displaying on screen
  /// If the player is playing, it will showed current time
  /// If the player was 'stopped' (pause at the end actually), it will showed total duration time
  String get currentDuration => isInit.value ? getCurrentTime() : getAudioDuration();
}
