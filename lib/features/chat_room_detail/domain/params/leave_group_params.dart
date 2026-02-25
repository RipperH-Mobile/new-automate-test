class LeaveGroupParams {
  final String roomId;
  final void Function(String roomId)? onRoomDeleted;
  final bool isOnlyLocal;

  LeaveGroupParams({
    required this.roomId,
    this.onRoomDeleted,
    this.isOnlyLocal = false,
  });
}
