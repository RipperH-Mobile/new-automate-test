import 'package:uchat/core/domain/entities/user_entity.dart';

class AccountUpdatedEvent {
  final UserEntity user;

  AccountUpdatedEvent(this.user);
}
