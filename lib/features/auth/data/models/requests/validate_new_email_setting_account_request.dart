class ValidateNewEmailSettingAccountRequest {
  final String newEmail;

  ValidateNewEmailSettingAccountRequest({
    required this.newEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'newEmail': newEmail,
    };
  }

  factory ValidateNewEmailSettingAccountRequest.fromJson(Map<String, dynamic> json) {
    return ValidateNewEmailSettingAccountRequest(
      newEmail: json['email'],
    );
  }
}
