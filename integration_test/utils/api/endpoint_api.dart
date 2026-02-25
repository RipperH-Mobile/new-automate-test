import 'package:flutter_dotenv/flutter_dotenv.dart';

final endpoints = EndPointApi();

class EndPointApi {
  final endpoint = EndPointGroup();
  final auth = AuthGroup();
  final setting = SettingGroup();
}

class EndPointGroup {
  final baseUrl = dotenv.env['API_URL_BASE'];
}

class AuthGroup {
  final requestOtp = dotenv.env['API_URL_AUTH_OTP'];
  final signIn = dotenv.env['API_URL_AUTH_SIGN_IN'];
}

class SettingGroup {
  final verifyOtp = dotenv.env['API_URL_USERS_SETTING_OTP_VERIFY'];
  final deleteAccount = dotenv.env['API_URL_USERS_SETTING_ACCOUNT'];
}
