class GetOtpMethodForgotPasswordResponse {
  final String email;
  final String method;
  final String phone;

  const GetOtpMethodForgotPasswordResponse({
    required this.email,
    required this.method,
    required this.phone,
  });

  factory GetOtpMethodForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return GetOtpMethodForgotPasswordResponse(
      email: json['email'] ?? '',
      method: json['method'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'method': method,
      'phone': phone,
    };
  }

  GetOtpMethodForgotPasswordResponse copyWith({
    String? email,
    String? method,
    String? phone,
  }) {
    return GetOtpMethodForgotPasswordResponse(
      email: email ?? this.email,
      method: method ?? this.method,
      phone: phone ?? this.phone,
    );
  }
}