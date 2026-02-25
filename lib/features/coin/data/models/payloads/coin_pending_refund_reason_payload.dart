import 'package:flutter/foundation.dart';
import 'package:uchat/features/coin/data/models/models/coin_pending_refund_reason_model.dart';

@immutable
class CoinPendingRefundReasonRequest {
  final int pageSize;
  final int page;

  const CoinPendingRefundReasonRequest({required this.pageSize, required this.page});

  Map<String, dynamic> toMap() {
    return {
      'pageSize': pageSize,
      'page': page,
    };
  }
}

@immutable
class CoinPendingRefundReasonResponse {
  final List<CoinPendingRefundReasonModel> rows;
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  const CoinPendingRefundReasonResponse({
    required this.rows,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory CoinPendingRefundReasonResponse.fromMap(Map<String, dynamic> json) {
    var rows = (json['rows'] as List).map((row) => CoinPendingRefundReasonModel.fromMap(row)).toList();

    return CoinPendingRefundReasonResponse(
      rows: rows,
      total: json['total'],
      page: json['page'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
    );
  }
}
