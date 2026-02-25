import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';

class LoginWithPhoneNumberArguments {
  final LinkAccountAuthEntity linkAccountModel;

  LoginWithPhoneNumberArguments({
    required this.linkAccountModel,
  });
}
