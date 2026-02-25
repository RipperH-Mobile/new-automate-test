import 'package:uchat/api/payloads/pagination/pagination_payload.dart';

// import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/coin/data/data_sources/remote/coin_http_data_source.dart';
import 'package:uchat/features/coin/data/data_sources/remote/coin_socket_data_source.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_package_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_pending_refund_reason_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_refund_reason_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_transaction_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/coin_update_payload.dart';
import 'package:uchat/features/coin/data/models/payloads/verify_purchase_payload.dart';
import 'package:uchat/features/coin/domain/entities/coin_entity.dart';
import 'package:uchat/features/coin/domain/entities/coin_package_entity.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_entity.dart';
import 'package:uchat/features/coin/domain/repositories/coin_remote_repository.dart';
// import 'package:uchat/utils/app_env.dart';

final _log = useLogger();

class CoinRemoteRepositoryImpl implements CoinRemoteRepository {
  final CoinHttpDataSource httpDataSource;
  final CoinSocketDataSource socketDataSource;

  CoinRemoteRepositoryImpl({
    required this.httpDataSource,
    required this.socketDataSource,
  });

  @override
  Future<List<CoinPackageEntity>> getCoinPackages(CoinPackageRequest request) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.getCoinPackages(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('Error fetching coin packages from socket', e, stackTrace);
      }
    }

    return await httpDataSource.getCoinPackages(request);
  }

  @override
  Future<CoinEntity?> getMyCoin() async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.getMyCoin();
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('Error fetching my coin from socket', e, stackTrace);
      }
    }

    return await httpDataSource.getMyCoin();
  }

  @override
  Future<CoinPendingRefundReasonResponse?> fetchPendingRefundReasons(CoinPendingRefundReasonRequest request) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        final pagination = await socketDataSource.fetchPendingRefundReasons(request);
        if (pagination == null) {
          return null;
        }

        return CoinPendingRefundReasonResponse(
          rows: pagination.data?.toList() ?? [],
          total: pagination.total,
          page: pagination.page,
          pageSize: pagination.pageSize,
          totalPages: pagination.totalPages,
        );
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('Error fetching pending refund reasons from socket', e, stackTrace);
      }
    }

    final pagination = await httpDataSource.fetchPendingRefundReasons(request);

    if (pagination == null) {
      return null;
    }

    return CoinPendingRefundReasonResponse(
      rows: pagination.data?.toList() ?? [],
      total: pagination.total,
      page: pagination.page,
      pageSize: pagination.pageSize,
      totalPages: pagination.totalPages,
    );
  }

  @override
  Future<PaginationPayload<CoinTransactionEntity>?> getTransactions(CoinTransactionRequest request) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.getTransactions(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('Error fetching transactions from socket', e, stackTrace);
      }
    }

    return httpDataSource.getTransactions(request);
  }

  @override
  Future<void> sendCoinRefundReason(CoinRefundReasonRequest request) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.sendCoinRefundReason(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('Error sending coin refund reason from socket', e, stackTrace);
      }
    }

    return httpDataSource.sendCoinRefundReason(request);
  }

  @override
  Future<CoinUpdateResponse?> verifyPurchaseAndroid(VerifyPurchaseAndroidRequest request) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.verifyPurchaseAndroid(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('Error verifying purchase from socket', e, stackTrace);
      }
    }

    return httpDataSource.verifyPurchaseAndroid(request);
  }

  @override
  Future<CoinUpdateResponse?> verifyPurchaseApple(VerifyPurchaseAppleRequest request) async {
    /// Check if Apple receipt is in sandbox mode from app side (Temporary)
    // if (AppEnv.isProd) {
    //   try {
    //     final checkSandBox = await httpDataSource.validateReceiptApple(
    //       request.serverVerificationData ?? '',
    //       isSandbox: true,
    //     );
    //     _log.d('verifyPurchase with AppleReceiptValidator: $checkSandBox');
    //
    //     if (checkSandBox['environment'].toString().toLowerCase() == 'sandbox') {
    //       throw ApiException(
    //         type: 'ERR_APPLE_RECEIPT_SANDBOX',
    //         message: 'Apple receipt is in sandbox mode but server is in production',
    //       );
    //     }
    //   } catch (e) {
    //     final currentUser = UserController.instance.currentUser.value;
    //     final userName = currentUser?.username ?? 'Unknown username';
    //     final displayName = currentUser?.displayName ?? 'Unknown display name';
    //     _log.e(
    //       'Apple receipt is in sandbox mode but server is in production. username: $userName, displayName: $displayName',
    //       e,
    //     );
    //     throw ApiException(
    //       type: 'ERR_APPLE_RECEIPT_SANDBOX',
    //       message: 'Apple receipt is in sandbox mode but server is in production',
    //     );
    //   }
    // }

    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.verifyPurchaseApple(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('Error verifying purchase from socket', e, stackTrace);
      }
    }

    return httpDataSource.verifyPurchaseApple(request);
  }
}
