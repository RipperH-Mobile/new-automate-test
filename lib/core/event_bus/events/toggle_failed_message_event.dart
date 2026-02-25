class ToggleFailedMessageEvent {
  final String roomId;
  final bool show;

  ToggleFailedMessageEvent({
    required this.roomId,
    required this.show,
  });

  @override
  String toString() => 'ToggleFailedMessageEvent(roomId: $roomId, show: $show)';
}
