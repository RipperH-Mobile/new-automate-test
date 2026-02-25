class TogglePinRoomParams {
  final String roomId;
  final bool isPinned;
  final bool isSecretRoom;

  TogglePinRoomParams({
    required this.roomId,
    required this.isPinned,
    this.isSecretRoom = false,
  });
}