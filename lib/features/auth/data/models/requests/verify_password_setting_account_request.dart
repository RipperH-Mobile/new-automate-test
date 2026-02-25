class VerifyPasswordSettingAccountRequest {
  final String password;

  VerifyPasswordSettingAccountRequest({
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
    };
  }

  factory VerifyPasswordSettingAccountRequest.fromJson(Map<String, dynamic> json) {
    return VerifyPasswordSettingAccountRequest(
      password: json['password'],
    );
  }
}
