import 'package:flutter/foundation.dart';
import 'package:uchat/features/coin/data/models/models/coin_account_model.dart';
import 'package:uchat/features/coin/data/models/models/coin_transaction_model.dart';

@immutable
class CoinUpdateResponse {
  final CoinTransactionModel transaction;
  final CoinAccountModel account;

  const CoinUpdateResponse({
    required this.transaction,
    required this.account,
  });

  factory CoinUpdateResponse.fromMap(Map<String, dynamic> map) {
    return CoinUpdateResponse(
      transaction: CoinTransactionModel.fromMap(map['coinTransaction']),
      account: CoinAccountModel.fromMap(map['coinAccount']),
    );
  }
}
