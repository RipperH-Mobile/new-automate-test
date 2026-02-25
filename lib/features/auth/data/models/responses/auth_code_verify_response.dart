import '../../../domain/entities/auth_code_verify_entity.dart';

class AuthCodeVerifyResponse {
  final bool success;

  AuthCodeVerifyResponse({
    required this.success,
  });

  factory AuthCodeVerifyResponse.fromMap(Map<String, dynamic> map) {
    return AuthCodeVerifyResponse(
      success: map['success'],
    );
  }

  AuthCodeVerifyEntity toEntity() {
    return AuthCodeVerifyEntity(
      success: success,
    );
  }
}
