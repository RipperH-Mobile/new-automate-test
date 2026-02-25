import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/presentation/views/widgets/participants/calling_participants_box_widget.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/call/participant_info.dart';

final _log = useLogger();

abstract class ParticipantGroupWidget extends StatefulWidget {
  // Convenience method to return relevant widget for participant
  static ParticipantGroupWidget widgetFor(
    ParticipantTrackV2 participantTrack,
    RoomCallModel callData, {
    bool showStatsLayer = false,
    bool isFullScreen = false,
    bool hideParticipantInfo = false,
    UiCallState uiState = UiCallState.voice,
  }) {
    if (participantTrack.participant is LocalParticipant) {
      return LocalParticipantWidget(
        participantTrack.participant as LocalParticipant,
        participantTrack.type,
        showStatsLayer,
        callData,
        uiState,
        isFullScreen,
        hideParticipantInfo,
      );
    } else if (participantTrack.participant is RemoteParticipant) {
      return RemoteParticipantWidget(
        participantTrack.participant as RemoteParticipant,
        participantTrack.type,
        showStatsLayer,
        callData,
        uiState,
        isFullScreen,
        hideParticipantInfo,
      );
    }
    throw UnimplementedError('Unknown participant type');
  }

  // Must be implemented by child class
  abstract final Participant participant;
  abstract final RoomCallModel callData;
  abstract final ParticipantTrackType type;
  abstract final bool showStatsLayer;
  abstract final UiCallState uiState;
  abstract final bool isFullScreen;
  abstract final bool hideParticipantInfo;

  final VideoQuality quality;

  const ParticipantGroupWidget({
    this.quality = VideoQuality.MEDIUM,
    super.key,
  });
}

class LocalParticipantWidget extends ParticipantGroupWidget {
  @override
  final LocalParticipant participant;
  @override
  final ParticipantTrackType type;
  @override
  final bool showStatsLayer;
  @override
  final bool isFullScreen;
  @override
  final bool hideParticipantInfo;
  @override
  final RoomCallModel callData;

  @override
  final UiCallState uiState;

  const LocalParticipantWidget(
    this.participant,
    this.type,
    this.showStatsLayer,
    this.callData,
    this.uiState,
    this.isFullScreen,
    this.hideParticipantInfo, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LocalParticipantWidgetState();
}

class RemoteParticipantWidget extends ParticipantGroupWidget {
  @override
  final RemoteParticipant participant;
  @override
  final ParticipantTrackType type;
  @override
  final bool showStatsLayer;
  @override
  final bool isFullScreen;
  @override
  final bool hideParticipantInfo;
  @override
  final RoomCallModel callData;

  @override
  final UiCallState uiState;

  const RemoteParticipantWidget(
    this.participant,
    this.type,
    this.showStatsLayer,
    this.callData,
    this.uiState,
    this.isFullScreen,
    this.hideParticipantInfo, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RemoteParticipantWidgetState();
}

abstract class _ParticipantWidgetState<T extends ParticipantGroupWidget> extends State<T> {
  // bool _visible = true;

  VideoTrack? get activeVideoTrack;

  AudioTrack? get activeAudioTrack;

  TrackPublication? get videoPublication;

  TrackPublication? get audioPublication;

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
  void didUpdateWidget(covariant T oldWidget) {
    oldWidget.participant.removeListener(_onParticipantChanged);
    widget.participant.addListener(_onParticipantChanged);
    _onParticipantChanged();
    super.didUpdateWidget(oldWidget);
  }

  // Notify Flutter that UI re-build is required, but we don't set anything here
  // since the updated values are computed properties.
  void _onParticipantChanged() => setState(() {});

  // Widgets to show above the info bar
  List<Widget> extraWidgets(bool isScreenShare) => [];

  bool get pNetworkUnstable => widget.participant.connectionQuality != ConnectionQuality.excellent;

  bool get pMicMute => widget.participant.isMicrophoneEnabled() == false;

  bool get pSpeaking => widget.participant.isSpeaking == true;

  bool get pVideoActive => activeVideoTrack != null && !activeVideoTrack!.muted;

  @override
  Widget build(BuildContext ctx) => CallingParticipantsBoxWidget(
        isScreenShare: isScreenShare,
        videoTrack: activeVideoTrack,
        isSpeaking: pSpeaking,
        isMute: widget.participant.isMicrophoneEnabled() == false,
        isConnectionPoor: pNetworkUnstable,
        callData: widget.callData,
        forceFullScreen: widget.isFullScreen,
        isShowFullNetwork: widget.showStatsLayer,
        name: widget.participant.name,
        hideParticipantInfo: widget.hideParticipantInfo,
        imageUrl: widget.participant.identity,
      );
}

class _LocalParticipantWidgetState extends _ParticipantWidgetState<LocalParticipantWidget> {
  @override
  LocalTrackPublication<LocalVideoTrack>? get videoPublication => widget.participant.videoTrackPublications
      .where((element) => element.source == widget.type.lkVideoSourceType)
      .firstOrNull;

