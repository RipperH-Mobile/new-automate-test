import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/room_file_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'room_file_collection.g.dart';

@Collection(accessor: 'roomFiles')
@Name('RoomFile')
class RoomFileCollection {
  @Index(unique: true, replace: true)
  String? get id {
    return file?.id;
  }

  @Index()
  String? get accountId {
    return file?.accountId;
  }

  Id get isarId => fastHash(id!);

  @Index()
  String? roomId;

  MessageFileModel? file;

  @Index()
  @Index(composite: [CompositeIndex('roomId')])
  @Index(composite: [CompositeIndex('accountId')])
  @Enumerated(EnumType.name)
  RoomFileType? type;

  @Index()
  String? messageId;

  String? messageRef;

  @Index()
  int? messageSeq;

  @Index()
  DateTime? get createAt {
    return file?.createdAt;
  }

  bool? isHidden;
  bool? isDownload;

  /// RoomFileId for each file
  ///
  /// This field is used to store the file `_id` of the file in the room from the server
  ///
  /// This used to query the file from the server
  @Index()
  String? roomFileId;

  RoomFileCollection({
    this.roomId,
    this.file,
    this.type,
    this.messageId,
    this.messageRef,
    this.messageSeq,
    this.isHidden = false,
    this.isDownload,
    this.roomFileId,
  });

  static RoomFileCollection fromMap(Map<String, dynamic> data) {
    return RoomFileCollection(
      roomFileId: data['_id'],
      roomId: data['roomId'],
      type: RoomFileType.from(data['fileType']),
      messageId: data['messageId'],
      messageRef: data['ref'],
      messageSeq: data['messageSeq'] != null ? int.parse(data['messageSeq'], radix: 16) : null,
      file: MessageFileModel.fromMap(data),
    );
  }

  static List<RoomFileCollection> fromMessageCollection(MessageCollection message) {
    if (message.files == null) return [];
    List<RoomFileCollection> result = [];
    for (final file in message.files!) {
      result.add(RoomFileCollection(
        roomId: message.roomId,
        file: file,
        type: RoomFileType.from(message.type?.value ?? ''),
        messageId: message.id,
        messageRef: message.ref,
        messageSeq: message.sequence,
        roomFileId: file.roomFileId,
      ));
    }
    return result;
  }

  @Index()
  @Index(composite: [CompositeIndex('roomId')])
  @Index(composite: [CompositeIndex('accountId')])
  bool get isPhotosOrVideos {
    return type == RoomFileType.image || type == RoomFileType.video;
  }

  RoomFileEntity toEntity() {
    return RoomFileEntity(
      roomId: roomId,
      file: file!.toEntity(),
      type: type,
      messageId: messageId,
      messageRef: messageRef,
      messageSeq: messageSeq,
      isHidden: isHidden,
      isDownload: isDownload,
      roomFileId: roomFileId ?? file?.roomFileId,
    );
  }

  static RoomFileCollection fromEntity(RoomFileEntity entity) {
    return RoomFileCollection(
      roomId: entity.roomId,
      file: MessageFileModel.fromEntity(entity.file),
      type: entity.type,
      messageId: entity.messageId,
      messageRef: entity.messageRef,
      messageSeq: entity.messageSeq,
      isHidden: entity.isHidden,
      isDownload: entity.isDownload,
      roomFileId: entity.roomFileId,
    );
  }

  @override
  bool operator ==(covariant RoomFileCollection other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.roomFileId == roomFileId &&
        other.roomId == roomId &&
        other.type == type &&
        other.messageId == messageId &&
        other.messageSeq == messageSeq;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roomFileId.hashCode ^
        roomId.hashCode ^
        type.hashCode ^
        messageId.hashCode ^
        messageSeq.hashCode;
  }

  @override
  String toString() {
    return 'RoomFileCollection{roomId: $roomId, file: $file, type: $type, messageId: $messageId, messageRef: $messageRef, messageSeq: $messageSeq, isHidden: $isHidden, isDownload: $isDownload, createAt: $createAt, roomFileId: $roomFileId}';
  }
}
