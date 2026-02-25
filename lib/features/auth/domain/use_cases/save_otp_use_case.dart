import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SaveOtpUseCase extends SimpleUseCase<void, SaveOtpResponseRequest> {
  final AuthServerRepository authServerRepository;

  SaveOtpUseCase({required this.authServerRepository});

  @override
  Future<void> call(SaveOtpResponseRequest params) async {
    return authServerRepository.saveOtpResponse(params);
  }
}
