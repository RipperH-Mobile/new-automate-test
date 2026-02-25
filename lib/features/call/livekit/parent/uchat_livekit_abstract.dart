import 'dart:async';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';

abstract class UChatLiveKitAbstract {
  /// Check if the controller is not existing
  ///
  /// [RETURN] Get.isRegistered<[CHILD_CONTROLLER]>(tag: callData.roomId) != true
  /// [CHILD_CONTROLLER] is the child class of [UChatLiveKitController]
  ///
  /// `UChatLiveKitController` is `AcceptIncomingCallCtl`, `StartDirectCallCtl`, `StartGroupCallCtl`, `JoinGroupCallCtl`
  ///
  ///! Override this method in child class
  bool get isNotExisting => false;

  Future<void> initialStartingUp() async {}

  void roomDataListener(RoomCallModel? data) {}

  void startCallTimer() {}

  /// [disconnect] Using need to explicitly class type.
  ///
  /// [OVERRIDE] super.disconnect<[CHILD_CONTROLLER]>()
  /// [CHILD_CONTROLLER] is the child class of [UChatLiveKitController]
  ///
  /// `UChatLiveKitController` is `AcceptIncomingCallCtl`, `StartDirectCallCtl`, `StartGroupCallCtl`, `JoinGroupCallCtl`
  ///
  ///! Override this method in child class
  Future<void> disconnect<C extends UChatLiveKitController>(String reason) async {}

  /// [connect] Using need to explicitly class type.
  ///
  /// [OVERRIDE] super.connect<[CHILD_CONTROLLER]>()
  /// [CHILD_CONTROLLER] is the child class of [UChatLiveKitController]
  ///
  /// `UChatLiveKitController` is `AcceptIncomingCallCtl`, `StartDirectCallCtl`, `StartGroupCallCtl`, `JoinGroupCallCtl`
  ///
  ///! Override this method in child class
  Future<void> connect<C extends UChatLiveKitController>() async {}

  void setUpStartCallListeners() {}

  void sortParticipants({dynamic event}) async {}

  void onParticipantConnectionQualityUpdatedEvent(ParticipantConnectionQualityUpdatedEvent event) {}

  void onRoomAttemptReconnectEvent(RoomAttemptReconnectEvent event) {}

  void onTrackUnmutedEvent(TrackUnmutedEvent event) {}

  void onTrackMutedEvent(TrackMutedEvent event) {}

  void onTrackSubscribedEvent(TrackSubscribedEvent event) {}

  void onActiveSpeakersChangedEvent(ActiveSpeakersChangedEvent event) {}

  void onRoomDisconnectedEvent(RoomDisconnectedEvent event) {}

  void onLocalTrackPublishedEvent(LocalTrackPublishedEvent event) {}

  void onLocalTrackUnpublishedEvent(LocalTrackUnpublishedEvent event) {}

  void onParticipantConnectedEvent(ParticipantConnectedEvent event) {}

  void onDataReceivedEvent(DataReceivedEvent event) {}

  void onParticipantDisconnectedEvent(ParticipantDisconnectedEvent event) {}

  void onRoomDidUpdate() async {}
}
