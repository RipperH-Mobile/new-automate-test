import 'package:flutter/foundation.dart';

@immutable
class CoinTransactionRefundEntity {
  final int? appAppleId;
  final String? signedTransactionInfo;

  const CoinTransactionRefundEntity({
    this.appAppleId,
    this.signedTransactionInfo,
  });

  factory CoinTransactionRefundEntity.fromMap(Map<String, dynamic> map) {
    return CoinTransactionRefundEntity(
      appAppleId: map['appAppleId'] ?? 0,
      signedTransactionInfo: map['signedTransactionInfo'] ?? '',
    );
  }
}
