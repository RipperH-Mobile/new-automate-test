import 'package:uchat/entities/enum/message_file_type.dart';

enum RoomFileType {
  image,
  video,
  file;

  String get value {
    switch (this) {
      case RoomFileType.image:
        return 'IMAGE';
      case RoomFileType.video:
        return 'VIDEO';
      case RoomFileType.file:
        return 'FILE';
    }
  }

  static from(String val) {
    switch (val) {
      case 'IMAGE':
        return RoomFileType.image;
      case 'VIDEO':
        return RoomFileType.video;
      case 'FILE':
        return RoomFileType.file;
    }
  }

  static toMessageFileType(RoomFileType roomFileType) {
    switch (roomFileType) {
      case RoomFileType.image:
        return MessageFileType.image;
      case RoomFileType.video:
        return MessageFileType.video;
      case RoomFileType.file:
        return MessageFileType.file;
    }
  }
}
