enum RoomContactType {
  contact,
  official,
  room;

  String get value {
    switch (this) {
      case RoomContactType.contact:
        return 'CONTACT';
      case RoomContactType.room:
        return 'ROOM';
      case RoomContactType.official:
        return 'OFFICIAL';
    }
  }

  static RoomContactType? from(String val) {
    switch (val) {
      case 'CONTACT':
        return RoomContactType.contact;
      case 'ROOM':
        return RoomContactType.room;
      case 'OFFICIAL':
        return RoomContactType.official;
    }

    return null;
  }
}
