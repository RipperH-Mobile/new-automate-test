// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:uchat/utils/datetime.dart';

@immutable
class StickerEntity {
  final String id;
  final String packId;
  final String fileId;
  final String emoji;
  final DateTime? createdAt;
  final DateTime? lastUsedAt;
  final bool isOwner;

  const StickerEntity({
    required this.id,
    required this.packId,
    required this.fileId,
    this.emoji = '',
    this.createdAt,
    this.lastUsedAt,
    this.isOwner = false,
  });

  @override
  String toString() {
    return 'StickerEntity(id: $id, packId: $packId, fileId: $fileId, emoji: $emoji, createdAt: $createdAt, lastUsedAt: $lastUsedAt, isOwner: $isOwner)';
  }

  @override
  bool operator ==(covariant StickerEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.packId == packId && other.fileId == fileId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ packId.hashCode ^ fileId.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'packId': packId,
      'fileId': fileId,
      'emoji': emoji,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'lastUsedAt': lastUsedAt?.millisecondsSinceEpoch,
      'isOwner': isOwner,
    };
  }

  factory StickerEntity.fromMap(Map<String, dynamic> map) {
    return StickerEntity(
      id: map['_id'] != null ? map['_id'] as String : map['id'] as String,
      packId: map['packId'] != null ? map['packId'] as String : '',
      fileId: map['fileId'] != null ? map['fileId'] as String : '',
      emoji: map['emoji'] != null ? map['emoji'] as String : '',
      createdAt: map['createdAt'] != null ? strToDateTime(map['createdAt']) : null,
      lastUsedAt: map['lastUsedAt'] != null ? strToDateTime(map['lastUsedAt']) : null,
      isOwner: map['isOwner'] != null ? map['isOwner'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory StickerEntity.fromJson(String source) => StickerEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  StickerEntity copyWith({
    String? id,
    String? packId,
    String? fileId,
    String? emoji,
    DateTime? createdAt,
    DateTime? lastUsedAt,
    bool? isOwner,
  }) {
    return StickerEntity(
      id: id ?? this.id,
      packId: packId ?? this.packId,
      fileId: fileId ?? this.fileId,
      emoji: emoji ?? this.emoji,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      isOwner: isOwner ?? this.isOwner,
    );
  }
}
