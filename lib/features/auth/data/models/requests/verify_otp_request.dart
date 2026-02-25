import 'package:uchat/utils/authentication/authentication_helper.dart';

class VerifyOTPRequest {
  String token;
  String otp;
  String phoneOrEmail;
  AuthenticationActionType actionName;
  bool? isPhoneNumber;
  bool? isEmail;

  VerifyOTPRequest({
    required this.token,
    required this.otp,
    required this.phoneOrEmail,
    required this.actionName,
    this.isPhoneNumber,
    this.isEmail,
  });

  Map<String, dynamic> toMap() => {
        'token': token,
        'otp': otp,
        'phoneOrEmail': phoneOrEmail,
        'actionName': actionName.value,
        'isPhoneNumber': isPhoneNumber,
        'isEmail': isEmail,
      };

  factory VerifyOTPRequest.fromJson(Map<String, dynamic> map) {
    return VerifyOTPRequest(
      token: map['token'],
      otp: map['otp'],
      phoneOrEmail: map['phoneOrEmail'],
      actionName: AuthenticationActionType.from(map['actionName']),
      isPhoneNumber: map['isPhoneNumber'],
      isEmail: map['isEmail'],
    );
  }
}
