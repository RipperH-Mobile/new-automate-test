import 'package:isar_community/isar.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_meta_entity.dart';

// import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

part 'room_meta_model.g.dart';

// final _log = useLogger();

@embedded
class RoomMetaModel {
  RoomMenuModel? menu;

  RoomMetaModel({
    this.menu,
  });

  factory RoomMetaModel.fromMap(Map<String, dynamic> json) {
    RoomMetaModel roomMenu = RoomMetaModel();

    if (json['menu'] != null) {
      roomMenu.menu = RoomMenuModel.fromMap(json['menu']);
    }

    return roomMenu;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (menu != null) {
      data['menu'] = menu!.toMap();
    }
    return data;
  }

  RoomMetaEntity toEntity() {
    return RoomMetaEntity(
      menu: menu?.toEntity(),
    );
  }

  static RoomMetaModel fromEntity(RoomMetaEntity entity) {
    return RoomMetaModel(
      menu: entity.menu != null ? RoomMenuModel.fromEntity(entity.menu!) : null,
    );
  }
}
