import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_arguments_abstract.dart';

class VerifyOtpTwoFaArguments implements VerifyOtpArguments {
  @override
  final OtpEntity otpEntity;
  @override
  final int? countDown;
  final String phoneOrEmail;
  final String? phoneNumberMask;
  final String? emailMask;


  VerifyOtpTwoFaArguments({
    required this.otpEntity,
    required this.phoneOrEmail,
    this.phoneNumberMask,
    this.emailMask,
    this.countDown,
  });
}
