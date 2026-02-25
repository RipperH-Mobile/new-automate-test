import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/data/models/payloads/coin_sticker_payload.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_buy_type.dart';

@immutable
class BuyStickerResponse {
  final CoinStickerResponse? coin;

  const BuyStickerResponse({
    this.coin,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coin': coin?.toMap(),
    };
  }

  factory BuyStickerResponse.fromMap(Map<String, dynamic> map) {
    return BuyStickerResponse(
      coin: map['coin'] != null ? CoinStickerResponse.fromMap(map['coin'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => toMap().toString();

  factory BuyStickerResponse.fromJson(String source) => BuyStickerResponse.fromMap(source as Map<String, dynamic>);
}

@immutable
class BuyStickerRequest {
  final String stickerId;
  final StickerBuyType type;

  const BuyStickerRequest({
    required this.stickerId,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    final currentPlatform = Platform.isIOS ? 'APPLE' : 'GOOGLE_PLAY';

    return <String, dynamic>{
      'stickerId': stickerId,
      'type': type.value,
      'platform': currentPlatform,
    };
  }
}
