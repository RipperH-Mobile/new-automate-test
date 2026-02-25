enum MethodName {
  putUser,
  putRoom,
  putMessage,
  putContact,
  putAlbum,
  deleteMessageByRoom,
  deleteRoom,
  deleteGroup,
  deleteAlbum,
  none, // used to add event without changing local db
}

enum EventType {
  albumCreate,
  albumUpdate,
  callEnd,
  contactUpdate,
  messageNew,
  messageUpdate,
  roomNew,
  roomUpdate,
  roomUpdateMember,
  roomUpdateSubscription,
  roomDelete,
  userUpdate,
  none,
}

class SyncUpdateModel {
  MethodName methodName;
  EventType eventType;
  dynamic data;

  SyncUpdateModel({
    required this.methodName,
    required this.eventType,
    required this.data,
  });
}
