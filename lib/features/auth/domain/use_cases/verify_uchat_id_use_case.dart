import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class VerifyUChatIdUseCase extends SimpleUseCase<void, String> {
  final AuthServerRepository authServerRepository;

  VerifyUChatIdUseCase({required this.authServerRepository});

  @override
  Future<void> call(String request) async {
    return authServerRepository.verifyUChatID(request);
  }
}
