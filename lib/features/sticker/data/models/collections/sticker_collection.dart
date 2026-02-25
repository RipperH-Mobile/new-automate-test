import 'package:isar_community/isar.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'sticker_collection.g.dart';

@Collection(accessor: 'stickers')
@Name('Sticker')
class StickerCollection {
  @Index(unique: true, replace: true)
  String id;

  Id get isarId => fastHash(id);

  @Index()
  String? packId;

  @Index()
  String? fileId;

  @Index(type: IndexType.value, caseSensitive: false)
  String? emoji;

  @Index()
  DateTime? createdAt;

  @Index()
  DateTime? lastUsedAt;

  StickerCollection({
    required this.id,
    required this.packId,
    required this.fileId,
    required this.emoji,
    this.createdAt,
    this.lastUsedAt,
  });

  factory StickerCollection.fromEntity(StickerEntity entity) {
    return StickerCollection(
      id: entity.id,
      packId: entity.packId,
      fileId: entity.fileId,
      emoji: entity.emoji,
      createdAt: entity.createdAt,
      lastUsedAt: entity.lastUsedAt,
    );
  }

  StickerEntity toEntity() {
    return StickerEntity(
      id: id,
      packId: packId!,
      fileId: fileId!,
      emoji: emoji ?? '',
      createdAt: createdAt,
      lastUsedAt: lastUsedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StickerCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'StickerCollection(id: $id, packId: $packId, fileId: $fileId, emoji: $emoji, createdAt: $createdAt, lastUsedAt: $lastUsedAt)';
  }
}
