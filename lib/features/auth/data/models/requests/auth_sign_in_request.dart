import 'dart:convert';

class AuthSignInRequest {
  final String token;
  final String otp;
  final String phoneOrEmail;
  final bool isPhoneNumber;
  AuthSignInRequest({
    required this.token,
    required this.otp,
    required this.phoneOrEmail,
    required this.isPhoneNumber,
  });

  AuthSignInRequest copyWith({
    String? token,
    String? otp,
    String? phoneOrEmail,
    bool? isPhoneNumber,
  }) {
    return AuthSignInRequest(
      token: token ?? this.token,
      otp: otp ?? this.otp,
      phoneOrEmail: phoneOrEmail ?? this.phoneOrEmail,
      isPhoneNumber: isPhoneNumber ?? this.isPhoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'otp': otp,
      'phoneOrEmail': phoneOrEmail,
      'isPhoneNumber': isPhoneNumber,
    };
  }

  factory AuthSignInRequest.fromMap(Map<String, dynamic> map) {
    return AuthSignInRequest(
      token: map['token'] as String,
      otp: map['otp'] as String,
      phoneOrEmail: map['phoneOrEmail'] as String,
      isPhoneNumber: map['isPhoneNumber'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthSignInRequest.fromJson(String source) =>
      AuthSignInRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthSignInRequest(token: $token, otp: $otp, phoneOrEmail: $phoneOrEmail, isPhoneNumber: $isPhoneNumber)';
  }

  @override
  bool operator ==(covariant AuthSignInRequest other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.otp == otp &&
        other.phoneOrEmail == phoneOrEmail &&
        other.isPhoneNumber == isPhoneNumber;
  }

  @override
  int get hashCode {
    return token.hashCode ^ otp.hashCode ^ phoneOrEmail.hashCode ^ isPhoneNumber.hashCode;
  }
}
