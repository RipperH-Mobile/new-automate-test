import 'package:uchat/features/auth/data/models/responses/verify_password_setting_account_response.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

abstract class VerifyPasswordSettingAccountEntity {}

class VerifyPasswordSettingAccountUnable2faEntity extends VerifyPasswordSettingAccountEntity {
  final String actionToken;
  final AuthenticationActionType actionName;

  VerifyPasswordSettingAccountUnable2faEntity({
    required this.actionToken,
    required this.actionName,
  });

  factory VerifyPasswordSettingAccountUnable2faEntity.fromResponse(
      VerifyPasswordSettingAccountUnable2faResponse response) {
    return VerifyPasswordSettingAccountUnable2faEntity(
      actionToken: response.actionToken,
      actionName: response.actionName,
    );
  }
}

class VerifyPasswordSettingAccountEnable2faEntity extends VerifyPasswordSettingAccountEntity {
  final String? phoneNumber;
  final String? email;

  VerifyPasswordSettingAccountEnable2faEntity({
    this.phoneNumber,
    this.email,
  });

  factory VerifyPasswordSettingAccountEnable2faEntity.fromResponse(
      VerifyPasswordSettingAccountEnable2faResponse response) {
    return VerifyPasswordSettingAccountEnable2faEntity(
      phoneNumber: response.phoneNumber,
      email: response.email,
    );
  }
}
