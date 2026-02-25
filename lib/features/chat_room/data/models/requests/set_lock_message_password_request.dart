class SetLockMessagePasswordRequest {
  String roomId;
  String password;

  SetLockMessagePasswordRequest({
    required this.roomId,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'password': password,
    };
  }
}
