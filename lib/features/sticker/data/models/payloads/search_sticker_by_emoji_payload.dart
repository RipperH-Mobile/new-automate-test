import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';

@immutable
class SearchStickerByEmojiResponse {
  final List<StickerEntity> stickerList;

  const SearchStickerByEmojiResponse({required this.stickerList});

  factory SearchStickerByEmojiResponse.fromList(List<dynamic> data) {
    List<StickerEntity> stickerList = [];
    for (Map<String, dynamic> pack in data) {
      for (Map<String, dynamic> sticker in pack['stickerItems']) {
        final StickerEntity stickerObj = StickerEntity.fromMap(sticker).copyWith(
          isOwner: pack['isOwner'],
          packId: pack['_id'],
        );
        stickerList.add(stickerObj);
      }
    }
    return SearchStickerByEmojiResponse(stickerList: stickerList);
  }
}

@immutable
class SearchStickerByEmojiRequest {
  final String emoji;

  const SearchStickerByEmojiRequest({required this.emoji});

  Map<String, dynamic> toMap() {
    return {
      'emoji': emoji,
    };
  }
}
