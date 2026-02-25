import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ClearOtpUseCase extends SimpleUseCase<void, String> {
  final AuthServerRepository authServerRepository;

  ClearOtpUseCase({required this.authServerRepository});

  @override
  Future<void> call(String phoneOrEmail) async {
    return authServerRepository.clearOtpResponse(phoneOrEmail);
  }
}
