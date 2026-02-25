// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

@immutable
class CoinEntity {
  /// Coins purchased from other sources. (ex: Stripe)
  final int globalCoin;

  /// Coins purchased from App store in app purchase.
  /// Can be used on iOS devices only.
  final int appleCoin;

  /// Coins purchased from Play store in app purchase.
  /// Can be used on Android devices only.
  final int googlePlayCoin;

  /// Coins used in sandbox mode.
  /// Can be used on both iOS and Android devices.
  final int sandboxCoin;

  const CoinEntity({
    required this.globalCoin,
    required this.appleCoin,
    required this.googlePlayCoin,
    required this.sandboxCoin,
  });

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'globalCoin': globalCoin,
      'appleCoin': appleCoin,
      'googlePlayCoin': googlePlayCoin,
      'sandboxCoin': sandboxCoin,
    };
  }

  factory CoinEntity.fromMap(Map<String, dynamic> map) {
    return CoinEntity(
      globalCoin: map['globalCoin'] as int,
      appleCoin: map['appleCoin'] as int,
      googlePlayCoin: map['googlePlayCoin'] as int,
      sandboxCoin: map['sandboxCoin'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinEntity.fromJson(String source) => CoinEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
