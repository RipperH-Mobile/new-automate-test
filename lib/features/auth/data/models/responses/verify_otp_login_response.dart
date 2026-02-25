import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_login_entity.dart';

class VerifyOtpLoginResponse {
  final String? token;
  final UserCollection? account;

  VerifyOtpLoginResponse({
    this.token,
    this.account,
  });

  factory VerifyOtpLoginResponse.fromJson(Map<String, dynamic> json) {
    final account = json['account'] != null ? UserCollection.fromMap(json['account']) : null;
    account?.firebaseToken = json['firebaseToken'];
    return VerifyOtpLoginResponse(
      token: json['token'],
      account: account,
    );
  }

  VerifyOtpLoginEntity toEntity() {
    return VerifyOtpLoginEntity(
      token: token,
      account: account?.toEntity(),
    );
  }
}
