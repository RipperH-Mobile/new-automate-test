import 'package:uchat/entities/models/room_data_model.dart';

import 'section.dart';

class GroupSection implements Section<RoomDataModel> {
  @override
  bool expanded = true;

  @override
  List<RoomDataModel> items;

  @override
  String header;

  @override
  int? amount;

  GroupSection(this.header, this.items, this.amount);

  @override
  List<RoomDataModel> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}
