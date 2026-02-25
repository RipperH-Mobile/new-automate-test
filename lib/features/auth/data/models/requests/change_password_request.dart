class ChangePasswordRequest {
  final String? actionToken;
  final String password;
  final String? newPassword;

  ChangePasswordRequest({
    this.actionToken,
    required this.password,
    this.newPassword,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'actionToken': actionToken,
      'password': password,
      'newPassword': newPassword,
    };
  }
}
