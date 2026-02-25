import 'package:uchat/features/chat_room/domain/entities/room_menu_action_entity.dart';

/// Entity to store all room menu action data for a room.
class RoomMenuEntity {
  /// List of room menu action that is saved for this room but not published yet.
  final List<RoomMenuActionEntity> draftMenu;
  /// List of room menu action that is published and all user in this room can use.
  final List<RoomMenuActionEntity> publishMenu;
  final DateTime? updatedAt;
  final DateTime? publishedAt;

  RoomMenuEntity({
    required this.draftMenu,
    required this.publishMenu,
    this.updatedAt,
    this.publishedAt,
  });
}
