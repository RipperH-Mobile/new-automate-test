import 'package:uchat/entities/models.dart';

// final _log = useLogger();

class GetMenuRequest {
  String officialAccountId;
  DateTime? lastUpdatedAt;

  GetMenuRequest({
    required this.officialAccountId,
    this.lastUpdatedAt,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'officialAccountId': officialAccountId,
    };

    if (lastUpdatedAt != null) {
      json['lastUpdatedAt'] = lastUpdatedAt!.toUtc().toIso8601String();
    }

    return json;
  }
}

class GetMenuResponse {
  OfficialMenuModel? menu;
  DateTime? lastUpdatedAt;

  GetMenuResponse({
    this.menu,
    this.lastUpdatedAt,
  });

  factory GetMenuResponse.fromMap(Map<String, dynamic> json) {
    // _log.d('GetMenu $json');
    if (json['menu'] != null) {
      final menu = OfficialMenuModel.fromMap(json['menu']);
      menu.lastUpdatedAt = DateTime.parse(json['updatedAt'].toString());

      return GetMenuResponse(
        menu: menu,
        lastUpdatedAt: menu.lastUpdatedAt,
      );
    } else {
      if (json['updatedAt'] != null) {
        return GetMenuResponse(
          lastUpdatedAt: DateTime.parse(json['updatedAt'].toString()),
        );
      }

      return GetMenuResponse();
    }
  }
}
