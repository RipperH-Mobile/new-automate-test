import 'package:uchat/entities/models/official_menu_model.dart';

class OaMenuPublishEvent {
  String id;
  OfficialMenuModel menu;
  DateTime? lastUpdatedAt;

  OaMenuPublishEvent({
    required this.id,
    required this.menu,
    required this.lastUpdatedAt,
  });

  @override
  String toString() => 'OaMenuPublishEvent(id: $id, menu: $menu, lastUpdatedAt: $lastUpdatedAt)';
}
