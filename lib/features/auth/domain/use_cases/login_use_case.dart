import 'package:uchat/features/auth/data/models/requests/check_user_exist_request.dart';
import 'package:uchat/features/auth/domain/entities/check_user_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class LoginUseCase extends SimpleUseCase<CheckUserEntity, CheckUserExistRequest> {
  LoginUseCase({
    required this.authServerRepository,
  });

  final AuthServerRepository authServerRepository;

  @override
  Future<CheckUserEntity> call(CheckUserExistRequest params) {
    return authServerRepository.checkUserExist(params);
  }
}
