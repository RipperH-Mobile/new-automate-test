class ForgotPasswordRequest {
  final String actionToken;
  final String phoneOrEmail;
  final String password;

  ForgotPasswordRequest({
    required this.actionToken,
    required this.phoneOrEmail,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'actionToken': actionToken,
      'phoneOrEmail': phoneOrEmail,
      'password': password,
    };
  }
}
