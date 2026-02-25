import 'package:uchat/utils/datetime.dart';

class GroupPermissionEntity {
  final String roomId;
  final bool enable;
  final bool applyToAdmin;
  final bool canSendMessages;
  final bool canSendMedia;
  final bool canMentionAll;
  final bool canEditOwnMessage;
  final bool canUnsendOwnMessage;
  final bool canReactions;
  final bool canAddDeleteAlbum;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GroupPermissionEntity({
    required this.roomId,
    this.enable = false,
    this.applyToAdmin = false,
    this.canSendMessages = true,
    this.canSendMedia = true,
    this.canMentionAll = true,
    this.canEditOwnMessage = true,
    this.canUnsendOwnMessage = true,
    this.canReactions = true,
    this.canAddDeleteAlbum = true,
    this.createdAt,
    this.updatedAt,
  });

  GroupPermissionEntity copyWith({
    String? roomId,
    bool? enable,
    bool? applyToAdmin,
    bool? canSendMessages,
    bool? canSendMedia,
    bool? canMentionAll,
    bool? canEditOwnMessage,
    bool? canUnsendOwnMessage,
    bool? canReactions,
    bool? canAddDeleteAlbum,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroupPermissionEntity(
      roomId: roomId ?? this.roomId,
      enable: enable ?? this.enable,
      applyToAdmin: applyToAdmin ?? this.applyToAdmin,
      canSendMessages: canSendMessages ?? this.canSendMessages,
      canSendMedia: canSendMedia ?? this.canSendMedia,
      canMentionAll: canMentionAll ?? this.canMentionAll,
      canEditOwnMessage: canEditOwnMessage ?? this.canEditOwnMessage,
      canUnsendOwnMessage: canUnsendOwnMessage ?? this.canUnsendOwnMessage,
      canReactions: canReactions ?? this.canReactions,
      canAddDeleteAlbum: canAddDeleteAlbum ?? this.canAddDeleteAlbum,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory GroupPermissionEntity.fromJson(Map<String, dynamic> data) {
    final roomId = data['_id'];
    final permissions = data['permissions'];

    return GroupPermissionEntity(
      roomId: roomId,
      enable: permissions['enable'],
      applyToAdmin: permissions['applyToAdmin'],
      canSendMessages: permissions['canSendMessages'],
      canSendMedia: permissions['canSendMedia'],
      canMentionAll: permissions['canMentionAll'],
      canEditOwnMessage: permissions['canEditOwnMessage'],
      canUnsendOwnMessage: permissions['canUnsendOwnMessage'],
      canReactions: permissions['canReactions'],
      canAddDeleteAlbum: permissions['canAddDeleteAlbum'],
      createdAt: strToDateTime(permissions['createdAt']),
      updatedAt: strToDateTime(permissions['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'permissions': {
        'roomId': roomId,
        'enable': enable,
        'applyToAdmin': applyToAdmin,
        'canSendMessages': canSendMessages,
        'canSendMedia': canSendMedia,
        'canMentionAll': canMentionAll,
        'canEditOwnMessage': canEditOwnMessage,
        'canUnsendOwnMessage': canUnsendOwnMessage,
        'canReactions': canReactions,
        'canAddDeleteAlbum': canAddDeleteAlbum,
        'createdAt': createdAt?.toUtc().toIso8601String(),
        'updatedAt': updatedAt?.toUtc().toIso8601String(),
      }
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GroupPermissionEntity &&
        roomId == other.roomId &&
        enable == other.enable &&
        applyToAdmin == other.applyToAdmin &&
        canSendMessages == other.canSendMessages &&
        canSendMedia == other.canSendMedia &&
        canMentionAll == other.canMentionAll &&
        canEditOwnMessage == other.canEditOwnMessage &&
        canUnsendOwnMessage == other.canUnsendOwnMessage &&
        canReactions == other.canReactions &&
        canAddDeleteAlbum == other.canAddDeleteAlbum &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      roomId,
      enable,
      applyToAdmin,
      canSendMessages,
      canSendMedia,
      canMentionAll,
      canEditOwnMessage,
      canUnsendOwnMessage,
      canReactions,
      canAddDeleteAlbum,
      createdAt,
      updatedAt,
    ]);
  }

  @override
  String toString() {
    return 'GroupPermissionEntity('
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
}
