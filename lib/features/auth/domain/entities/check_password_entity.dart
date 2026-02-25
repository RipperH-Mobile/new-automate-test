import 'package:uchat/core/domain/entities/user_entity.dart';

sealed class CheckPasswordEntity {}

class CheckPasswordEntityUnableTwoFa extends CheckPasswordEntity {
  final String? token;
  final String? firebaseToken;
  final UserEntity? account;

  CheckPasswordEntityUnableTwoFa({
    this.token,
    this.firebaseToken,
    this.account,
  });
}

class CheckPasswordEntityEnableTwoFa extends CheckPasswordEntity {
  final String phoneNumber;
  final String email;

  CheckPasswordEntityEnableTwoFa({
    required this.phoneNumber,
    required this.email,
  });
}
