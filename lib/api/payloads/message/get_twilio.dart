class GetTwilioResponse {
  String? twilioToken;
  String? roomId;
  String? roomType;
  String? callType;

  GetTwilioResponse({
    required this.twilioToken,
    required this.roomId,
    required this.roomType,
    required this.callType,
  });

  factory GetTwilioResponse.fromMap(Map<String, dynamic> json) {
    return GetTwilioResponse(
      twilioToken: json['twilioToken'],
      roomId: json['room']['_id'],
      roomType: json['room']['roomType'],
      callType: json['room']['callType'],
    );
  }
}
