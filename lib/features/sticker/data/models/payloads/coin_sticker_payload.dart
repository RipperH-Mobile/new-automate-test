import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

@immutable
class CoinStickerResponse {
  final int globalCoin;
  final int googlePlayCoin;
  final int appleCoin;

  const CoinStickerResponse({
    required this.globalCoin,
    required this.googlePlayCoin,
    required this.appleCoin,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'globalCoin': globalCoin,
      'googlePlayCoin': googlePlayCoin,
      'appleCoin': appleCoin,
    };
  }

  factory CoinStickerResponse.fromMap(Map<String, dynamic> map) {
    return CoinStickerResponse(
      globalCoin: map['globalCoin'] as int,
      googlePlayCoin: map['googlePlayCoin'] as int,
      appleCoin: map['appleCoin'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinStickerResponse.fromJson(String source) =>
      CoinStickerResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Return [appleCoin] or [googlePlayCoin] based on the device os.
  int get platformCoin {
    if (Platform.isIOS) {
      return appleCoin;
    } else if (Platform.isAndroid) {
      return googlePlayCoin;
    }
    return 0;
  }

  /// Return sum of coins that this device can use.
  /// Use this value to show user in ui.
  int get coins {
    return globalCoin + platformCoin;
  }

  @override
  String toString() =>
      'CoinStickerResponse(globalCoin: $globalCoin, googlePlayCoin: $googlePlayCoin, appleCoin: $appleCoin)';
}
