import 'package:isar_community/isar.dart';
import 'package:uchat/features/chat_room/domain/entities/room_menu_command_arg_entity.dart';

part 'room_menu_command_arg_model.g.dart';

@embedded
class RoomMenuCommandArgModel {
  String? username;
  String? roomGroupId;
  String? url;

  RoomMenuCommandArgModel({
    this.username,
    this.roomGroupId,
    this.url,
  });

  factory RoomMenuCommandArgModel.fromMap(Map<String, dynamic> data) {
    var arg = RoomMenuCommandArgModel();

    if (data['username'] != null) {
      arg.username = data['username'];
    }

    if (data['roomGroupId'] != null) {
      arg.roomGroupId = data['roomGroupId'];
    }

    if (data['url'] != null) {
      arg.url = data['url'];
    }

    return arg;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (username != null) data['username'] = username;
    if (roomGroupId != null) data['roomGroupId'] = roomGroupId;
    if (url != null) data['url'] = url;
    return data;
  }

  RoomMenuCommandArgEntity toEntity() {
    if (username == null && roomGroupId == null && url == null) {
      // TODO (exception) This should change to UChat exception class.
      // This data should always have at least 1 non null variable. If everything is null that should mean this data is incorrect.
      throw Exception('Can not create entity : Invalid model data');
    }

    return RoomMenuCommandArgEntity(
      username: username,
      roomGroupId: roomGroupId,
      url: url,
    );
  }

  static RoomMenuCommandArgModel fromEntity(RoomMenuCommandArgEntity entity) {
    return RoomMenuCommandArgModel(
      username: entity.username,
      roomGroupId: entity.roomGroupId,
      url: entity.url,
    );
  }
}
