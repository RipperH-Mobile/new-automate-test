import 'package:uchat/features/auth/data/models/requests/auth_register_request.dart';
import 'package:uchat/features/auth/domain/entities/auth_login_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RegisterUseCase extends SimpleUseCase<AuthLoginEntity, AuthRegisterRequest> {
  final AuthServerRepository authServerRepository;

  RegisterUseCase({required this.authServerRepository});

  @override
  Future<AuthLoginEntity> call(AuthRegisterRequest params) async {
    return authServerRepository.register(params);
  }
}
