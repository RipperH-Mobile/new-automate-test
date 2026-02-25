class ForgotPasswordGetOtpArguments {
  final String phoneOrEmail;
  final String phoneNumberDisplay;
  final String? emailDisplay;

  ForgotPasswordGetOtpArguments({
    required this.phoneOrEmail,
    required this.phoneNumberDisplay,
    this.emailDisplay,
  });
}
