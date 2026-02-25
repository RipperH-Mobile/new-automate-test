import 'package:uchat/utils/authentication/authentication_helper.dart';

class SettingAccountCreateNewPasswordArguments {
  final String actionToken;
  final String accountId;
  final String phoneOrEmail;
  final AuthenticationActionType actionType;
  final bool enableChangePasswordSuccessToast;

  SettingAccountCreateNewPasswordArguments({
    required this.actionToken,
    required this.accountId,
    required this.phoneOrEmail,
    required this.actionType,
    this.enableChangePasswordSuccessToast = true,
  });
}
