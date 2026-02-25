// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/chat_category_type.dart';

import 'package:uchat/utils/fast_hash.dart';

part 'chat_category_collection.g.dart';

@Collection(accessor: 'chatCategorys')
@Name('ChatCategory')
class ChatCategoryCollection {
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id!);

  @Enumerated(EnumType.name)
  ChatCategoryType? type;

  @Index()
  bool isUnread;

  ChatCategoryCollection({
    this.id,
    this.type,
    this.isUnread = false,
  });

  void update(ChatCategoryCollection other) {
    if (other.id != null) {
      id = other.id;
    }

    if (other.type != null) {
      type = other.type;
    }

    isUnread = other.isUnread;
  }

  ChatCategoryCollection copyWith({
    String? id,
    ChatCategoryType? type,
    bool? isUnread,
  }) {
    return ChatCategoryCollection(
      id: id ?? this.id,
      type: type ?? this.type,
      isUnread: isUnread ?? this.isUnread,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'type': type?.value,
      'isUnread': isUnread,
    };
  }

  factory ChatCategoryCollection.fromMap(Map<String, dynamic> map) {
    return ChatCategoryCollection(
      id: map['_id'] != null ? map['_id'] as String : null,
      type: map['type'] != null ? ChatCategoryType.fromString(map['type'] as String) : null,
      isUnread: map['isUnread'] != null ? map['isUnread'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatCategoryCollection.fromJson(String source) =>
      ChatCategoryCollection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatFolderCollection(id: $id, type: $type,isUnread: $isUnread)';
  }
}
