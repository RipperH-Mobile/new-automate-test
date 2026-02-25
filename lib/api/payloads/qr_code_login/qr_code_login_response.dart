import 'package:uchat/api/payloads.dart';
import 'package:uchat/entities/collections/user_collection.dart';

class QrCodeLoginResponse {
  final UserCollection account;
  final String token;
  final String hash;

  QrCodeLoginResponse({
    required this.account,
    required this.token,
    required this.hash,
  });

  factory QrCodeLoginResponse.fromMap(Map<String, dynamic> map) {
    return QrCodeLoginResponse(
      account: UserResponse.fromMap(map['account']).toUserCollection(),
      token: map['token'] != null ? map['token'] as String : '',
      hash: map['hash'] != null ? map['hash'] as String : '',
    );
  }
}
