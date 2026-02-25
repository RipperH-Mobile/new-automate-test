class RoomMenuRequest {
  final String roomId;
  final List<RoomMenuItemRequest> menu;

  RoomMenuRequest({
    required this.roomId,
    required this.menu,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'menu': menu.map((e) => e.toJson()).toList(),
    };
  }
}

class RoomMenuItemRequest {
  final String title;
  final String command;
  final Map<String, dynamic> commandArg;

  RoomMenuItemRequest({
    required this.title,
    required this.command,
    required this.commandArg,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'command': command,
      'commandArg': commandArg,
    };
  }
}
