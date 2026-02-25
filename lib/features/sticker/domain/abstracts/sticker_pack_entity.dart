import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';

@immutable
abstract class StickerPackEntity {
  final String id;
  final String name;
  final String description;
  final String coverId;
  final List<StickerEntity> stickerItems;
  final List<String> tags;
  final bool isDefault;
  final bool isDownloaded;
  final bool isPublish;
  final bool deleted;
  final int popular;
  final double price;
  final bool recommend;
  final bool isOwner;
  final bool isFavorite;
  final String publisher;
  final int seq;
  final DateTime? expireAt;
  final DateTime? favouriteAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int amountOfItems;

  // Whether the sticker pack has an expiration date which is start counting from when user buy or get this pack.
  // On server side this is a pack with expireIn field and this pack will after some time after buying. (such as 1 year after buying)
  // Sticker pack that have a fixed expire date (such as 01/12/2025) is not included and isSetExpire will be false in that case.
  final bool isSetExpire;

  const StickerPackEntity({
    required this.id,
    required this.name,
    required this.coverId,
    this.description = '',
    this.tags = const [],
    this.stickerItems = const [],
    this.isDefault = false,
    this.isDownloaded = false,
    this.isPublish = true,
    this.deleted = false,
    this.popular = 0,
    this.price = 0.0,
    this.recommend = false,
    this.isOwner = false,
    this.isFavorite = false,
    this.publisher = '',
    this.seq = 0,
    this.expireAt,
    this.favouriteAt,
    this.createdAt,
    this.updatedAt,
    this.amountOfItems = 0,
    this.isSetExpire = false,
  });

  @override
  bool operator ==(covariant StickerPackEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.coverId == coverId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ coverId.hashCode;
  }
}
