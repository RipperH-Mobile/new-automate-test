class CheckUserForgotPasswordEntity {
  final String? email;
  final String phoneNumber;

  const CheckUserForgotPasswordEntity({
    this.email,
    required this.phoneNumber,
  });
}
