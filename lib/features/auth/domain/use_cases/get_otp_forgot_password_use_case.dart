import 'package:uchat/features/auth/data/models/requests/get_otp_forgot_password_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetOtpForgotPasswordUseCase extends SimpleUseCase<OtpEntity, GetOtpForgotPasswordRequest> {
  final AuthServerRepository authServerRepository;

  GetOtpForgotPasswordUseCase({required this.authServerRepository});

  @override
  Future<OtpEntity> call(GetOtpForgotPasswordRequest params) async {
    return authServerRepository.getOtpForgotPassword(params);
  }
}