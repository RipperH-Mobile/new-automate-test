import 'package:uchat/features/auth/domain/entities/otp_entity.dart';

class SaveOtpResponseRequest {
  final OtpEntity otpEntity;
  final String phoneOrEmail;

  SaveOtpResponseRequest({
    required this.otpEntity,
    required this.phoneOrEmail,
  });
}
