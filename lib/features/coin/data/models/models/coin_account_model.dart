// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:uchat/features/coin/data/models/models/coin_model.dart';

@immutable
class CoinAccountModel {
  final CoinModel coin;
  final String? id;
  final String? accountId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CoinAccountModel({
    required this.coin,
    this.id,
    this.accountId,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coin': coin.toMap(),
      'id': id,
      'accountId': accountId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CoinAccountModel.fromMap(Map<String, dynamic> map) {
    final coinModel = CoinModel(
      globalCoin: map['globalCoin'],
      appleCoin: map['appleCoin'],
      googlePlayCoin: map['googlePlayCoin'],
      sandboxCoin: map['sandboxCoin'] as int? ?? 0,
    );

    return CoinAccountModel(
      coin: coinModel,
      id: map['_id'] != null ? map['_id'] as String : null,
      accountId: map['accountId'] != null ? map['accountId'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinAccountModel.fromJson(String source) =>
      CoinAccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CoinAccountModel other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  String toString() {
    return 'CoinAccountModel(coin: $coin, id: $id, accountId: $accountId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  int get coins {
    return coin.coins;
  }

  int get sandboxCoin {
    return coin.sandboxCoin;
  }
}
