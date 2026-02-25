import 'package:isar_community/isar.dart';
import 'package:uchat/utils/datetime.dart';

part 'rich_menu_model.g.dart';

/// Rich Menu Response Model
/// Represents the complete rich menu response from the API
@embedded
class RichMenuModel {
  final String? officialAccountId;
  final DateTime? updatedAt;
  final RichMenuPublishModel? publishMenu;
  final DateTime? publishedAt;

  RichMenuModel({
    this.officialAccountId,
    this.updatedAt,
    this.publishMenu,
    this.publishedAt,
  });

  factory RichMenuModel.fromJson(Map<String, dynamic> json) {
    return RichMenuModel(
      officialAccountId: json['officialAccountId'] as String?,
      updatedAt: json['updatedAt'] != null ? strToDateTime(json['updatedAt']) : null,
      publishMenu: json['publishMenu'] != null ? RichMenuPublishModel.fromJson(json['publishMenu']) : null,
      publishedAt: json['publishedAt'] != null ? strToDateTime(json['publishedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (officialAccountId != null) 'officialAccountId': officialAccountId,
      if (updatedAt != null) 'updatedAt': updatedAt!.toUtc().toIso8601String(),
      if (publishMenu != null) 'publishMenu': publishMenu!.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt!.toUtc().toIso8601String(),
    };
  }

  bool get hasPublishedMenu => publishMenu != null && publishMenu!.actions?.isNotEmpty == true;
}

/// Rich Menu Publish Model
/// Contains the container configuration and function areas
@embedded
class RichMenuPublishModel {
  final String? id;
  final RichMenuContainerModel? container;
  final List<RichMenuFunctionModel>? actions;

  RichMenuPublishModel({
    this.id,
    this.container,
    this.actions,
  });

  factory RichMenuPublishModel.fromJson(Map<String, dynamic> json) {
    return RichMenuPublishModel(
      id: json['_id'] as String?,
      container: RichMenuContainerModel.fromJson(json['container'] ?? {}),
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => RichMenuFunctionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'container': container?.toJson(),
      'actions': actions?.map((e) => e.toJson()).toList(),
    };
  }
}

/// Rich Menu Container Model
/// Defines the dimensions and background image of the rich menu
@embedded
class RichMenuContainerModel {
  final double width;
  final double height;
  final String? imageId;

  RichMenuContainerModel({
    this.width = 400,
    this.height = 300,
    this.imageId,
  });

  factory RichMenuContainerModel.fromJson(Map<String, dynamic> json) {
    return RichMenuContainerModel(
      width: (json['width'] as num?)?.toDouble() ?? 400,
      height: (json['height'] as num?)?.toDouble() ?? 300,
      imageId: json['imageId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      if (imageId != null) 'imageId': imageId,
    };
  }
}

/// Rich Menu Bounds Model
/// Represents the position and size of a clickable area
@embedded
class RichMenuBoundsModel {
  final double x;
  final double y;
  final double width;
  final double height;

  RichMenuBoundsModel({
    this.x = 0,
    this.y = 0,
    this.width = 0,
    this.height = 0,
  });

  factory RichMenuBoundsModel.fromJson(Map<String, dynamic> json) {
    return RichMenuBoundsModel(
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    };
  }
}

/// Rich Menu Function Model
/// Represents a clickable area in the rich menu
@embedded
class RichMenuFunctionModel {
  final int? index;
  final String? command;
  final RichMenuBoundsModel? bounds;
  final RichMenuCommandArgModel? commandArg;

  RichMenuFunctionModel({
    this.index,
    this.command,
    this.bounds,
    this.commandArg,
  });

  /// Command types
  static const String commandNone = 'NONE';
  static const String commandOpenUrl = 'LINK';
  static const String commandSendMessage = 'TEXT';

  factory RichMenuFunctionModel.fromJson(Map<String, dynamic> json) {
    return RichMenuFunctionModel(
      index: (json['index'] as num?)?.toInt(),
      command: json['command'] as String? ?? commandNone,
      bounds: json['bounds'] != null
          ? RichMenuBoundsModel.fromJson(Map<String, dynamic>.from(json['bounds'] as Map))
          : null,
      commandArg: json['commandArg'] != null
          ? RichMenuCommandArgModel.fromJson(Map<String, dynamic>.from(json['commandArg'] as Map))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (index != null) 'index': index,
      'command': command,
      if (bounds != null) 'bounds': bounds!.toJson(),
      if (commandArg != null) 'commandArg': commandArg!.toJson(),
    };
  }

  bool get isOpenUrl => command == commandOpenUrl;
  bool get isSendMessage => command == commandSendMessage;
  bool get isNone => command == commandNone;

  /// Convenience getters for bounds
  double? get x => bounds?.x;
  double? get y => bounds?.y;
  double? get width => bounds?.width;
  double? get height => bounds?.height;
}

/// Rich Menu Command Argument Model
/// Contains the arguments for each command type
@embedded
class RichMenuCommandArgModel {
  final String? url;
  final String? message;

  RichMenuCommandArgModel({
    this.url,
    this.message,
  });

  factory RichMenuCommandArgModel.fromJson(Map<String, dynamic> json) {
    return RichMenuCommandArgModel(
      url: json['url'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (url != null) 'url': url,
      if (message != null) 'message': message,
    };
  }
}
