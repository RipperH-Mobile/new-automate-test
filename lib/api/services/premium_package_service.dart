import 'dart:convert';

import 'package:uchat/api/backend_path.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/api/payloads/premium_package/ios_check_receipt_response.dart';
import 'package:uchat/api/payloads/premium_package/send_reason_cancel.dart';
import 'package:uchat/api/socket/socket_response.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections.dart';

import '../payloads.dart';

final _log = useLogger();

class PremiumPackageService with ServiceMixin {
  static final PremiumPackageService instance = PremiumPackageService._internal();

  factory PremiumPackageService() => instance;

  PremiumPackageService._internal();

  Future<List<PremiumPackageCollection>> getAllPremiumPackage() async {
    if (socketCaller.isReadyForCall) {
      SocketResponse? socketResp;
      try {
        socketResp = await socketCaller.emitCall(
          BackendPath.getAllPremiumPackage.socket,
          {},
        );

        return socketResp.data['rows']
            .map<PremiumPackageCollection>(
              (e) => PremiumPackageCollection.fromMap(e),
            )
            .toList();
      } catch (e, stackTrace) {
        _log.w('Socket emit error, fallback to http request.', e, stackTrace);
      }
    }

    try {
      final response = await httpCaller.get(
        BackendPath.getAllPremiumPackage.http,
      );

      final result = response.data['rows']
          .map<PremiumPackageCollection>(
            (e) => PremiumPackageCollection.fromMap(e),
          )
          .toList();

      return result;
    } catch (e, stackTrace) {
      _log.e('getAllPremiumPackage error.', e, stackTrace);
      rethrow;
    }
  }

  Future<PremiumPackageCollection> getPremiumPackageById(String id) async {
    try {
      //NOTE. If want to get by id , but for now is don't need
      final response = await httpCaller.get(
        BackendPath.getPremiumPackageById.http,
        data: id,
      );

      final responseJsonDecode = jsonDecode(response.data);

      final result = PremiumPackageCollection.fromMap(responseJsonDecode);

      return result;
    } catch (e, stackTrace) {
      _log.e('getPremiumPackageById error.', e, stackTrace);
      rethrow;
    }
  }

  Future<bool?> sendReview({required SendReviewRequest request}) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await socketCaller.emitCall(
          BackendPath.sendReview.socket,
          request.toMap(),
        );

        return response.data;
      } catch (e, stackTrace) {
        _log.w('sendReview with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.sendReview.http,
      data: request.toMap(),
    );

    return httpResp.data;
  }

  Future<bool?> sendRemindMeLater() async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await socketCaller.emitCall(
          BackendPath.sendRemindMeLater.socket,
          {},
        );

        return response.data;
      } catch (e, stackTrace) {
        _log.w('sendRemindMeLater with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.sendRemindMeLater.http,
    );

    return httpResp.data;
  }

  Future<bool?> sendReasonCancel({required SendReasonCancelRequest request}) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await socketCaller.emitCall(
          BackendPath.sendReasonForCancel.socket,
          request.toMap(),
        );

        return response.data;
      } catch (e, stackTrace) {
        _log.w('sendReview with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.sendReasonForCancel.http,
      data: request.toMap(),
    );

    return httpResp.data;
  }

  Future<IosCheckReceiptResponse> checkIOSReceiptSubscription({required String receipt}) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await socketCaller.emitCall(
          BackendPath.checkIOSReceiptSubscription.socket,
          {
            'receipt': receipt,
          },
        );

        return IosCheckReceiptResponse.fromMap(response.data);
      } catch (e, stackTrace) {
        _log.w('checkIOSReceiptSubscription with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.checkIOSReceiptSubscription.http,
      data: {
        'receipt': receipt,
      },
    );

    return IosCheckReceiptResponse.fromMap(httpResp.data);
  }
}
