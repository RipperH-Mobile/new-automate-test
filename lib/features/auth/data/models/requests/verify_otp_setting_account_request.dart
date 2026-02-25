class VerifyOtpSettingAccountRequest {
  final String token;
  final String otp;
  final String? phoneNumber;
  final String? email;

  VerifyOtpSettingAccountRequest({
    required this.token,
    required this.otp,
    this.phoneNumber,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'otp': otp,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  factory VerifyOtpSettingAccountRequest.fromJson(Map<String, dynamic> json) {
    return VerifyOtpSettingAccountRequest(
      token: json['token'] as String,
      otp: json['otp'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
    );
  }
}
