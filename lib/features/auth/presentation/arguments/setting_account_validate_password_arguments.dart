import 'package:uchat/utils/authentication/authentication_helper.dart';

class SettingAccountValidatePasswordArguments {
  final AuthenticationActionType actionType;
  final SocialActionType? socialActionType;

  SettingAccountValidatePasswordArguments({
    required this.actionType,
    this.socialActionType,
  });

  SettingAccountValidatePasswordArguments copyWith({
    AuthenticationActionType? actionType,
    SocialActionType? socialActionType,
  }) {
    return SettingAccountValidatePasswordArguments(
      actionType: actionType ?? this.actionType,
      socialActionType: socialActionType ?? this.socialActionType,
    );
  }
}
