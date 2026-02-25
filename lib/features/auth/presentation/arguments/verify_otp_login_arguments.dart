import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_arguments_abstract.dart';

class VerifyOtpLoginArguments implements VerifyOtpArguments {
  @override
  final OtpEntity otpEntity;
  @override
  final int? countDown;
  final String? phone;
  final String? email;
  final String? countryCode;
  final LinkAccountAuthEntity? linkAccountModel;
  final bool setupPassword;

  VerifyOtpLoginArguments({
    this.phone,
    this.email,
    this.countryCode,
    required this.otpEntity,
    this.countDown,
    this.linkAccountModel,
    this.setupPassword = false,
  });
}
