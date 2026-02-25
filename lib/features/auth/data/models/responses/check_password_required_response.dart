import 'package:uchat/features/auth/domain/entities/check_password_required_entity.dart';

class CheckPasswordRequiredResponse {
  final bool passwordRequired;

  CheckPasswordRequiredResponse({
    required this.passwordRequired,
  });

  factory CheckPasswordRequiredResponse.fromJson(Map<String, dynamic> json) => CheckPasswordRequiredResponse(
        passwordRequired: json['passwordRequired'] ?? false,
      );

  CheckPasswordRequiredEntity toEntity() {
    return CheckPasswordRequiredEntity(
      passwordRequired: passwordRequired,
    );
  }
}
