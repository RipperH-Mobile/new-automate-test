class SettingEmailOTPRequest {
  String token;
  String otp;
  String actionToken;

  SettingEmailOTPRequest({
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
