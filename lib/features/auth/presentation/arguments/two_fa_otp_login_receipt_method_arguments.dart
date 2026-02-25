class TwoFaOtpLoginReceiptMethodArguments {
  final String phoneOrEmail;
  final String phoneNumberMask;
  final String emailMask;

  TwoFaOtpLoginReceiptMethodArguments({
    required this.phoneOrEmail,
    required this.phoneNumberMask,
    required this.emailMask,
  });

  TwoFaOtpLoginReceiptMethodArguments copyWith({
    String? phoneOrEmail,
    String? phoneNumberMask,
    String? emailMask,
  }) {
    return TwoFaOtpLoginReceiptMethodArguments(
      phoneOrEmail: phoneOrEmail ?? this.phoneOrEmail,
      phoneNumberMask: this.phoneNumberMask,
      emailMask: this.emailMask,
    );
  }
}
