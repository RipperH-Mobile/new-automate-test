import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_arguments_abstract.dart';

class VerifyOtpForgotPasswordArguments implements VerifyOtpArguments {
  @override
  final OtpEntity otpEntity;
  @override
  final int? countDown;
  final String? phoneNumber;
  final String? phoneNumberDisplay;

  VerifyOtpForgotPasswordArguments({
    required this.otpEntity,
    this.phoneNumber,
    this.phoneNumberDisplay,
    this.countDown,
  });
}
