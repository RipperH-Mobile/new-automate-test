import 'package:uchat/api/payloads/account/update_account_setting.dart';
import 'package:uchat/api/payloads/account/user_response.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdateAccountSettingUseCase extends SimpleUseCase<UserResponse?, UpdateAccountSettingRequest> {
  final AuthServerRepository authServerRepository;

  UpdateAccountSettingUseCase({
    required this.authServerRepository,
  });

  @override
  Future<UserResponse?> call(UpdateAccountSettingRequest request) async {
    return authServerRepository.updateAccountSetting(request);
  }
}
