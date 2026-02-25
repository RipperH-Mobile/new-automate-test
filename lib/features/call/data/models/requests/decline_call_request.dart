class DeclineCallRequest {
  final String roomCallId;
  final String liveKitRoomSID;
  final bool isCancel;

  DeclineCallRequest({
    required this.roomCallId,
    required this.liveKitRoomSID,
    this.isCancel = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomCallId': roomCallId,
      'liveKitRoom': liveKitRoomSID,
      if (isCancel == true) 'isCancel': true,
    };
  }
}
