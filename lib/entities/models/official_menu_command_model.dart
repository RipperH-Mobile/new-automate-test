import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models.dart';

part 'official_menu_command_model.g.dart';

@embedded
class OfficialMenuCommandModel {
  // Possibility of command
  static const commandNone = 'NONE';
  static const commandAddFriendAndChat = 'ADD_FRIEND_AND_CHAT';
  static const commandOpenUrl = 'OPEN_URL';
  static const commandJoinGroup = 'JOIN_GROUP';

  // Possibility of aspect ratio
  static const ratioSixtyNine = '16:9';
  static const ratioFourThree = '4:3';

  String? command;
  double? width;
  double? height;
  int? x;
  int? y;
  String? imageFileId;
  OfficialMenuCommandArgModel? arg;

  OfficialMenuCommandModel({
    this.command,
    this.width,
    this.height,
    this.imageFileId,
  });

  factory OfficialMenuCommandModel.fromMap(Map<String, dynamic> data) {
    var command = OfficialMenuCommandModel();
    command.command = data['command'] as String;

    if (data['width'] is int) {
      command.width = (data['width'] as int).toDouble();
    } else if (data['width'] is double) {
      command.width = data['width'] as double;
    }

    if (data['height'] is int) {
      command.height = (data['height'] as int).toDouble();
    } else if (data['height'] is double) {
      command.height = data['height'] as double;
    }

    if (data['x'] is int) {
      command.x = data['x'] as int;
    } else if (data['x'] is double) {
      command.x = (data['x'] as double).toInt();
    }

    if (data['y'] is int) {
      command.y = data['y'] as int;
    } else if (data['y'] is double) {
      command.y = (data['y'] as double).toInt();
    }

    command.imageFileId = data['imageFileId'] as String?;
    if (data['commandArg'] != null) {
      command.arg = OfficialMenuCommandArgModel.fromMap(data['commandArg']);
    }

    return command;
  }

  bool get isCmdAddFriendAndChat {
    return command == OfficialMenuCommandModel.commandAddFriendAndChat;
  }

  bool get isCmdOpenUrl {
    return command == OfficialMenuCommandModel.commandOpenUrl;
  }

  bool get isJoinGroup {
    return command == OfficialMenuCommandModel.commandJoinGroup;
  }

  Map<String, dynamic> toMap() {
    return {
      'command': command,
      'width': width,
      'height': height,
      'x': x,
      'y': y,
      'imageFileId': imageFileId,
      'commandArg': arg?.toMap(),
    };
  }
}
