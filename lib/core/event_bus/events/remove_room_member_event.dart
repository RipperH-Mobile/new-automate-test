class RemoveRoomMemberEvent {
  List<String> memberIds; // Will contain removed member only.
  String roomId;
  bool isAccountDeleted;

  RemoveRoomMemberEvent({
    required this.roomId,
    required this.memberIds,
    this.isAccountDeleted = false,
  });

  @override
  String toString() =>
      'RemoveRoomMemberEvent(roomId: $roomId, memberCount: ${memberIds.length}, isAccountDeleted: $isAccountDeleted)';
}
