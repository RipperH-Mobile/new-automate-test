import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uchat/utils/datetime.dart';

@immutable
class StickerHistoryEntity {
  final String id;
  final String name;
  final String description;
  final String coverId;
  final List<String> tags;
  final bool isDefault;
  final bool isPublish;
  final String publisher;
  final double price;
  final String type;
  final DateTime? receivedAt;
  final DateTime? expireAt;
  final String? giftById;
  final String? giftBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StickerHistoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.coverId,
    this.tags = const [],
    this.isDefault = false,
    this.isPublish = true,
    required this.publisher,
    this.price = 0.0,
    required this.type,
    this.receivedAt,
    this.expireAt,
    this.giftById,
    this.giftBy,
    this.createdAt,
    this.updatedAt,
  });

  @override
  bool operator ==(covariant StickerHistoryEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.receivedAt == receivedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ receivedAt.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'coverId': coverId,
      'tags': tags,
      'isDefault': isDefault,
      'isPublish': isPublish,
      'publisher': publisher,
      'price': price,
      'type': type,
      'receivedAt': receivedAt?.millisecondsSinceEpoch,
      'expireAt': expireAt?.millisecondsSinceEpoch,
      'giftById': giftById,
      'giftBy': giftBy,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory StickerHistoryEntity.fromMap(Map<String, dynamic> map) {
    return StickerHistoryEntity(
      id: map['_id'] != null ? map['_id'] as String : '',
      name: map['name'] != null ? map['name'] as String : '',
      description: map['description'] != null ? map['description'] as String : '',
      coverId: map['coverId'] != null ? map['coverId'] as String : '',
      tags: List<String>.from((map['tags'] as List<dynamic>).map<String>((x) => x as String)),
      isDefault: map['isDefault'] != null ? map['isDefault'] as bool : false,
      isPublish: map['isPublish'] != null ? map['isPublish'] as bool : true,
      publisher: map['publisher'] != null ? map['publisher'] as String : 'UChat Company',
      price: map['price'] != null ? (map['price'] as num).toDouble() : 0.0,
      type: map['type'] != null ? map['type'] as String : 'SELF',
      receivedAt: map['receivedAt'] != null ? strToDateTime(map['receivedAt']) : null,
      expireAt: map['expireAt'] != null ? strToDateTime(map['expireAt']) : null,
      giftById: map['giftById'] != null ? map['giftById'] as String : null,
      giftBy: map['giftBy'] != null ? map['giftBy'] as String : null,
      createdAt: map['createdAt'] != null ? strToDateTime(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? strToDateTime(map['updatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StickerHistoryEntity.fromJson(String source) =>
      StickerHistoryEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
