class CheckUserPhoneOrEmailRequest {
  final String phoneOrEmail;
  final bool isForgotPassword;

  CheckUserPhoneOrEmailRequest({
    required this.phoneOrEmail,
    required this.isForgotPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneOrEmail': phoneOrEmail,
      'isForgotPassword': isForgotPassword,
    };
  }
}

class CheckUserPhoneOrEmailResponse {
  final String? phoneNumber;
  final String? email;

  CheckUserPhoneOrEmailResponse({this.phoneNumber, this.email});

  factory CheckUserPhoneOrEmailResponse.fromMap(Map<String, dynamic> map) {
    return CheckUserPhoneOrEmailResponse(
      phoneNumber: map['phoneNumber'],
      email: map['email'],
    );
  }
}
