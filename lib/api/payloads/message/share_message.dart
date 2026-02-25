class ShareMessagePayload {
  String roomId;
  String destRoomId;
  String messageId;
  List<String> fileIdList;

  ShareMessagePayload({
    required this.roomId,
    required this.destRoomId,
    required this.messageId,
    required this.fileIdList,
  });

  Map<String, dynamic> toJson() {
    final jsonData = {
      'roomId': roomId,
      'destRoomId': destRoomId,
      'messageId': messageId,
      'fileIdList': fileIdList,
    };

    return jsonData;
  }

  @override
  String toString() {
    return 'roomId: $roomId, destRoomId: $destRoomId, messageId: $messageId, fileIdList: $fileIdList';
  }
}
