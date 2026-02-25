import 'package:uchat/features/chat_room/data/models/collections/pin_message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';

/// Extensions for mapping between PinMessageCollection and PinMessageEntity
extension PinMessageCollectionMapper on PinMessageCollection {
  /// Convert collection to domain entity
  PinMessageEntity toEntity() {
    return PinMessageEntity(
      id: id,
      ref: ref,
      pinnedBy: pinnedBy,
      roomId: roomId,
      parentId: parentId,
      createdAt: createdAt,
      message: message?.toEntity(),
    );
  }
}

/// Extensions for mapping between PinMessageEntity and PinMessageCollection
extension PinMessageEntityMapper on PinMessageEntity {
  /// Convert domain entity to collection
  PinMessageCollection toCollection() {
    final collection = PinMessageCollection();

    collection.id = id;
    collection.ref = ref;
    collection.pinnedBy = pinnedBy;
    collection.roomId = roomId;
    collection.parentId = parentId;
    collection.createdAt = createdAt;
    collection.message = message?.toModel();

    return collection;
  }
}

/// Extensions for List<PinMessageCollection>
extension PinMessageCollectionListMapper on List<PinMessageCollection> {
  /// Convert list of collections to list of entities
  List<PinMessageEntity> toEntities() {
    return map((collection) => collection.toEntity()).toList();
  }
}

/// Extensions for List<PinMessageEntity>
extension PinMessageEntityListMapper on List<PinMessageEntity> {
  /// Convert list of entities to list of collections
  List<PinMessageCollection> toCollections() {
    return map((entity) => entity.toCollection()).toList();
  }
}
