// import 'package:animate_do/animate_do.dart';
// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:get/get.dart';
// import 'package:livekit_client/livekit_client.dart';
// import 'package:uchat/core/theme/app_radius.dart';
// import 'package:uchat/core/theme/app_space.dart';
// import 'package:uchat/features/call/views/widgets/component/call_user_profile.dart';
// import 'package:uchat/features/call/views/widgets/component/call_mute_mic_badge.dart';
// import 'package:uchat/features/call/views/widgets/component/mute_mic_with_icon_widget.dart';
// import 'package:uchat/features/call/views/widgets/component/network_unstable_red_dino_widget.dart';
// // import 'package:uchat/features/call/views/widgets/component/network_unstable_yellow_widget.dart';
// import 'package:uchat/features/call/utils/constant.dart';
// import 'package:uchat/features/call/utils/enum.dart';
// import 'package:uchat/entities/models/room_call_model.dart';
// import 'package:uchat/features/call/views/widgets/element/call_status.dart';
// import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
// import 'package:uchat/widgets/call/participant_info.dart';

// final _log = useLogger();

// abstract class ParticipantDirectWidget extends StatefulWidget {
//   // Convenience method to return relevant widget for participant
//   static ParticipantDirectWidget widgetFor(
//     ParticipantTrackV2 participantTrack,
//     RoomCallModel callData, {
//     bool showStatsLayer = false,
//     bool isFullScreen = false,
//     bool hideParticipantInfo = false,
//     UiCallState uiState = UiCallState.voice,
//     CallStatusWidget? callStatus,
//   }) {
//     if (participantTrack.participant is LocalParticipant) {
//       return LocalParticipantWidget(
//         participantTrack.participant as LocalParticipant,
//         participantTrack.type,
//         showStatsLayer,
//         callData,
//         uiState,
//         isFullScreen,
//         hideParticipantInfo,
//         callStatus,
//       );
//     } else if (participantTrack.participant is RemoteParticipant) {
//       return RemoteParticipantWidget(
//         participantTrack.participant as RemoteParticipant,
//         participantTrack.type,
//         showStatsLayer,
//         callData,
//         uiState,
//         isFullScreen,
//         hideParticipantInfo,
//         callStatus,
//       );
//     }
//     throw UnimplementedError('Unknown participant type');
//   }

//   // Must be implemented by child class
//   abstract final Participant participant;
//   abstract final RoomCallModel callData;
//   abstract final ParticipantTrackType type;
//   abstract final bool showStatsLayer;
//   abstract final UiCallState uiState;
//   abstract final bool isFullScreen;
//   abstract final bool hideParticipantInfo;
//   abstract final CallStatusWidget? callStatus;

//   final VideoQuality quality;

//   const ParticipantDirectWidget({
//     this.quality = VideoQuality.MEDIUM,
//     super.key,
//   });
// }

// class LocalParticipantWidget extends ParticipantDirectWidget {
//   @override
//   final LocalParticipant participant;
//   @override
//   final ParticipantTrackType type;
//   @override
//   final bool showStatsLayer;
//   @override
//   final bool isFullScreen;
//   @override
//   final bool hideParticipantInfo;
//   @override
//   final RoomCallModel callData;

//   @override
//   final UiCallState uiState;
//   @override
//   final CallStatusWidget? callStatus;

//   const LocalParticipantWidget(
//     this.participant,
//     this.type,
//     this.showStatsLayer,
//     this.callData,
//     this.uiState,
//     this.isFullScreen,
//     this.hideParticipantInfo,
//     this.callStatus, {
//     super.key,
//   });

//   @override
//   State<StatefulWidget> createState() => _LocalParticipantWidgetState();
// }

// class RemoteParticipantWidget extends ParticipantDirectWidget {
//   @override
//   final RemoteParticipant participant;
//   @override
//   final ParticipantTrackType type;
//   @override
//   final bool showStatsLayer;
//   @override
//   final bool isFullScreen;
//   @override
//   final bool hideParticipantInfo;
//   @override
//   final RoomCallModel callData;

//   @override
//   final UiCallState uiState;
//   @override
//   final CallStatusWidget? callStatus;

//   const RemoteParticipantWidget(
//     this.participant,
//     this.type,
//     this.showStatsLayer,
//     this.callData,
//     this.uiState,
//     this.isFullScreen,
//     this.hideParticipantInfo,
//     this.callStatus, {
//     super.key,
//   });

