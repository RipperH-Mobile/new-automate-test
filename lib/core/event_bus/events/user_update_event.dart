import 'package:uchat/core/domain/entities/user_entity.dart';

class UserUpdateEvent {
  UserEntity user;

  UserUpdateEvent({required this.user});

  @override
  String toString() => 'UserUpdateEvent(user: $user)';
}
