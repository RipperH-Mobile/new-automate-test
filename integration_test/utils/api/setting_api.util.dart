import 'package:http/http.dart' as http;
import 'base/base_api.util.dart';
import 'endpoint_api.dart';

class SettingApi extends BaseApiUtil {
  SettingApi(http.Client client) : super(client);

  Future<dynamic> verifyOtp(Map<String, dynamic> verifyOtpBodyData) {
    return post(endpoints.setting.verifyOtp, data: verifyOtpBodyData);
  }

  Future<dynamic> deleteAccount(Map<String, dynamic> deleteAccountBodyData) {
    return delete(endpoints.setting.deleteAccount, data: deleteAccountBodyData);
  }
}
