import 'package:isar_community/isar.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'message_reaction_collection.g.dart';

@Collection(accessor: 'messageReaction')
@Name('MessageReaction')
class MessageReactionCollection {
  /// This is use for isar id only to uniquely identify each MessageReactionCollection.
  @Index(unique: true, replace: true)
  String? get localDbId {
    return '$roomId-$msgId-$emojiId-$accountId';
  }

  Id get isarId => fastHash(localDbId!);

  @Index()
  String? msgId;

  @Index()
  @Index(composite: [CompositeIndex('msgId')])
  String? roomId;

  @Index()
  @Index(composite: [CompositeIndex('msgId')])
  String? emojiId;

  @Index()
  String? fileId;

  @Index()
  @Index(composite: [CompositeIndex('msgId')])
  String? accountId;

  @Index()
  String? displayName;

  @Index()
  String? avatarPath;

  @Index()
  DateTime? createdAt;

  MessageReactionCollection({
    this.msgId,
    this.roomId,
    this.emojiId,
    this.fileId,
    this.accountId,
    this.displayName,
    this.avatarPath,
    this.createdAt,
  });

  // Convert from json to model
  factory MessageReactionCollection.fromJson(Map<String, dynamic> data) {
    return MessageReactionCollection(
      msgId: data['_id'],
      roomId: data['roomId'],
      emojiId: data['emojiId'],
      fileId: data['fileId'],
      accountId: data['accountId'],
      displayName: data['displayName'],
      avatarPath: data['avatarId'],
      createdAt: data['createdAt'],
    );
  }

  void update(MessageReactionCollection messageReaction) {
    if (messageReaction.msgId != null) {
      msgId = messageReaction.msgId;
    }

    if (messageReaction.roomId != null) {
      roomId = messageReaction.roomId;
    }

    if (messageReaction.emojiId != null) {
      emojiId = messageReaction.emojiId;
    }

    if (messageReaction.fileId != null) {
      fileId = messageReaction.fileId;
    }

    if (messageReaction.accountId != null) {
      accountId = messageReaction.accountId;
    }

    if (messageReaction.displayName != null) {
      displayName = messageReaction.displayName;
    }

    if (messageReaction.avatarPath != null) {
      avatarPath = messageReaction.avatarPath;
    }

    if (messageReaction.createdAt != null) {
      createdAt = messageReaction.createdAt;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is MessageReactionCollection && localDbId == other.localDbId;
  }

  @ignore
  @override
  int get hashCode => localDbId.hashCode;

  @override
  String toString() => 'MessageReactionCollection(id: $localDbId, '
      'msgId: $msgId, '
      'roomId: $roomId, '
      'emojiId: $emojiId, '
      'fileId: $fileId, '
      'accountId: $accountId, '
      'displayName: $displayName, '
      'avatarPath: $avatarPath, ';
}
