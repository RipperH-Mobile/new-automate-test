import 'package:uchat/features/auth/domain/entities/check_password_required_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class CheckPasswordRequiredUseCase extends SimpleUseCase<CheckPasswordRequiredEntity, NoParams> {
  final AuthServerRepository authServerRepository;

  CheckPasswordRequiredUseCase({required this.authServerRepository});

  @override
  Future<CheckPasswordRequiredEntity> call(NoParams params) async {
    return authServerRepository.checkPasswordRequired();
  }
}
