import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_arguments_abstract.dart';

class VerifyOtpLinkEmailArguments implements VerifyOtpArguments {
  @override
  final OtpEntity otpEntity;
  @override
  final int? countDown;
  final String phoneOrEmail;
  final LinkAccountAuthEntity linkAccountModel;
  final bool setupPassword;

  VerifyOtpLinkEmailArguments({
    required this.phoneOrEmail,
    required this.otpEntity,
    required this.linkAccountModel,
    this.setupPassword = false,
    this.countDown,
  });
}
