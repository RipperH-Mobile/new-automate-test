import 'package:uchat/features/auth/data/models/requests/validate_forgot_password_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ValidateForgotPasswordUseCase extends SimpleUseCase<void, ValidateForgotPasswordRequest> {
  final AuthServerRepository authServerRepository;

  ValidateForgotPasswordUseCase({required this.authServerRepository});

  @override
  Future<void> call(ValidateForgotPasswordRequest params) async {
    return await authServerRepository.validateForgotPassword(params);
  }
}