  @override
  LocalTrackPublication<LocalAudioTrack>? get audioPublication => widget.participant.audioTrackPublications
      .where((element) => element.source == widget.type.lkAudioSourceType)
      .firstOrNull;

  @override
  VideoTrack? get activeVideoTrack => videoPublication?.track;

  @override
  AudioTrack? get activeAudioTrack => audioPublication?.track;
}

class _RemoteParticipantWidgetState extends _ParticipantWidgetState<RemoteParticipantWidget> {
  @override
  RemoteTrackPublication<RemoteVideoTrack>? get videoPublication => widget.participant.videoTrackPublications
      .where((element) => element.source == widget.type.lkVideoSourceType)
      .firstOrNull;

  @override
  RemoteTrackPublication<RemoteAudioTrack>? get audioPublication => widget.participant.audioTrackPublications
      .where((element) => element.source == widget.type.lkAudioSourceType)
      .firstOrNull;

  @override
  VideoTrack? get activeVideoTrack => videoPublication?.track;

  @override
  AudioTrack? get activeAudioTrack => audioPublication?.track;

  @override
  List<Widget> extraWidgets(bool isScreenShare) => [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Menu for RemoteTrackPublication<RemoteAudioTrack>
            if (audioPublication != null)
              RemoteTrackPublicationMenuWidget(
                pub: audioPublication!,
                icon: Icons.volume_up,
              ),
            // Menu for RemoteTrackPublication<RemoteVideoTrack>
            if (videoPublication != null)
              RemoteTrackPublicationMenuWidget(
                pub: videoPublication!,
                icon: isScreenShare ? Icons.monitor : Icons.videocam,
              ),
            if (videoPublication != null)
              RemoteTrackFPSMenuWidget(
                pub: videoPublication!,
                icon: Icons.menu,
              ),
            if (videoPublication != null)
              RemoteTrackQualityMenuWidget(
                pub: videoPublication!,
                icon: Icons.monitor_outlined,
              ),
          ],
        ),
      ];
}

class RemoteTrackPublicationMenuWidget extends StatelessWidget {
  final IconData icon;
  final RemoteTrackPublication pub;

  const RemoteTrackPublicationMenuWidget({
    required this.pub,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black.withValues(alpha: 0.3),
        child: PopupMenuButton<Function>(
          tooltip: 'Subscribe menu',
          icon: Icon(icon,
              color: {
                TrackSubscriptionState.notAllowed: Colors.red,
                TrackSubscriptionState.unsubscribed: Colors.grey,
                TrackSubscriptionState.subscribed: Colors.green,
              }[pub.subscriptionState]),
          onSelected: (value) => value(),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Function>>[
            // Subscribe/Unsubscribe
            if (pub.subscribed == false)
              PopupMenuItem(
                child: const Text('Subscribe'),
                value: () => pub.subscribe(),
              )
            else if (pub.subscribed == true)
              PopupMenuItem(
                child: const Text('Un-subscribe'),
                value: () => pub.unsubscribe(),
              ),
          ],
        ),
      );
}

class RemoteTrackFPSMenuWidget extends StatelessWidget {
  final IconData icon;
  final RemoteTrackPublication pub;

  const RemoteTrackFPSMenuWidget({
    required this.pub,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black.withValues(alpha: 0.3),
        child: PopupMenuButton<Function>(
          tooltip: 'Preferred FPS',
          icon: Icon(icon, color: Colors.white),
          onSelected: (value) => value(),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Function>>[
            PopupMenuItem(
              child: const Text('30'),
              value: () => pub.setVideoFPS(30),
            ),
            PopupMenuItem(
              child: const Text('15'),
              value: () => pub.setVideoFPS(15),
            ),
            PopupMenuItem(
              child: const Text('8'),
              value: () => pub.setVideoFPS(8),
            ),
          ],
        ),
      );
}

class RemoteTrackQualityMenuWidget extends StatelessWidget {
  final IconData icon;
  final RemoteTrackPublication pub;

  const RemoteTrackQualityMenuWidget({
    required this.pub,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black.withValues(alpha: 0.3),
        child: PopupMenuButton<Function>(
          tooltip: 'Preferred Quality',
          icon: Icon(icon, color: Colors.white),
          onSelected: (value) => value(),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Function>>[
            PopupMenuItem(
              child: const Text('HIGH'),
              value: () => pub.setVideoQuality(VideoQuality.HIGH),
            ),
            PopupMenuItem(
              child: const Text('MEDIUM'),
              value: () => pub.setVideoQuality(VideoQuality.MEDIUM),
            ),
            PopupMenuItem(
              child: const Text('LOW'),
              value: () => pub.setVideoQuality(VideoQuality.LOW),
            ),
          ],
        ),
      );
}
