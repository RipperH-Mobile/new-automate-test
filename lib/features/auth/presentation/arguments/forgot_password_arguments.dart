class ForgotPasswordArguments {
  final String actionToken;
  final String phoneOrEmail;

  ForgotPasswordArguments({
    required this.actionToken,
    required this.phoneOrEmail,
  });
}
