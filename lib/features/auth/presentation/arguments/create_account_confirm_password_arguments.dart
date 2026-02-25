class CreateAccountConfirmPasswordArguments {
  final String actionToken;
  final String phoneNumber;
  final String displayName;
  final String newPassword;
  CreateAccountConfirmPasswordArguments({
    required this.actionToken,
    required this.phoneNumber,
    required this.displayName,
    required this.newPassword,
  });
}
