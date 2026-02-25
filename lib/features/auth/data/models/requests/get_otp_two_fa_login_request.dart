class GetOtpTwoFaLoginRequest {
  final String phoneOrEmail;
  final bool? isPhoneNumber;
  final bool? isEmail;

  GetOtpTwoFaLoginRequest({
    required this.phoneOrEmail,
    this.isPhoneNumber,
    this.isEmail,
  });

  // to json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phoneOrEmail': phoneOrEmail,
      'isPhoneNumber': isPhoneNumber,
      'isEmail': isEmail,
    };
  }
}
