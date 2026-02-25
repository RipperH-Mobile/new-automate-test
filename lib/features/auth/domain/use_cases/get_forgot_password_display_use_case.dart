import 'package:uchat/features/auth/data/models/requests/check_user_forgot_password_request.dart';
import 'package:uchat/features/auth/domain/entities/check_user_forgot_password_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetForgotPasswordDisplayUseCase extends SimpleUseCase<CheckUserForgotPasswordEntity, CheckUserForgotPasswordRequest> {
  final AuthServerRepository authServerRepository;

  GetForgotPasswordDisplayUseCase({required this.authServerRepository});

  @override
  Future<CheckUserForgotPasswordEntity> call(CheckUserForgotPasswordRequest params) async {
    return authServerRepository.checkUserForgotPassword(params);
  }
}