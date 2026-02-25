enum ChatRoomCustomInputType {
  sticker,
  gif,
  closed,
  imageAndVideo;

  String get value {
    switch (this) {
      case ChatRoomCustomInputType.sticker:
        return 'STICKER';
      case ChatRoomCustomInputType.gif:
        return 'GIF';
      case ChatRoomCustomInputType.closed:
        return 'CLOSED';
      case ChatRoomCustomInputType.imageAndVideo:
        return 'IMAGE_AND_VIDEO';
    }
  }

  static ChatRoomCustomInputType from(String val) {
    switch (val) {
      case 'STICKER':
        return ChatRoomCustomInputType.sticker;
      case 'GIF':
        return ChatRoomCustomInputType.gif;
      case 'IMAGE_AND_VIDEO':
        return ChatRoomCustomInputType.imageAndVideo;
      case 'CLOSED':
      default:
        return ChatRoomCustomInputType.closed;
    }
  }
}
