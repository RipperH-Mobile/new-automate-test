class ResetReadCountLocalEvent {
  final String roomId;
  const ResetReadCountLocalEvent({required this.roomId});

  @override
  String toString() => 'ResetReadCountLocalEvent(roomId: $roomId)';
}
