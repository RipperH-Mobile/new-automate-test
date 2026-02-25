import 'package:uchat/entities/enum/room_file_type.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/message_file_entity.dart';

class RoomFileEntity {
  final String? roomId;
  final MessageFileEntity file;
  final RoomFileType? type;
  final String? messageId;
  final String? messageRef;
  final int? messageSeq;
  final bool? isHidden;
  final bool? isDownload;
  final DateTime? createAt;
  final String? roomFileId;

  String? get id {
    return file.id;
  }

  String? get accountId {
    return file.accountId;
  }

  bool get isPhotosOrVideos {
    return type == RoomFileType.image || type == RoomFileType.video;
  }

  RoomFileEntity({
    this.roomId,
    required this.file,
    this.type,
    this.messageId,
    this.messageRef,
    this.messageSeq,
    this.isHidden = false,
    this.isDownload,
    this.createAt,
    this.roomFileId,
  });

  RoomFileEntity copyWith({
    String? roomId,
    MessageFileEntity? file,
    RoomFileType? type,
    String? messageId,
    String? messageRef,
    int? messageSeq,
    bool? isHidden,
    bool? isDownload,
    DateTime? createAt,
    String? roomFileId,
  }) {
    return RoomFileEntity(
      roomId: roomId ?? this.roomId,
      file: file ?? this.file,
      type: type ?? this.type,
      messageId: messageId ?? this.messageId,
      messageRef: messageRef ?? this.messageRef,
      messageSeq: messageSeq ?? this.messageSeq,
      isHidden: isHidden ?? this.isHidden,
      isDownload: isDownload ?? this.isDownload,
      createAt: createAt ?? this.createAt,
      roomFileId: roomFileId ?? this.roomFileId,
    );
  }

  @override
  String toString() {
    return 'RoomFileEntity{roomId: $roomId, file: $file, type: $type, messageId: $messageId, messageRef: $messageRef, messageSeq: $messageSeq, isHidden: $isHidden, isDownload: $isDownload, createAt: $createAt, roomFileId: $roomFileId}';
  }
}
