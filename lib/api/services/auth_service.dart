import 'package:uchat/api/backend_path.dart';
import 'package:uchat/api/http.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/api/payloads.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/auth/data/models/responses/verify_otp_response.dart';

final _log = useLogger();

@Deprecated('Use AuthApiServiceNew instead')
class AuthService with ServiceMixin {
  /// Singleton pattern
  static final AuthService instance = AuthService._internal();

  factory AuthService() => instance;

  AuthService._internal();

  Future<VerifyOtpResponse?> verifyOTP(VerifyOTPRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.authVerifyOtp.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<VerifyOtpResponse>(
      (data) => VerifyOtpResponse.fromMap(data),
    );
  }

  Future<void> logout() async {
    if (socketCaller.isReadyForCall) {
      try {
        await socketCaller.emitCall(BackendPath.logout.socket, null);

        return;
      } on ApiException catch (_) {
        rethrow;
      } catch (e, stackTrace) {
        _log.w('logout with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await httpCaller.post(
      BackendPath.logout.http,
    );
  }

  Future<VerifyDebugPasscodeResponse?> verifyDebugPasscode(
    VerifyDebugPasscodeRequest request,
  ) async {
    final httpResp = await httpCaller.post(
      BackendPath.verifyDebugPasscode.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<VerifyDebugPasscodeResponse>(
      (data) => VerifyDebugPasscodeResponse.fromMap(data),
    );
  }

  Future<RequestOTPResponse?> checkUserExist(CheckUserExistRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.authUserCheck.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3<RequestOTPResponse>(
      (data) => RequestOTPResponse.fromMap(data),
    );
  }

  Future<RequestOTPResponse?> checkPassword(CheckUserExistWithPasswordRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.authUserCheck.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3<RequestOTPResponse>(
      (data) => RequestOTPResponse.fromMap(data),
    );
  }

  Future<RequestOTPResponse?> selectOtpType(AuthSelectOtpTypeRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.authSelectOtpType.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<RequestOTPResponse>(
      (data) => RequestOTPResponse.fromMap(data),
    );
  }

  Future<RequestOTPResponse?> signIn(AuthSignInRequest request) async {
    final response = await httpCaller.post(
      BackendPath.signIn.http,
      data: request.toMap(),
    );

    return response.mapToResponse<RequestOTPResponse>(
      (data) => RequestOTPResponse.fromMap(data),
    );
  }

  Future<bool> officialAccountQRSignInVerifyToken(OAQRVerifyTokenRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final resp = await socketCaller.emitCall(
          BackendPath.officialAccountQRSignInVerifyToken.socket,
          request.toMap(),
        );
        return resp.data;
      } on ApiException catch (_) {
        rethrow;
      } catch (e, stackTrace) {
        _log.w('officialAccountQRSignInVerifyToken with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final resp = await httpCaller.post(
      BackendPath.officialAccountQRSignInVerifyToken.http,
      data: request.toMap(),
    );

    return resp.data;
  }
}
