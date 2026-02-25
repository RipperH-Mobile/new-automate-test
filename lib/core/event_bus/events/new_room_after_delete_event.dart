class NewRoomAfterDeleteEvent {
  final String roomId;

  NewRoomAfterDeleteEvent({required this.roomId});

  @override
  String toString() => 'NewRoomAfterDeleteEvent(roomId: $roomId)';
}
