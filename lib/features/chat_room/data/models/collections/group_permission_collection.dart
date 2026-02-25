import 'package:isar_community/isar.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'group_permission_collection.g.dart';

@Collection(accessor: 'groupPermissions')
@Name('GroupPermission')
class GroupPermissionCollection {
  @Index(unique: true, replace: true)
  String? roomId;

  Id get isarId => fastHash(roomId!);

  bool? enable;
  bool? applyToAdmin;
  bool? canSendMessages;
  bool? canSendMedia;
  bool? canMentionAll;
  bool? canEditOwnMessage;
  bool? canUnsendOwnMessage;
  bool? canReactions;
  bool? canAddDeleteAlbum;
  DateTime? createdAt;
  DateTime? updatedAt;

  GroupPermissionCollection({
    this.roomId,
    this.enable,
    this.applyToAdmin,
    this.canSendMessages,
    this.canSendMedia,
    this.canMentionAll,
    this.canEditOwnMessage,
    this.canUnsendOwnMessage,
    this.canReactions,
    this.canAddDeleteAlbum,
    this.createdAt,
    this.updatedAt,
  });

  @override
  bool operator ==(Object other) {
    return other is GroupPermissionCollection && roomId == other.roomId;
  }

  @override
  int get hashCode => roomId.hashCode;

  @override
  String toString() {
    return 'GroupPermissionCollection('
        'roomId: $roomId, '
        'enable: $enable, '
        'applyToAdmin: $applyToAdmin, '
        'canSendMessages: $canSendMessages, '
        'canSendMedia: $canSendMedia, '
        'canMentionAll: $canMentionAll, '
        'canEditOwnMessage: $canEditOwnMessage, '
        'canUnsendOwnMessage: $canUnsendOwnMessage, '
        'canReactions: $canReactions, '
        'canAddDeleteAlbum: $canAddDeleteAlbum, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt'
        ')';
  }

// Mapper methods moved to extension file: group_permission_mapper_extensions.dart
}
