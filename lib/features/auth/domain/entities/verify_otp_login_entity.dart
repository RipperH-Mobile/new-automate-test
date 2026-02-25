import 'package:uchat/core/domain/entities/user_entity.dart';

class VerifyOtpLoginEntity {
  final String? token;
  final UserEntity? account;

  const VerifyOtpLoginEntity({
    this.token,
    this.account,
  });
}