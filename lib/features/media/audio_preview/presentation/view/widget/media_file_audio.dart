import 'dart:math';

import 'package:audioplayers/audioplayers.dart' as audio_player;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/entities/enum/file_download_status.dart';
import 'package:uchat/features/media/audio_preview/domain/entities/media_audio_entity.dart';
import 'package:uchat/features/media/audio_preview/presentation/controller/media_file_audio_controller.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/get_name.dart';

class MediaFileAudio extends GetView<MediaFileAudioController> {
  final MediaAudioEntity file;
  final void Function(BuildContext) onTapMenu;

  const MediaFileAudio({
    super.key,
    required this.file,
    required this.onTapMenu,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.playAudio(file),
      child: Padding(
        padding: EdgeInsets.only(top: 5.spMin, left: 10.spMin, right: 10.spMin),
        child: Stack(
          children: [
            _buildCard(context),
            _buildDownloadProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: const BorderSide(color: Color.fromARGB(40, 128, 128, 128)),
      ),
      color: const Color(0xFFF2F2F2),
      shadowColor: Colors.black,
      elevation: 0,
      child: ListTile(
        leading: _buildAudioLeadingIcon(),
        title: _buildTitle(),
        subtitle: _buildAudioSubtitle(context),
        trailing: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            onTapMenu(context);
          },
          child: Padding(
            padding: EdgeInsets.all(4.spMin),
            child: Image.asset(
              UChatAssetPath.meatBallsIcon,
              color: const Color(0xFF808080),
              width: 18.spMin,
              cacheWidth: 50.cacheSize,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAudioLeadingIcon() {
    return Obx(
      () {
        bool isPlaying = controller.currentlyPlayingFile.value == file &&
            (controller.playerState.value == audio_player.PlayerState.playing);

        bool isLoading = controller.isLoadingMap[file.id ?? ''] ?? false;

        return Material(
          elevation: 0.2,
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          child: SizedBox(
            width: 49.spMin,
            height: 49.spMin,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: isPlaying ? 20.spMin : 35.spMin,
                  width: isPlaying ? 20.spMin : 35.spMin,
                  child: isLoading
                      ? SizedBox(
                          width: 35.spMin,
                          height: 35.spMin,
                          child: const CircularProgressIndicator(),
                        )
                      : Image.asset(
                          isPlaying
                              ? 'assets/images/v2/icon_bookmark_audio_pause.png'
                              : 'assets/images/v2/icon_bookmark_audio_wave.png',
                          fit: BoxFit.contain,
                          width: 35.spMin,
                          height: 35.spMin,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Text(
      file.name ?? 'UNKNOWN',
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildAudioSubtitle(BuildContext context) {
    return Obx(
      () {
        bool isCurrentFile = controller.currentlyPlayingFile.value == file;
        bool isUserInteracting = controller.isUserInteracting.value;
        bool shouldShowSlider = isCurrentFile &&
            (controller.playerState.value == audio_player.PlayerState.playing ||
                controller.playerState.value == audio_player.PlayerState.paused ||
                controller.playerState.value == audio_player.PlayerState.completed ||
                isUserInteracting);

        Duration duration = Duration(milliseconds: (file.duration ?? 0).toInt());
        Duration currentPosition = isCurrentFile ? controller.currentPosition.value : Duration.zero;

        String durationText = _formatDuration(duration);

        // Handle cases where duration is zero to avoid division by zero
        double maxSliderValue = duration.inMilliseconds.toDouble();
        double currentSliderValue = currentPosition.inMilliseconds.toDouble();

        // Show playback controls only when `shouldShowSlider` is true
        if (shouldShowSlider) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Current position time
              Text(
                _formatDuration(currentPosition),
                style: TextStyle(
                  color: const Color(0xFF808080),
                  fontSize: 12.spMin,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 5.spMin), // Spacing between time and progress bar
              // Slider for seeking
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 2.spMin,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.spMin),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 8.spMin),
                  ),
                  child: Slider(
                    min: 0.0,
                    max: maxSliderValue > 0 ? maxSliderValue : 1.0,
                    value: currentSliderValue.clamp(0.0, maxSliderValue),
                    activeColor: UTheme.color.primary,
                    inactiveColor: Colors.white,
                    onChangeStart: (value) {
                      controller.setUserInteracting(true);
                    },
                    onChanged: (value) {
                      // Update the UI to follow the finger
                      controller.updateCurrentPosition(Duration(milliseconds: value.toInt()));
                    },
                    onChangeEnd: (value) {
                      controller.setUserInteracting(false);
                      controller.seekAudio(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
              ),
              SizedBox(width: 10.spMin), // Spacing between progress bar and duration
              // Total duration time
              Text(
                durationText,
                style: TextStyle(
                  color: const Color(0xFF808080),
                  fontSize: 12.spMin,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
        } else {
          // For non-playing files or when the audio has ended and the user is not interacting
          return _buildFileSubtitle();
        }
      },
    );
  }

  Widget _buildFileSubtitle() {
    String fileSize = _formatFileSize(file.size ?? 0);
    String senderName = getNameHelper(id: file.accountId);

    return Text(
      'Send by @senderName - @fileSize'.trParams({
        'senderName': senderName,
        'fileSize': fileSize,
      }),
      style: TextStyle(
        color: const Color(0xFF808080),
        fontSize: 12.spMin,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildDownloadProgressIndicator() {
    if (file.downloadStatus == FileDownloadStatus.loading) {
      return Positioned.fill(
        left: 5.spMin,
        top: 5.spMin,
        right: 5.spMin,
        bottom: 5.spMin,
        child: LiquidLinearProgressIndicator(
          value: file.downloadProgress,
          valueColor: const AlwaysStoppedAnimation(Color.fromARGB(72, 0, 0, 0)),
          backgroundColor: const Color(0x44FFFFFF),
          borderColor: const Color(0x44FFFFFF),
          borderWidth: -1.0,
          borderRadius: 20.spMin,
          direction: Axis.vertical,
          center: Text('${(file.downloadProgress * 100).round()}%'),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  String _formatFileSize(int sizeInBytes) {
    if (sizeInBytes <= 0) return '0 Bytes';
    const List<String> sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
    int i = (log(sizeInBytes) / log(1024)).floor();
    double size = sizeInBytes / pow(1024, i);
    return '${size.toStringAsFixed(2)} ${sizes[i]}';
  }
}
