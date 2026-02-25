/// Request class for watching pin messages changes in a room locally
class WatchPinMessagesInRoomLocalRequest {
  const WatchPinMessagesInRoomLocalRequest({
    required this.roomId,
    this.pageSize,
  });

  /// The room ID to watch pin messages from
  final String roomId;

  /// Optional page size limit for the stream
  final int? pageSize;
}
