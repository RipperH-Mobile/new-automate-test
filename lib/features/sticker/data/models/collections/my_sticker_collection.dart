import 'package:isar_community/isar.dart';
import 'package:uchat/features/sticker/data/models/collections/sticker_collection.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'my_sticker_collection.g.dart';

@Collection(accessor: 'myStickers')
@Name('MyStickers')
class MyStickerCollection {
  @Index(unique: true, replace: true)
  String id;

  Id get isarId => fastHash(id);

  @Index()
  String? name;

  String? description;

  String? coverId;

  final stickerItems = IsarLinks<StickerCollection>();

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
  int? seq;

  @Index()
  DateTime? expireAt;

  @Index()
  DateTime? favouriteAt;

  DateTime? receivedAt;

  MyStickerCollection({
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
    this.seq,
    this.expireAt,
    this.favouriteAt,
    this.receivedAt,
  });

  factory MyStickerCollection.fromEntity(MyStickerPackEntity entity) {
    return MyStickerCollection(
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
      seq: entity.seq,
      expireAt: entity.expireAt,
      favouriteAt: entity.favouriteAt,
      receivedAt: entity.receivedAt,
    );
  }

  MyStickerPackEntity toEntity() {
    return MyStickerPackEntity(
      id: id,
      name: name ?? '',
      description: description ?? '',
      coverId: coverId ?? '',
      tags: tags ?? [],
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDefault: isDefault ?? false,
      isDownloaded: isDownloaded ?? false,
      isPublish: isPublish ?? true,
      deleted: deleted ?? false,
      popular: popular ?? 0,
      price: price ?? 0.0,
      recommend: recommend ?? false,
      isOwner: isOwner ?? false,
      isFavorite: isFavorite ?? false,
      publisher: publisher ?? '',
      seq: seq ?? 0,
      expireAt: expireAt,
      favouriteAt: favouriteAt,
      stickerItems: stickerItems.map((e) => e.toEntity()).toList(),
      receivedAt: receivedAt,
    );
  }

  StoreStickerPackEntity toStoreEntity() {
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
      isPublish: isPublish ?? true,
      deleted: deleted ?? false,
      popular: popular ?? 0,
      price: price ?? 0.0,
      recommend: recommend ?? false,
      isOwner: isOwner ?? false,
      isFavorite: isFavorite ?? false,
      publisher: publisher ?? '',
    );
  }

  factory MyStickerCollection.fromStoreEntity(StoreStickerPackEntity entity) {
    final mySticker = MyStickerCollection(
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
      seq: entity.seq,
      expireAt: entity.expireAt,
      favouriteAt: entity.favouriteAt,
    );

    return mySticker;
  }

  @Index()
  int get orderNo {
    if (seq != null && seq! > 0) return seq!;
    // seq 0 means that this pack isn't sorted by user yet. In that case it should be after
    // the packs that have seq > 0 so high number is set here to move it to the end of the list.
    // This will cause a bug when someone has 10 million sticker packs, but we don't expect that to happen.
    return 9999999;
  }

  @Index()
  bool get isExpire {
    if (expireAt != null) {
      return DateTime.now().isAfter(expireAt!);
    }
    // If expireAt is null, This pack does not expire.
    return false;
  }

  @override
  bool operator ==(Object other) {
    return other is MyStickerCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'MyStickersCollection(id: $id, name: $name, description: $description, coverId: $coverId, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, favouriteAt: $favouriteAt , isDefault: $isDefault, isDownloaded: $isDownloaded, isPublish: $isPublish, deleted: $deleted, popular: $popular, price: $price, recommend: $recommend, isOwner: $isOwner, isFavorite: $isFavorite, publisher: $publisher)';
  }
}
