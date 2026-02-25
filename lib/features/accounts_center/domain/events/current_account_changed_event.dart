import 'package:uchat/core/domain/entities/user_entity.dart';

class CurrentAccountChangedEvent {
  final UserEntity user;

  CurrentAccountChangedEvent(this.user);
}
