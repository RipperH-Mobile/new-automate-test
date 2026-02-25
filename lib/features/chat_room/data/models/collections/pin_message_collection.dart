import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/album_task_model.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/features/chat_room/data/models/models/deleted_by_account_model.dart';
import 'package:uchat/features/chat_room/data/models/models/last_emoji_model.dart';
import 'package:uchat/features/chat_room/data/models/models/mention_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_payload_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_video_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_member_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_model.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'pin_message_collection.g.dart';

@Collection(accessor: 'pinMessage')
@Name('PinMessage')
class PinMessageCollection {
  @Index()
  String? id;

  Id get isarId => fastHash(ref ?? id!);

  @Index()
  String? ref;

  String? pinnedBy;

  @Index()
  String? roomId;

  String? parentId;

  DateTime? createdAt;

  // Use MessageModel for the message field
  MessageModel? message;

  PinMessageCollection();

  PinMessageCollection.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    ref = json['ref'];
    pinnedBy = json['pinnedBy'];
    roomId = json['roomId'];
    parentId = json['parentId'];
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;

    // Parse nested message object using MessageModel
    if (json['message'] != null) {
      final messageMap = json['message'];
      messageMap['roomId'] = roomId;
      messageMap['ref'] = ref;
      message = MessageModel.fromMap(messageMap);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'ref': ref,
      'pinnedBy': pinnedBy,
      'roomId': roomId,
      'parentId': parentId,
      'createdAt': createdAt?.toIso8601String(),
      'message': message?.toMap(),
    };
  }

  @override
  String toString() {
    return 'PinMessageCollection(id: $id, ref: $ref, pinnedBy: $pinnedBy, roomId: $roomId, messageId: ${message?.id})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PinMessageCollection &&
        other.id == id &&
        other.ref == ref &&
        other.pinnedBy == pinnedBy &&
        other.roomId == roomId &&
        other.message?.id == message?.id;
  }

  @override
  int get hashCode {
    return id.hashCode ^ ref.hashCode ^ pinnedBy.hashCode ^ roomId.hashCode ^ (message?.id?.hashCode ?? 0);
  }
}
