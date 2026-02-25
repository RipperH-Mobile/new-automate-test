import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';
import 'package:uchat/features/contact/presentation/views/sections/section.dart';

class ContactSearchResultSection implements Section<ContactSearchResultModel> {
  @override
  bool expanded = true;

  @override
  String header;

  @override
  int? amount;

  @override
  List<ContactSearchResultModel> items;

  ContactSearchResultSection(this.header, this.items, this.amount);

  @override
  List<ContactSearchResultModel> getItems() => items;

  @override
  bool isSectionExpanded() => expanded;

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}
