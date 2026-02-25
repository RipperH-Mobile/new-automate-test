import 'package:isar_community/isar.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'bookmark_tag_collection.g.dart';

@Collection(accessor: 'bookmarkTag')
@Name('BookmarkTag')
class BookmarkTagCollection {
  /// This is use for isar id only to uniquely identify each BookmarkTagCollection.
  @Index(unique: true, replace: true)
  String? get localDbId {
    return '$msgId-$emojiTagId';
  }

  Id get isarId => fastHash(localDbId!);

  @Index()
  String? id;

  @Index()
  String? msgId;

  @Index()
  String? emojiTagId;

  @Index()
  String? name;

  @Index()
  String? defaultName;

  @Index()
  String? fileId;

  @Index()
  DateTime? createdAt;

  @Index()
  DateTime? updatedAt;

  BookmarkTagCollection({
    this.id,
    this.msgId,
    this.emojiTagId,
    this.name,
    this.defaultName,
    this.fileId,
    this.createdAt,
    this.updatedAt,
  });

  // Convert from json to model
  factory BookmarkTagCollection.fromMap(Map<String, dynamic> data) {
    return BookmarkTagCollection(
      msgId: data['_id'],
      emojiTagId: data['emojiTagId'],
      name: data['nameTag'],
      defaultName: data['defaultName'],
      fileId: data['fileId'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  void update(BookmarkTagCollection bookmarkTag) {
    if (bookmarkTag.id != null) {
      id = bookmarkTag.id;
    }

    if (bookmarkTag.msgId != null) {
      msgId = bookmarkTag.msgId;
    }

    if (bookmarkTag.emojiTagId != null) {
      emojiTagId = bookmarkTag.emojiTagId;
    }

    if (bookmarkTag.name != null) {
      name = bookmarkTag.name;
    }

    if (bookmarkTag.defaultName != null) {
      defaultName = bookmarkTag.defaultName;
    }

    if (bookmarkTag.fileId != null) {
      fileId = bookmarkTag.fileId;
    }

    if (bookmarkTag.createdAt != null) {
      createdAt = bookmarkTag.createdAt;
    }

    if (bookmarkTag.updatedAt != null) {
      updatedAt = bookmarkTag.updatedAt;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is BookmarkTagCollection && localDbId == other.localDbId;
  }

  @ignore
  @override
  int get hashCode => localDbId.hashCode;

  @override
  String toString() => 'BookmarkTagCollection(id: $localDbId, '
      'msgId: $msgId, '
      'emojiTagId: $emojiTagId, '
      'name: $name, '
      'defaultName: $defaultName, '
      'fileId: $fileId, '
      'createdAt: $createdAt'
      'updatedAt: $updatedAt';
}
