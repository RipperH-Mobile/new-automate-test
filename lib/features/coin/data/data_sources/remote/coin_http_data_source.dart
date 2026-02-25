import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
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

class CoinHttpDataSource {
  final HttpCaller httpCaller;

  CoinHttpDataSource({
    required this.httpCaller,
  });

  Future<Map<String, dynamic>> validateReceiptApple(String receiptData, {bool isSandbox = false}) async {
    final String appleVerifyUrl = 'https://buy.itunes.apple.com/verifyReceipt'; // Production
    final String sandboxVerifyUrl = 'https://sandbox.itunes.apple.com/verifyReceipt'; // Sandbox

    final url = isSandbox ? sandboxVerifyUrl : appleVerifyUrl;

    final response = await httpCaller.post(
      url,
      options: Options(contentType: Headers.jsonContentType),
      data: {
        'receipt-data': receiptData,
        // 'password': 'your_shared_secret',  // Your shared secret for auto-renewable subscriptions
      },
      isExternalApi: true,
    );

    if (response.statusCode == 200) {
      // Successfully received a response
      return json.decode(response.data);
    } else {
      // Error
      throw Exception('Failed to validate receipt');
    }
  }

  /// Send verification data from Play store to backend to verify whether
  /// this purchase is valid.
  /// Return [CoinUpdateResponse] with updated coin data if purchase is valid.
  /// Otherwise return null.
  Future<CoinUpdateResponse?> verifyPurchaseAndroid(VerifyPurchaseAndroidRequest request) async {
    final httpResp = await httpCaller.post(
      CoinBackendPath.verifyPurchaseAndroid.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3<CoinUpdateResponse>(
      (data) => CoinUpdateResponse.fromMap(data),
    );
  }

  /// Send verification data from App Store to backend to verify whether
  /// this purchase is valid.
  /// Return [CoinUpdateResponse] with updated coin data if purchase is valid.
  /// Otherwise return null.
  Future<CoinUpdateResponse?> verifyPurchaseApple(VerifyPurchaseAppleRequest request) async {
    final httpResp = await httpCaller.post(
      CoinBackendPath.verifyPurchaseApple.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3(
      (data) => CoinUpdateResponse.fromMap(data),
    );
  }

  Future<CoinEntity?> getMyCoin() async {
    final httpResp = await httpCaller.get(CoinBackendPath.getMyCoins.http);
    return httpResp.mapToResponseV3((data) => CoinEntity.fromMap(data));
  }

  Future<List<CoinPackageEntity>> getCoinPackages(CoinPackageRequest request) async {
    final httpResp = await httpCaller.get(
      CoinBackendPath.getCoinPackages.http.replaceAll(':platform', request.platform),
    );

    return httpResp.listToResponseV3((data) => CoinPackageEntity.fromMap(data))?.toList() ?? [];
  }

  Future<PaginationPayload<CoinTransactionEntity>?> getTransactions(CoinTransactionRequest request) async {
    final httpResp = await httpCaller.get(
      CoinBackendPath.getTransactions.http,
      queryParameters: request.toMap(),
    );

    return httpResp.mapToResponse(
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
    final httpResp = await httpCaller.get(
      CoinBackendPath.getPendingRefundReason.http,
      queryParameters: request.toMap(),
    );

    return httpResp.mapToResponse(
      (data) => PaginationPayload.fromMapV3(data, listMapper: (item) {
        return item.map((e) => CoinPendingRefundReasonModel.fromMap(e));
      }),
    );
  }

  Future<void> sendCoinRefundReason(CoinRefundReasonRequest request) async {
    await httpCaller.post(
      CoinBackendPath.sendCoinRefundReason.http,
      data: request.toMap(),
    );
  }
}
