class CheckUserExistRequest {
  CheckUserExistRequest({
    required this.phoneOrEmail,
    this.isSignUp = false,
  });

  final String phoneOrEmail;
  final bool isSignUp;

  Map<String, dynamic> toMap() {
    return {
      'phoneOrEmail': phoneOrEmail,
      'isSignUp': isSignUp,
    };
  }
}
