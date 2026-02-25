class GetOtpForgotPasswordRequest {
  final String phoneOrEmail;
  final bool? isPhoneNumber;
  final bool? isEmail;
  final bool? isForgotPassword;

  GetOtpForgotPasswordRequest({
    required this.phoneOrEmail,
    this.isPhoneNumber,
    this.isEmail,
    this.isForgotPassword,
  });

  // to json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phoneOrEmail': phoneOrEmail,
      'isPhoneNumber': isPhoneNumber,
      'isEmail': isEmail,
      'isForgotPassword': isForgotPassword,
    };
  }
}