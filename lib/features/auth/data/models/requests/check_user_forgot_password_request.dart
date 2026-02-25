class CheckUserForgotPasswordRequest {
  CheckUserForgotPasswordRequest({
    required this.phoneOrEmail,
    this.isForgotPassword = false,
  });
  final String phoneOrEmail;
  final bool isForgotPassword;

  Map<String, dynamic> toMap() {
    return {
      'phoneOrEmail': phoneOrEmail,
      'isForgotPassword': isForgotPassword,
    };
  }
}
