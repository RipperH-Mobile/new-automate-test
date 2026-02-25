import 'package:uchat/features/auth/data/models/requests/link_email_otp_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class LinkAccountWithEmailUseCase extends SimpleUseCase<OtpEntity, LinkEmailOtpRequest> {
  final AuthServerRepository authServerRepository;

  LinkAccountWithEmailUseCase({required this.authServerRepository});

  @override
  Future<OtpEntity> call(LinkEmailOtpRequest params) async {
    return authServerRepository.linkAccountWithEmail(params);
  }
}
