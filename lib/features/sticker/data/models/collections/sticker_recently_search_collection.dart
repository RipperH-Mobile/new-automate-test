import 'package:isar_community/isar.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';

import 'package:uchat/utils/fast_hash.dart';

part 'sticker_recently_search_collection.g.dart';

@Collection(accessor: 'stickerRecentlySearches')
@Name('StickerRecentlySearch')
class StickerRecentlySearchCollection {
  @Index(unique: true, replace: true)
  String id;

  Id get isarId => fastHash(id);

  @Index()
  String? name;

  String? description;

  String? coverId;

  @Index(type: IndexType.value, caseSensitive: false)
  List<String>? tags;

  @Index()
  DateTime? createdAt;

  @Index()
  DateTime? updatedAt;

  @Index()
  bool? isDefault;

  @Index()
  bool? isDownloaded;

  @Index()
  bool? isPublish;

  bool? deleted;

  int? popular;

  @Index()
  double? price;

  @Index()
  bool? recommend;

  bool? isOwner;

  @Index()
  bool? isFavorite;

  @Index()
  String? publisher;

  @Index()
  DateTime? lastOpenedAt;

  StickerRecentlySearchCollection({
    required this.id,
    this.coverId,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.isDefault,
    this.name,
    this.description,
    this.isPublish,
    this.deleted,
    this.popular,
    this.price,
    this.recommend,
    this.isOwner,
    this.isFavorite,
    this.publisher,
    this.isDownloaded,
    this.lastOpenedAt,
  });

  StoreStickerPackEntity toEntity() {
    return StoreStickerPackEntity(
      id: id,
      name: name ?? '',
      description: description ?? '',
      coverId: coverId ?? '',
      tags: tags ?? [],
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDefault: isDefault ?? false,
      isDownloaded: isDownloaded ?? false,
      isPublish: isPublish ?? false,
      deleted: deleted ?? false,
      popular: popular ?? 0,
      price: price ?? 0.0,
      recommend: recommend ?? false,
      isOwner: isOwner ?? false,
      isFavorite: isFavorite ?? false,
      publisher: publisher ?? '',
    );
  }

  factory StickerRecentlySearchCollection.fromEntity(StoreStickerPackEntity entity) {
    return StickerRecentlySearchCollection(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      coverId: entity.coverId,
      tags: entity.tags,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDefault: entity.isDefault,
      isDownloaded: entity.isDownloaded,
      isPublish: entity.isPublish,
      deleted: entity.deleted,
      popular: entity.popular,
      price: entity.price,
      recommend: entity.recommend,
      isOwner: entity.isOwner,
      isFavorite: entity.isFavorite,
      publisher: entity.publisher,
    );
  }

  @override
  bool operator ==(covariant StickerRecentlySearchCollection other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  String toString() {
    return 'StickerRecentlySearchCollection(id: $id, name: $name, description: $description, coverId: $coverId, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, isDefault: $isDefault, isDownloaded: $isDownloaded, isPublish: $isPublish, deleted: $deleted, popular: $popular, price: $price, recommend: $recommend, isOwner: $isOwner, isFavorite: $isFavorite, publisher: $publisher, lastOpenedAt: $lastOpenedAt)';
  }
}
