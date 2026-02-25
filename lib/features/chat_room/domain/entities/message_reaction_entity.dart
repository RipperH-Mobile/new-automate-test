class MessageReactionEntity {
  final String? emojiId;
  final String? fileId;
  final String? accountId;
  final String? displayName;
  final String? avatarPath;
  final DateTime? createdAt;

  MessageReactionEntity({
    this.emojiId,
    this.fileId,
    this.accountId,
    this.displayName,
    this.avatarPath,
    this.createdAt,
  });

  // String? get accountName {
  //   final roomMembers = RoomMemberDb().getAllMemberInRoomSync(roomId ?? '');
  //   String? name;

  //   if (roomMembers == null) return displayName;

  //   for (final member in roomMembers) {
  //     if ((accountId ?? '') == member.accountId) {
  //       name = member.account?.shortName;
  //       break;
  //     }
  //   }

  //   return name ?? displayName;
  // }

  // String? get avatarId {
  //   final roomMembers = RoomMemberDb().getAllMemberInRoomSync(roomId ?? '');
  //   String? path;

  //   if (roomMembers == null) return avatarPath;

  //   for (final member in roomMembers) {
  //     if ((accountId ?? '') == member.accountId) {
  //       path = member.account?.avatarId;
  //       break;
  //     }
  //   }

  //   return path ?? avatarPath;
  // }

  /// Copy with method for immutability
  MessageReactionEntity copyWith({
    String? msgId,
    String? roomId,
    String? emojiId,
    String? fileId,
    String? accountId,
    String? displayName,
    String? avatarPath,
    DateTime? createdAt,
  }) {
    return MessageReactionEntity(
      emojiId: emojiId ?? this.emojiId,
      fileId: fileId ?? this.fileId,
      accountId: accountId ?? this.accountId,
      displayName: displayName ?? this.displayName,
      avatarPath: avatarPath ?? this.avatarPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'emojiId: $emojiId, '
      'fileId: $fileId, '
      'accountId: $accountId, '
      'displayName: $displayName, '
      'avatarPath: $avatarPath)';
}
