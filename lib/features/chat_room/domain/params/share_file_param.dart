class ShareFileParam {
  String originRoomId;
  String destinationRoomId;
  String messageId;
  List<String> fileIdList;

  ShareFileParam({
    required this.originRoomId,
    required this.destinationRoomId,
    required this.messageId,
    required this.fileIdList,
  });
}
