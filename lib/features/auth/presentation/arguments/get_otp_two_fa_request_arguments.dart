class GetOtpTwoFaRequestArguments {
  final String phoneOrEmail;
  final String? phoneNumberMask;
  final String? emailMask;

  GetOtpTwoFaRequestArguments({
    required this.phoneOrEmail,
    this.phoneNumberMask,
    this.emailMask,
  });
}
