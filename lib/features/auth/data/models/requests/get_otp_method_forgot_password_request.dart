class GetOtpMethodForgotPasswordRequest {
  final String phoneOrEmail;

  const GetOtpMethodForgotPasswordRequest({
    required this.phoneOrEmail,
  });

  factory GetOtpMethodForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    return GetOtpMethodForgotPasswordRequest(
      phoneOrEmail: json['phoneOrEmail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneOrEmail': phoneOrEmail,
    };
  }

  GetOtpMethodForgotPasswordRequest copyWith({
    String? phoneOrEmail,
  }) {
    return GetOtpMethodForgotPasswordRequest(
      phoneOrEmail: phoneOrEmail ?? this.phoneOrEmail,
    );
  }
}