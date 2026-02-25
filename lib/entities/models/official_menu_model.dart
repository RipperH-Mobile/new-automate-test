import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models.dart';

part 'official_menu_model.g.dart';

@embedded
class OfficialMenuModel {
  OfficialMenuContainerModel? container;
  List<OfficialMenuCommandModel>? commands;
  DateTime? lastUpdatedAt;

  OfficialMenuModel({
    this.container,
    this.commands,
  });

  factory OfficialMenuModel.fromMap(Map<String, dynamic> data) {
    /**
     * FROM JSON
     *
     * {
     *     lastUpdatedAt: DateTime,
     *     container: {
     *       aspectRatio: String['16:9','4:3'],
     *       width: Float,
     *       height: Float,
     *       imageFileId: String
     *     },
     *     commands: [
     *       {
     *         command: String[''],
     *         width: Float,
     *         height: Float,
     *         x: Int,
     *         y: Int,
     *         imageFileId: String,
     *         commandArg: {
     *           username: String, // When command is ''
     *           url: String, // When command is ''
     *         },
     *       }
     *     ],
     * }
     */
    var menu = OfficialMenuModel();

    if (data['last_update_at'] != null) {
      menu.lastUpdatedAt = DateTime.parse(data['last_update_at'] as String);
    }

    if (data['container'] != null) {
      menu.container = OfficialMenuContainerModel.fromMap(data['container']);
    }

    if (data['functions'] != null) {
      for (var data in data['functions']) {
        menu.commands ??= <OfficialMenuCommandModel>[];

        menu.commands!.add(OfficialMenuCommandModel.fromMap(data));
      }
    }

    return menu;
  }

  @override
  String toString() {
    return 'LastUpdatedAt: $lastUpdatedAt, CommandLength: ${commands?.length ?? 0}, Container: $container';
  }

  Map<String, dynamic> toMap() {
    return {
      'last_update_at': lastUpdatedAt?.toIso8601String(),
      'container': container?.toMap(),
      'functions': commands?.map((e) => e.toMap()).toList(),
    };
  }
}
