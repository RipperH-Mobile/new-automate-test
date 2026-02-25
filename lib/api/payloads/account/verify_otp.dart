class VerifyOtpRequest {
  String token;
  String otp;
  String actionName;
  bool? isEmail;
  bool? isPhoneNumber;

  VerifyOtpRequest({
    required this.token,
    required this.otp,
    required this.actionName,
    this.isEmail,
    this.isPhoneNumber,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'token': token,
      'otp': otp,
      'actionName': actionName,
    };

    if (isEmail == null && isPhoneNumber == null) {
      throw Exception('Both isEmail and isPhoneNumber can not be null.');
    }

    if (isEmail == true) {
      json['isEmail'] = true;
    }

    if (isPhoneNumber == true) {
      json['isPhoneNumber'] = true;
    }

    return json;
  }
}
