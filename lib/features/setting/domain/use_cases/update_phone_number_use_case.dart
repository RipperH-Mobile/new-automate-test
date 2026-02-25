import 'package:uchat/features/setting/data/models/request/update_phone_number_request.dart';
import 'package:uchat/features/setting/domain/params/update_phone_number_params.dart';
import 'package:uchat/features/setting/domain/repositories/setting_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdatePhoneNumberUseCase extends SimpleUseCase<UpdatePhoneNumberResponse, UpdatePhoneNumberParams> {
  final SettingServerRepository settingServerRepository;

  UpdatePhoneNumberUseCase({required this.settingServerRepository});

  @override
  Future<UpdatePhoneNumberResponse> call(UpdatePhoneNumberParams params) async {
    final response = await settingServerRepository.updatePhoneNumber(
      UpdatePhoneNumberRequest(
        actionToken: params.actionToken,
        newPhoneNumber: params.newPhoneNumber,
      ),
    );
    return response;
  }
}
