import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

class SettingAccountOtpVerifyArguments {
  final AuthenticationActionType actionType;
  final SelectedOtpType method;
  final String? email;
  final String? phoneNumber;
  final OtpEntity? otpEntity;
  final int? countDown;
  final String? otp;
  final SocialActionType? socialActionType;
  final bool canGodModeByPassOtp;

  SettingAccountOtpVerifyArguments({
    required this.actionType,
    required this.method,
    this.email,
    this.otpEntity,
    this.phoneNumber,
    this.countDown,
    this.otp,
    this.socialActionType,
    this.canGodModeByPassOtp = true,
  });

  SettingAccountOtpVerifyArguments copyWith({
    AuthenticationActionType? actionType,
    SelectedOtpType? method,
    String? email,
    OtpEntity? otpEntity,
    String? phoneNumber,
    int? countDown,
    String? otp,
    SocialActionType? socialActionType,
    bool? canGodModeByPassOtp,
  }) {
    return SettingAccountOtpVerifyArguments(
      actionType: actionType ?? this.actionType,
      method: method ?? this.method,
      email: email ?? this.email,
      otpEntity: otpEntity ?? this.otpEntity,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countDown: countDown ?? this.countDown,
      otp: otp ?? this.otp,
      socialActionType: socialActionType ?? this.socialActionType,
      canGodModeByPassOtp: canGodModeByPassOtp ?? this.canGodModeByPassOtp,
    );
  }
}
