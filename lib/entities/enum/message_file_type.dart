import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/file_manager/file_manager.dart';
import 'package:uchat/entities/enum/room_file_type.dart';
import 'package:uchat/features/media_gallery/media_gallery.dart';

enum MessageFileType {
  image('IMAGE'),
  video('VIDEO'),
  gif('GIF'),
  file('FILE'),
  audio('AUDIO'),
  location('LOCATION'),
  groupAvatar('GROUP_AVATAR'),
  videoThumbnail('VIDEO_THUMBNAIL'),
  fileThumbnail('FILE_THUMBNAIL'),
  unknown('UNKNOWN');

  final String value;

  const MessageFileType(this.value);

  factory MessageFileType.fromString(String? value) {
    return values.firstWhere((e) => e.value == value);
  }

  factory MessageFileType.fromMediaGallery(MediaType value) {
    switch (value) {
      case MediaType.image:
        return MessageFileType.image;
      case MediaType.video:
        return MessageFileType.video;
      case MediaType.audio:
        return MessageFileType.audio;
      default:
        return MessageFileType.unknown;
    }
  }

  factory MessageFileType.fromFileExtension(String? value) {
    final extensionFile = value?.split('.').last.trim();
    if (UChatConstant.supportImageExtensionList.contains(extensionFile)) {
      return MessageFileType.image;
    } else if (UChatConstant.supportVideoExtensionList.contains(extensionFile)) {
      return MessageFileType.video;
    } else if (UChatConstant.supportGifExtensionList.contains(extensionFile)) {
      return MessageFileType.gif;
    } else if (UChatConstant.supportAudioExtensionList.contains(extensionFile)) {
      return MessageFileType.audio;
    } else {
      return MessageFileType.file;
    }
  }

  factory MessageFileType.fromFileMime(String mime) {
    if (mime.isNotEmpty) {
      if (isImageTypeSupported(mime)) {
        return MessageFileType.image;
      }

      if (isVideoTypeSupported(mime)) {
        return MessageFileType.video;
      }

      if (mime.contains(RegExp(r'audio/'))) {
        return MessageFileType.audio;
      }
    }

    return MessageFileType.file;
  }

  RoomFileType get toRoomFileType {
    switch (this) {
      case MessageFileType.image:
        return RoomFileType.image;
      case MessageFileType.video:
        return RoomFileType.video;
      case MessageFileType.file:
        return RoomFileType.file;
      default:
        return RoomFileType.file;
    }
  }
}
