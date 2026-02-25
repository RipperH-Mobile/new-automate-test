import 'package:isar_community/isar.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_action_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_menu_action_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_menu_entity.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

part 'room_menu_model.g.dart';

final _log = useLogger();

@embedded
class RoomMenuModel {
  List<RoomMenuActionModel> draftMenu;
  List<RoomMenuActionModel> publishMenu;
  DateTime? updatedAt;
  DateTime? publishedAt;

  RoomMenuModel({
    this.draftMenu = const [],
    this.publishMenu = const [],
    this.updatedAt,
    this.publishedAt,
  });

  factory RoomMenuModel.fromMap(Map<String, dynamic> json) {
    RoomMenuModel roomMenu = RoomMenuModel();
    _log.d('publishedAt: ${json['publishedAt']}');

    if (json['draftMenu'] != null) {
      roomMenu.draftMenu = [];
      for (Map<String, dynamic> menu in json['draftMenu']) {
        roomMenu.draftMenu.add(RoomMenuActionModel.fromMap(menu));
      }
    }

    if (json['publishMenu'] != null) {
      roomMenu.publishMenu = [];
      for (Map<String, dynamic> menu in json['publishMenu']) {
        roomMenu.publishMenu.add(RoomMenuActionModel.fromMap(menu));
      }
    }

    if (json['updatedAt'] != null) {
      roomMenu.updatedAt = strToDateTime(json['updatedAt']);
    }

    if (json['publishedAt'] != null) {
      roomMenu.publishedAt = strToDateTime(json['publishedAt']);
    }

    return roomMenu;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['draftMenu'] = draftMenu.map((v) => v.toMap()).toList();
    data['publishMenu'] = publishMenu.map((v) => v.toMap()).toList();
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt!.toUtc().toIso8601String();
    }
    if (publishedAt != null) {
      data['publishedAt'] = publishedAt!.toUtc().toIso8601String();
    }
    return data;
  }

  RoomMenuEntity toEntity() {
    List<RoomMenuActionEntity> draftMenuEntities = [];
    List<RoomMenuActionEntity> publishMenuEntities = [];
    for (final menuAction in draftMenu) {
      draftMenuEntities.add(menuAction.toEntity());
    }

    for (final menuAction in publishMenu) {
      publishMenuEntities.add(menuAction.toEntity());
    }

    return RoomMenuEntity(
      draftMenu: draftMenuEntities,
      publishMenu: publishMenuEntities,
      updatedAt: updatedAt,
      publishedAt: publishedAt,
    );
  }

  static RoomMenuModel fromEntity(RoomMenuEntity entity) {
    List<RoomMenuActionModel> draftMenu = entity.draftMenu.map((e) => RoomMenuActionModel.fromEntity(e)).toList();
    List<RoomMenuActionModel> publishMenu = entity.publishMenu.map((e) => RoomMenuActionModel.fromEntity(e)).toList();

    return RoomMenuModel(
      draftMenu: draftMenu,
      publishMenu: publishMenu,
      updatedAt: entity.updatedAt,
      publishedAt: entity.publishedAt,
    );
  }
}
