// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/domain/abstracts/sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';
import 'package:uchat/utils/datetime.dart';

@immutable
class StoreStickerPackEntity implements StickerPackEntity {
  @override
  final String id;
  @override
  final String coverId;
  @override
  final String name;
  @override
  final String description;
  @override
  final List<String> tags;
  @override
  final bool isDefault;
  @override
  final bool isDownloaded;
  @override
  final bool isPublish;
  @override
  final bool deleted;
  @override
  final int popular;
  @override
  final double price;
  @override
  final bool recommend;
  @override
  final bool isOwner;
  @override
  final bool isFavorite;
  @override
  final String publisher;
  @override
  final int seq;
  @override
  final DateTime? expireAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? favouriteAt;
  @override
  final List<StickerEntity> stickerItems;
  @override
  final int amountOfItems;
  // Whether the sticker pack has an expiration date which is start counting from when user buy or get this pack.
  // On server side this is a pack with expireIn field and this pack will after some time after buying. (such as 1 year after buying)
  // Sticker pack that have a fixed expire date (such as 01/12/2025) is not included and isSetExpire will be false in that case.
  @override
  final bool isSetExpire;

  const StoreStickerPackEntity({
    required this.id,
    required this.coverId,
    required this.name,
    this.description = '',
    this.stickerItems = const [],
    this.tags = const [],
    this.isDefault = false,
    this.isDownloaded = false,
    this.isPublish = true,
    this.deleted = false,
    this.popular = 0,
    this.price = 0.0,
    this.recommend = false,
    this.isOwner = false,
    this.isFavorite = false,
    this.publisher = 'UChat Company',
    this.seq = 0,
    this.expireAt,
    this.createdAt,
    this.updatedAt,
    this.favouriteAt,
    this.amountOfItems = 0,
    this.isSetExpire = false,
  });

  StoreStickerPackEntity copyWith({
    String? id,
    String? coverId,
    String? name,
    String? description,
    List<String>? tags,
    bool? isDefault,
    bool? isDownloaded,
    bool? isPublish,
    bool? deleted,
    int? popular,
    double? price,
    bool? recommend,
    bool? isOwner,
    bool? isFavorite,
    String? publisher,
    int? seq,
    DateTime? expireAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? favouriteAt,
    List<StickerEntity>? stickerItems,
    int? amountOfItems,
    bool? isSetExpire,
  }) {
    return StoreStickerPackEntity(
      id: id ?? this.id,
      coverId: coverId ?? this.coverId,
      name: name ?? this.name,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      isDefault: isDefault ?? this.isDefault,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isPublish: isPublish ?? this.isPublish,
      deleted: deleted ?? this.deleted,
      popular: popular ?? this.popular,
      price: price ?? this.price,
      recommend: recommend ?? this.recommend,
      isOwner: isOwner ?? this.isOwner,
      isFavorite: isFavorite ?? this.isFavorite,
      publisher: publisher ?? this.publisher,
      seq: seq ?? this.seq,
      expireAt: expireAt ?? this.expireAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      favouriteAt: favouriteAt ?? this.favouriteAt,
      stickerItems: stickerItems ?? this.stickerItems,
      amountOfItems: amountOfItems ?? this.amountOfItems,
      isSetExpire: isSetExpire ?? this.isSetExpire,
    );
  }

  @override
  String toString() {
    return 'StoreStickerPackEntity(id: $id, coverId: $coverId, name: $name, description: $description, tags: $tags, isDefault: $isDefault, isDownloaded: $isDownloaded, isPublish: $isPublish, deleted: $deleted, popular: $popular, price: $price, recommend: $recommend, isOwner: $isOwner, isFavorite: $isFavorite, publisher: $publisher, seq: $seq, expireAt: $expireAt, createdAt: $createdAt, updatedAt: $updatedAt, favouriteAt: $favouriteAt, stickerItems: $stickerItems, amountOfItems: $amountOfItems, isSetExpire: $isSetExpire)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'coverId': coverId,
      'name': name,
      'description': description,
      'tags': tags,
      'isDefault': isDefault,
      'isDownloaded': isDownloaded,
      'isPublish': isPublish,
      'deleted': deleted,
      'popular': popular,
      'price': price,
      'recommend': recommend,
      'isOwner': isOwner,
      'isFavorite': isFavorite,
      'publisher': publisher,
      'seq': seq,
      'expireAt': expireAt?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'favouriteAt': favouriteAt?.millisecondsSinceEpoch,
      'stickerItems': stickerItems.map((x) => x.toMap()).toList(),
      'amountOfItems': amountOfItems,
      'isSetExpire': isSetExpire,
    };
  }

  factory StoreStickerPackEntity.fromMap(Map<String, dynamic> map) {
    List<StickerEntity> stickerList = [];
    if (map['stickerItems'] != null) {
      for (Map<String, dynamic> stickerData in map['stickerItems']) {
        stickerData['packId'] = map['_id'] ?? map['id'];
        stickerList.add(StickerEntity.fromMap(stickerData));
      }
    }

    return StoreStickerPackEntity(
      id: map['_id'] != null ? map['_id'] as String : '',
      coverId: map['coverId'] != null ? map['coverId'] as String : '',
      name: map['name'] != null ? map['name'] as String : '',
      description: map['description'] != null ? map['description'] as String : '',
      tags: List<String>.from((map['tags'] as List<dynamic>).map<String>((x) => x as String)),
      isDefault: map['isDefault'] != null ? map['isDefault'] as bool : false,
      isDownloaded: map['isDownloaded'] != null ? map['isDownloaded'] as bool : false,
      isPublish: map['isPublish'] != null ? map['isPublish'] as bool : true,
      deleted: map['deleted'] != null ? map['deleted'] as bool : false,
      popular: map['popular'] != null ? map['popular'] as int : 0,
      price: map['price'] != null ? (map['price'] as num).toDouble() : 0.0,
      recommend: map['recommend'] != null ? map['recommend'] as bool : false,
      isOwner: map['isOwner'] != null ? map['isOwner'] as bool : false,
      isFavorite: map['isFavourite'] != null ? map['isFavourite'] as bool : false,
      publisher: map['publisher'] != null ? map['publisher'] as String : 'UChat Company',
      seq: map['seq'] != null ? map['seq'] as int : 0,
      expireAt: map['expireAt'] != null ? strToDateTime(map['expireAt']) : null,
      createdAt: map['createdAt'] != null ? strToDateTime(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? strToDateTime(map['updatedAt']) : null,
      favouriteAt: map['favouriteAt'] != null ? strToDateTime(map['favouriteAt']) : null,
      stickerItems: stickerList,
      amountOfItems: map['amountOfItems'] != null ? map['amountOfItems'] as int : 0,
      isSetExpire: map['isSetExpire'] != null ? map['isSetExpire'] as bool : false,
    );
  }

  MyStickerPackEntity toMyStickerPack() {
    return MyStickerPackEntity(
      id: id,
      coverId: coverId,
      name: name,
      description: description,
      tags: tags,
      isDefault: isDefault,
      isDownloaded: isDownloaded,
      isPublish: isPublish,
      deleted: deleted,
      popular: popular,
      price: price,
      recommend: recommend,
      isOwner: isOwner,
      isFavorite: isFavorite,
      publisher: publisher,
      seq: seq,
      expireAt: expireAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      favouriteAt: favouriteAt,
      stickerItems: stickerItems,
      amountOfItems: amountOfItems,
      isSetExpire: isSetExpire,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreStickerPackEntity.fromJson(String source) =>
      StoreStickerPackEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant StoreStickerPackEntity other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
