import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

abstract class Section<M> extends ExpandableListSection<M> {
  bool expanded = true;
  late List<M> items;
  late String header;
  late int? amount;
}
