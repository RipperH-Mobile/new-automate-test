class UpdateNewPasswordRequest {
  final String actionToken;
  final String newPassword;

  UpdateNewPasswordRequest({
    required this.actionToken,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'actionToken': actionToken,
      'newPassword': newPassword,
    };
  }
}