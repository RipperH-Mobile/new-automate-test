enum MessageType {
  text,
  sticker,
  stickerGift,
  stickerSharing,
  file,
  image,
  audio,
  video,
  gif,
  system,
  @Deprecated('Currently unsent message will be updated to type system with MessageSystemType.unSentMessage')

  /// Old unsent message will be this type but newer unsent message will be system type.
  unsent,
  remove,
  removeOthers,
  edit,
  album,
  location,
  callMsg,
  contact,
  mobileContact;

  String get value {
    switch (this) {
      case MessageType.text:
        return 'TEXT';
      case MessageType.sticker:
        return 'STICKER';
      case MessageType.stickerGift:
        return 'STICKER_GIFT';
      case MessageType.stickerSharing:
        return 'SHARE_STICKER';
      case MessageType.file:
        return 'FILE';
      case MessageType.image:
        return 'IMAGE';
      case MessageType.audio:
        return 'AUDIO';
      case MessageType.video:
        return 'VIDEO';
      case MessageType.gif:
        return 'GIF';
      case MessageType.system:
        return 'SYSTEM_MESSAGE';
      case MessageType.unsent:
        return 'UNSENT';
      case MessageType.remove:
        return 'REMOVE';
      case MessageType.removeOthers:
        return 'REMOVE_OTHERS';
      case MessageType.edit:
        return 'EDIT';
      case MessageType.album:
        return 'ALBUM';
      case MessageType.location:
        return 'LOCATION';
      case MessageType.callMsg:
        return 'CALL_MESSAGE';
      case MessageType.contact:
        return 'CONTACT';
      case MessageType.mobileContact:
        return 'MOBILE_CONTACT';
    }
  }

  static from(String val) {
    switch (val) {
      case 'TEXT':
        return MessageType.text;
      case 'STICKER':
        return MessageType.sticker;
      case 'STICKER_GIFT':
        return MessageType.stickerGift;
      case 'SHARE_STICKER':
        return MessageType.stickerSharing;
      case 'FILE':
        return MessageType.file;
      case 'IMAGE':
        return MessageType.image;
      case 'AUDIO':
        return MessageType.audio;
      case 'VIDEO':
        return MessageType.video;
      case 'GIF':
        return MessageType.gif;
      case 'SYSTEM_MESSAGE':
        return MessageType.system;
      case 'UNSENT':
        return MessageType.unsent;
      case 'REMOVE':
        return MessageType.remove;
      case 'REMOVE_OTHERS':
        return MessageType.removeOthers;
      case 'EDIT':
        return MessageType.edit;
      case 'ALBUM':
        return MessageType.album;
      case 'LOCATION':
        return MessageType.location;
      case 'CALL_MESSAGE':
        return MessageType.callMsg;
      case 'CONTACT':
        return MessageType.contact;
      case 'MOBILE_CONTACT':
        return MessageType.mobileContact;
    }
  }
}
