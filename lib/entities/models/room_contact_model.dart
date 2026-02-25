import 'package:get/get.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/room_interface.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class RoomContactModel<T> {
  final RoomContactType type;
  T data;
  final bool isMe;

  RoomContactModel({
    required this.type,
    required this.data,
    this.isMe = false,
  });

  String? get id {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      return contact.id;
    } else if (data is RoomInterface) {
      final room = data as RoomInterface;
      return room.id;
    }

    return null;
  }

  String? get name {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      if (contact.isDeleted == true) {
        return 'Deleted User'.tr;
      }
      return contact.name;
    } else if (data is RoomInterface) {
      final room = data as RoomInterface;
      return room.roomName;
    }
    return null;
  }

  String? get avatarUrl {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      return contact.avatarUrl;
    } else if (data is RoomInterface) {
      final room = data as RoomInterface;
      return room.roomAvatarUrl;
    }
    return null;
  }

  String? get backgroundUrl {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      return contact.backgroundUrl;
    }
    return null;
  }

  String? get blurHash {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      return contact.backgroundBlurhash;
    }
    return null;
  }

  bool get hasAvatar {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      return contact.hasAvatar;
    } else if (data is RoomInterface) {
      final room = data as RoomInterface;
      return room.hasAvatar;
    }

    return false;
  }

  bool get isOfficial {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      return contact.isOfficial;
    }

    return false;
  }

  bool get isPrivateGroup {
    if (data is RoomInterface) {
      final room = data as RoomInterface;
      return room.accessType == RoomAccessType.private;
    }

    return false;
  }

  bool get isGroup {
    return type == RoomContactType.room && roomType == RoomType.group;
  }

  bool get isContact {
    return type == RoomContactType.contact;
  }

  bool get isContactButNotMe {
    return !isMe && type == RoomContactType.contact;
  }

  bool get canEditName {
    if (!isContactButNotMe) {
      return false;
    }

    if (data is ContactInterface) {
      final contact = data as ContactInterface;

      return contact.isFriend && !contact.isOfficial;
    }

    return false;
  }

  bool get canShowChatButton {
    if (type == RoomContactType.contact) {
      _log.d('canShowChatButton: $type');
      return contact?.isFriend ?? false;
    }

    final room = (data as RoomInterface);
    if (room.isDirect) {
      return true;
    }

    return room.isJoined == true && !(room.isRequesting ?? false);
  }

  bool get canShowJoinButton {
    if (type == RoomContactType.contact) {
      return false;
    }

    final room = (data as RoomInterface);
    if (room.isDirect) {
      return false;
    }

    return room.isJoined == false && !(room.isRequesting ?? false);
  }

  bool get canShowWaitingForApprove {
    return room?.isRequesting ?? false;
  }

  String? get statusMessage {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;

      if (contact.statusMessage == '') {
        return null;
      }

      return contact.statusMessage;
    }

    if (isMe) {
      return 'Enter status message...'.tr;
    }
    return null;
  }

  bool get hasStatusMessage {
    return statusMessage != null && statusMessage != '';
  }

  RoomType? get roomType {
    if (data is RoomInterface) {
      final room = data as RoomInterface;

      return room.roomType;
    }
    return null;
  }

  ContactInterface? get contact {
    if (data is ContactInterface) {
      return data as ContactInterface;
    }
    return null;
  }

  RoomInterface? get room {
    if (data is RoomInterface) {
      return data as RoomInterface;
    }
    return null;
  }

  bool get isDeleted {
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      return contact.isDeleted == true;
    }
    return false;
  }

  void updateRoom(RoomInterface room) {
    try {
      if (data != null) {
        (data as RoomInterface).update(room);
      } else {
        data = room as T;
      }
    } catch (e, stacktrace) {
      _log.e('RoomContactModel updateRoom error', e, stacktrace);
    }
  }

  void updateContact(ContactInterface contact) {
    data = contact as T;
  }

  @override
  String toString() {
    return '[Instance:RoomContactModel] id: "$id" type: "$type", data: "$data", isMe: "$isMe", canShowJoinButton: "$canShowJoinButton"';
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(covariant RoomContactModel<T> other) {
    return id == other.id;
  }
}
