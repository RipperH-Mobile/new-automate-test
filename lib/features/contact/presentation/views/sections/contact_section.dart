import 'package:uchat/entities/interfaces.dart';

import 'section.dart';

class ContactSection implements Section<ContactInterface> {
  @override
  bool expanded = true;

  @override
  List<ContactInterface> items;

  @override
  String header;

  @override
  int? amount;

  ContactSection(this.header, this.items, this.amount);

  @override
  List<ContactInterface> getItems() {
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
