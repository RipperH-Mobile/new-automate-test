import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';

class LinkAccountWithFacebookArguments {
  final UserEntity user;
  final LinkAccountAuthEntity linkAccountModel;
  final bool setupPassword;

  LinkAccountWithFacebookArguments({
    required this.user,
    required this.linkAccountModel,
    this.setupPassword = false,
  });
}
