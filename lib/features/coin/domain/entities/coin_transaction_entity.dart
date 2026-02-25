import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_meta_entity.dart';
import 'package:uchat/features/coin/domain/enums/coin_transaction_type.dart';
import 'package:uchat/utils/date.dart';

@immutable
class CoinTransactionEntity {
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
  final CoinTransactionMetaEntity? meta;

  const CoinTransactionEntity({
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

  factory CoinTransactionEntity.fromMap(Map<String, dynamic> map) {
    return CoinTransactionEntity(
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
      meta: map['meta'] != null ? CoinTransactionMetaEntity.fromMap(map['meta']) : null,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CoinTransactionEntity && id == other.id && orderId == other.orderId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ orderId.hashCode;
  }

  @override
  String toString() {
    return 'CoinTransactionModel(id: $id, accountId: $accountId, type: $type, item: $item, orderId: $orderId, coinPlatform: $coinPlatform, balanceBefore: $balanceBefore, balanceAfter: $balanceAfter, bonus: $bonus, amount: $amount, createdAt: $createdAt, meta: $meta)';
  }

  String get datetime {
    return createdAt.toLocal().format('dd/MM/yyyy - HH:mm');
  }

  String get title {
    if (type == CoinTransactionType.spend) {
      if (meta?.type == 'GIFT') {
        return 'Sent sticker gift: @stickerName'.trParams({'stickerName': meta?.stickerName ?? 'UNKNOWN'.tr});
      } else {
        return 'Purchase sticker: @stickerName'.trParams({'stickerName': meta?.stickerName ?? 'UNKNOWN'.tr});
      }
    } else if (type == CoinTransactionType.refund) {
      return 'Refund coins'.tr;
    } else if (type == CoinTransactionType.topUp) {
      return 'Purchase coins'.tr;
    }

    return 'Unknown'.tr;
  }

  int get totalAmount {
    if (type == CoinTransactionType.topUp) {
      if (bonus != null && bonus! > 0) {
        return amount + bonus!;
      } else {
        return amount;
      }
    }

    return amount;
  }
}
