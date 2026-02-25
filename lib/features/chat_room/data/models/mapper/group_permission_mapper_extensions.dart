import 'package:uchat/features/chat_room/data/models/collections/group_permission_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';

extension GroupPermissionMapper on GroupPermissionCollection {
  GroupPermissionEntity toEntity() {
    if (roomId == null) {
      throw Exception('Cannot create entity: Invalid model data - roomId is null');
    }

    return GroupPermissionEntity(
      roomId: roomId!,
      enable: enable ?? false,
      applyToAdmin: applyToAdmin ?? false,
      canSendMessages: canSendMessages ?? false,
      canSendMedia: canSendMedia ?? false,
      canMentionAll: canMentionAll ?? false,
      canEditOwnMessage: canEditOwnMessage ?? false,
      canUnsendOwnMessage: canUnsendOwnMessage ?? false,
      canReactions: canReactions ?? false,
      canAddDeleteAlbum: canAddDeleteAlbum ?? false,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension GroupPermissionEntityMapper on GroupPermissionEntity {
  GroupPermissionCollection toCollection() {
    return GroupPermissionCollection(
      roomId: roomId,
      enable: enable,
      applyToAdmin: applyToAdmin,
      canSendMessages: canSendMessages,
      canSendMedia: canSendMedia,
      canMentionAll: canMentionAll,
      canEditOwnMessage: canEditOwnMessage,
      canUnsendOwnMessage: canUnsendOwnMessage,
      canReactions: canReactions,
      canAddDeleteAlbum: canAddDeleteAlbum,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension GroupPermissionCollectionListExtensions on List<GroupPermissionCollection> {
  List<GroupPermissionEntity> toEntities() {
    return map((collection) => collection.toEntity()).toList();
  }
}

extension GroupPermissionEntityListExtensions on List<GroupPermissionEntity> {
  List<GroupPermissionCollection> toCollections() {
    return map((entity) => entity.toCollection()).toList();
  }
}