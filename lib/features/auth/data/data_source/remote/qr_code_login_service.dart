import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uchat/api/api.dart';
import 'package:uchat/api/payloads/qr_code_login/update_qr_code_login_request.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class QrCodeLoginService {
  static final QrCodeLoginService instance = Get.find<QrCodeLoginService>();
  // static final QrCodeLoginService instance = QrCodeLoginService._internal();

  // factory QrCodeLoginService() => instance;

  // QrCodeLoginService._internal();

  final HttpCaller httpCaller;
  final SocketCaller socketCaller;

  QrCodeLoginService({
    required this.httpCaller,
    required this.socketCaller,
  });

  Future<bool?> postQrCodeLogin(UpdateQrCodeLoginRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await socketCaller.emitCall(
          'v2.accounts.checkQrLogin.post',
          request.toJson(),
        );

        return response.data;
      } catch (e, stackTrace) {
        _log.w('postQrCodeLogin error. fallback to http...', e, stackTrace);
      }
    }

    try {
      final httpResp = await httpCaller.post(
        'v2/users/check-qr-login',
        data: request.toJson(),
      );

      return httpResp.data;
    } catch (e, stackTrace) {
      _log.e('postQrCodeLogin error.', e, stackTrace);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTokenFromQrCodeLogin(UpdateQrCodeLoginRequest request) async {
    try {
      final httpResp = await httpCaller.post(
        'v2/users/qr-login',
        data: request.toJson(),
      );

      return httpResp.data;
    } catch (e, stackTrace) {
      _log.e('getTokenFromQrCodeLogin error.', e, stackTrace);
      rethrow;
    }
  }

  Future<String> getLocation() async {
    String ip = '';
    String region = '';

    try {
      final response = await http.get(Uri.parse('https://api64.ipify.org?format=json'));

      if (response.statusCode == 200) {
        ip = jsonDecode(response.body);
      }
    } catch (e, stackTrace) {
      _log.w('Warning: fetching public IP', e, stackTrace);
    }

    try {
      final response = await http.get(Uri.parse('https://ipinfo.io/json?token=$ip'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        region = data['region'];
      }
    } catch (e, stackTrace) {
      _log.e('Error: fetching IP geolocation', e, stackTrace);
    }

    return region;
  }
}
