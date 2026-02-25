class FetchRoomMemberParams {
  final String? roomId;
  final bool useTransaction;
  final bool saveToDb;

  FetchRoomMemberParams({
    required this.roomId,
    this.useTransaction = true,
    this.saveToDb = true,
  });
}
