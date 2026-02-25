class ValidateNewPasswordRequest {
  final String newPassword;

  ValidateNewPasswordRequest({
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'newPassword': newPassword,
    };
  }
}
