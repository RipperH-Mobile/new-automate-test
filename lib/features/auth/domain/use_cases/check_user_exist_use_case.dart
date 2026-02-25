import 'package:uchat/features/auth/data/models/requests/check_user_exist_request.dart';
import 'package:uchat/features/auth/domain/entities/check_user_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class CheckUserExistUseCase extends SimpleUseCase<CheckUserEntity, CheckUserExistRequest> {
  final AuthServerRepository authServerRepository;

  CheckUserExistUseCase({required this.authServerRepository});

  @override
  Future<CheckUserEntity> call(CheckUserExistRequest params) async {
    return authServerRepository.checkUserExist(params);
  }
}
