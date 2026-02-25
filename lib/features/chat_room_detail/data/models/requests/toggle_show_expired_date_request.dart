class ToggleShowExpiredDateRequest {
  final String roomId;
  final bool isShowExpireTime;

  ToggleShowExpiredDateRequest({
    required this.roomId,
    required this.isShowExpireTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'isShowExpireTime': isShowExpireTime,
    };
  }
}
