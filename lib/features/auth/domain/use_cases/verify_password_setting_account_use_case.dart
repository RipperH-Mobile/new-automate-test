import 'package:uchat/features/auth/data/models/requests/verify_password_setting_account_request.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class VerifyPasswordSettingAccountUseCase
    extends SimpleUseCase<VerifyPasswordSettingAccountEntity, VerifyPasswordSettingAccountRequest> {
  final AuthServerRepository authServerRepository;

  VerifyPasswordSettingAccountUseCase({required this.authServerRepository});

  @override
  Future<VerifyPasswordSettingAccountEntity> call(VerifyPasswordSettingAccountRequest request) async {
    return authServerRepository.verifyPasswordSettingAccount(request);
  }
}
