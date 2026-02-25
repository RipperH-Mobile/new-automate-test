class UpdateEmailSettingAccountRequest {
  final String actionToken;
  final String newEmail;

  UpdateEmailSettingAccountRequest({
    required this.actionToken,
    required this.newEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'actionToken': actionToken,
      'newEmail': newEmail,
    };
  }

  factory UpdateEmailSettingAccountRequest.fromJson(Map<String, dynamic> json) {
    return UpdateEmailSettingAccountRequest(
      actionToken: json['actionToken'],
      newEmail: json['newEmail'],
    );
  }
}