//   @override
//   State<StatefulWidget> createState() => _RemoteParticipantWidgetState();
// }

// abstract class _ParticipantWidgetState<T extends ParticipantDirectWidget> extends State<T> {
//   // bool _visible = true;

//   VideoTrack? get activeVideoTrack;

//   AudioTrack? get activeAudioTrack;

//   TrackPublication? get videoPublication;

//   TrackPublication? get audioPublication;

//   bool get isScreenShare => widget.type == ParticipantTrackType.kScreenShare;
//   EventsListener<ParticipantEvent>? _listener;

//   @override
//   void initState() {
//     super.initState();
//     _listener = widget.participant.createListener();
//     _listener?.on<TranscriptionEvent>((e) {
//       for (var seg in e.segments) {
//         _log.d('Transcription: ${seg.text} ${seg.isFinal}');
//       }
//     });

//     widget.participant.addListener(_onParticipantChanged);
//     _onParticipantChanged();
//   }

//   @override
//   void dispose() {
//     widget.participant.removeListener(_onParticipantChanged);
//     _listener?.dispose();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant T oldWidget) {
//     oldWidget.participant.removeListener(_onParticipantChanged);
//     widget.participant.addListener(_onParticipantChanged);
//     _onParticipantChanged();
//     super.didUpdateWidget(oldWidget);
//   }

//   // Notify Flutter that UI re-build is required, but we don't set anything here
//   // since the updated values are computed properties.
//   void _onParticipantChanged() => setState(() {});

//   // Widgets to show above the info bar
//   List<Widget> extraWidgets(bool isScreenShare) => [];

//   bool get pNetworkUnstable => widget.participant.connectionQuality != ConnectionQuality.excellent;

//   bool get pMicMute => widget.participant.isMicrophoneEnabled() == false;

//   bool get pVideoActive => activeVideoTrack != null && !activeVideoTrack!.muted;

