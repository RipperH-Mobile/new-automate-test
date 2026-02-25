import 'package:uchat/features/setting/data/models/request/check_new_phone_number_request.dart';
import 'package:uchat/features/setting/data/models/request/update_phone_number_request.dart';

abstract class SettingServerRepository {
  Future<void> checkCanChangePhoneNumber();
  Future<void> checkNewPhoneNumber(CheckNewPhoneNumberRequest request);
  Future<UpdatePhoneNumberResponse> updatePhoneNumber(UpdatePhoneNumberRequest request);
}
