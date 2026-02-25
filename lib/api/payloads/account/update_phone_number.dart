class SettingPhoneNumberOTPRequest {
  String token;
  String otp;
  String actionToken;

  SettingPhoneNumberOTPRequest({
    required this.token,
    required this.otp,
    required this.actionToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'otp': otp,
      'actionToken': actionToken,
    };
  }
}
