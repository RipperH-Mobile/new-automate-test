class UpdateLastTypedAtRequest {
  String roomId;
  bool isTyping;
  String? displayName;

  UpdateLastTypedAtRequest({
    required this.roomId,
    required this.isTyping,
    this.displayName,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'roomId': roomId,
      'isTyping': isTyping,
    };
    if (displayName != null) {
      json['displayName'] = displayName;
    }
    return json;
  }
}
