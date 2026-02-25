import 'package:isar_community/isar.dart';
import 'package:uchat/entities/collections/bookmark_tag_collection.dart';
import 'package:uchat/entities/models/bookmark_item_model.dart';

part 'bookmark_tag_model.g.dart';

@embedded
class BookmarkTagModel {
  final String? id;
  final String? accountId;
  final String? emojiTagId;
  final String? name;
  final String? emoji;
  final String? fileId;
  final String? defaultName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BookmarkTagModel({
    this.id,
    this.accountId,
    this.emojiTagId,
    this.name,
    this.emoji,
    this.fileId,
    this.defaultName,
    this.createdAt,
    this.updatedAt,
  });

  factory BookmarkTagModel.fromMap(Map<String, dynamic> json) {
    return BookmarkTagModel(
      id: json['_id'],
      accountId: json['accountId'],
      emojiTagId: json['emojiTagId'],
      name: json['name'],
      emoji: json['emoji'],
      fileId: json['fileId'],
      defaultName: json['defaultName'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'accountId': accountId,
      'emojiTagId': emojiTagId,
      'name': name,
      'emoji': emoji,
      'fileId': fileId,
      'defaultName': defaultName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  BookmarkTagCollection toCollection({required String msgId}) {
    return BookmarkTagCollection(
      id: id,
      msgId: msgId,
      emojiTagId: emojiTagId,
      name: name,
      fileId: fileId,
      defaultName: defaultName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  BookmarkItemModel toItem({BookmarkTagModel? bookmarkTags}) {
    return BookmarkItemModel(
      id: bookmarkTags?.id,
      emojiTagId: bookmarkTags?.emojiTagId,
      name: bookmarkTags?.name ?? bookmarkTags?.defaultName,
      fileId: bookmarkTags?.fileId,
      emoji: bookmarkTags?.emoji,
      isDefault: !(bookmarkTags?.isDeletable ?? false),
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'accountId': accountId,
        'emojiTagId': emojiTagId,
        'name': name,
        'emoji': emoji,
        'fileId': fileId,
        'defaultName': defaultName,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  /// Computed property to determine if the tag is deletable
  bool get isDeletable => name != null && name!.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkTagModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          accountId == other.accountId &&
          emojiTagId == other.emojiTagId &&
          name == other.name &&
          emoji == other.emoji &&
          fileId == other.fileId &&
          defaultName == other.defaultName;

  @override
  int get hashCode =>
      id.hashCode ^
      accountId.hashCode ^
      emojiTagId.hashCode ^
      name.hashCode ^
      emoji.hashCode ^
      fileId.hashCode ^
      defaultName.hashCode;

  @override
  String toString() {
    return 'BookmarkTagsModel (msgId: $id, '
        'emojiTagId: $emojiTagId, '
        'name: $name, '
        'defaultName: $defaultName, '
        'emoji: $emoji, '
        'fileId: $fileId, '
        'createdAt: $createdAt), '
        'updatedAt: $updatedAt)';
  }
}
