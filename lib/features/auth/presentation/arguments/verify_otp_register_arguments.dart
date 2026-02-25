import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_arguments_abstract.dart';

class VerifyOtpRegisterArguments implements VerifyOtpArguments {
  @override
  final OtpEntity otpEntity;
  @override
  final int? countDown;
  final String? phone;
  final String? email;
  final String? countryCode;

  VerifyOtpRegisterArguments({
    required this.otpEntity,
    this.phone,
    this.email,
    this.countryCode,
    this.countDown,
  });
}
