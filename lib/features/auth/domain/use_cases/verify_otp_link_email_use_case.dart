import 'package:uchat/features/auth/data/models/requests/link_email_verify_otp_request.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class VerifyOtpLinkEmailUseCase extends SimpleUseCase<UserEntity, LinkEmailVerifyOtpRequest> {
  final AuthServerRepository authServerRepository;

  VerifyOtpLinkEmailUseCase({required this.authServerRepository});

  @override
  Future<UserEntity> call(LinkEmailVerifyOtpRequest params) async {
    return authServerRepository.verifyOtpLinkEmail(params);
  }
}