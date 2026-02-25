import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/features/auth/domain/entities/check_password_entity.dart';

sealed class CheckPasswordResponse {}

class CheckPasswordResponseUnableTwoFa extends CheckPasswordResponse {
  final String? token;
  final String? firebaseToken;
  final UserCollection? account;

  CheckPasswordResponseUnableTwoFa({
    this.token,
    this.firebaseToken,
    this.account,
  });

  factory CheckPasswordResponseUnableTwoFa.fromJson(Map<String, dynamic> json) {
    return CheckPasswordResponseUnableTwoFa(
      token: json['token'],
      firebaseToken: json['firebaseToken'],
      account: json['account'] != null ? UserCollection.fromMap(json['account']) : null,
    );
  }

  CheckPasswordEntityUnableTwoFa toEntity() {
    return CheckPasswordEntityUnableTwoFa(
      token: token,
      firebaseToken: firebaseToken,
      account: account?.toEntity(),
    );
  }
}

class CheckPasswordResponseEnableTwoFa extends CheckPasswordResponse {
  final String phoneNumber;
  final String email;

  CheckPasswordResponseEnableTwoFa({
    required this.phoneNumber,
    required this.email,
  });

  factory CheckPasswordResponseEnableTwoFa.fromJson(Map<String, dynamic> json) {
    return CheckPasswordResponseEnableTwoFa(
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
    );
  }

  CheckPasswordEntityEnableTwoFa toEntity() {
    return CheckPasswordEntityEnableTwoFa(
      phoneNumber: phoneNumber,
      email: email,
    );
  }
}
