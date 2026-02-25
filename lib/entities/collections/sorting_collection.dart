// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/chat_sorting_type.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'sorting_collection.g.dart';

@Collection(accessor: 'sortings')
@Name('Sorting')
class SortingCollection {
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id!);

  @Enumerated(EnumType.name)
  ChatSortingType? type;

  SortingCollection({
    this.id,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'type': type?.value,
    };
  }

  void update(SortingCollection other) {
    if (other.id != null) {
      id = other.id;
    }

    if (other.type != null) {
      type = other.type;
    }
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SortingCollection(id: $id, type: $type)';
  }
}
