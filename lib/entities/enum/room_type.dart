enum RoomType {
  direct,
  group,
  directSecret,
  bookmark,
  system;

  String get value {
    switch (this) {
      case RoomType.direct:
        return 'DIRECT';
      case RoomType.group:
        return 'GROUP';
      case RoomType.directSecret:
        return 'DIRECT_SECRET';
      case RoomType.bookmark:
        return 'BOOKMARK';
      case RoomType.system:
        return 'SYSTEM';
    }
  }

  static RoomType? from(String? val) {
    switch (val) {
      case 'DIRECT':
        return RoomType.direct;
      case 'GROUP':
        return RoomType.group;
      case 'DIRECT_SECRET':
        return RoomType.directSecret;
      case 'BOOKMARK':
        return RoomType.bookmark;
      case 'SYSTEM':
        return RoomType.system;
      default:
        return null;
    }
  }
}
