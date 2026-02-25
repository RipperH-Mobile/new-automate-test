import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/features/coin/data/data_sources/remote/backend_path.dart';
import 'package:uchat/features/coin/data/models/models/coin_pending_refund_reason_model.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_package_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_pending_refund_reason_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_refund_reason_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_transaction_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_update_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/verify_purchase_payload.dart';
import 'package:uchat/features/coin/domain/entities/coin_entity.dart';
import 'package:uchat/features/coin/domain/entities/coin_package_entity.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_entity.dart';

class CoinSocketDataSource {
  final SocketCaller socketCaller;

  CoinSocketDataSource({required this.socketCaller});

  /// Send verification data from Play store to backend to verify whether
  /// this purchase is valid.
  /// Return [CoinUpdateResponse] with updated coin data if purchase is valid.
  /// Otherwise return null.
  Future<CoinUpdateResponse?> verifyPurchaseAndroid(VerifyPurchaseAndroidRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      CoinBackendPath.verifyPurchaseAndroid.socket,
      request.toMap(),
      timeout: const Duration(seconds: 60),
    );

    return socketResp.mapToResponseV3<CoinUpdateResponse>((data) => CoinUpdateResponse.fromMap(data));
  }

  /// Send verification data from App Store to backend to verify whether
  /// this purchase is valid.
  /// Return [CoinUpdateResponse] with updated coin data if purchase is valid.
  /// Otherwise return null.
  Future<CoinUpdateResponse?> verifyPurchaseApple(VerifyPurchaseAppleRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      CoinBackendPath.verifyPurchaseApple.socket,
      request.toMap(),
      timeout: const Duration(seconds: 60),
    );

    return socketResp.mapToResponseV3((data) => CoinUpdateResponse.fromMap(data));
  }

  Future<CoinEntity?> getMyCoin() async {
    final socketResp = await socketCaller.emitCallV3(CoinBackendPath.getMyCoins.socket, {});
    return socketResp.mapToResponseV3((data) => CoinEntity.fromMap(data));
  }

  Future<List<CoinPackageEntity>> getCoinPackages(CoinPackageRequest request) async {
    final socketResp = await socketCaller.emitCallV3(CoinBackendPath.getCoinPackages.socket, request.toMap());
    return socketResp.listToResponseV3((data) => CoinPackageEntity.fromMap(data))?.toList() ?? [];
  }

  Future<PaginationPayload<CoinTransactionEntity>?> getTransactions(CoinTransactionRequest request) async {
    final socketResp = await socketCaller.emitCallV3(CoinBackendPath.getTransactions.socket, request.toMap());
    return socketResp.mapToResponse(
      (data) => PaginationPayload<CoinTransactionEntity>.fromMapV3(
        data,
        listMapper: (item) {
          return item.map((e) => CoinTransactionEntity.fromMap(e));
        },
      ),
    );
  }

  Future<PaginationPayload<CoinPendingRefundReasonModel>?> fetchPendingRefundReasons(
      CoinPendingRefundReasonRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      CoinBackendPath.getPendingRefundReason.socket,
      request.toMap(),
      timeout: const Duration(seconds: 60),
    );

    return socketResp.mapToResponse((data) {
      return PaginationPayload<CoinPendingRefundReasonModel>.fromMapV3(data, listMapper: (item) {
        return item.map((e) => CoinPendingRefundReasonModel.fromMap(e));
      });
    });
  }

  Future<void> sendCoinRefundReason(CoinRefundReasonRequest request) async {
    await socketCaller.emitCallV3(CoinBackendPath.sendCoinRefundReason.socket, request.toMap());
  }
}
