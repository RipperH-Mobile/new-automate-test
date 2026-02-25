import 'package:uchat/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class VerifyOtpUseCase extends SimpleUseCase<VerifyOtpEntity, VerifyOTPRequest> {
  final AuthServerRepository authServerRepository;

  VerifyOtpUseCase({required this.authServerRepository});

  @override
  Future<VerifyOtpEntity> call(VerifyOTPRequest params) async {
    return authServerRepository.verifyOtp(params);
  }
}