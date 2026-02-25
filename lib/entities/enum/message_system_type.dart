enum MessageSystemType {
  createGroup,
  inviteToGroup,
  removeFromGroup,
  leaveGroup,
  leaveDirectChat,
  callStart,
  callEnd,
  callDecline,
  changeGroupName,
  changeGroupPhoto,
  joinToGroup,
  changeAlbumName,
  removeAlbum,
  removeImageAlbum,
  createdSecretRoom,
  createdAlbum,
  destroyedSecretRoom,
  changedSecretRoomExp,
  capturedScreen,
  unknown,
  pinMessage,
  unPinMessage,
  unPinAllMessage,
  unSentMessage,
  changeOwner;

  String get value {
    switch (this) {
      case MessageSystemType.createGroup:
        return 'CREATED_GROUP';
      case MessageSystemType.inviteToGroup:
        return 'INVITE_TO_GROUP';
      case MessageSystemType.removeFromGroup:
        return 'REMOVE_FROM_GROUP';
      case MessageSystemType.leaveGroup:
        return 'LEAVE_GROUP';
      case MessageSystemType.leaveDirectChat:
        return 'LEAVE_DIRECT_CHAT';
      case MessageSystemType.callStart:
        return 'CALL_ROOM_START';
      case MessageSystemType.callEnd:
        return 'CALL_ROOM_END';
      case MessageSystemType.callDecline:
        return 'CALL_ROOM_DECLINE';
      case MessageSystemType.changeGroupName:
        return 'CHANGE_GROUP_NAME';
      case MessageSystemType.changeGroupPhoto:
        return 'CHANGE_GROUP_PHOTO';
      case MessageSystemType.joinToGroup:
        return 'JOIN_TO_GROUP';
      case MessageSystemType.changeAlbumName:
        return 'CHANGE_ALBUM_NAME';
      case MessageSystemType.removeAlbum:
        return 'REMOVE_ALBUM';
      case MessageSystemType.removeImageAlbum:
        return 'REMOVE_IMAGE_ALBUM';
      case MessageSystemType.createdSecretRoom:
        return 'CREATED_SECRET_ROOM';
      case MessageSystemType.createdAlbum:
        return 'CREATED_ALBUM';
      case MessageSystemType.destroyedSecretRoom:
        return 'DESTROYED_SECRET_ROOM';
      case MessageSystemType.changedSecretRoomExp:
        return 'CHANGED_SECRET_ROOM_EXP';
      case MessageSystemType.capturedScreen:
        return 'CAPTURED_SCREEN';
      case MessageSystemType.pinMessage:
        return 'PIN_MESSAGE';
      case MessageSystemType.unPinMessage:
        return 'UNPIN_MESSAGE';
      case MessageSystemType.unPinAllMessage:
        return 'UNPIN_ALL_MESSAGE';
      case MessageSystemType.unSentMessage:
        return 'UNSENT_MESSAGE';
      case MessageSystemType.changeOwner:
        return 'CHANGE_OWNER';
      default:
        return 'UNKNOWN';
    }
  }

  static MessageSystemType? from(String val) {
    switch (val) {
      case 'CREATED_GROUP':
        return MessageSystemType.createGroup;
      case 'INVITE_TO_GROUP':
        return MessageSystemType.inviteToGroup;
      case 'REMOVE_FROM_GROUP':
        return MessageSystemType.removeFromGroup;
      case 'LEAVE_GROUP':
        return MessageSystemType.leaveGroup;
      case 'LEAVE_DIRECT_CHAT':
        return MessageSystemType.leaveDirectChat;
      case 'CALL_ROOM_START':
        return MessageSystemType.callStart;
      case 'CALL_ROOM_END':
        return MessageSystemType.callEnd;
      case 'CALL_ROOM_DECLINE':
        return MessageSystemType.callDecline;
      case 'CHANGE_GROUP_NAME':
        return MessageSystemType.changeGroupName;
      case 'CHANGE_GROUP_PHOTO':
        return MessageSystemType.changeGroupPhoto;
      case 'JOIN_TO_GROUP':
        return MessageSystemType.joinToGroup;
      case 'CHANGE_ALBUM_NAME':
        return MessageSystemType.changeAlbumName;
      case 'REMOVE_ALBUM':
        return MessageSystemType.removeAlbum;
      case 'REMOVE_IMAGE_ALBUM':
        return MessageSystemType.removeImageAlbum;
      case 'CREATED_SECRET_ROOM':
        return MessageSystemType.createdSecretRoom;
      case 'CREATED_ALBUM':
        return MessageSystemType.createdAlbum;
      case 'DESTROYED_SECRET_ROOM':
        return MessageSystemType.destroyedSecretRoom;
      case 'CHANGED_SECRET_ROOM_EXP':
        return MessageSystemType.changedSecretRoomExp;
      case 'CAPTURED_SCREEN':
        return MessageSystemType.capturedScreen;
      case 'PIN_MESSAGE':
        return MessageSystemType.pinMessage;
      case 'UNPIN_MESSAGE':
        return MessageSystemType.unPinMessage;
      case 'UNPIN_ALL_MESSAGE':
        return MessageSystemType.unPinAllMessage;
      case 'UNSENT_MESSAGE':
        return MessageSystemType.unSentMessage;
      case 'CHANGE_OWNER':
        return MessageSystemType.changeOwner;
      default:
        return MessageSystemType.unknown;
    }
  }
}
