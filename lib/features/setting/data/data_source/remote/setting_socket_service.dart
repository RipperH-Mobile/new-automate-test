import 'package:uchat/api/api.dart';
import 'package:uchat/features/setting/data/models/request/check_new_phone_number_request.dart';
import 'package:uchat/features/setting/data/models/request/update_phone_number_request.dart';

import 'backend_path.dart';

class SettingSocketService {
  final SocketCaller socketCaller;

  SettingSocketService({required this.socketCaller});

  Future<void> checkCanChangePhoneNumber() async {
    await socketCaller.emitCallV3(
      checkCanChangePhoneNumberPath.socket,
      {},
    );
  }

  Future<void> checkNewPhoneNumber(CheckNewPhoneNumberRequest request) async {
    await socketCaller.emitCallV3(
      checkNewPhoneNumberPath.socket,
      request.toJson(),
    );
  }

  Future<UpdatePhoneNumberResponse?> updatePhoneNumber(UpdatePhoneNumberRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      updatePhoneNumberPath.socket,
      request.toJson(),
    );

    return socketResp.mapToResponseV3<UpdatePhoneNumberResponse>(
      (data) => UpdatePhoneNumberResponse.fromJson(data),
    );
  }
}
