import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_history_entity.dart';

@immutable
class FetchStickerHistoryResponse {
  final List<StickerHistoryEntity> items;
  final bool hasMore;
  final int totalFound;
  final String? nextCursor;

  const FetchStickerHistoryResponse({
    required this.items,
    this.hasMore = false,
    this.totalFound = 0,
    this.nextCursor,
  });

  factory FetchStickerHistoryResponse.fromMap(Map<String, dynamic> map) {
    List<StickerHistoryEntity> items = [];
    for (Map<String, dynamic> item in map['items'] ?? []) {
      final StickerHistoryEntity stickerHistory = StickerHistoryEntity.fromMap(item);
      items.add(stickerHistory);
    }

    return FetchStickerHistoryResponse(
      items: items,
      hasMore: map['hasMore'] ?? false,
      totalFound: map['totalFound'] ?? 0,
      nextCursor: map['nextCursor'] as String?,
    );
  }
}

@immutable
class FetchStickerHistoryRequest {
  final String type;
  final int limit;
  final DateTime? nextCursor;

  const FetchStickerHistoryRequest({
    this.type = 'SELF',
    this.limit = 20,
    this.nextCursor,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{
      'type': type,
      'limit': limit,
    };

    if (nextCursor != null) {
      data['nextCursor'] = nextCursor!.toIso8601String();
    }

    return data;
  }
}
