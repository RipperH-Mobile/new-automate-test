class ValidateForgotPasswordRequest {
  final String accountId;
  final String password;
  final String token;

  ValidateForgotPasswordRequest({
    required this.accountId,
    required this.password,
    required this.token,
  });

  factory ValidateForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ValidateForgotPasswordRequest(
      accountId: json['accountId'] as String,
      password: json['password'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'password': password,
      'token': token,
    };
  }

  ValidateForgotPasswordRequest copyWith({
    String? accountId,
    String? password,
    String? token,
  }) {
    return ValidateForgotPasswordRequest(
      accountId: accountId ?? this.accountId,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}