class GroupCallJoinResponse {
  final String? liveKitToken;
  final DateTime? startCallAt;
  final String? callType; // TODO: fix to enum
  final String? roomCallId;

  GroupCallJoinResponse({
    required this.liveKitToken,
    required this.startCallAt,
    required this.callType,
    required this.roomCallId,
  });

  factory GroupCallJoinResponse.fromMap(Map<String, dynamic> json) {
    return GroupCallJoinResponse(
      liveKitToken: json['liveKitToken'],
      roomCallId: json['roomCallId'],
      startCallAt: DateTime.tryParse(json['startCallAt'].toString()) ?? DateTime.now(),
      callType: json['callType'] ?? 'VOICE',
    );
  }
}
