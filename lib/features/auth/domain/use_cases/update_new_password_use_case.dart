import 'package:uchat/features/auth/data/models/requests/update_new_password_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdateNewPasswordUseCase extends SimpleUseCase<void, UpdateNewPasswordRequest> {
  final AuthServerRepository repository;

  UpdateNewPasswordUseCase({
    required this.repository,
  });

  @override
  Future<void> call(UpdateNewPasswordRequest params) async {
    await repository.updateNewPassword(params);
  }
}