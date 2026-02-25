// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:uchat/features/coin/data/models/models/coin_transaction_meta_model.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_entity.dart';
import 'package:uchat/features/coin/domain/enums/coin_transaction_type.dart';

@immutable
class CoinTransactionModel {
  final String id;
  final String accountId;
  final CoinTransactionType type;
  final String item;
  final String orderId;
  final String coinPlatform;
  final int balanceBefore;
  final int balanceAfter;
  final int? bonus;
  final int amount;
  final DateTime createdAt;
  final CoinTransactionMetaModel? meta;

  const CoinTransactionModel({
    required this.id,
    required this.accountId,
    required this.type,
    required this.item,
    required this.orderId,
    required this.coinPlatform,
    required this.balanceBefore,
    required this.balanceAfter,
    this.bonus,
    required this.amount,
    required this.createdAt,
    this.meta,
  });

  factory CoinTransactionModel.fromMap(Map<String, dynamic> map) {
    return CoinTransactionModel(
      id: map['_id'],
      accountId: map['accountId'],
      type: CoinTransactionType.from(map['type'])!,
      item: map['item'],
      orderId: map['orderId'],
      coinPlatform: map['coinPlatform'],
      balanceBefore: map['balanceBefore'] ?? 0,
      balanceAfter: map['balanceAfter'] ?? 0,
      bonus: map['bonus'],
      amount: map['amount'],
      createdAt: DateTime.parse(map['createdAt']),
      meta: map['meta'] != null ? CoinTransactionMetaModel.fromMap(map['meta']) : null,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CoinTransactionModel && id == other.id && orderId == other.orderId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ orderId.hashCode;
  }

  @override
  String toString() {
    return 'CoinTransactionModel(id: $id, accountId: $accountId, type: $type, item: $item, orderId: $orderId, coinPlatform: $coinPlatform, balanceBefore: $balanceBefore, balanceAfter: $balanceAfter, bonus: $bonus, amount: $amount, createdAt: $createdAt, meta: $meta)';
  }

  CoinTransactionEntity toEntity() {
    return CoinTransactionEntity(
      id: id,
      accountId: accountId,
      type: type,
      item: item,
      orderId: orderId,
      coinPlatform: coinPlatform,
      balanceBefore: balanceBefore,
      balanceAfter: balanceAfter,
      bonus: bonus,
      amount: amount,
      createdAt: createdAt,
      meta: meta?.toEntity(),
    );
  }
}
