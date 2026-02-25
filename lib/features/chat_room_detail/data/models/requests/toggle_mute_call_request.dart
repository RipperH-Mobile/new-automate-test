class ToggleMuteCallRequest {
  final String roomId;
  final bool isMutedCall;

  ToggleMuteCallRequest({
    required this.roomId,
    required this.isMutedCall,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'roomId': roomId, 'isMutedCall': isMutedCall};

    return json;
  }
}
