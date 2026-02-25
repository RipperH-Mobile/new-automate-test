import 'package:uchat/utils/authentication/authentication_helper.dart';

class TwoFaOtpReceiptMethodArguments {
  final AuthenticationActionType actionType;
  final SelectedOtpType method;
  final SocialActionType? socialActionType;
  final bool canGodModeByPassOtp;

  TwoFaOtpReceiptMethodArguments({
    required this.actionType,
    required this.method,
    this.socialActionType,
    this.canGodModeByPassOtp = true,
  });

  TwoFaOtpReceiptMethodArguments copyWith({
    AuthenticationActionType? actionType,
    SelectedOtpType? method,
    SocialActionType? socialActionType,
    bool? canGodModeByPassOtp,
  }) {
    return TwoFaOtpReceiptMethodArguments(
      actionType: actionType ?? this.actionType,
      method: method ?? this.method,
      socialActionType: socialActionType ?? this.socialActionType,
      canGodModeByPassOtp: canGodModeByPassOtp ?? this.canGodModeByPassOtp,
    );
  }
}
