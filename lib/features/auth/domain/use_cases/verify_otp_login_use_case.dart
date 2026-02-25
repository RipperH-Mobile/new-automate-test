import 'package:uchat/features/auth/data/models/requests/auth_sign_in_request.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_login_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class VerifyOtpLoginUseCase extends SimpleUseCase<VerifyOtpLoginEntity, AuthSignInRequest> {
  final AuthServerRepository authServerRepository;

  VerifyOtpLoginUseCase({required this.authServerRepository});

  @override
  Future<VerifyOtpLoginEntity> call(AuthSignInRequest params) async {
    return authServerRepository.verifyOtpLogin(params);
  }
}