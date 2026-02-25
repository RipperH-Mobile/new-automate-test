import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_folder/domain/enums/chat_folder_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';

class ChatFolderEntity {
  /// ChatFolderEntity is a model that represent a chat folder from ChatFolderCollection in local database
  final String id;
  final String name;
  final ChatFolderType type;
  final int seq;

  /// Below properties are optional
  /// because it is local data only
  ///
  /// ⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄
  /// Start: Optional properties
  ///
  final ChatOrderType? orderType;
  final bool? isUnread;
  final bool? isHidden;
  final bool? deleted;
  ///
  /// End: Optional properties
  /// ⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃⌃

  /// List of room subscriptions
  /// from load of use case.
  // TODO: Change to RoomSubscriptionEntity
  final List<RoomSubscriptionCollection>? roomSubscriptions;

  /// Constructor
  /// Required properties are:
  /// - [id] is the id of ChatFolderCollection
  /// - [name] is the name of ChatFolderCollection
  /// - [type] is the type of ChatFolderCollection
  /// - [seq] is the seq of ChatFolderCollection
  ChatFolderEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.seq,
    this.orderType,
    this.isUnread,
    this.isHidden,
    this.deleted,
    this.roomSubscriptions,
  });

  ///
  /// Convert Map to ChatFolderEntity
  ///
  factory ChatFolderEntity.fromMap(Map<String, dynamic> map) {
    return ChatFolderEntity(
      id: map['_id'] as String,
      name: map['name'] as String,
      seq: map['seq'] as int,
      deleted: map['deleted'] as bool?,
      type: ChatFolderType.fromString(map['type']),
    );
  }

  ///
  /// Helper method to convert ChatFolderEntity to Map
  ///
  ChatFolderEntity copyWith({
    String? id,
    String? name,
    ChatFolderType? type,
    int? seq,
    ChatOrderType? orderType,
    bool? isUnread,
    bool? isHidden,
    bool? deleted,
    bool? isRecommended,
    List<RoomSubscriptionCollection>? roomSubscriptions,
  }) {
    return ChatFolderEntity.copyWith(
      chatFolder: this,
      id: id,
      name: name,
      type: type,
      seq: seq,
      orderType: orderType,
      isUnread: isUnread,
      isHidden: isHidden,
      deleted: deleted,
      roomSubscriptions: roomSubscriptions,
    );
  }

  ///
  /// Copy with method to create a new instance of ChatFolderEntity
  ///
  factory ChatFolderEntity.copyWith({
    required ChatFolderEntity chatFolder,
    String? id,
    String? name,
    ChatFolderType? type,
    int? seq,
    ChatOrderType? orderType,
    bool? isUnread,
    bool? isHidden,
    bool? deleted,
    List<RoomSubscriptionCollection>? roomSubscriptions,
  }) {
    return ChatFolderEntity(
      id: id ?? chatFolder.id,
      name: name ?? chatFolder.name,
      type: type ?? chatFolder.type,
      seq: seq ?? chatFolder.seq,
      orderType: orderType ?? chatFolder.orderType,
      isUnread: isUnread ?? chatFolder.isUnread,
      isHidden: isHidden ?? chatFolder.isHidden,
      deleted: deleted ?? chatFolder.deleted,
      roomSubscriptions: roomSubscriptions ?? chatFolder.roomSubscriptions,
    );
  }

  bool get isRecommended {
    return type != ChatFolderType.normal && type != ChatFolderType.all;
  }

  String get displayName {
    if (isRecommended || type == ChatFolderType.all) {
      return type.displayName;
    } else {
      return name;
    }
  }

  @override
  String toString() {
    return 'ChatFolderEntity(id: $id, name: $name, type: $type, orderType: $orderType, seq: $seq, isUnread: $isUnread, isHidden: $isHidden, deleted: $deleted, roomSubscriptions: $roomSubscriptions)';
  }

  @override
  bool operator ==(covariant ChatFolderEntity other) {
    return identical(this, other) || other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
