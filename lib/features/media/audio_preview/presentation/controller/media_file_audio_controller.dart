import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart' as audio_player;
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/features/media/audio_preview/domain/entities/media_audio_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class MediaFileAudioController extends GetxController {
  final String tag;

  MediaFileAudioController({
    required this.tag,
  });

  // Audio player instance
  audio_player.AudioPlayer audioPlayer = audio_player.AudioPlayer();

  // Currently playing audio file
  final Rx<MediaAudioEntity?> currentlyPlayingFile = Rx<MediaAudioEntity?>(null);

  // Playback position and duration
  final Rx<Duration> currentPosition = Duration.zero.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;

  // Player state
  final Rx<audio_player.PlayerState> playerState = audio_player.PlayerState.stopped.obs;

  // Map to track the loading state of each file
  final RxMap<String, bool> isLoadingMap = <String, bool>{}.obs;

  // Map to store local file paths of downloaded audio files
  final Map<String, String> localFilePaths = {};

  // Flag to track if the user is interacting with the slider
  final RxBool isUserInteracting = false.obs;

  @override
  void onInit() {
    // Audio Player Listeners
    audioPlayer.onPositionChanged.listen((position) {
      if (!isUserInteracting.value) {
        // Only update currentPosition if the user is not interacting with the slider
        currentPosition.value = position;
      }
    });

    audioPlayer.onPlayerStateChanged.listen((state) {
      playerState.value = state;
    });

    audioPlayer.onDurationChanged.listen((duration) {
      totalDuration.value = duration;
    });

    audioPlayer.onPlayerComplete.listen((event) {
      playerState.value = audio_player.PlayerState.completed;

      if (!isUserInteracting.value) {
        if (currentlyPlayingFile.value != null) {
          currentPosition.value = totalDuration.value;
          currentlyPlayingFile.value = null; // Reset the current file
        }
      }
    });

    super.onInit();
  }

  @override
  void onClose() async {
    // Dispose audio player
    audioPlayer.dispose();
    playerState.value = audio_player.PlayerState.stopped;

    super.onClose();
  }

  /// Plays the selected audio file
  Future<void> playAudio(MediaAudioEntity audioFile) async {
    String fileId = audioFile.id ?? '';
    if (fileId.isEmpty) return;

    if (currentlyPlayingFile.value != null && currentlyPlayingFile.value != audioFile) {
      // Stop current audio
      await audioPlayer.stop();
    }

    if (currentlyPlayingFile.value == audioFile) {
      // Pause or resume the same audio
      if (playerState.value == audio_player.PlayerState.playing) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.resume();
      }
    } else {
      // Start playing new audio
      currentlyPlayingFile.value = audioFile;
      currentPosition.value = Duration.zero;
      totalDuration.value = Duration.zero;

      String? localFilePath;

      if (audioFile.isLocalFile) {
        localFilePath = audioFile.url; // Local file path
      } else {
        // Check if the file has already been downloaded
        if (localFilePaths.containsKey(fileId)) {
          localFilePath = localFilePaths[fileId];
        } else {
          // Download the file to local storage
          localFilePath = await downloadAudioFile(audioFile);
          if (localFilePath != null) {
            localFilePaths[fileId] = localFilePath;
            audioFile.isLocalFile = true;
            audioFile.url = localFilePath;
          } else {
            // Handle download failure
            _log.e('Failed to download audio file');
            return;
          }
        }
      }

      if (localFilePath != null) {
        // Verify that the file exists
        File localFile = File(localFilePath);
        if (await localFile.exists()) {
          await audioPlayer.play(DeviceFileSource(localFilePath));
        } else {
          _log.e('Local file does not exist at path: $localFilePath');
          // Handle the error appropriately
        }
      }
    }
  }

  /// Downloads the audio file and returns the local file path
  Future<String?> downloadAudioFile(MediaAudioEntity audioFile) async {
    String url = audioFile.apiFileUrl;
    String fileId = audioFile.id ?? '';

    if (fileId.isEmpty) return null;

    isLoadingMap[fileId] = true; // Set loading state to true

    try {
      // Determine the local file path where you want to save the downloaded file
      Directory appDocDir = await getApplicationDocumentsDirectory();

      // Use the path package to handle file extensions
      String fileExtension = p.extension(url);
      String localFileName = fileExtension.isNotEmpty ? fileId + fileExtension : fileId;
      String localFilePath = p.join(appDocDir.path, localFileName);

      // Check if the file already exists
      File localFile = File(localFilePath);
      if (await localFile.exists()) {
        isLoadingMap[fileId] = false; // Set loading state to false
        return localFilePath;
      }

      // Initialize Dio
      Dio dio = Dio();

      // Set headers, including authentication
      dio.options.headers = HttpCaller().apiHeader;

      // Log the URL and headers
      _log.i('Download URL: $url');
      _log.i('Headers: ${dio.options.headers}');

      // Make the HTTP GET request with followRedirects: true
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true, // Allow redirects
          validateStatus: (status) {
            return status! < 500; // Accept status codes less than 500
          },
        ),
      );

      // Log status code and response headers
      _log.i('Status code: ${response.statusCode}');
      _log.i('Response headers: ${response.headers.map}');

      // Check the status code
      if (response.statusCode == 200) {
        // Check Content-Type header
        String? contentType = response.headers.value('content-type');
        if (contentType != null && contentType.contains('audio')) {
          // Write the response bytes to the file
          await localFile.writeAsBytes(response.data);

          // Verify that the file is not empty
          if (await localFile.length() > 0) {
            isLoadingMap[fileId] = false;
            return localFilePath;
          } else {
            _log.e('Downloaded file is empty.');
            isLoadingMap[fileId] = false;
            return null;
          }
        } else {
          _log.e('Unexpected content type: $contentType');
          _log.e('Response data: ${response.data}');
          isLoadingMap[fileId] = false;
          return null;
        }
      } else {
        _log.e('Failed to download audio file. Status code: ${response.statusCode}');
        _log.e('Response data: ${response.data}');
        isLoadingMap[fileId] = false;
        return null;
      }
    } catch (e, stackTrace) {
      _log.e('Error downloading audio file.', e, stackTrace);
      isLoadingMap[fileId] = false;
      return null;
    }
  }

  void seekAudio(Duration position) async {
    currentPosition.value = position;

    if (playerState.value == audio_player.PlayerState.completed ||
        playerState.value == audio_player.PlayerState.stopped) {
      // Start playback from the new position
      await audioPlayer.play(
        DeviceFileSource(currentlyPlayingFile.value!.url!),
        position: position,
      );
    } else {
      await audioPlayer.seek(position);
      if (playerState.value == audio_player.PlayerState.paused) {
        await audioPlayer.resume();
      }
    }
  }

  void updateCurrentPosition(Duration position) {
    currentPosition.value = position;
  }

  void setUserInteracting(bool isInteracting) {
    isUserInteracting.value = isInteracting;
  }
}
