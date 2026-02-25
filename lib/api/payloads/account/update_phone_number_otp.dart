class UpdatePhoneNumberOtpRequest {
  String phoneNumber;
  String countryCode;

  UpdatePhoneNumberOtpRequest({
    required this.phoneNumber,
    required this.countryCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
    };
  }
}
