import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class ParticipantTrack {
  ParticipantTrack({required this.participant, required this.videoTrack, required this.isScreenShare});

  VideoTrack? videoTrack;
  Participant participant;
  final bool isScreenShare;
}

enum ParticipantTrackType {
  kUserMedia,
  kScreenShare,
}

class ParticipantTrackV2 {
  ParticipantTrackV2({required this.participant, this.type = ParticipantTrackType.kUserMedia});

  Participant participant;
  final ParticipantTrackType type;
}

extension ParticipantTrackTypeExt on ParticipantTrackType {
  TrackSource get lkVideoSourceType => {
        ParticipantTrackType.kUserMedia: TrackSource.camera,
        ParticipantTrackType.kScreenShare: TrackSource.screenShareVideo,
      }[this]!;

  TrackSource get lkAudioSourceType => {
        ParticipantTrackType.kUserMedia: TrackSource.microphone,
        ParticipantTrackType.kScreenShare: TrackSource.screenShareAudio,
      }[this]!;
}

class ParticipantInfoWidget extends StatelessWidget {
  //
  final String? title;
  final bool audioAvailable;
  final ConnectionQuality connectionQuality;
  final bool isScreenShare;

  const ParticipantInfoWidget({
    this.title,
    this.audioAvailable = true,
    this.connectionQuality = ConnectionQuality.unknown,
    this.isScreenShare = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      padding: const EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != null)
            Flexible(
              child: Text(
                title!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          isScreenShare
              ? const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.monitor,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Icon(
                    audioAvailable ? Icons.mic : Icons.mic_off,
                    color: audioAvailable ? Colors.white : Colors.red,
                    size: 16,
                  ),
                ),
          if (connectionQuality != ConnectionQuality.unknown)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(
                connectionQuality == ConnectionQuality.poor ? Icons.wifi_off : Icons.wifi,
                color: {
                  ConnectionQuality.excellent: Colors.green,
                  ConnectionQuality.good: Colors.orange,
                  ConnectionQuality.poor: Colors.red,
                }[connectionQuality],
                size: 16,
              ),
            ),
        ],
      ),
    );
  }
}
