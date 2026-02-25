import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/entities/enum/contact_type.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/date.dart';

mixin ContactMixin implements ContactInterface {
  @override
  bool get isOfficial {
    return type == ContactType.official.value;
  }

  @override
  bool get isBlocked {
    return blocked == true;
  }

  @override
  bool get isHidden {
    return hidden == true;
  }

  @override
  bool get isFriend {
    return originalIsFriend ?? false;
  }

  @override
  set isFriend(bool? isFriend) {
    originalIsFriend = isFriend;
  }

  @override
  bool get isDeleted {
    return originalIsDeleted ?? false;
  }

  @override
  set isDeleted(bool? isDeleted) {
    originalIsDeleted = isDeleted;
  }

  bool get canShowInFriendSearch {
    return canShowInFriendList;
  }

  bool get canShowInOfficialAccountSearch {
    return canShowInOfficialAccountList;
  }

  bool get canShowInFriendList {
    return !isDeleted && !isBlocked && !isHidden && !isOfficial && isFriend == true;
  }

  bool get canShowInOfficialAccountList {
    return !isDeleted && !isBlocked && !isHidden && isOfficial && isFriend == true;
  }

  bool get canChatWith {
    return canShowInFriendList;
  }

  bool get canShowInShareContact {
    return !isDeleted && !isBlocked && !isHidden && isFriend;
  }

  @override
  bool get hasOfficialMenu {
    return menu?.container != null && menu?.commands != null;
  }

  @override
  String? get name {
    if (nickname != null && nickname != '') {
      return nickname;
    }

    return displayName;
  }

  @override
  String? get shortName {
    if (nickname != null && nickname != '') {
      return shortNickname;
    }

    if (shortDisplayName.isNotEmpty) {
      return shortDisplayName;
    }
    return null;
  }

  @override
  String? get backgroundUrl {
    if (backgroundId != null) {
      return FileService().getProfileBackgroundUrl(backgroundId!);
    }
    return null;
  }

  bool get exist {
    return id != null;
  }

  String? get joinInMessage {
    if (createdAt != null) {
      return 'Joined in @joinIn'.trParams({
        'joinIn': createdAt!.toLocal().format('MM/yyyy'),
      });
    }
    return null;
  }

  void update(ContactInterface contact, {bool forceUpdateStatus = false}) {
    if (contact.displayName != null) {
      displayName = contact.displayName;
    }

    if (contact.username != null) {
      username = contact.username;
    }

    if (contact.avatarId != null) {
      avatarId = contact.avatarId;
    }

    if (contact.blocked != null) {
      blocked = contact.blocked;
    }

    if (contact.createdAt != null) {
      createdAt = contact.createdAt;
    }

    if (contact.updatedAt != null) {
      updatedAt = contact.updatedAt;
    }

    if (contact.phoneNumber != null) {
      phoneNumber = contact.phoneNumber;
    }

    if (contact.type != null) {
      type = contact.type;
    }

    if (contact.nickname != null) {
      if (contact.nickname!.isEmpty) {
        nickname = '';
      } else {
        nickname = contact.nickname;
      }
    }

    if (contact.backgroundId != null) {
      backgroundId = contact.backgroundId;
    }

    if (contact.backgroundBlurhash != null) {
      backgroundBlurhash = contact.backgroundBlurhash;
    }

    if (contact.hidden != null) {
      hidden = contact.hidden;
    }

    if (contact.menu != null) {
      menu = contact.menu;
    }

    if (contact.lastSeenAt != null) {
      lastSeenAt = contact.lastSeenAt;
    }

    if (contact.lastTypedAt != null) {
      lastTypedAt = contact.lastTypedAt;
    }

    if (contact.isTyping != null) {
      isTyping = contact.isTyping;
      if (contact.isTyping == false) {
        lastTypedAt = null;
      }
    }

    if (contact.friendCanSeeMyLastSeen != null) {
      friendCanSeeMyLastSeen = contact.friendCanSeeMyLastSeen;
    }

    if (contact.originalIsFriend != null) {
      originalIsFriend = contact.originalIsFriend;
    }

    if (contact.originalStatusMessage != null || forceUpdateStatus) {
      statusMessage = contact.statusMessage;
    }

    if (contact.onlineStatus != null) {
      onlineStatus = contact.onlineStatus;
    }

    if (contact.originalIsDeleted != null) {
      originalIsDeleted = contact.originalIsDeleted;
    }
    if (contact.vibraniumShield != null) {
      vibraniumShield = contact.vibraniumShield;
    }
    if (contact.hiddenAt != null) {
      hiddenAt = contact.hiddenAt;
    }
    if (contact.blockedAt != null) {
      blockedAt = contact.blockedAt;
    }
  }

  bool get isMe {
    return id == UserController.instance.currentUser()?.id;
  }

  @override
  String get shortDisplayName {
    if (displayName == null) return '';

    final characters = displayName!.characters;
    if (characters.length > 15) {
      final short = displayName?.characters.take(10);

      return '$short...';
    } else {
      return displayName!;
    }
  }

  @override
  String get shortNickname {
    if (nickname == null || nickname == '') return '';

    final characters = nickname!.characters;
    if (characters.length > 15) {
      final short = nickname?.characters.take(10);

      return '$short...';
    } else {
      return nickname!;
    }
  }
}
