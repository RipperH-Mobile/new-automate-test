import 'package:uchat/features/auth/data/models/requests/get_otp_two_fa_login_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetOtpTwoFaLoginUseCase extends SimpleUseCase<OtpEntity, GetOtpTwoFaLoginRequest> {
  final AuthServerRepository authServerRepository;

  GetOtpTwoFaLoginUseCase({required this.authServerRepository});

  @override
  Future<OtpEntity> call(GetOtpTwoFaLoginRequest params) async {
    return authServerRepository.getOtpTwoFaLogin(params);
  }
}
