import 'package:isar_community/isar.dart';

part 'official_menu_command_arg_model.g.dart';

@embedded
class OfficialMenuCommandArgModel {
  String? username;
  String? roomGroupId;
  String? url;

  OfficialMenuCommandArgModel({
    this.username,
    this.roomGroupId,
    this.url,
  });

  factory OfficialMenuCommandArgModel.fromMap(Map<String, dynamic> data) {
    var arg = OfficialMenuCommandArgModel();

    if (data['username'] != null) {
      arg.username = data['username']['value'];
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
    return {
      'username': username,
      'roomGroupId': roomGroupId,
      'url': url,
    };
  }
}
