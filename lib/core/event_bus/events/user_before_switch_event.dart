import 'package:uchat/entities/collections.dart';

class UserBeforeSwitchEvent {
  UserCollection fromUser;
  UserCollection toUser;

  UserBeforeSwitchEvent({
    required this.fromUser,
    required this.toUser,
  });

  @override
  String toString() => 'UserBeforeSwitchEvent(fromUser: $fromUser, toUser: $toUser)';
}
