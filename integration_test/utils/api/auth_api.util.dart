import 'package:http/http.dart' as http;
import 'base/base_api.util.dart';
import 'endpoint_api.dart';

class AuthApi extends BaseApiUtil {
  AuthApi(http.Client client) : super(client);

  Future<dynamic> requestOtp(Map<String, dynamic> requestOtpBodyData) async {
    return await post(endpoints.auth.requestOtp, data: requestOtpBodyData);
  }

  Future<dynamic> signIn(Map<String, dynamic> signInBodyData) async {
    return await post(endpoints.auth.signIn, data: signInBodyData);
  }
}
