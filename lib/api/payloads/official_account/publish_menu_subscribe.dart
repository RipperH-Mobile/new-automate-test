import 'package:uchat/entities/models.dart';

class PublishMenuSubscribe {
  String? id;
  OfficialMenuModel? menu;
  DateTime? lastUpdatedAt;

  PublishMenuSubscribe({
    this.id,
    this.menu,
    this.lastUpdatedAt,
  });

  factory PublishMenuSubscribe.fromMap(Map<String, dynamic> json) {
    final publishMenuResp = PublishMenuSubscribe();

    if (json['id'] != null) {
      publishMenuResp.id = json['id'];
    }

    if (json['menu'] != null) {
      final menu = OfficialMenuModel.fromMap(json['menu']);
      menu.lastUpdatedAt = DateTime.parse(json['updatedAt'].toString());

      publishMenuResp.menu = menu;
      publishMenuResp.lastUpdatedAt = menu.lastUpdatedAt;
    } else {
      if (json['updatedAt'] != null) {
        publishMenuResp.lastUpdatedAt = DateTime.parse(json['updatedAt'].toString());
      }
    }
    return publishMenuResp;
  }
}
