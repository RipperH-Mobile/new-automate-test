import 'package:get/get.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/domain/entities/room_menu_action_entity.dart';

// import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

part 'room_menu_action_model.g.dart';

// final _log = useLogger();

@embedded
class RoomMenuActionModel {
  // Possibility of command
  static const commandNone = 'NONE';
  static const commandAddFriendAndChat = 'ADD_FRIEND_AND_CHAT';
  static const commandOpenUrl = 'OPEN_URL';
  static const commandJoinGroup = 'JOIN_GROUP';

  String? title;
  String? command;
  RoomMenuCommandArgModel? commandArg;

  RoomMenuActionModel({
    this.title,
    this.command,
    this.commandArg,
  });

  factory RoomMenuActionModel.fromMap(Map<String, dynamic> data) {
    var menu = RoomMenuActionModel();

    menu.title = data['title'];
    menu.command = data['command'];

    if (data['commandArg'] != null) {
      menu.commandArg = RoomMenuCommandArgModel.fromMap(data['commandArg']);
    }

    return menu;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (title != null) data['title'] = title;
    if (command != null) data['command'] = command;
    if (commandArg != null) data['commandArg'] = commandArg!.toMap();
    return data;
  }

  bool get isEmptyCommand {
    return command == null;
  }

  bool get isCmdAddFriendAndChat {
    return command == RoomMenuActionModel.commandAddFriendAndChat;
  }

  bool get isCmdOpenUrl {
    return command == RoomMenuActionModel.commandOpenUrl;
  }

  bool get isJoinGroup {
    return command == RoomMenuActionModel.commandJoinGroup;
  }

  String? get commandHumanName {
    if (isCmdAddFriendAndChat) {
      return 'Add friend and chat'.tr;
    } else if (isCmdOpenUrl) {
      return 'Open web / url'.tr;
    } else if (isJoinGroup) {
      return 'Join group'.tr;
    }
    return null;
  }

  String? get commandHumanValue {
    if (isCmdAddFriendAndChat) {
      return commandArg?.username;
    } else if (isCmdOpenUrl) {
      return commandArg?.url;
    } else if (isJoinGroup) {
      return commandArg?.roomGroupId;
    }
    return null;
  }

  RoomMenuActionEntity toEntity() {
    if (title == null || command == null || commandArg == null) {
      // TODO (exception) This should change to UChat exception class or model class should change this to non nullable.
      // This data / flow needed all 3 variable to work if any is missing should mean that data is incorrect.
      throw Exception('Can not create entity : Invalid model data');
    }

    return RoomMenuActionEntity(
      title: title!,
      command: command!,
      commandArg: commandArg!.toEntity(),
    );
  }

  static RoomMenuActionModel fromEntity(RoomMenuActionEntity entity) {
    return RoomMenuActionModel(
      title: entity.title,
      command: entity.command,
      commandArg: RoomMenuCommandArgModel.fromEntity(entity.commandArg),
    );
  }
}
