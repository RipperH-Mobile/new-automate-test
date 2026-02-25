import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_received_sticker_gift_history_payload.dart';

@immutable
class StickerGiftReceivedEntity {
  final String packId;
  final String packName;
  final String packCoverId;
  final String description;
  final List<String> tags;
  final bool isDefault;
  final bool isPublish;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String publisher;
  final int price;
  final DateTime receivedAt;
  final String giftById;
  final String giftBy;

  const StickerGiftReceivedEntity({
    required this.packId,
    required this.packName,
    required this.packCoverId,
    required this.description,
    required this.tags,
    required this.isDefault,
    required this.isPublish,
    required this.createdAt,
    required this.updatedAt,
    required this.publisher,
    required this.price,
    required this.receivedAt,
    required this.giftById,
    required this.giftBy,
  });

  factory StickerGiftReceivedEntity.fromResponse(GetReceivedStickerGiftHistoryResponse response) {
    return StickerGiftReceivedEntity(
      packId: response.packId,
      packName: response.packName,
      packCoverId: response.packCoverId,
      description: response.description,
      tags: response.tags,
      isDefault: response.isDefault,
      isPublish: response.isPublish,
      createdAt: response.createdAt,
      updatedAt: response.updatedAt,
      publisher: response.publisher,
      price: response.price,
      receivedAt: response.receivedAt,
      giftById: response.giftById,
      giftBy: response.giftBy,
    );
  }

  StickerGiftReceivedEntity copyWith({
    String? packId,
    String? packName,
    String? packCoverId,
    String? description,
    List<String>? tags,
    bool? isDefault,
    bool? isPublish,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? publisher,
    int? price,
    DateTime? receivedAt,
    String? giftById,
    String? giftBy,
  }) {
    return StickerGiftReceivedEntity(
      packId: packId ?? this.packId,
      packName: packName ?? this.packName,
      packCoverId: packCoverId ?? this.packCoverId,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      isDefault: isDefault ?? this.isDefault,
      isPublish: isPublish ?? this.isPublish,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publisher: publisher ?? this.publisher,
      price: price ?? this.price,
      receivedAt: receivedAt ?? this.receivedAt,
      giftById: giftById ?? this.giftById,
      giftBy: giftBy ?? this.giftBy,
    );
  }
}
