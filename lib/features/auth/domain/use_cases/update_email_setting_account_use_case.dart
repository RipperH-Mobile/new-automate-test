import 'package:uchat/features/auth/data/models/requests/update_email_setting_account_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdateEmailSettingAccountUseCase extends SimpleUseCase<void, UpdateEmailSettingAccountRequest> {
  final AuthServerRepository authServerRepository;

  UpdateEmailSettingAccountUseCase({required this.authServerRepository});

  @override
  Future<void> call(UpdateEmailSettingAccountRequest params) async {
    return authServerRepository.updateEmailSettingAccount(params);
  }
}
