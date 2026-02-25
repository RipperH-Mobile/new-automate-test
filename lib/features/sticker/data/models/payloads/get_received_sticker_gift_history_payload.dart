import 'package:flutter/foundation.dart';
import 'package:uchat/utils/datetime.dart';

@immutable
class GetReceivedStickerGiftHistoryRequest {
  final DateTime? nextCursor;
  final int? limit;

  const GetReceivedStickerGiftHistoryRequest({
    this.nextCursor,
    this.limit = 20,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'type': 'GIFT',
    };
    if (nextCursor != null) {
      data['nextCursor'] = nextCursor!.toIso8601String();
    }
    if (limit != null) {
      data['limit'] = limit;
    }

    return data;
  }
}

@immutable
class GetReceivedStickerGiftHistoryResponse {
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
  final String type;
  final String giftById;
  final String giftBy;

  const GetReceivedStickerGiftHistoryResponse({
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
    required this.type,
    required this.giftById,
    required this.giftBy,
  });

  static List<GetReceivedStickerGiftHistoryResponse> fromJson(List<Map<String, dynamic>> dataList) {
    List<GetReceivedStickerGiftHistoryResponse> result = [];
    for (final data in dataList) {
      List<String> tags = [];
      if (data['tag'] is List) {
        tags = List<String>.from(data['tag']);
      }
      result.add(GetReceivedStickerGiftHistoryResponse(
        packId: data['_id'],
        packName: data['name'],
        packCoverId: data['coverId'],
        description: data['description'],
        tags: tags,
        isDefault: data['isDefault'],
        isPublish: data['isPublish'],
        createdAt: strToDateTime(data['createdAt'])!,
        updatedAt: strToDateTime(data['updatedAt'])!,
        publisher: data['publisher'],
        price: data['price'],
        receivedAt: strToDateTime(data['receivedAt'])!,
        type: data['type'],
        giftById: data['giftById'],
        giftBy: data['giftBy'],
      ));
    }
    return result;
  }
}
