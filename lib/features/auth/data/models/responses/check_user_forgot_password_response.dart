import 'package:uchat/features/auth/domain/entities/check_user_forgot_password_entity.dart';

class CheckUserForgotPasswordResponse {
  final String? email;
  final String phoneNumber;

  CheckUserForgotPasswordResponse({
    this.email,
    required this.phoneNumber,
  });

  // from json
  factory CheckUserForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return CheckUserForgotPasswordResponse(
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  CheckUserForgotPasswordEntity toEntity() {
    return CheckUserForgotPasswordEntity(
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
