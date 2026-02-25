import 'package:uchat/api/api.dart';
import 'package:uchat/features/setting/data/models/request/check_new_phone_number_request.dart';
import 'package:uchat/features/setting/data/models/request/update_phone_number_request.dart';

import 'backend_path.dart';

class SettingApiService {
  final HttpCaller httpCaller;

  SettingApiService({required this.httpCaller});

  Future<void> checkCanChangePhoneNumber() async {
    await httpCaller.get(
      checkCanChangePhoneNumberPath.http,
    );
  }

  Future<void> checkNewPhoneNumber(CheckNewPhoneNumberRequest request) async {
    await httpCaller.post(
      checkNewPhoneNumberPath.http,
      data: request.toJson(),
    );
  }

  Future<UpdatePhoneNumberResponse?> updatePhoneNumber(UpdatePhoneNumberRequest request) async {
    final resp = await httpCaller.post(
      updatePhoneNumberPath.http,
      data: request.toJson(),
    );

    return resp.mapToResponseV3<UpdatePhoneNumberResponse>(
      (data) => UpdatePhoneNumberResponse.fromJson(data),
    );
  }
}
