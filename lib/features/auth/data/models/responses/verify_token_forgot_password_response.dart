class VerifyTokenForgotPasswordResponse {
  final String actionToken;
  final String actionName;
  final String accountId;
  final String phone;

  VerifyTokenForgotPasswordResponse({
    required this.actionToken,
    required this.actionName,
    required this.accountId,
    required this.phone,
  });

  factory VerifyTokenForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return VerifyTokenForgotPasswordResponse(
      actionToken: json['actionToken'] as String,
      actionName: json['actionName'] as String,
      accountId: json['accountId'] as String,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionToken': actionToken,
      'actionName': actionName,
      'accountId': accountId,
      'phone': phone,
    };
  }

  VerifyTokenForgotPasswordResponse copyWith({
    String? actionToken,
    String? actionName,
    String? accountId,
    String? phone,
  }) {
    return VerifyTokenForgotPasswordResponse(
      actionToken: actionToken ?? this.actionToken,
      actionName: actionName ?? this.actionName,
      accountId: accountId ?? this.accountId,
      phone: phone ?? this.phone,
    );
  }
}