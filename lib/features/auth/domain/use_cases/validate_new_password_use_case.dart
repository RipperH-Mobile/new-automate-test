import 'package:uchat/features/auth/data/models/requests/validate_new_password_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ValidateNewPasswordUseCase extends SimpleUseCase<void, ValidateNewPasswordRequest> {
  final AuthServerRepository repository;

  ValidateNewPasswordUseCase({
    required this.repository,
  });

  @override
  Future<void> call(ValidateNewPasswordRequest params) async {
    await repository.validateNewPassword(params);
  }
}
