import 'package:uchat/features/auth/domain/entities/check_user_entity.dart';

sealed class CheckUserResponse {}

class CheckUserOtpResponse extends CheckUserResponse {
  final String? token;
  final String? ref;
  final String? type;
  final DateTime? firstGet;
  final DateTime? timeout;
  final String? phoneNumber;
  final String? email;
  final String? actionToken;

  CheckUserOtpResponse({
    this.token,
    this.ref,
    this.type,
    this.firstGet,
    this.timeout,
    this.phoneNumber,
    this.email,
    this.actionToken,
  });

  // from json
  factory CheckUserOtpResponse.fromJson(Map<String, dynamic> json) {
    return CheckUserOtpResponse(
      token: json['token'],
      ref: json['ref'],
      type: json['type'],
      firstGet: DateTime.parse(json['firstGet'] ?? DateTime.now().toString()),
      timeout: DateTime.parse(json['timeout'] ?? DateTime.now().add(const Duration(minutes: 1)).toString()),
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      actionToken: json['actionToken'],
    );
  }

  CheckUserOtpEntity toEntity() {
    return CheckUserOtpEntity(
      token: token,
      ref: ref,
      type: type,
      firstGet: firstGet,
      timeout: timeout,
      phoneNumber: phoneNumber,
      email: email,
      actionToken: actionToken,
    );
  }
}

class CheckUserPasswordResponse extends CheckUserResponse {
  final bool? passwordRequired;

  CheckUserPasswordResponse({
    this.passwordRequired,
  });

  // from json
  factory CheckUserPasswordResponse.fromJson(Map<String, dynamic> json) {
    return CheckUserPasswordResponse(
      passwordRequired: json['passwordRequired'],
    );
  }

  CheckUserPasswordEntity toEntity() {
    return CheckUserPasswordEntity(
      passwordRequired: passwordRequired,
    );
  }
}
