class ChatRoomDetailOwnerTransferArgument {
  final String roomId;
  final String roomName;
  final bool isShowLeaveGroup;

  ChatRoomDetailOwnerTransferArgument({
    required this.roomId,
    required this.roomName,
    this.isShowLeaveGroup = false,
  });
}
