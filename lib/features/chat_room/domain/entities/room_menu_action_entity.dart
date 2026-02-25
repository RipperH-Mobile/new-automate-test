import 'package:uchat/features/chat_room/data/models/models/room_menu_action_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_menu_command_arg_entity.dart';

/// Entity to store data required for room menu action.
class RoomMenuActionEntity {
  /// User defined name of this action.
  final String title;

  // TODO Change this from String to enum
  /// What type of action this menu will do. Its value will be one of constant value command in [RoomMenuActionModel]
  final String command;

  /// Entity to store data required for room menu action's specific task.
  final RoomMenuCommandArgEntity commandArg;

  RoomMenuActionEntity({
    required this.title,
    required this.command,
    required this.commandArg,
  });
}
