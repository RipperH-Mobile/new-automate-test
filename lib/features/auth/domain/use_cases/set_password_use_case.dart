import 'package:uchat/features/auth/data/models/requests/change_password_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SetPasswordUseCase extends SimpleUseCase<void, ChangePasswordRequest> {
  final AuthServerRepository authServerRepository;

  SetPasswordUseCase({required this.authServerRepository});

  @override
  Future<void> call(ChangePasswordRequest params) async {
    return authServerRepository.setPassword(params);
  }
}