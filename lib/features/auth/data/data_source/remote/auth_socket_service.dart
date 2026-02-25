import 'package:uchat/api/api.dart';
import 'package:uchat/features/auth/data/models/requests/multifactor_update_setting_request.dart';
import 'package:uchat/features/auth/data/models/requests/multifactor_validate_setting_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_email_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_new_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_email_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_password_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/responses/check_password_required_response.dart';
import 'package:uchat/features/auth/data/models/responses/multifactor_validate_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_otp_response.dart';
import 'package:uchat/features/auth/data/models/requests/delete_session_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_sessions_list_request.dart';
import 'package:uchat/features/auth/data/models/responses/get_sessions_list_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_password_setting_account_response.dart';

class AuthSocketService {
  final SocketCaller socketCaller;

  AuthSocketService({
    required this.socketCaller,
  });

  Future<CheckPasswordRequiredResponse?> checkPasswordRequired() async {
    final res = await socketCaller.emitCallV3(
      BackendPath.accountSettingCheckPasswordRequire.socket,
      null,
    );
    return res.mapToResponseV3((data) => CheckPasswordRequiredResponse.fromJson(data));
  }

  Future<void> deleteAccount(DeleteAccountRequest data) async {
    await socketCaller.emitCallV3(
      BackendPath.deleteAccount.socket,
      data.toMap(),
    );
  }

  Future<VerifyPasswordSettingAccountResponse?> verifyPasswordSettingAccount(
      VerifyPasswordSettingAccountRequest request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.accountSettingVerifyPassword.socket,
      request.toJson(),
    );
    final map = res.mapToResponseV3(
      (data) => data,
    );
    if (map == null) {
      return null;
    }

    if (map['actionToken'] != null) {
      return res.mapToResponseV3((data) => VerifyPasswordSettingAccountUnable2faResponse.fromJson(data));
    } else {
      return res.mapToResponseV3((data) => VerifyPasswordSettingAccountEnable2faResponse.fromJson(data));
    }
  }

  Future<void> validateNewEmailSettingAccount(ValidateNewEmailSettingAccountRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.accountSettingValidateNewEmail.socket,
      request.toJson(),
    );
  }

  Future<void> updateEmailSettingAccount(UpdateEmailSettingAccountRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.accountSettingUpdateEmail.socket,
      request.toJson(),
    );
  }

  Future<VerifyOtpResponse?> verifyOtpTwoFa(VerifyOtpSettingAccountRequest request) async {
    final response = await socketCaller.emitCallV3(
      BackendPath.verifyOtpTwoFa.socket,
      request.toJson(),
    );

    return response.mapToResponseV3((result) => VerifyOtpResponse.fromMap(result));
  }

  Future<void> validateNewPassword(ValidateNewPasswordRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.settingNewPasswordValidate.socket,
      request.toJson(),
    );
  }

  Future<void> updateNewPassword(UpdateNewPasswordRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.settingUpdateNewPassword.http,
      request.toJson(),
    );
  }

  Future<MultifactorValidateResponse?> multifactorValidate(
    MultifactorValidateSettingRequest request,
  ) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.settingMultifactorValidate.socket,
      request.toJson(),
    );

    final map = res.mapToResponseV3(
      (data) => data,
    );
    if (map == null) {
      return null;
    }

    if (map['isGetOtp'] != null) {
      return res.mapToResponseV3((data) => MultifactorValidateTurnOffResponse.fromJson(data));
    } else {
      return res.mapToResponseV3((data) => MultifactorValidateTurnOnResponse.fromJson(data));
    }
  }

  Future<void> multifactorUpdate(MultifactorUpdateSettingRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.settingMultifactorUpdate.socket,
      request.toJson(),
    );
  }

  Future<PaginationPayload<GetSessionsListResponse>?> getSessionsListResponse(
    GetSessionsListRequest request,
  ) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getSessionsList.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse((e) {
      return PaginationPayload<GetSessionsListResponse>.fromMapV3(
        e,
        listMapper: (data) {
          List<GetSessionsListResponse> dataList = [];
          for (final item in data) {
            dataList.add(GetSessionsListResponse.fromMap(item));
          }
          return dataList;
        },
      );
    });
  }

  Future<void> deleteSession(DeleteSessionRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.deleteSession.socket,
      request.toMap(),
    );
  }

  Future<void> deleteSessionsList(String request) async {
    await socketCaller.emitCallV3(
      BackendPath.deleteSessionsList.socket,
      {
        'actionToken': request,
      },
    );
  }
}
