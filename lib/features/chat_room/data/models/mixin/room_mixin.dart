import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/room_interface.dart';
import 'package:uchat/features/chat_room/data/models/models/room_meta_model.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

final _log = useLogger();

mixin RoomMixin implements RoomInterface {
  @override
  @ignore
  String? get roomName {
    String? processedRoomName;
    if (originalRoomName == null) {
      // Process room name
      if (roomType == RoomType.direct || roomType == RoomType.directSecret) {
        RoomMemberCollection? friendMember = GetIt.I<RoomMemberDb>().getFirstOtherInRoomSync(id!);

        if (friendMember != null) {
          processedRoomName = friendMember.account?.name ?? friendMember.account?.username;
        } else {
          processedRoomName = 'UNKNOWN'.tr.toUpperCase();
        }
      } else if (roomType == RoomType.group) {
        processedRoomName = 'UNTITLED'.tr;
      }
    }
    return processedRoomName ?? originalRoomName;
  }

  /// Same as [roomName] but async version.
  /// Use this to avoid isar transaction in transaction error.
  Future<String?> getRoomName() async {
    String? processedRoomName;
    if (originalRoomName == null) {
      // Process room name
      if (roomType == RoomType.direct || roomType == RoomType.directSecret) {
        RoomMemberCollection? friendMember = await GetIt.I<RoomMemberDb>().getFirstOtherInRoom(id!);

        if (friendMember != null) {
          processedRoomName = friendMember.account?.name ?? friendMember.account?.username;
        } else {
          processedRoomName = 'UNKNOWN'.tr.toUpperCase();
        }
      } else if (roomType == RoomType.group) {
        processedRoomName = 'UNTITLED'.tr;
      }
    }
    return processedRoomName ?? originalRoomName;
  }

  @override
  @ignore
  String get title {
    // _log.i(roomType);
    switch (roomType) {
      case RoomType.group:
        return roomName ?? '';
      case RoomType.bookmark:
        return 'Bookmark';
      case RoomType.direct:
      case RoomType.system:
      case RoomType.directSecret:
        ContactModel? member = firstOtherInRoom?.account;
        // _log.i(member?.displayName);
        if (member != null) {
          final contactFromDB = GetIt.I<GetContactSyncUseCase>().call(member.id!);

          // _log.i('${contactFromDB?.name} //// ${member.name}');

          if (contactFromDB?.name != null) {
            return contactFromDB!.name!;
          }

          if (member.name != null) {
            return member.name!;
          }
        }

        if (roomName != null && roomName != 'UNKNOWN') {
          return roomName!;
        }

        return 'UNKNOWN'.tr.toUpperCase();
      default:
        return 'UNKNOWN'.tr.toUpperCase();
    }
  }

  @override
  @ignore
  String? get subTitle {
    if (roomType == RoomType.direct || roomType == RoomType.system) {
      ContactModel? contact = firstOtherInRoom?.account;
      if (contact != null) {
        return contact.joinInMessage;
      }
    } else if (roomType == RoomType.group) {
      return '@countMember members'.trParams({
        'countMember': (memberCount ?? 0).toString(),
      });
    }
    return null;
  }

  @ignore
  RoomMemberCollection? get meInRoom {
    if (originalMeInRoom != null) return originalMeInRoom;

    originalMeInRoom ??= GetIt.I<RoomMemberDb>().getMeInRoomSync(id!);

    return originalMeInRoom;
  }

  @ignore
  RoomMemberCollection? get firstOtherInRoom {
    if (originalFirstOtherInRoom != null) {
      return originalFirstOtherInRoom!;
    }

    originalFirstOtherInRoom = GetIt.I<RoomMemberDb>().getFirstOtherInRoomSync(id!);

    return originalFirstOtherInRoom;
  }

  @override
  @ignore
  bool get hasAvatar {
    if (roomType == RoomType.group) {
      return photoId != null && photoId != '';
    }

    return firstOtherInRoom?.account?.hasAvatar == true;
  }

  @override
  String get defaultRoomAvatarUrl {
    return 'https://www.gravatar.com/avatar/$id?s=80&d=identicon&r=g';
  }

  @override
  @ignore
  String get roomAvatarUrl {
    if (isGroup) {
      if (hasPhotoId) {
        /// Special case for mock data from GenerateDataForStressTestUseCase.
        if (id?.contains('mock') == true) {
          return '${AppEnv.apiUrl}assets/$photoId';
        }
        return FileService().getFileUrl(photoId!);
      }

      return defaultRoomAvatarUrl;
    }

    if (firstOtherInRoom?.account?.avatarUrl != null) {
      return firstOtherInRoom!.account!.avatarUrl;
    }

    return defaultRoomAvatarUrl;
  }

  @override
  String get widgetKey {
    return 'ROOM-$id';
  }

  @override
  bool get meIsOwner {
    return ownerId == UserController.instance.currentUser()?.id;
  }

  @override
  bool get isDirect {
    return roomType == RoomType.direct;
  }

  @override
  bool get isGroup {
    return roomType == RoomType.group;
  }

  @override
  bool get isSystem {
    return roomType == RoomType.system;
  }

  @override
  bool get canShowInLatestSearch {
    return latestSearch != null;
  }

  @ignore
  bool get hasFirstOtherInRoom {
    return firstOtherInRoom != null;
  }

  @override
  bool get canLeaveGroup {
    return !meIsOwner;
  }

  @override
  bool get canAddAdmin {
    return meIsOwner;
  }

  @override
  bool get canRemoveAdmin {
    return meIsOwner;
  }

  @override
  bool get canTransferOwner {
    return meIsOwner;
  }

  @override
  bool get hasPhotoId {
    return photoId != null && photoId != '';
  }

  @override
  bool get hasPhotoBlurhash {
    return photoBlurhash != null && photoBlurhash != '';
  }

  @override
  bool get isPrivateGroup {
    return accessType == RoomAccessType.private;
  }

  bool get isSecretRoom {
    // TODO maybe add group secret type here ?
    return roomType == RoomType.directSecret;
  }

  bool get isBookmark {
    return roomType == RoomType.bookmark;
  }

  @override
  void update(
    RoomInterface room, {
    bool ignoreMySubscription = false,
  }) {
    if (room.roomType != null && roomType == null) {
      roomType = room.roomType;
    }

    if (room.originalRoomName != null) {
      originalRoomName = room.originalRoomName;
    }

    if (room.createdAt != null) {
      createdAt = room.createdAt;
    }

    if (room.updatedAt != null) {
      updatedAt = room.updatedAt;
    }

    if (room.draftMessage != null) {
      draftMessage = room.draftMessage;
    }

    if (room.draftReplyMessage != null) {
      draftReplyMessage = room.draftReplyMessage;
    }

    if (room.deleted != null) {
      deleted = room.deleted;
    }

    if (room.hasPhotoId) {
      photoId = room.photoId;
    }

    if (room.hasPhotoBlurhash) {
      photoBlurhash = room.photoBlurhash;
    }

    if (room.ownerId != null) {
      ownerId = room.ownerId;
    }

    if (room.groupRef != null) {
      groupRef = room.groupRef;
    }

    if (room.memberRequestCount != null) {
      memberRequestCount = room.memberRequestCount;
    }

    if (room.accessType != null) {
      accessType = room.accessType;
    }

    if (room.callType != null) {
      callType = room.callType;
    }

    if (room.callStatus != null) {
      callStatus = room.callStatus;
    }

    meta ??= RoomMetaModel();

    if (room.meta?.menu != null) {
      meta!.menu = room.meta!.menu;
    }

    if (room.latestSearch != null) {
      latestSearch = room.latestSearch;
    }

    if (room.isJoined != null) {
      isJoined = room.isJoined;
    }

    if (room.isRequesting != null) {
      isRequesting = room.isRequesting;
    }

    if (room.roomPublicKey != null) {
      roomPublicKey = room.roomPublicKey;
    }

    if (room.roomCryptoKey != null) {
      roomCryptoKey = room.roomCryptoKey;
    }

    if (room.memberCount != null) {
      memberCount = room.memberCount;
    }

    if (room.expireAt != null) {
      expireAt = room.expireAt;
    }

    if (room.expireIn != null) {
      expireIn = room.expireIn;
    }

    if (room.otherPublicKey != null) {
      otherPublicKey = room.otherPublicKey;
    }

    if (room.selfPrivateKey != null) {
      selfPrivateKey = room.selfPrivateKey;
    }

    if (room.hasFailedMessage != null) {
      hasFailedMessage = room.hasFailedMessage;
    }

    // Force recalculate when update
    // originalMeInRoom = null;
    // originalFirstOtherInRoom = null;
    // meInRoom;
    // firstOtherInRoom;
  }

  // @override
  // void sortMembers() {
  //   int memberSorting(RoomMemberModel a, RoomMemberModel b) {
  //     // Sort Owner
  //     if (a.accountId! == ownerId) {
  //       // _log.i('Sorting: A owner...');
  //       return -1;
  //     }
  //
  //     if (b.accountId! == ownerId) {
  //       // _log.i('Sorting: B owner...');
  //       return 1;
  //     }
  //
  //     assert(adminIds != null);
  //     if (adminIds == null) {
  //       _log.e('Expect adminIds is not null, found null.');
  //     }
  //
  //     if (a.accountId == null) {
  //       _log.e('Expect a.accountId is not null, found null.');
  //     }
  //
  //     if (b.accountId == null) {
  //       _log.e('Expect b.accountId is not null, found null.');
  //     }
  //
  //     try {
  //       // Sort Admin
  //       final aIsAdmin = adminIds?.contains(a.accountId!) ?? false;
  //       final bIsAdmin = adminIds?.contains(b.accountId!) ?? false;
  //
  //       if (aIsAdmin && !bIsAdmin) {
  //         return -1;
  //       } else if (!aIsAdmin && bIsAdmin) {
  //         return 1;
  //       } else if (aIsAdmin && bIsAdmin) {
  //         return a.account!.showName.compareTo(b.account!.showName);
  //       }
  //
  //       if (a.account != null && b.account != null) {
  //         return a.account!.showName.compareTo(b.account!.showName);
  //       }
  //     } catch (e, stackTrace) {
  //       _log.e('On sortMembers error.', e, stackTrace);
  //     }
  //
  //     return 0;
  //   }
  //
  //   members.sort(memberSorting);
  // }

  // @override
  // void updateMembers(List<RoomMemberModel> members) {
  //   for (final member in members) {
  //     originalMembers
  //         ?.firstWhereOrNull((element) => element.accountId == member.accountId)
  //         ?.update(member);
  //   }
  // }

  /// Get list of members where lastTypedAt is within [typingTimeout] seconds
  @override
  @ignore
  Iterable<RoomMemberCollection> get typingMembers {
    final now = DateTime.now();
    final members = GetIt.I<RoomMemberDb>().getAllMemberInRoomSync(id!);
    return members!.where((element) {
      if (element.isMe) return false;
      if (element.lastTypedAt == null) return false;

      final timeDiff = now.difference(element.lastTypedAt!).inSeconds;
      return timeDiff <= UChatConstant.typingTimeout;
    });
  }

  @override
  @ignore
  DateTime? get latestLastTypedAt {
    try {
      DateTime? returnValue;
      for (RoomMemberCollection member in typingMembers) {
        if (returnValue == null) {
          returnValue = member.lastTypedAt;
        } else if (member.lastTypedAt!.isAfter(returnValue)) {
          returnValue = member.lastTypedAt;
        }
      }
      return returnValue;
    } catch (e, stacktrace) {
      _log.e('get latestLastTypedAt failed', e, stacktrace);
      return null;
    }
  }

  @override
  @ignore
  DateTime? get latestLastSeenAt {
    try {
      DateTime? returnValue;
      final members = GetIt.I<RoomMemberDb>().getAllMemberInRoomSync(id!);
      for (RoomMemberCollection member in members!) {
        // Check last seen of other member only
        if (member.isMe) continue;
        if (returnValue == null) {
          returnValue = member.account?.lastSeenAt;
        } else if (member.account?.lastSeenAt?.isAfter(returnValue) ?? false) {
          returnValue = member.account?.lastSeenAt;
        }
      }
      return returnValue;
    } catch (e, stacktrace) {
      _log.e('get latestLastSeenAt failed', e, stacktrace);
      return null;
    }
  }

  String typingText({
    required bool isDirectRoom,
    required List<RoomMemberCollection> typingMembers,
  }) {
    final isMobile = UChatScreenUtil.instance.isMobile;
    if (typingMembers.length > 1) {
      if (isMobile) {
        return 'typing'.tr;
      } else {
        if (typingMembers.length <= 2) {
          return '@memberName1, @memberName2 : typing ...'.trParams({
            'memberName1': typingMembers[0].account?.shortDisplayName ?? '',
            'memberName2': typingMembers[1].account?.shortDisplayName ?? '',
          });
        } else {
          return '@memberName1, @memberName2 and @number more : typing ...'.trParams({
            'memberName1': typingMembers[0].account?.shortDisplayName ?? '',
            'memberName2': typingMembers[1].account?.shortDisplayName ?? '',
            'number': (typingMembers.length - 2).toString(),
          });
        }
      }
    } else {
      if (isMobile) {
        if (isDirectRoom) {
          return 'typing'.tr;
        } else {
          final showName = typingMembers.first.account?.shortDisplayName ?? 'typing'.tr;
          return showName;
        }
      } else {
        if (isDirectRoom) {
          return 'typing ...'.tr;
        } else {
          return '@memberName : typing ...'.trParams({
            'memberName': typingMembers.first.account?.shortDisplayName ?? '',
          });
        }
      }
    }
  }
}
