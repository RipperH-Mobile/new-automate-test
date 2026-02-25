import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/data/models/models/chat_folder_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/utils/datetime.dart';

class RoomSubscriptionEntity {
  final String? id;
  final String? roomId;
  final String? roomName;
  final String? accountId;
  final int? unreadCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MessageModel? lastMessage;
  final bool? isPinned;
  final bool? isMuted;
  final bool? isHidden;
  final bool? isMentioned;
  final bool? isDirectChatBlocked;
  final bool? isDirectChatFriend;
  final bool? isHideMessageNotification;
  final bool? isMutedCall;
  final RoomType? roomType;
  final DateTime? latestShare;
  final bool? hasFirstOtherInRoom;
  final bool? hasCryptoKey;
  final int? firstSequence;
  final int? newestMsgSeq;
  final int? oldestMsgSeq;
  final bool? isShowExpireTime;
  final bool? isRoomDeleted;
  final List<ChatFolderModel>? chatFolders;
  final String? password;
  final int? theme;
  final bool? isLocalDeleting;
  final DateTime? hiddenAt;

  const RoomSubscriptionEntity({
    this.id,
    this.roomId,
    this.roomName,
    this.accountId,
    this.unreadCount,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
    this.isPinned,
    this.isMuted,
    this.isHidden,
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
    this.hiddenAt,
  });

  bool get isGroup => roomType == RoomType.group;

  bool get isDirect => roomType == RoomType.direct;

  bool get isSystem => roomType == RoomType.system;

  bool get isSecretRoom => roomType == RoomType.directSecret;

  bool get isBookmark => roomType == RoomType.bookmark;

  bool get canShowInShare {
    if ((isDirect && hasFirstOtherInRoom != true) || (isDirect && isDirectChatBlocked == true)) {
      return false;
    }
    return true;
  }

  bool get canShowInLatestShare {
    return isRoomDeleted != true && latestShare != null && hasFirstOtherInRoom == true;
  }

  bool get canShowInGroupSearch {
    return isRoomDeleted != true && isGroup && !(isHidden == true);
  }

  bool get canShowInDirectSearch {
    return isRoomDeleted != true && isDirect && !(isHidden == true);
  }

  bool get hasMessage {
    return lastMessage != null && (isHidden != true);
  }

  bool get canShowInChatList {
    final isDeleted = isRoomDeleted == true || isLocalDeleting == true;

    if (roomType == RoomType.directSecret) {
      return !isDeleted && hasMessage && hasCryptoKey == true;
    } else {
      return !isDeleted && hasMessage;
    }
  }

  factory RoomSubscriptionEntity.fromMap(Map<String, dynamic> json) {
    List<ChatFolderModel> tempChatFolders = [];
    if (json['chatFolders'] != null) {
      for (final chatFolder in json['chatFolders']) {
        tempChatFolders.add(ChatFolderModel.fromMap(chatFolder));
      }
    }

    return RoomSubscriptionEntity(
      id: json['_id'],
      accountId: json['accountId'],
      roomId: json['roomId'],
      roomName: json['roomName'],
      unreadCount: json['unreadCount'],
      lastMessage: json['lastMessage'] != null ? MessageModel.fromMap(json['lastMessage']) : null,
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

  RoomSubscriptionEntity copyWithEntity(RoomSubscriptionEntity other) {
    return RoomSubscriptionEntity(
      id: other.id ?? id,
      roomId: other.roomId ?? roomId,
      roomName: other.roomName ?? roomName,
      accountId: other.accountId ?? accountId,
      unreadCount: other.unreadCount ?? unreadCount,
      createdAt: other.createdAt ?? createdAt,
      updatedAt: other.updatedAt ?? updatedAt,
      lastMessage: other.lastMessage ?? lastMessage,
      isPinned: other.isPinned ?? isPinned,
      isMuted: other.isMuted ?? isMuted,
      isHidden: other.isHidden ?? isHidden,
      isMentioned: other.isMentioned ?? isMentioned,
      isDirectChatBlocked: other.isDirectChatBlocked ?? isDirectChatBlocked,
      isDirectChatFriend: other.isDirectChatFriend ?? isDirectChatFriend,
      isHideMessageNotification: other.isHideMessageNotification ?? isHideMessageNotification,
      isMutedCall: other.isMutedCall ?? isMutedCall,
      roomType: other.roomType ?? roomType,
      latestShare: other.latestShare ?? latestShare,
      hasFirstOtherInRoom: other.hasFirstOtherInRoom ?? hasFirstOtherInRoom,
      hasCryptoKey: other.hasCryptoKey ?? hasCryptoKey,
      firstSequence: other.firstSequence ?? firstSequence,
      newestMsgSeq: other.newestMsgSeq ?? newestMsgSeq,
      oldestMsgSeq: other.oldestMsgSeq ?? oldestMsgSeq,
      isShowExpireTime: other.isShowExpireTime ?? isShowExpireTime,
      isRoomDeleted: other.isRoomDeleted ?? isRoomDeleted,
      chatFolders: other.chatFolders ?? chatFolders,
      password: other.password ?? password,
      theme: other.theme ?? theme,
      isLocalDeleting: other.isLocalDeleting ?? isLocalDeleting,
      hiddenAt: other.hiddenAt ?? hiddenAt,
    );
  }

  RoomSubscriptionEntity copyWith({
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
    DateTime? hiddenAt,
  }) {
    return RoomSubscriptionEntity(
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
      hiddenAt: hiddenAt ?? this.hiddenAt,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RoomSubscriptionEntity && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'RoomSubscriptionEntity('
        'id: $id, '
        'roomId: $roomId, '
        'roomName: $roomName, '
        'roomType: $roomType, '
        'unreadCount: $unreadCount, '
        'isRoomDeleted: $isRoomDeleted)';
  }
}
