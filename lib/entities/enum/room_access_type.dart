import 'package:get/get.dart';

enum RoomAccessType {
  public,
  private;

  String get value {
    switch (this) {
      case RoomAccessType.public:
        return 'PUBLIC';
      case RoomAccessType.private:
        return 'PRIVATE';
    }
  }

  static RoomAccessType from(String val) {
    switch (val) {
      case 'PUBLIC':
        return RoomAccessType.public;
      case 'PRIVATE':
      default:
        return RoomAccessType.private;
    }
  }

  String get displayValue {
    switch (this) {
      case RoomAccessType.public:
        return 'Public'.tr;
      case RoomAccessType.private:
        return 'Private'.tr;
    }
  }

  bool get isPublic => this == RoomAccessType.public;
  bool get isPrivate => this == RoomAccessType.private;
}
