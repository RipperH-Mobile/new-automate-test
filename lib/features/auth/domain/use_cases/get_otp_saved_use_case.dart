import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetOtpSavedUseCase extends SimpleUseCase<OtpEntity, String> {
  final AuthServerRepository authServerRepository;

  GetOtpSavedUseCase({required this.authServerRepository});

  @override
  Future<OtpEntity> call(String params) async {
    return authServerRepository.getOtpResponse(params);
  }
}
