class RoomDeleteEvent {
  String roomId;
  bool? isDeleteInContact;

  RoomDeleteEvent({required this.roomId, this.isDeleteInContact});

  @override
  String toString() => 'RoomDeleteEvent(roomId: $roomId${isDeleteInContact != null ? ', isDeleteInContact: $isDeleteInContact' : ''})';
}
