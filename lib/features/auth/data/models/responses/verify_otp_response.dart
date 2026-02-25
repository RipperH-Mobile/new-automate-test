import 'package:uchat/features/auth/domain/entities/verify_otp_entity.dart';

class VerifyOtpResponse {
  final String actionToken;
  final String actionName;
  final String accountId;

  VerifyOtpResponse({
    required this.actionToken,
    required this.actionName,
    required this.accountId,
  });

  Map<String, dynamic> toJson() => {
        'actionToken': actionToken,
        'actionName': actionName,
        'accountId': accountId,
      };

  factory VerifyOtpResponse.fromMap(Map<String, dynamic> map) {
    return VerifyOtpResponse(
      actionToken: map['actionToken'],
      actionName: map['actionName'],
      accountId: map['accountId'] ?? '',
    );
  }

  VerifyOtpEntity toEntity() {
    return VerifyOtpEntity(
      actionToken: actionToken,
      actionName: actionName,
      accountId: accountId,
    );
  }
}
