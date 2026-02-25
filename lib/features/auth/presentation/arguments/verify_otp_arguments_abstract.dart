import 'package:uchat/features/auth/domain/entities/otp_entity.dart';

abstract class VerifyOtpArguments {
  final OtpEntity otpEntity;
  final int? countDown;

  VerifyOtpArguments({
    required this.otpEntity,
    this.countDown,
  });
}
