import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';

class PinMessageEntity {
  final String? id;
  final String? ref;
  final String? pinnedBy;
  final String? roomId;
  final String? parentId;
  final DateTime? createdAt;
  final MessageEntity? message;

  const PinMessageEntity({
    this.id,
    this.ref,
    this.pinnedBy,
    this.roomId,
    this.parentId,
    this.createdAt,
    this.message,
  });

  PinMessageEntity copyWith({
    String? id,
    String? ref,
    String? pinnedBy,
    String? roomId,
    String? parentId,
    DateTime? createdAt,
    MessageEntity? message,
  }) {
    return PinMessageEntity(
      id: id ?? this.id,
      ref: ref ?? this.ref,
      pinnedBy: pinnedBy ?? this.pinnedBy,
      roomId: roomId ?? this.roomId,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PinMessageEntity &&
        other.id == id &&
        other.ref == ref &&
        other.pinnedBy == pinnedBy &&
        other.roomId == roomId &&
        other.parentId == parentId &&
        other.createdAt == createdAt &&
        other.message == message;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ref.hashCode ^
        pinnedBy.hashCode ^
        roomId.hashCode ^
        parentId.hashCode ^
        createdAt.hashCode ^
        message.hashCode;
  }

  @override
  String toString() {
    return 'PinMessageEntity(id: $id, ref: $ref, pinnedBy: $pinnedBy, roomId: $roomId, parentId: $parentId, createdAt: $createdAt, message: $message)';
  }
}
