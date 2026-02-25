import 'package:uchat/utils/authentication/authentication_helper.dart';

class SettingAccountConfirmNewPasswordArguments {
  final String actionToken;
  final String newPassword;
  final String phoneOrEmail;
  final AuthenticationActionType actionType;
  final bool enableChangePasswordSuccessToast;

  SettingAccountConfirmNewPasswordArguments({
    required this.actionToken,
    required this.newPassword,
    required this.phoneOrEmail,
    required this.actionType,
    this.enableChangePasswordSuccessToast = true,
  });
}
