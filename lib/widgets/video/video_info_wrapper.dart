import 'package:flutter/material.dart';
import 'package:uchat/widgets/video/video_duration_text.dart';
import 'package:uchat/widgets/video/video_play_icon.dart';

class VideoInfoWrapper extends StatelessWidget {
  final Widget thumbnail;
  final double duration;
  final bool isShowDuration;

  const VideoInfoWrapper({
    super.key,
    required this.thumbnail,
    required this.duration,
    this.isShowDuration = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: thumbnail,
        ),
        ..._buildVideoDetail(duration),
      ],
    );
  }

  /// Build play icon and video duration
  List<Widget> _buildVideoDetail(double duration) {
    return [
      const Center(
        child: VideoPlayIcon(),
      ),
      if (isShowDuration)
        Align(
          alignment: Alignment.bottomRight,
          child: VideoDurationText(
            durationMs: duration.toInt(),
            borderRadius: 8,
          ),
        ),
    ];
  }
}
