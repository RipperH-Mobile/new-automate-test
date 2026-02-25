import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_package_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_pending_refund_reason_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_refund_reason_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_transaction_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_update_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/verify_purchase_payload.dart';
import 'package:uchat/features/coin/domain/entities/coin_entity.dart';
import 'package:uchat/features/coin/domain/entities/coin_package_entity.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_entity.dart';

abstract class CoinRemoteRepository {
  Future<CoinUpdateResponse?> verifyPurchaseAndroid(VerifyPurchaseAndroidRequest request);

  Future<CoinUpdateResponse?> verifyPurchaseApple(VerifyPurchaseAppleRequest request);

  Future<CoinEntity?> getMyCoin();

  Future<List<CoinPackageEntity>> getCoinPackages(CoinPackageRequest request);

  Future<PaginationPayload<CoinTransactionEntity>?> getTransactions(CoinTransactionRequest request);

  Future<void> sendCoinRefundReason(CoinRefundReasonRequest request);

  Future<CoinPendingRefundReasonResponse?> fetchPendingRefundReasons(CoinPendingRefundReasonRequest request);
}
