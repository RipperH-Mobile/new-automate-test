class CheckUserExistWithPasswordRequest {
  CheckUserExistWithPasswordRequest({
    required this.phoneOrEmail,
    required this.password,
    this.isSignUp = false,
    this.isDesktop = false,
  });

  final String phoneOrEmail;
  final String password;
  final bool isSignUp;
  final bool isDesktop;

  Map<String, dynamic> toMap() {
    return {
      'phoneOrEmail': phoneOrEmail,
      'password': password,
      'isSignUp': isSignUp,
      'isDesktop': isDesktop,
    };
  }
}
