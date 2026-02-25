import 'package:uchat/features/auth/data/models/requests/forgot_password_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ForgotPasswordUseCase extends SimpleUseCase<bool, ForgotPasswordRequest> {
  final AuthServerRepository authServerRepository;

  ForgotPasswordUseCase({required this.authServerRepository});

  @override
  Future<bool> call(ForgotPasswordRequest params) async {
    return authServerRepository.forgotPassword(params);
  }
}
