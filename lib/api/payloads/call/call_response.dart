class LiveKitCallResponseV2 {
  final String? liveKitToken;
  final String? liveKitRoomSID;
  final String? roomCallId;
  final DateTime? startCallAt;
  final String? callType;

  LiveKitCallResponseV2({
    required this.liveKitToken,
    required this.liveKitRoomSID,
    required this.roomCallId,
    this.startCallAt,
    this.callType,
  });

  factory LiveKitCallResponseV2.fromMap(Map<String, dynamic> json) {
    DateTime? tempStartCallAt;
    if (json['startCallAt'] != null) {
      tempStartCallAt = DateTime.tryParse(json['startCallAt'].toString()) ?? DateTime.now();
    }
    return LiveKitCallResponseV2(
      liveKitToken: json['liveKitToken'],
      liveKitRoomSID: json['liveKitRoomSID'],
      roomCallId: json['roomCallId'],
      startCallAt: tempStartCallAt,
      callType: json['callType'] ?? 'VOICE',
    );
  }
}
