import 'package:uchat/utils/authentication/authentication_helper.dart';

class GetOtpSettingAccountRequest {
  final String? phoneNumber;
  final String? email;
  final AuthenticationActionType? actionName;

  GetOtpSettingAccountRequest({
    this.phoneNumber,
    this.email,
    this.actionName,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'email': email,
      'actionName': actionName?.value,
    };
  }
}
