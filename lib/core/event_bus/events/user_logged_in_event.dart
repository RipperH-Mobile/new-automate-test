import 'package:uchat/core/domain/entities/user_entity.dart';

@Deprecated('Use hookUserAfterLoaded instead')
class UserLoggedInEvent {
  UserEntity user;

  UserLoggedInEvent({required this.user});

  @override
  String toString() => 'UserLoggedInEvent(user: $user)';
}
