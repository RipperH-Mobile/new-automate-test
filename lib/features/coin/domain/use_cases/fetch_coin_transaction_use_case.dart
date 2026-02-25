import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_transaction_payload.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_entity.dart';
import 'package:uchat/features/coin/domain/repositories/coin_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

@immutable
class FetchCoinTransactionParams {
  final DateTime? afterAt;
  final DateTime? beforeAt;
  final int? page;
  final int pageSize;

  const FetchCoinTransactionParams({
    this.afterAt,
    this.beforeAt,
    this.page,
    this.pageSize = 20,
  });

  String _getPlatform(String os) {
    if (os == 'android') return 'GOOGLE_PLAY';
    if (os == 'ios') return 'APPLE';
    return '';
  }

  CoinTransactionRequest toRequest() {
    String platform = _getPlatform(Platform.operatingSystem);
    return CoinTransactionRequest(
      afterAt: afterAt,
      beforeAt: beforeAt,
      page: page,
      pageSize: pageSize,
      platform: platform,
    );
  }
}

class FetchCoinTransactionUseCase extends SimpleUseCase<(int, Set<CoinTransactionEntity>), FetchCoinTransactionParams> {
  final CoinRemoteRepository coinRemoteRepository;

  FetchCoinTransactionUseCase({
    required this.coinRemoteRepository,
  });

  @override
  Future<(int, Set<CoinTransactionEntity>)> call(FetchCoinTransactionParams params) async {
    final request = params.toRequest();
    final transactionsPagination = await coinRemoteRepository.getTransactions(request);

    final transactions = transactionsPagination?.data;
    final totalPages = transactionsPagination?.totalPages ?? 0;
    if (transactions == null) {
      return (0, <CoinTransactionEntity>{});
    }

    final transactionSet = transactions.toSet();
    return (totalPages, transactionSet);
  }
}
