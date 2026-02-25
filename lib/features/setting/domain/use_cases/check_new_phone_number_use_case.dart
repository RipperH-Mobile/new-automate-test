import 'package:uchat/features/setting/data/models/request/check_new_phone_number_request.dart';
import 'package:uchat/features/setting/domain/params/check_new_phone_number_params.dart';
import 'package:uchat/features/setting/domain/repositories/setting_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class CheckNewPhoneNumberUseCase extends SimpleUseCase<void, CheckNewPhoneNumberParams> {
  final SettingServerRepository settingServerRepository;

  CheckNewPhoneNumberUseCase({required this.settingServerRepository});

  @override
  Future<void> call(CheckNewPhoneNumberParams params) async {
    await settingServerRepository.checkNewPhoneNumber(
      CheckNewPhoneNumberRequest(
        newPhoneNumber: params.newPhoneNumber,
      ),
    );
  }
}
