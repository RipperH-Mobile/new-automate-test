import 'package:uchat/features/auth/data/models/requests/validate_new_email_setting_account_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ValidateNewEmailSettingAccountUseCase extends SimpleUseCase<void, ValidateNewEmailSettingAccountRequest> {
  final AuthServerRepository authServerRepository;

  ValidateNewEmailSettingAccountUseCase({required this.authServerRepository});

  @override
  Future<void> call(ValidateNewEmailSettingAccountRequest params) async {
    return authServerRepository.validateNewEmailSettingAccount(params);
  }
}