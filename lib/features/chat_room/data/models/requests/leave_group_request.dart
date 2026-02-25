class LeaveGroupRequest {
  String roomId;

  LeaveGroupRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'roomId': roomId,
    };

    return json;
  }
}
