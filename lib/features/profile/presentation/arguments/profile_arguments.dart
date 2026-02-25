class ProfileArgumentsV2 {
  final String roomId;
  final bool fromGroup;

  ProfileArgumentsV2({
    required this.roomId,
    this.fromGroup = false,
  }) : assert(roomId.isNotEmpty || fromGroup == false, 'RoomId cannot be null if fromGroup is true');
}
