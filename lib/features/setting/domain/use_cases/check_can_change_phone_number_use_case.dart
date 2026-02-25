import 'package:uchat/features/setting/domain/repositories/setting_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class CheckCanChangePhoneNumberUseCase extends SimpleUseCase<void, NoParams> {
  final SettingServerRepository settingServerRepository;

  CheckCanChangePhoneNumberUseCase({required this.settingServerRepository});

  @override
  Future<void> call(NoParams params) async {
    await settingServerRepository.checkCanChangePhoneNumber();
  }
}
