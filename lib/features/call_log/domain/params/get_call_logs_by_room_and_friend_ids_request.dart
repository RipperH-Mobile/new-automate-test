class GetCallLogsByRoomAndFriendIdsRequest {
  final List<String> roomIds;
  final List<String> friendIds;
  final int? limit;

  const GetCallLogsByRoomAndFriendIdsRequest({
    required this.roomIds,
    this.friendIds = const [],
    this.limit,
  });
}
