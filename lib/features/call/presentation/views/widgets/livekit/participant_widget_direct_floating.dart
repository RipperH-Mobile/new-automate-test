import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/presentation/views/widgets/component/call_user_profile.dart';
import 'package:uchat/features/call/presentation/views/widgets/livekit/participant_image_background.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/call/participant_info.dart';

final _log = useLogger();

class RemoteParticipantFloating extends StatefulWidget {
  final RemoteParticipant? participant;

  final ParticipantTrackType? type;

  final RoomCallModel callData;

  final UiCallState uiState;

  final Widget? callStatus;

  final Widget? floatingParticipant;

  final String? overrideAvatarImage;
  final String? overrideBlurHash;

  const RemoteParticipantFloating({
    super.key,
    this.participant,
    required this.type,
    required this.callData,
    required this.uiState,
    this.callStatus,
    this.floatingParticipant,
    this.overrideAvatarImage,
    this.overrideBlurHash,
  });

  @override
  State<StatefulWidget> createState() => _RemoteParticipantFloatingState();
}

class _RemoteParticipantFloatingState extends State<RemoteParticipantFloating> {
  RemoteTrackPublication<RemoteVideoTrack>? get videoPublication => widget.participant?.videoTrackPublications
      .where((element) => element.source == widget.type?.lkVideoSourceType)
      .firstOrNull;

  RemoteTrackPublication<RemoteAudioTrack>? get audioPublication => widget.participant?.audioTrackPublications
      .where((element) => element.source == widget.type?.lkAudioSourceType)
      .firstOrNull;

  VideoTrack? get activeVideoTrack => videoPublication?.track;

  AudioTrack? get activeAudioTrack => audioPublication?.track;

  bool get isScreenShare => widget.type == ParticipantTrackType.kScreenShare;
  EventsListener<ParticipantEvent>? _listener;

  @override
  void initState() {
    super.initState();
    _listener = widget.participant?.createListener();
    _listener?.on<TranscriptionEvent>((e) {
      for (var seg in e.segments) {
        _log.d('Transcription: ${seg.text} ${seg.isFinal}');
      }
    });

    widget.participant?.addListener(_onParticipantChanged);
    _onParticipantChanged();
  }

  @override
  void dispose() {
    widget.participant?.removeListener(_onParticipantChanged);
    _listener?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    oldWidget.participant?.removeListener(_onParticipantChanged);
    widget.participant?.addListener(_onParticipantChanged);
    _onParticipantChanged();
    super.didUpdateWidget(oldWidget);
  }

  // Notify Flutter that UI re-build is required, but we don't set anything here
  // since the updated values are computed properties.
  void _onParticipantChanged() => setState(() {});

  bool get pMicMute => widget.participant?.isMicrophoneEnabled() == false;

  bool get pVideoActive => activeVideoTrack != null && !activeVideoTrack!.muted;

  @override
  Widget build(BuildContext ctx) => IgnorePointer(
        child: Stack(
          children: [
            ParticipantImageBackground(
              image: widget.overrideAvatarImage ?? widget.callData.imageUrl ?? '',
              blurHash: widget.overrideBlurHash ?? widget.callData.imageBlurHash ?? '',
            ),
            // Video
            if (pVideoActive)
              Container(
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
                    fit: VideoViewFit.cover,
                  ),
                ),
              )
            else
              CallUserProfileWidget(
                speaking: widget.participant?.isSpeaking == true && !isScreenShare,
                uiState: UiCallState.voice,
                image: widget.overrideAvatarImage ?? widget.callData.imageUrl ?? '',
                blurHash: widget.overrideBlurHash ?? widget.callData.imageBlurHash ?? '',
                showBorder: true,
                size: 54,
              ),

            if (widget.floatingParticipant != null) widget.floatingParticipant!,

            if (pMicMute)
              Positioned(
                bottom: AppSpace.space1,
                left: AppSpace.space1,
                child: FadeIn(
                  child: Container(
                    decoration: BoxDecoration(
                      // TODO: fix color
                      color: Colors.black.withValues(
                        alpha: 0.6,
                      ),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(
                      AppSpace.space2,
                    ),
                    child: Assets.vectors.callMuteMicIcon.svg(
                      width: AppSize.size6,
                      height: AppSize.size6,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
