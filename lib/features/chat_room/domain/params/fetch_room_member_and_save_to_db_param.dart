class FetchRoomMemberAndSaveToDbParam {
  String roomId;
  bool useTransaction;

  FetchRoomMemberAndSaveToDbParam({
    required this.roomId,
    this.useTransaction = true,
  });
}