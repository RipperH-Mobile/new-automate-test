import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';

class LoginPasswordArguments {
  final String? phone;
  final String? email;
  final String? countryCode;
  final int? cooldown;
  final LinkAccountAuthEntity? linkAccountModel;

  LoginPasswordArguments({
    this.phone,
    this.email,
    this.countryCode,
    this.cooldown,
    this.linkAccountModel,
  });
}
