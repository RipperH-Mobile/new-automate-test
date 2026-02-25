import 'package:uchat/features/auth/data/models/requests/get_otp_setting_account_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetOtpSettingAccountUseCase extends SimpleUseCase<OtpEntity, GetOtpSettingAccountRequest> {
  final AuthServerRepository authServerRepository;

  GetOtpSettingAccountUseCase({required this.authServerRepository});

  @override
  Future<OtpEntity> call(GetOtpSettingAccountRequest params) async {
    return authServerRepository.getOtpSettingAccount(params);
  }
}
