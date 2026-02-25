import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/presentation/views/widgets/component/call_user_profile.dart';
import 'package:uchat/features/call/presentation/views/widgets/component/call_mute_mic_badge.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/call/participant_info.dart';

final _log = useLogger();

class RemoteParticipantWidgetNew extends StatefulWidget {
  final RemoteParticipant participant;

  final ParticipantTrackType type;

  final RoomCallModel callData;

  final UiCallState uiState;

  final Widget? callStatus;

  final Widget? floatingParticipant;

  final String? overrideAvatarImage;

  const RemoteParticipantWidgetNew({
    super.key,
    required this.participant,
    required this.type,
    required this.callData,
    required this.uiState,
    this.callStatus,
    this.floatingParticipant,
    this.overrideAvatarImage,
  });

  @override
  State<StatefulWidget> createState() => _RemoteParticipantWidgetNewState();
}

class _RemoteParticipantWidgetNewState extends State<RemoteParticipantWidgetNew> {
  RemoteTrackPublication<RemoteVideoTrack>? get videoPublication => widget.participant.videoTrackPublications
      .where((element) => element.source == widget.type.lkVideoSourceType)
      .firstOrNull;

  RemoteTrackPublication<RemoteAudioTrack>? get audioPublication => widget.participant.audioTrackPublications
      .where((element) => element.source == widget.type.lkAudioSourceType)
      .firstOrNull;

  VideoTrack? get activeVideoTrack => videoPublication?.track;

  AudioTrack? get activeAudioTrack => audioPublication?.track;

  bool get isScreenShare => widget.type == ParticipantTrackType.kScreenShare;
  EventsListener<ParticipantEvent>? _listener;

  @override
  void initState() {
    super.initState();
    _listener = widget.participant.createListener();
    _listener?.on<TranscriptionEvent>((e) {
      for (var seg in e.segments) {
        _log.d('Transcription: ${seg.text} ${seg.isFinal}');
      }
    });

    widget.participant.addListener(_onParticipantChanged);
    _onParticipantChanged();
  }

  @override
  void dispose() {
    widget.participant.removeListener(_onParticipantChanged);
    _listener?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    oldWidget.participant.removeListener(_onParticipantChanged);
    widget.participant.addListener(_onParticipantChanged);
    _onParticipantChanged();
    super.didUpdateWidget(oldWidget);
  }

  // Notify Flutter that UI re-build is required, but we don't set anything here
  // since the updated values are computed properties.
  void _onParticipantChanged() => setState(() {});

  bool get pNetworkUnstable => widget.participant.connectionQuality != ConnectionQuality.excellent;

  bool get pMicMute => widget.participant.isMicrophoneEnabled() == false;

  bool get pVideoActive => activeVideoTrack != null && !activeVideoTrack!.muted;

  @override
  Widget build(BuildContext ctx) => IgnorePointer(
        child: Stack(
          children: [
            if (pVideoActive)
              Container(
                color: Colors.black,
              ),
            // Video
            if (pVideoActive)
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: AppSpace.space6,
                    left: AppSpace.space4,
                    right: AppSpace.space4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppRadius.roundedXl,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppRadius.roundedXl,
                    ),
                    child: VideoTrackRenderer(
                      renderMode: VideoRenderMode.auto,
                      activeVideoTrack!,
                      fit: isScreenShare ? VideoViewFit.contain : VideoViewFit.cover,
                    ),
                  ),
                ),
              )
            else
              CallUserProfileWidget(
                speaking: widget.participant.isSpeaking && !isScreenShare,
                uiState: UiCallState.voice,
                image: widget.overrideAvatarImage ?? widget.callData.imageUrl ?? '',
                blurHash: widget.callData.imageBlurHash ?? '',
                showBorder: true,
              ),
            if (widget.floatingParticipant != null) widget.floatingParticipant!,
            if (pMicMute || widget.callStatus != null)
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      if (widget.callStatus != null && !pVideoActive)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpace.space4,
                          ),
                          child: widget.callStatus!,
                        ),
                      if (pMicMute)
                        FadeIn(
                          child: MuteMicBadge(
                            displayName: widget.participant.name,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
}
