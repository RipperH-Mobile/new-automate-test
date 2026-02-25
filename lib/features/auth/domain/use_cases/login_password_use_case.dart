import 'package:uchat/features/auth/data/models/requests/check_user_exist_with_password_request.dart';
import 'package:uchat/features/auth/domain/entities/check_password_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class LoginPasswordUseCase extends SimpleUseCase<CheckPasswordEntity, CheckUserExistWithPasswordRequest> {
  LoginPasswordUseCase({
    required this.authServerRepository,
  });

  final AuthServerRepository authServerRepository;

  @override
  Future<CheckPasswordEntity> call(CheckUserExistWithPasswordRequest params) async {
    return authServerRepository.checkPassword(params);
  }
}
