import 'package:flutter/foundation.dart';
import 'package:uchat/features/coin/data/models/models/coin_transaction_model.dart';

@immutable
class CoinTransactionRequest {
  final DateTime? afterAt;
  final DateTime? beforeAt;
  final int? page;
  final int pageSize;
  final String platform;

  const CoinTransactionRequest({
    this.afterAt,
    this.beforeAt,
    this.page,
    this.pageSize = 20,
    required this.platform,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'beforeAt': beforeAt?.toUtc().toIso8601String() ?? DateTime.now().toUtc().toIso8601String(),
      'page': page,
      'pageSize': pageSize,
      'platform': platform,
    };

    if (afterAt != null) {
      json['afterAt'] = afterAt!.toIso8601String();
    }

    return json;
  }
}

@immutable
class CoinTransactionResponse {
  final List<CoinTransactionModel> transactions;
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  const CoinTransactionResponse({
    required this.transactions,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory CoinTransactionResponse.fromMap(Map<String, dynamic> map) {
    List<CoinTransactionModel> transactions = [];
    final List<dynamic> transactionsRows = map['rows'];

    for (final transactionRow in transactionsRows) {
      // Filter to remove all transaction without type. A transaction without a type is a transaction for which the
      // server hasn't received a webhook update from the App Store yet which mean that transaction isn't completed.
      if (transactionRow['type'] == null) {
        continue;
      }
      transactions.add(
        CoinTransactionModel.fromMap(transactionRow),
      );
    }

    return CoinTransactionResponse(
      transactions: transactions,
      total: map['total'],
      page: map['page'],
      pageSize: map['pageSize'],
      totalPages: map['totalPages'],
    );
  }
}
