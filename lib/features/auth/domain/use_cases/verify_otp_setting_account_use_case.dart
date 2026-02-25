import 'package:uchat/features/auth/data/models/requests/verify_otp_setting_account_request.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class VerifyOtpSettingAccountUseCase extends SimpleUseCase<VerifyOtpEntity, VerifyOtpSettingAccountRequest> {
  final AuthServerRepository authServerRepository;

  VerifyOtpSettingAccountUseCase({required this.authServerRepository});

  @override
  Future<VerifyOtpEntity> call(VerifyOtpSettingAccountRequest params) async {
    return authServerRepository.verifyOtpTwoFa(params);
  }
}
