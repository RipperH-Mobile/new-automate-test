import 'package:flutter/foundation.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_refund_entity.dart';

@immutable
class CoinTransactionRefundModel {
  final int? appAppleId;
  final String? signedTransactionInfo;

  const CoinTransactionRefundModel({
    this.appAppleId,
    this.signedTransactionInfo,
  });

  factory CoinTransactionRefundModel.fromMap(Map<String, dynamic> map) {
    return CoinTransactionRefundModel(
      appAppleId: map['appAppleId'] ?? 0,
      signedTransactionInfo: map['signedTransactionInfo'] ?? '',
    );
  }

  CoinTransactionRefundEntity toEntity() {
    return CoinTransactionRefundEntity(
      appAppleId: appAppleId,
      signedTransactionInfo: signedTransactionInfo,
    );
  }
}
