// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthSelectOtpTypeRequest {
  final String phoneOrEmail;
  final bool? isPhoneNumber;
  final bool? isEmail;
  final bool? isForgotPassword;

  AuthSelectOtpTypeRequest({
    required this.phoneOrEmail,
    this.isPhoneNumber,
    this.isEmail,
    this.isForgotPassword,
  });

  AuthSelectOtpTypeRequest copyWith({
    String? phoneOrEmail,
    bool? isPhoneNumber,
    bool? isEmail,
    bool? isForgotPassword,
  }) {
    return AuthSelectOtpTypeRequest(
      phoneOrEmail: phoneOrEmail ?? this.phoneOrEmail,
      isPhoneNumber: isPhoneNumber ?? this.isPhoneNumber,
      isEmail: isEmail ?? this.isEmail,
      isForgotPassword: isForgotPassword ?? this.isForgotPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneOrEmail': phoneOrEmail,
      'isPhoneNumber': isPhoneNumber,
      'isEmail': isEmail,
      'isForgotPassword': isForgotPassword,
    };
  }

  factory AuthSelectOtpTypeRequest.fromMap(Map<String, dynamic> map) {
    return AuthSelectOtpTypeRequest(
      phoneOrEmail: map['phoneOrEmail'] as String,
      isPhoneNumber: map['isPhoneNumber'] != null ? map['isPhoneNumber'] as bool : null,
      isEmail: map['isEmail'] != null ? map['isEmail'] as bool : null,
      isForgotPassword: map['isForgotPassword'] != null ? map['isForgotPassword'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthSelectOtpTypeRequest.fromJson(String source) =>
      AuthSelectOtpTypeRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthSelectOtpTypeRequest(phoneOrEmail: $phoneOrEmail, isPhoneNumber: $isPhoneNumber, isEmail: $isEmail, isForgotPassword: $isForgotPassword)';
  }

  @override
  bool operator ==(covariant AuthSelectOtpTypeRequest other) {
    if (identical(this, other)) return true;

    return other.phoneOrEmail == phoneOrEmail &&
        other.isPhoneNumber == isPhoneNumber &&
        other.isEmail == isEmail &&
        other.isForgotPassword == isForgotPassword;
  }

  @override
  int get hashCode {
    return phoneOrEmail.hashCode ^ isPhoneNumber.hashCode ^ isEmail.hashCode ^ isForgotPassword.hashCode;
  }
}
