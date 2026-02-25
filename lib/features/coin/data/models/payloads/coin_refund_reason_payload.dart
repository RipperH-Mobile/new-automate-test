import 'package:flutter/foundation.dart';

@immutable
class CoinRefundReasonRequest {
  final String reason;
  final String transactionId;

  const CoinRefundReasonRequest({
    required this.reason,
    required this.transactionId,
  });

  Map<String, String> toMap() {
    return {
      'reason': reason,
      'transactionId': transactionId,
    };
  }
}
