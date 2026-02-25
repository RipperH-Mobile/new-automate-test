import 'package:uchat/entities/models/bookmark_item_model.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_entity.dart';

class BookmarkPackageWithItemsModel extends EmojiPackageEntity {
  List<BookmarkItemModel>? emojiItems;

  BookmarkPackageWithItemsModel({
    super.coverId,
    super.coverImageUrl,
    super.createdAt,
    super.description,
    super.id,
    super.isDefault,
    super.isPublish,
    super.name,
    super.tags,
    super.updatedAt,
    this.emojiItems,
  });

  factory BookmarkPackageWithItemsModel.fromMap(Map<String, dynamic> json) => BookmarkPackageWithItemsModel(
        id: json['_id'],
        name: json['name'] == null ? null : LangModel.fromMap(json['name']),
        description: json['description'],
        coverId: json['coverId'],
        tags: json['tags'] == null ? [] : List<String>.from(json['tags']!.map((x) => x)),
        isDefault: json['isDefault'],
        isPublish: json['isPublish'],
        createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
        coverImageUrl: json['coverImageUrl'],
        emojiItems: json['emojiItems'] == null
            ? []
            : List<BookmarkItemModel>.from(json['emojiItems']!.map((x) => BookmarkItemModel.fromMap(x))),
      );

  @override
  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name?.toMap(),
        'description': description,
        'coverId': coverId,
        'tags': tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        'isDefault': isDefault,
        'isPublish': isPublish,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'coverImageUrl': coverImageUrl,
        'emojiItems': emojiItems == null ? [] : List<dynamic>.from(emojiItems!.map((x) => x.toMap())),
      };
}
