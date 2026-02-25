class LinkEmailVerifyOtpRequest {
  final String token;
  final String otp;

  LinkEmailVerifyOtpRequest({
    required this.token,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'otp': otp,
    };
  }
}
