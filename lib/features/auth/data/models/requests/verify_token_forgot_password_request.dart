class VerifyTokenForgotPasswordRequest {
  final String sessionId;
  final String token;

  VerifyTokenForgotPasswordRequest({
    required this.sessionId,
    required this.token,
  });

  factory VerifyTokenForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    return VerifyTokenForgotPasswordRequest(
      sessionId: json['sessionId'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'token': token,
    };
  }

  VerifyTokenForgotPasswordRequest copyWith({
    String? sessionId,
    String? token,
  }) {
    return VerifyTokenForgotPasswordRequest(
      sessionId: sessionId ?? this.sessionId,
      token: token ?? this.token,
    );
  }
}