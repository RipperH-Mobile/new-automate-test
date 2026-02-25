import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

extension RoomSubscriptionCollectionExtension on RoomSubscriptionCollection {
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
      isShowExpireTime: isShowExpireTime,
      isRoomDeleted: isRoomDeleted,
      chatFolders: chatFolders,
      password: password,
      theme: theme,
      isLocalDeleting: isLocalDeleting,
    );
  }
}

extension RoomSubscriptionEntityExtension on RoomSubscriptionEntity {
  RoomSubscriptionCollection toCollection() {
    return RoomSubscriptionCollection(
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

extension RoomSubscriptionCollectionListExtensions on List<RoomSubscriptionCollection> {
  List<RoomSubscriptionEntity> toEntities() {
    return map((collection) => collection.toEntity()).toList();
  }
}

extension RoomSubscriptionEntityListExtensions on List<RoomSubscriptionEntity> {
  List<RoomSubscriptionCollection> toCollections() {
    return map((entity) => entity.toCollection()).toList();
  }
}