//   buildInfoVideoWidget() {
//     final isPadding = widget.uiState == UiCallState.video && widget.isFullScreen == false;
//     final padding = isPadding ? 120 : 0;
//     final endCallBtnHeight = UChatCallConstant.videoEndCallBtnSize.height;
//     final bottomPadding = MediaQuery.paddingOf(context).bottom - endCallBtnHeight;
//     return [
//       if (widget.participant is RemoteParticipant)
//         Align(
//           alignment: Alignment.bottomLeft,
//           child: AnimatedPadding(
//             duration: const Duration(milliseconds: 150),
//             padding: EdgeInsets.only(
//               left: 10.0,
//               right: 10.0,
//               bottom: bottomPadding <= 0 ? 20 : bottomPadding,
//             ),
//             child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   if (pMicMute && pNetworkUnstable)
//                     Flexible(
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FadeIn(
//                             delay: const Duration(milliseconds: 800),
//                             child: MuteMicWithIconWidget(
//                               displayName: widget.participant.name,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (pMicMute && !pNetworkUnstable)
//                         Flexible(
//                           child: SizedBox(
//                             width: Get.width - padding,
//                             child: FadeIn(
//                               delay: const Duration(milliseconds: 800),
//                               child: MuteMicWithIconWidget(
//                                 displayName: widget.participant.name,
//                               ),
//                             ),
//                           ),
//                         ),
//                       if ((pMicMute && pNetworkUnstable) || (!pMicMute && pNetworkUnstable))
//                         Flexible(
//                           child: FadeIn(
//                             delay: const Duration(milliseconds: 800),
//                             child: SizedBox(
//                               width: Get.width - padding,
//                               child: CallNetworkUnstableRedDinoWidget(
//                                 displayName: widget.participant.name,
//                               ),
//                             ),
//                           ),
//                         ),
//                       SizedBox(
//                         width: 8,
//                         height: endCallBtnHeight,
//                       ),
//                     ],
//                   ),
//                 ]),
//           ),
//         ),
//     ];
//   }

//   buildNoVideoInfoWidget() {
//     return [
//       if (widget.participant is RemoteParticipant && pMicMute)
//         SafeArea(
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 top: AppSpace.space12,
//               ),
//               child: FadeIn(
//                 child: MuteMicTextWidget(
//                   displayName: widget.participant.name,
//                 ),
//               ),
//             ),
//           ),
//         ),
//     ];
//   }

//   @override
//   Widget build(BuildContext ctx) => IgnorePointer(
//         child: Stack(
//           children: [
//             if (pVideoActive)
//               Container(
//                 color: Colors.black,
//               ),
//             // Video
//             if (pVideoActive)
//               SafeArea(
//                 child: Container(
//                   padding: const EdgeInsets.only(
//                     // top: AppSpace.space1,
//                     bottom: AppSpace.space6,
//                     left: AppSpace.space4,
//                     right: AppSpace.space4,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(
//                       AppRadius.roundedXl,
//                     ),
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(
//                       AppRadius.roundedXl,
//                     ),
//                     child: VideoTrackRenderer(
//                       renderMode: VideoRenderMode.auto,
//                       activeVideoTrack!,
//                       fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//                     ),
//                   ),
//                 ),
//               )
//             else if (widget.participant is RemoteParticipant)
//               CallUserProfileWidget(
//                 speaking: widget.participant.isSpeaking && !isScreenShare,
//                 uiState: UiCallState.voice,
//                 image: widget.callData.imageUrl ?? '',
//                 blurHash: widget.callData.imageBlurHash ?? '',
//                 showBorder: true,
//                 // isMuted: widget.uiState != UiCallState.video ? pMicMute : false,
//               ),
//             // if (widget.participant is RemoteParticipant && widget.hideParticipantInfo == false)
//             //   if (widget.uiState == UiCallState.video) ...buildInfoVideoWidget() else ...buildNoVideoInfoWidget(),
//             if (widget.participant is RemoteParticipant && pMicMute || widget.callStatus != null)
//               SafeArea(
//                 child: Align(
//                   alignment: Alignment.topCenter,
//                   child: Column(
//                     children: [
//                       if (widget.callStatus != null && !pVideoActive)
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             bottom: AppSpace.space4,
//                           ),
//                           child: widget.callStatus!,
//                         ),
//                       if (pMicMute)
//                         FadeIn(
//                           child: MuteMicTextWidget(
//                             displayName: widget.participant.name,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),

//             if (widget.participant is LocalParticipant &&
//                 widget.callData.callState == CallState.connecting &&
//                 pVideoActive == false)
//               CallUserProfileWidget(
//                 speaking: widget.participant.isSpeaking && !isScreenShare,
//                 uiState: UiCallState.voice,
//                 image: widget.callData.imageUrl ?? '',
//                 blurHash: widget.callData.imageBlurHash ?? '',
//                 showBorder: true,
//                 // isMuted: widget.uiState != UiCallState.video ? pMicMute : false,
//               ),
//           ],
//         ),
//       );
// }

// class _LocalParticipantWidgetState extends _ParticipantWidgetState<LocalParticipantWidget> {
//   @override
//   LocalTrackPublication<LocalVideoTrack>? get videoPublication => widget.participant.videoTrackPublications
//       .where((element) => element.source == widget.type.lkVideoSourceType)
//       .firstOrNull;

//   @override
//   LocalTrackPublication<LocalAudioTrack>? get audioPublication => widget.participant.audioTrackPublications
//       .where((element) => element.source == widget.type.lkAudioSourceType)
//       .firstOrNull;

//   @override
//   VideoTrack? get activeVideoTrack => videoPublication?.track;

//   @override
//   AudioTrack? get activeAudioTrack => audioPublication?.track;
// }

// class _RemoteParticipantWidgetState extends _ParticipantWidgetState<RemoteParticipantWidget> {
//   @override
//   RemoteTrackPublication<RemoteVideoTrack>? get videoPublication => widget.participant.videoTrackPublications
//       .where((element) => element.source == widget.type.lkVideoSourceType)
//       .firstOrNull;

//   @override
//   RemoteTrackPublication<RemoteAudioTrack>? get audioPublication => widget.participant.audioTrackPublications
//       .where((element) => element.source == widget.type.lkAudioSourceType)
//       .firstOrNull;

//   @override
//   VideoTrack? get activeVideoTrack => videoPublication?.track;

//   @override
//   AudioTrack? get activeAudioTrack => audioPublication?.track;

//   @override
//   List<Widget> extraWidgets(bool isScreenShare) => [
//         Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             // Menu for RemoteTrackPublication<RemoteAudioTrack>
//             if (audioPublication != null)
//               RemoteTrackPublicationMenuWidget(
//                 pub: audioPublication!,
//                 icon: Icons.volume_up,
//               ),
//             // Menu for RemoteTrackPublication<RemoteVideoTrack>
//             if (videoPublication != null)
//               RemoteTrackPublicationMenuWidget(
//                 pub: videoPublication!,
//                 icon: isScreenShare ? Icons.monitor : Icons.videocam,
//               ),
//             if (videoPublication != null)
//               RemoteTrackFPSMenuWidget(
//                 pub: videoPublication!,
//                 icon: Icons.menu,
//               ),
//             if (videoPublication != null)
//               RemoteTrackQualityMenuWidget(
//                 pub: videoPublication!,
//                 icon: Icons.monitor_outlined,
//               ),
//           ],
//         ),
//       ];
// }

// class RemoteTrackPublicationMenuWidget extends StatelessWidget {
//   final IconData icon;
//   final RemoteTrackPublication pub;

//   const RemoteTrackPublicationMenuWidget({
//     required this.pub,
//     required this.icon,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) => Material(
//         color: Colors.black.withValues(alpha: 0.3),
//         child: PopupMenuButton<Function>(
//           tooltip: 'Subscribe menu',
//           icon: Icon(icon,
//               color: {
//                 TrackSubscriptionState.notAllowed: Colors.red,
//                 TrackSubscriptionState.unsubscribed: Colors.grey,
//                 TrackSubscriptionState.subscribed: Colors.green,
//               }[pub.subscriptionState]),
//           onSelected: (value) => value(),
//           itemBuilder: (BuildContext context) => <PopupMenuEntry<Function>>[
//             // Subscribe/Unsubscribe
//             if (pub.subscribed == false)
//               PopupMenuItem(
//                 child: const Text('Subscribe'),
//                 value: () => pub.subscribe(),
//               )
//             else if (pub.subscribed == true)
//               PopupMenuItem(
//                 child: const Text('Un-subscribe'),
//                 value: () => pub.unsubscribe(),
//               ),
//           ],
//         ),
//       );
// }

// class RemoteTrackFPSMenuWidget extends StatelessWidget {
//   final IconData icon;
//   final RemoteTrackPublication pub;

//   const RemoteTrackFPSMenuWidget({
//     required this.pub,
//     required this.icon,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) => Material(
//         color: Colors.black.withValues(alpha: 0.3),
//         child: PopupMenuButton<Function>(
//           tooltip: 'Preferred FPS',
//           icon: Icon(icon, color: Colors.white),
//           onSelected: (value) => value(),
//           itemBuilder: (BuildContext context) => <PopupMenuEntry<Function>>[
//             PopupMenuItem(
//               child: const Text('30'),
//               value: () => pub.setVideoFPS(30),
//             ),
//             PopupMenuItem(
//               child: const Text('15'),
//               value: () => pub.setVideoFPS(15),
//             ),
//             PopupMenuItem(
//               child: const Text('8'),
//               value: () => pub.setVideoFPS(8),
//             ),
//           ],
//         ),
//       );
// }

// class RemoteTrackQualityMenuWidget extends StatelessWidget {
//   final IconData icon;
//   final RemoteTrackPublication pub;

//   const RemoteTrackQualityMenuWidget({
//     required this.pub,
//     required this.icon,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) => Material(
//         color: Colors.black.withValues(alpha: 0.3),
//         child: PopupMenuButton<Function>(
//           tooltip: 'Preferred Quality',
//           icon: Icon(icon, color: Colors.white),
//           onSelected: (value) => value(),
//           itemBuilder: (BuildContext context) => <PopupMenuEntry<Function>>[
//             PopupMenuItem(
//               child: const Text('HIGH'),
//               value: () => pub.setVideoQuality(VideoQuality.HIGH),
//             ),
//             PopupMenuItem(
//               child: const Text('MEDIUM'),
//               value: () => pub.setVideoQuality(VideoQuality.MEDIUM),
//             ),
//             PopupMenuItem(
//               child: const Text('LOW'),
//               value: () => pub.setVideoQuality(VideoQuality.LOW),
//             ),
//           ],
//         ),
//       );
// }
