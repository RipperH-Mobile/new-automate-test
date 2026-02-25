import 'package:characters/characters.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_call_type.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/album_task_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/features/chat_room/data/models/models/deleted_by_account_model.dart';
import 'package:uchat/features/chat_room/data/models/models/last_emoji_model.dart';
import 'package:uchat/features/chat_room/data/models/models/mention_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_payload_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_video_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_member_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/fast_hash.dart';

import '../models/chat_folder_model.dart';

part 'room_subscription_collection.g.dart';

final _log = useLogger();

@Collection(accessor: 'roomSubscription')
@Name('RoomSubscription')
class RoomSubscriptionCollection {
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id!);

  @Index()
  String? roomId;
  String? roomName;

  @Index()
  String? accountId;
  int? unreadCount = 0;
  DateTime? createdAt;
  DateTime? updatedAt;
  MessageModel? lastMessage;
  bool? isPinned;
  bool? isMuted;
  @Index()
  bool? isHidden;
  @Index()
  DateTime? hiddenAt;
  bool? isMentioned;

  // Used to check whether this room is blocked or not when using share to feature.
  bool? isDirectChatBlocked;

  // Used to check whether this user is friend or not when using share to feature.
  bool? isDirectChatFriend;
  bool? isHideMessageNotification;
  bool? isMutedCall;
  @Enumerated(EnumType.name)
  @Index()
  RoomType? roomType;
  DateTime? latestShare;
  bool? hasFirstOtherInRoom;
  bool? hasCryptoKey;

  /// This variable indicates the oldest message that can be seen in that chat.
  /// Ex.
  /// accountA and accountB have been in this group since it was created,
  /// and there are still no messages in the group.
  /// So, [firstSequence] of accountA and accountB will be 1.
  /// Then accountC has joined when the group was already had 1000 messages.
  /// So, [firstSequence] of accountC will be 1000.
  int? firstSequence;

  // Used to save the newest message sequence in localDB
  int? newestMsgSeq;

  // Used to save the oldest message sequence in localDB
  int? oldestMsgSeq;

  bool? isShowExpireTime;

  @Index()
  bool? isRoomDeleted;

  List<ChatFolderModel>? chatFolders;

  String? password;

  int? theme;
  @Index()
  bool? isLocalDeleting;

  RoomSubscriptionCollection({
    this.id,
    this.unreadCount,
    this.accountId,
    this.roomId,
    this.roomName,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
    this.isPinned,
    this.isMuted,
    this.isHidden,
    this.hiddenAt,
    this.isMentioned,
    this.isDirectChatBlocked,
    this.isDirectChatFriend,
    this.isHideMessageNotification,
    this.isMutedCall,
    this.roomType,
    this.latestShare,
    this.hasFirstOtherInRoom,
    this.hasCryptoKey,
    this.firstSequence,
    this.newestMsgSeq,
    this.oldestMsgSeq,
    this.isShowExpireTime,
    this.isRoomDeleted,
    this.chatFolders,
    this.password,
    this.theme,
    this.isLocalDeleting,
  });

  factory RoomSubscriptionCollection.fromMap(Map<String, dynamic> json) {
    MessageModel? lastMessage;
    if (json['lastMessage'] != null && json['lastMessage'] is Map<String, dynamic>) {
      try {
        // BUG: The last message is not always a Map<String, dynamic> type, sometimes it's a String (empty).
        lastMessage = MessageModel.fromMap(json['lastMessage']);
      } catch (e, stackTrace) {
        _log.e(
          'Error parse last message. (type: ${json['lastMessage'].runtimeType} -> ${json['lastMessage']})',
          e,
          stackTrace,
        );
      }
    }

    List<ChatFolderModel> tempChatFolders = [];
    if (json['chatFolders'] != null) {
      for (final chatFolder in json['chatFolders']) {
        try {
          tempChatFolders.add(ChatFolderModel.fromMap(chatFolder));
        } catch (e, stackTrace) {
          _log.e(
            'Error parse chat folder. ($chatFolder)',
            e,
            stackTrace,
          );
        }
      }
    }

    return RoomSubscriptionCollection(
      id: json['_id'],
      accountId: json['accountId'],
      roomId: json['roomId'],
      roomName: json['roomName'],
      unreadCount: json['unreadCount'],
      lastMessage: lastMessage,
      isPinned: json['isPinned'],
      isMuted: json['isMuted'],
      isHidden: json['isHidden'],
      hiddenAt: json['hiddenAt'] != null ? strToDateTime(json['hiddenAt']) : null,
      isMentioned: json['isMentioned'],
      isDirectChatBlocked: json['isDirectChatBlocked'],
      isDirectChatFriend: json['isDirectChatFriend'],
      isHideMessageNotification: json['isHideMessageNotification'],
      isMutedCall: json['isMutedCall'],
      roomType: json['roomType'] != null ? RoomType.from(json['roomType']) : null,
      createdAt: strToDateTime(json['createdAt']),
      updatedAt: strToDateTime(json['updatedAt']),
      firstSequence: int.tryParse(json['firstSequence'] ?? '', radix: 16),
      newestMsgSeq: int.tryParse(json['newestMsgSeq'] ?? '', radix: 16),
      oldestMsgSeq: int.tryParse(json['oldestMsgSeq'] ?? '', radix: 16),
      isShowExpireTime: json['isShowExpireTime'],
      isRoomDeleted: json['isRoomDeleted'],
      chatFolders: tempChatFolders.isNotEmpty ? tempChatFolders : null,
      password: json['passwordForLockedMessage'],
      theme: int.tryParse(json['theme'] ?? ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountId': accountId,
      'roomId': roomId,
      'roomName': roomName,
      'unreadCount': unreadCount,
      'lastMessage': lastMessage?.toMap(),
      'isPinned': isPinned,
      'isMuted': isMuted,
      'isHidden': isHidden,
      'isMentioned': isMentioned,
      'isDirectChatBlocked': isDirectChatBlocked,
      'isDirectChatFriend': isDirectChatFriend,
      'isHideMessageNotification': isHideMessageNotification,
      'isMutedCall': isMutedCall,
      'roomType': roomType?.name,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'firstSequence': firstSequence,
      'newestMsgSeq': newestMsgSeq,
      'oldestMsgSeq': oldestMsgSeq,
      'isShowExpireTime': isShowExpireTime,
      'isRoomDeleted': isRoomDeleted,
      'chatFolders': chatFolders?.map((e) => e.toMap()).toList(),
      'password': password,
      'theme': theme,
      'latestShare': latestShare?.toIso8601String(),
      'hasFirstOtherInRoom': hasFirstOtherInRoom,
      'hasCryptoKey': hasCryptoKey,
      'isLocalDeleting': isLocalDeleting,
    };
  }

  void update(RoomSubscriptionCollection receiveSub) {
    if (receiveSub.id != null) {
      id = receiveSub.id;
    }

    if (receiveSub.roomId != null) {
      roomId = receiveSub.roomId;
    }

    if (receiveSub.roomName != null) {
      roomName = receiveSub.roomName;
    }

    if (receiveSub.accountId != null) {
      accountId = receiveSub.accountId;
    }

    if (receiveSub.unreadCount != null) {
      unreadCount = receiveSub.unreadCount;
    }

    if (receiveSub.createdAt != null) {
      createdAt = receiveSub.createdAt;
    }

    if (receiveSub.updatedAt != null) {
      updatedAt = receiveSub.updatedAt;
    }
    if (receiveSub.isShowExpireTime != null) {
      isShowExpireTime = receiveSub.isShowExpireTime;
    }

    if (receiveSub.lastMessage != null) {
      if (lastMessage != null) {
        final idNotMatch = lastMessage!.id != receiveSub.lastMessage!.id;
        final seqSubMsg = receiveSub.lastMessage!.sequence ?? 0;
        final seqLastMsg = lastMessage!.sequence ?? 0;
        final seqNotMatch = seqSubMsg >= seqLastMsg;

        // Update lastMessage data when new data is the same message (with updated data)
        // or new data is not the same message but have higher seq number.
        /// When [hide] or [unhide] message, the seq number and id are the same but the data is different.
        if (!idNotMatch || (idNotMatch && seqNotMatch)) {
          // If new data is the same message, update it with new data.
          lastMessage!.update(receiveSub.lastMessage!);
        } else {
          // If new data is not the same seq number and id, update it with new data.
          lastMessage = receiveSub.lastMessage;
        }
      } else {
        lastMessage = receiveSub.lastMessage;
      }
    }

    if (receiveSub.isPinned != null) {
      isPinned = receiveSub.isPinned;
    }

    if (receiveSub.isMuted != null) {
      isMuted = receiveSub.isMuted;
    }

    if (receiveSub.isHidden != null) {
      isHidden = receiveSub.isHidden;
    }

    if (receiveSub.isMentioned != null) {
      isMentioned = receiveSub.isMentioned;
    }

    if (receiveSub.isDirectChatBlocked != null) {
      isDirectChatBlocked = receiveSub.isDirectChatBlocked;
    }

    if (receiveSub.isDirectChatFriend != null) {
      isDirectChatFriend = receiveSub.isDirectChatFriend;
    }

    if (receiveSub.isHideMessageNotification != null) {
      isHideMessageNotification = receiveSub.isHideMessageNotification;
    }

    if (receiveSub.isMutedCall != null) {
      isMutedCall = receiveSub.isMutedCall;
    }

    if (receiveSub.roomType != null) {
      roomType = receiveSub.roomType;
    }

    if (receiveSub.latestShare != null) {
      latestShare = receiveSub.latestShare;
    }

    if (receiveSub.hasFirstOtherInRoom != null) {
      hasFirstOtherInRoom = receiveSub.hasFirstOtherInRoom;
    }

    if (receiveSub.hasCryptoKey != null) {
      hasCryptoKey = receiveSub.hasCryptoKey;
    }

    if (receiveSub.firstSequence != null) {
      firstSequence = receiveSub.firstSequence;
    }

    if (receiveSub.newestMsgSeq != null) {
      newestMsgSeq = receiveSub.newestMsgSeq;
    }

    if (receiveSub.oldestMsgSeq != null) {
      oldestMsgSeq = receiveSub.oldestMsgSeq;
    }

    if (receiveSub.isRoomDeleted != null) {
      isRoomDeleted = receiveSub.isRoomDeleted;
    }

    if (receiveSub.chatFolders != null) {
      chatFolders = receiveSub.chatFolders;
    }

    if (receiveSub.password != null) {
      password = receiveSub.password;
    }

    if (receiveSub.theme != null) {
      theme = receiveSub.theme;
    }

    if (receiveSub.isLocalDeleting != null) {
      isLocalDeleting = receiveSub.isLocalDeleting;
    }
    if (receiveSub.hiddenAt != null) {
      hiddenAt = receiveSub.hiddenAt;
    }
  }

  @ignore
  String get title {
    // _log.i(roomType);
    switch (roomType) {
      case RoomType.group:
        return roomName ?? '';
      case RoomType.bookmark:
        return 'Bookmark';
      case RoomType.direct:
      case RoomType.directSecret:
        final firstOtherInRoom = GetIt.I<RoomMemberDb>().getFirstOtherInRoomSync(roomId ?? '');
        if (firstOtherInRoom != null) {
          ContactModel? member = firstOtherInRoom.account;
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
        }

        if (roomName != null && roomName != 'UNKNOWN') {
          return roomName!;
        }

        return 'UNKNOWN'.tr.toUpperCase();
      default:
        return 'UNKNOWN'.tr.toUpperCase();
    }
  }

  bool get isGroup {
    return roomType == RoomType.group;
  }

  bool get isDirect {
    return roomType == RoomType.direct;
  }

  bool get isSecretRoom {
    return roomType == RoomType.directSecret;
  }

  bool get isBookmark {
    return roomType == RoomType.bookmark;
  }

  bool get isSystem {
    return roomType == RoomType.system;
  }

  DateTime? get roomLocalDateTime {
    DateTime? finalDate;

    if (lastMessage == null) {
      return createdAt;
    } else {
      finalDate = lastMessage?.createdAt?.toLocal();
    }

    return finalDate;
  }

  String get lastMessageTime {
    String dateFormat = '';

    if (roomLocalDateTime != null) {
      final DateTime now = DateTime.now().toLocal();
      final DateTime yesterday = now.subtract(const Duration(days: 1));

      if (roomLocalDateTime!.isSameDay(now)) {
        //NOTE. time today
        dateFormat = roomLocalDateTime!.format('HH:mm');
      } else if (roomLocalDateTime!.isSameDay(yesterday)) {
        //NOTE. yesterday
        dateFormat = 'Yesterday'.tr;
      } else {
        //NOTE. Feb 14, 2025
        dateFormat = roomLocalDateTime!.format('MMM d, y');
      }
    }

    return dateFormat;
  }

  @Index()
  bool get canShowInShare {
    if ((isDirect && hasFirstOtherInRoom != true) || (isDirect && isDirectChatBlocked == true)) {
      return false;
    }
    return true;
  }

  @Index()
  bool get canShowInLatestShare {
    return isRoomDeleted != true && latestShare != null && hasFirstOtherInRoom == true;
  }

  @Index()
  bool get canShowInGroupSearch {
    return isRoomDeleted != true && isGroup && !(isHidden == true);
  }

  @Index()
  bool get canShowInDirectSearch {
    return isRoomDeleted != true && isDirect && !(isHidden == true);
  }

  @Index()
  bool get hasMessage {
    return lastMessage != null && (isHidden != true);
  }

  @Index()
  bool get canShowInChatList {
    final isDeleted = isRoomDeleted == true || isLocalDeleting == true;

    if (roomType == RoomType.directSecret) {
      return !isDeleted && hasMessage && hasCryptoKey == true;
    } else {
      return !isDeleted && hasMessage;
    }
  }

  @ignore
  String? get lastMessageText {
    if (lastMessage?.isSending == true) {
      return 'Sending...'.tr;
    }
    if (lastMessage?.isHidden == true) {
      return 'This message is hidden.'.tr;
    }

    if (lastMessage?.isDecryptFailed == true) {
      return 'This message cannot be read'.tr;
    }

    if (lastMessage?.isUnsentMessage == true || lastMessage?.isRemoveMessage == true) {
      return 'This message is deleted.'.tr;
    }

    if (lastMessage?.isSystemMessage == true) {
      MessageModel message = lastMessage!;
      return message.systemText;
    }

    if (isSecretRoom && lastMessage?.message != null && lastMessage?.message != '') {
      if (lastMessage?.mine == true) {
        return 'You sent a message.'.tr;
      } else {
        return '@displayName sent a message.'.trParams({'displayName': lastMessage?.displayName ?? 'SOMEONE'.tr});
      }
    }

    if (lastMessage == null) {
      return 'Tap to start chatting!'.tr;
    }

    final mine = lastMessage?.mine;
    final type = lastMessage?.type;

    String senderName = lastMessage?.displayName ?? '';
    if (mine == true) {
      senderName = 'You'.tr;
    } else if (senderName.characters.length >= 15) {
      senderName = '${senderName.characters.take(15)}\u2026';
    }

    if (lastMessage?.isLocked == true) {
      if (mine == true) {
        return 'You: send a message.'.tr;
      }

      return '@displayName: send you a message.'.trParams({
        'displayName': senderName,
      });
    }

    switch (type) {
      case MessageType.text:
        if ((mine == true && isGroup) || (mine == false && isDirect)) {
          return lastMessage?.message;
        }

        return '$senderName: ${lastMessage?.message}';

      ///TODO: Change Last Message
      case MessageType.stickerGift:
        return '@displayName sent you a sticker gift'.trParams({
          'displayName': senderName,
        });
      case MessageType.stickerSharing:
        return '@displayName share sticker "@stickerName".'.trParams({
          'displayName': senderName,
          'stickerName': lastMessage?.meta?.stickerName ?? 'Unknown'.tr,
        });
      case MessageType.sticker:
        if (mine == true) {
          return 'You sent a sticker'.tr;
        }

        if (!(mine == true) && isDirect) {
          if (lastMessage?.meta?.stickerEmoji != null) {
            return 'Sent a sticker (@emoji).'.trParams({
              'emoji': lastMessage?.meta!.stickerEmoji! ?? '',
            });
          }

          return '@displayName sent a sticker'.trParams({
            'displayName': senderName,
          });
        }

        return '@displayName sent a sticker.'.trParams({
          'displayName': senderName,
        });
      case MessageType.file:
        if (mine == true) {
          return 'You sent a file'.tr;
        }

        if (!(mine == true) && isDirect) {
          return '@displayName sent a file'.trParams({
            'displayName': senderName,
          });
        }

        return '@displayName sent a file'.trParams({
          'displayName': senderName,
        });
      case MessageType.image:
        //NOTE. need BE send files
        int amount = lastMessage?.files?.length ?? 1;
        String manyPhotos = amount > 1 ? 'photos'.tr : 'photo'.tr;

        if (mine == true) {
          return 'You sent @amount @manyPhotos'.trParams({
            'displayName': senderName,
            'amount': amount.toString(),
            'manyPhotos': manyPhotos,
          });
        }

        if (!(mine == true) && isDirect) {
          return '@displayName sent @amount @manyPhotos'.trParams({
            'displayName': senderName,
            'amount': amount.toString(),
            'manyPhotos': manyPhotos,
          });
        }

        return '@displayName sent @amount @manyPhotos'.trParams({
          'displayName': senderName,
          'amount': amount.toString(),
          'manyPhotos': manyPhotos,
        });
      case MessageType.audio:
        if (mine == true) {
          return 'You sent a voice message'.tr;
        }

        if (!(mine == true) && isDirect) {
          return '@displayName sent a voice message'.trParams({
            'displayName': senderName,
          });
        }

        return '@displayName sent a voice message'.trParams({
          'displayName': senderName,
        });
      case MessageType.video:
        if (mine == true) {
          return 'You sent a video'.tr;
        }

        if (!(mine == true) && isDirect) {
          return '@displayName sent a video'.trParams({
            'displayName': senderName,
          });
        }

        return '@displayName sent a video'.trParams({
          'displayName': senderName,
        });
      case MessageType.gif:
        if (mine == true) {
          return 'You sent a GIF'.tr;
        }

        if (!(mine == true) && isDirect) {
          return '@displayName sent a GIF'.trParams({
            'displayName': senderName,
          });
        }

        return '@displayName sent a GIF'.trParams({
          'displayName': senderName,
        });
      case MessageType.system:
        // TODO: Handle this case.
        break;
      case MessageType.unsent:
        // TODO: Handle this case.
        break;
      case MessageType.remove:
        // TODO: Handle this case.
        break;
      case MessageType.removeOthers:
        return 'Admin delete a message'.tr;
      case MessageType.edit:
        // TODO: Handle this case.
        break;
      case MessageType.album:
        if (mine == true) {
          return 'You upload image to an album'.tr;
        }

        if (!(mine == true) && isDirect) {
          return '@displayName upload image to an album'.trParams({
            'displayName': senderName,
          });
        }

        return '@displayName upload image to an album'.trParams({
          'displayName': senderName,
        });
      case MessageType.location:
        if (mine == true) {
          return 'You sent a location'.tr;
        }

        if (!(mine == true) && isDirect) {
          return '@displayName sent a location'.trParams({
            'displayName': senderName,
          });
        }

        return '@displayName sent a location'.trParams({
          'displayName': senderName,
        });
      case null:
        return '';
      case MessageType.callMsg:
        final msgCallType = lastMessage?.callMessage?.type;
        switch (msgCallType) {
          case MessageCallType.join:
            if (mine == true) {
              return 'You have joined @callType call'.trParams({
                'callType': (lastMessage?.callMessage?.isVideo ?? false) ? 'video'.tr : 'voice'.tr,
              });
            }
            return '@displayName has joined @callType call'.trParams({
              'displayName': senderName,
              'callType': (lastMessage?.callMessage?.isVideo ?? false) ? 'video'.tr : 'voice'.tr,
            });
          case MessageCallType.start:
            if (mine == true) {
              return 'You start @callType call'.trParams({
                'callType': (lastMessage?.callMessage?.isVideo ?? false) ? 'video'.tr : 'voice'.tr,
              });
            }
            return '@displayName start @callType call'.trParams({
              'displayName': senderName,
              'callType': (lastMessage?.callMessage?.isVideo ?? false) ? 'video'.tr : 'voice'.tr,
            });
          case MessageCallType.end:
            return 'Call time @time'.trParams({
              'time': lastMessage?.callMessage?.payload?.durationString ?? '',
            });
          case MessageCallType.leave:
            if (mine == true) {
              return 'You have left the @callType call'.trParams({
                'callType': (lastMessage?.callMessage?.isVideo ?? false) ? 'video'.tr : 'voice'.tr,
              });
            }
            return '@displayName has left the @callType call'.trParams({
              'displayName': senderName,
              'callType': (lastMessage?.callMessage?.isVideo ?? false) ? 'video'.tr : 'voice'.tr,
            });
          case MessageCallType.decline:
          case MessageCallType.timeout:
          case MessageCallType.unreachable:
          case MessageCallType.unknown:
            if (mine == true) {
              return 'No answer'.tr;
            }

            return 'Missed call from @displayName'.trParams({
              'displayName': senderName,
            });

          default:
            return '';
        }
      case MessageType.mobileContact:
      case MessageType.contact:
        return '@displayName sent a contact'.trParams({
          'displayName': mine == true ? 'You'.tr : senderName,
        });
    }

    return '';
  }

  @Index()
  String? get nameLowercase {
    return roomName?.toLowerCase();
  }

  String get widgetKey {
    return 'ROOM-Subscription-$id';
  }

  @override
  String toString() {
    return 'RoomSubscriptionCollection('
        'id: $id, '
        'isRoomDeleted: $isRoomDeleted, '
        'roomId: $roomId, '
        'roomName: $roomName, '
        'accountId: $accountId, '
        'unreadCount: $unreadCount, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'lastMessage: $lastMessage, '
        'isPinned: $isPinned, '
        'isMuted: $isMuted, '
        'isHidden: $isHidden, '
        'isMentioned: $isMentioned, '
        'isDirectChatBlocked: $isDirectChatBlocked, '
        'isDirectChatFriend: $isDirectChatFriend, '
        'isHideMessageNotification: $isHideMessageNotification, '
        'isMutedCall: $isMutedCall, '
        'roomType: $roomType, '
        'latestShare: $latestShare, '
        'hasFirstOtherInRoom: $hasFirstOtherInRoom '
        'isShowExpireTime: $isShowExpireTime '
        'firstSequence: $firstSequence '
        'newestMsgSeq: $newestMsgSeq '
        'oldestMsgSeq: $oldestMsgSeq '
        'theme: $theme)';
  }

  @override
  bool operator ==(Object other) {
    return other is RoomSubscriptionCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  RoomSubscriptionCollection copyWith({
    String? id,
    String? roomId,
    String? roomName,
    String? accountId,
    int? unreadCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    MessageModel? lastMessage,
    bool? isPinned,
    bool? isMuted,
    bool? isHidden,
    bool? isMentioned,
    bool? isDirectChatBlocked,
    bool? isDirectChatFriend,
    bool? isHideMessageNotification,
    bool? isMutedCall,
    RoomType? roomType,
    DateTime? latestShare,
    bool? hasFirstOtherInRoom,
    bool? hasCryptoKey,
    int? firstSequence,
    int? newestMsgSeq,
    int? oldestMsgSeq,
    bool? isShowExpireTime,
    bool? isRoomDeleted,
    List<ChatFolderModel>? chatFolders,
    String? password,
    int? theme,
    bool? isLocalDeleting,
  }) {
    return RoomSubscriptionCollection(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      accountId: accountId ?? this.accountId,
      unreadCount: unreadCount ?? this.unreadCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessage: lastMessage ?? this.lastMessage,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      isHidden: isHidden ?? this.isHidden,
      isMentioned: isMentioned ?? this.isMentioned,
      isDirectChatBlocked: isDirectChatBlocked ?? this.isDirectChatBlocked,
      isDirectChatFriend: isDirectChatFriend ?? this.isDirectChatFriend,
      isHideMessageNotification: isHideMessageNotification ?? this.isHideMessageNotification,
      isMutedCall: isMutedCall ?? this.isMutedCall,
      roomType: roomType ?? this.roomType,
      latestShare: latestShare ?? this.latestShare,
      hasFirstOtherInRoom: hasFirstOtherInRoom ?? this.hasFirstOtherInRoom,
      hasCryptoKey: hasCryptoKey ?? this.hasCryptoKey,
      firstSequence: firstSequence ?? this.firstSequence,
      newestMsgSeq: newestMsgSeq ?? this.newestMsgSeq,
      oldestMsgSeq: oldestMsgSeq ?? this.oldestMsgSeq,
      isShowExpireTime: isShowExpireTime ?? this.isShowExpireTime,
      isRoomDeleted: isRoomDeleted ?? this.isRoomDeleted,
      chatFolders: chatFolders ?? this.chatFolders,
      password: password ?? this.password,
      theme: theme ?? this.theme,
      isLocalDeleting: isLocalDeleting ?? this.isLocalDeleting,
    );
  }

  static RoomSubscriptionCollection fromEntity(RoomSubscriptionEntity entity) {
    return RoomSubscriptionCollection(
      id: entity.id,
      roomId: entity.roomId,
      roomName: entity.roomName,
      accountId: entity.accountId,
      unreadCount: entity.unreadCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      lastMessage: entity.lastMessage,
      isPinned: entity.isPinned,
      isMuted: entity.isMuted,
      isHidden: entity.isHidden,
      isMentioned: entity.isMentioned,
      isDirectChatBlocked: entity.isDirectChatBlocked,
      isDirectChatFriend: entity.isDirectChatFriend,
      isHideMessageNotification: entity.isHideMessageNotification,
      isMutedCall: entity.isMutedCall,
      roomType: entity.roomType,
      hasFirstOtherInRoom: entity.hasFirstOtherInRoom,
      firstSequence: entity.firstSequence,
      newestMsgSeq: entity.newestMsgSeq,
      oldestMsgSeq: entity.oldestMsgSeq,
      isShowExpireTime: entity.isShowExpireTime,
      isRoomDeleted: entity.isRoomDeleted,
      chatFolders: entity.chatFolders,
      password: entity.password,
      hasCryptoKey: entity.hasCryptoKey,
      theme: entity.theme,
      isLocalDeleting: entity.isLocalDeleting,
      latestShare: entity.latestShare,
    );
  }

  RoomSubscriptionEntity toEntity() {
    return RoomSubscriptionEntity(
      id: id,
      roomId: roomId,
      roomName: roomName,
      accountId: accountId,
      unreadCount: unreadCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastMessage: lastMessage,
      isPinned: isPinned,
      isMuted: isMuted,
      isHidden: isHidden,
      isMentioned: isMentioned,
      isDirectChatBlocked: isDirectChatBlocked,
      isDirectChatFriend: isDirectChatFriend,
      isHideMessageNotification: isHideMessageNotification,
      isMutedCall: isMutedCall,
      roomType: roomType,
      latestShare: latestShare,
      hasFirstOtherInRoom: hasFirstOtherInRoom,
      hasCryptoKey: hasCryptoKey,
      firstSequence: firstSequence,
      newestMsgSeq: newestMsgSeq,
      oldestMsgSeq: oldestMsgSeq,
      isShowExpireTime: isShowExpireTime,
      isRoomDeleted: isRoomDeleted,
      chatFolders: chatFolders,
      password: password,
      theme: theme,
      isLocalDeleting: isLocalDeleting,
      hiddenAt: hiddenAt,
    );
  }
}
