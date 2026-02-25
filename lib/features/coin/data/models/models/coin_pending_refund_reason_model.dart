import 'package:flutter/foundation.dart';

@immutable
class CoinPendingRefundReasonModel {
  final String id;
  final int amount;

  const CoinPendingRefundReasonModel({required this.id, required this.amount});

  factory CoinPendingRefundReasonModel.fromMap(Map<String, dynamic> map) {
    return CoinPendingRefundReasonModel(
      id: map['_id'],
      amount: map['amount'],
    );
  }
}
