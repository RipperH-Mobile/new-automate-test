class OnRoomSelectedEvent {
  final String roomId;
  const OnRoomSelectedEvent({required this.roomId});

  @override
  String toString() => 'OnRoomSelectedEvent(roomId: $roomId)';
}
