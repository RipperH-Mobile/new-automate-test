// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar_community/isar.dart';
import 'package:uchat/utils/fast_hash.dart';

import '../../../domain/entities/chat_folder_entity.dart';
import '../../../domain/enums/chat_folder_type.dart';
import '../../../domain/enums/chat_order_type.dart';

part 'chat_folder_collection.g.dart';

@Collection(accessor: 'chatFolders')
@Name('ChatFolder')
class ChatFolderCollection {
  @Index(unique: true, replace: true)
  String id;

  Id get isarId => fastHash(id);

  String? name;

  @Enumerated(EnumType.name)
  ChatFolderType? type;

  int? seq;

  /// Is local data only
  @Enumerated(EnumType.name)
  ChatOrderType orderType;

  /// Is local data only
  @Index()
  bool isUnread;

  /// Is local data only
  @Index()
  bool isHidden;

  ChatFolderCollection({
    required this.id,
    this.name,
    this.type,
    this.seq,
    this.orderType = ChatOrderType.unread,
    this.isUnread = false,
    this.isHidden = false,
  });

  void update(ChatFolderCollection other) {
    if (other.name != null) {
      name = other.name;
    }

    if (other.type != null) {
      type = other.type;
    }

    if (other.seq != null) {
      seq = other.seq;
    }

    orderType = other.orderType;
    isUnread = other.isUnread;
    isHidden = other.isHidden;
  }

  bool get isRecommended {
    return type != ChatFolderType.normal && type != ChatFolderType.all;
  }

  String get displayName {
    if (isRecommended || type == ChatFolderType.all) {
      return type?.displayName ?? '';
    } else {
      return name ?? '';
    }
  }

  factory ChatFolderCollection.fromEntity(ChatFolderEntity entity) {
    return ChatFolderCollection(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      seq: entity.seq,
      orderType: entity.orderType ?? ChatOrderType.unread,
      isUnread: entity.isUnread ?? false,
      isHidden: entity.isHidden ?? false,
    );
  }

  ChatFolderEntity toEntity() {
    return ChatFolderEntity(
      id: id,
      name: name!,
      type: type!,
      seq: seq!,
      orderType: orderType,
      isUnread: isUnread,
      isHidden: isHidden,
    );
  }

  @override
  String toString() {
    return 'ChatFolderCollection(id: $id, name: $name, type: $type, orderType: $orderType, seq: $seq, isUnread: $isUnread, isHidden: $isHidden)';
  }

  @override
  bool operator ==(covariant ChatFolderCollection other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
