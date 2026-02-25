import 'package:uchat/core/domain/entities/user_entity.dart';

class LoginWelcomeArguments {
  final UserEntity? user;
  final String? token;
  final bool waitSyncUserOnly;

  LoginWelcomeArguments({
    this.user,
    this.token,
    required this.waitSyncUserOnly,
  });
}
