import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

sealed class VerifyPasswordSettingAccountResponse {}

class VerifyPasswordSettingAccountUnable2faResponse extends VerifyPasswordSettingAccountResponse {
  final String actionToken;
  final AuthenticationActionType actionName;

  VerifyPasswordSettingAccountUnable2faResponse({
    required this.actionToken,
    required this.actionName,
  });

  factory VerifyPasswordSettingAccountUnable2faResponse.fromJson(Map<String, dynamic> map) {
    return VerifyPasswordSettingAccountUnable2faResponse(
      actionToken: map['actionToken'],
      actionName: AuthenticationActionType.from(map['actionName']),
    );
  }

  Map<String, dynamic> toJson() => {
        'actionToken': actionToken,
        'actionName': actionName.value,
      };

  VerifyPasswordSettingAccountUnable2faEntity toEntity() {
    return VerifyPasswordSettingAccountUnable2faEntity(
      actionToken: actionToken,
      actionName: actionName,
    );
  }
}

class VerifyPasswordSettingAccountEnable2faResponse extends VerifyPasswordSettingAccountResponse {
  final String? phoneNumber;
  final String? email;

  VerifyPasswordSettingAccountEnable2faResponse({
    this.phoneNumber,
    this.email,
  });

  factory VerifyPasswordSettingAccountEnable2faResponse.fromJson(Map<String, dynamic> map) {
    return VerifyPasswordSettingAccountEnable2faResponse(
      phoneNumber: map['phoneNumber'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'email': email,
      };

  VerifyPasswordSettingAccountEnable2faEntity toEntity() {
    return VerifyPasswordSettingAccountEnable2faEntity(
      phoneNumber: phoneNumber,
      email: email,
    );
  }
}
