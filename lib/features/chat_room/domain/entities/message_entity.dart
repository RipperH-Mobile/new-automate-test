import 'package:uchat/entities/enums.dart';

import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/entities/models/mobile_contact_model.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/features/chat_room/data/models/models/last_emoji_model.dart';
import 'package:uchat/features/chat_room/data/models/models/mention_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_model.dart';
import 'package:uchat/features/chat_room/domain/entities/last_emoji_entity.dart';

class MessageEntity {
  final String? id;
  final String? ref;
  final String? roomId;
  final String? accountId;
  final String? message;
  final MessageType? type;
  final List<MessageFileModel>? files;
  final List<MessageLinkModel>? links;
  final MessageMetaModel? meta;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? sequence;
  final bool? isSending;
  final bool? isSendFailed;
  final bool? isHidden;
  final bool? isEdited;
  final ContactModel? account;
  final ContactModel? contact;
  final MobileContactModel? mobileContact;
  final String? shareContactId;
  final MessageModel? replyMessage;
  final MessageSystemModel? systemMessage;
  final MessageCallModel? callMessage;
  final bool? isParentDeleted;
  final bool? isEncrypted;
  final bool? isDecryptFailed;
  final bool? isAlreadyShowAnimatedAndSound;
  final String? bookmarkMessageId;
  final List<LastEmojiEntity>? lastEmojis;
  final List<String>? selectedReactionList;
  final List<BookmarkTagModel>? bookmarkEmojiTags;
  final int? emojiAmount;
  final String? originalMessageId;
  final String? originalRoomId;
  final String? historyForAccountId;
  final String? collapseId;
  final bool? isLocked;
  final bool? isCurrentlyUnlock;
  final bool? isMyNote;
  final List<MentionModel>? mentionList;
  final RoomModel? room;
  final bool? isPinned;

  const MessageEntity({
    this.id,
    this.ref,
    this.roomId,
    this.accountId,
    this.message,
    this.type,
    this.files,
    this.links,
    this.meta,
    this.createdAt,
    this.updatedAt,
    this.sequence,
    this.isSending,
    this.isSendFailed,
    this.isHidden,
    this.isEdited,
    this.account,
    this.contact,
    this.mobileContact,
    this.shareContactId,
    this.replyMessage,
    this.systemMessage,
    this.callMessage,
    this.isParentDeleted,
    this.isEncrypted,
    this.isDecryptFailed,
    this.isAlreadyShowAnimatedAndSound,
    this.bookmarkMessageId,
    this.lastEmojis,
    this.selectedReactionList,
    this.bookmarkEmojiTags,
    this.emojiAmount,
    this.originalMessageId,
    this.originalRoomId,
    this.historyForAccountId,
    this.collapseId,
    this.isLocked,
    this.isCurrentlyUnlock,
    this.isMyNote,
    this.mentionList,
    this.room,
    this.isPinned,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      id: json['id'] as String?,
      ref: json['ref'] as String?,
      roomId: json['roomId'] as String?,
      accountId: json['accountId'] as String?,
      message: json['message'] as String?,
      type: json['type'] != null ? MessageType.from(json['type']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      sequence: json['sequence'] as int?,
      isSending: json['isSending'] as bool?,
      isSendFailed: json['isSendFailed'] as bool?,
      isHidden: json['isHidden'] as bool?,
      isEdited: json['isEdited'] as bool?,
      shareContactId: json['shareContactId'] as String?,
      isParentDeleted: json['isParentDeleted'] as bool?,
      isEncrypted: json['isEncrypted'] as bool?,
      isDecryptFailed: json['isDecryptFailed'] as bool?,
      isAlreadyShowAnimatedAndSound: json['isAlreadyShowAnimatedAndSound'] as bool?,
      bookmarkMessageId: json['bookmarkMessageId'] as String?,
      selectedReactionList:
          json['selectedReactionList'] != null ? List<String>.from(json['selectedReactionList']) : null,
      emojiAmount: json['emojiAmount'] as int?,
      originalMessageId: json['originalMessageId'] as String?,
      originalRoomId: json['originalRoomId'] as String?,
      historyForAccountId: json['historyForAccountId'] as String?,
      collapseId: json['collapseId'] as String?,
      isLocked: json['isLocked'] as bool?,
      isCurrentlyUnlock: json['isCurrentlyUnlock'] as bool?,
      isMyNote: json['isMyNote'] as bool?,
      files: json['files'] != null ? (json['files'] as List).map((e) => MessageFileModel.fromMap(e)).toList() : null,
      links: json['links'] != null ? (json['links'] as List).map((e) => MessageLinkModel.fromMap(e)).toList() : null,
      meta: json['meta'] != null ? MessageMetaModel.fromMap(json['meta']) : null,
      account: json['account'] != null ? ContactModel.fromMap(json['account']) : null,
      contact: json['contact'] != null ? ContactModel.fromMap(json['contact']) : null,
      mobileContact: json['mobileContact'] != null ? MobileContactModel.fromMap(json['mobileContact']) : null,
      replyMessage: json['replyMessage'] != null ? MessageModel.fromMap(json['replyMessage']) : null,
      systemMessage: json['systemMessage'] != null ? MessageSystemModel.fromMap(json['systemMessage']) : null,
      callMessage: json['callMessage'] != null ? MessageCallModel.fromMap(json['callMessage']) : null,
      lastEmojis: json['lastEmojis'] != null
          ? (json['lastEmojis'] as List).map((e) => LastEmojiModel.fromJson(e)).toList().toEntities()
          : null,
      bookmarkEmojiTags: json['bookmarkEmojiTags'] != null
          ? (json['bookmarkEmojiTags'] as List).map((e) => BookmarkTagModel.fromMap(e)).toList()
          : null,
      mentionList: json['mentionList'] != null
          ? (json['mentionList'] as List).map((e) => MentionModel.fromMap(e)).toList()
          : null,
      room: json['room'] != null ? RoomModel.fromMap(json['room']) : null,
      isPinned: json['isPinned'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ref': ref,
      'roomId': roomId,
      'accountId': accountId,
      'message': message,
      'type': type?.value,
      'files': files?.map((e) => e.toMap()).toList(),
      'links': links?.map((e) => e.toMap()).toList(),
      'meta': meta?.toMap(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'sequence': sequence,
      'isSending': isSending,
      'isSendFailed': isSendFailed,
      'isHidden': isHidden,
      'isEdited': isEdited,
      'account': account?.toMap(),
      'contact': contact?.toMap(),
      'mobileContact': mobileContact?.toJson(),
      'shareContactId': shareContactId,
      'replyMessage': replyMessage?.toMap(),
      'systemMessage': systemMessage?.toMap(),
      'callMessage': callMessage?.toMap(),
      'isParentDeleted': isParentDeleted,
      'isEncrypted': isEncrypted,
      'isDecryptFailed': isDecryptFailed,
      'isAlreadyShowAnimatedAndSound': isAlreadyShowAnimatedAndSound,
      'bookmarkMessageId': bookmarkMessageId,
      'lastEmojis': lastEmojis?.toModels(),
      'selectedReactionList': selectedReactionList,
      'bookmarkEmojiTags': bookmarkEmojiTags?.map((e) => e.toMap()).toList(),
      'emojiAmount': emojiAmount,
      'originalMessageId': originalMessageId,
      'originalRoomId': originalRoomId,
      'historyForAccountId': historyForAccountId,
      'collapseId': collapseId,
      'isLocked': isLocked,
      'isCurrentlyUnlock': isCurrentlyUnlock,
      'isMyNote': isMyNote,
      'mentionList': mentionList?.map((e) => e.toMap()).toList(),
      'room': room?.toMap(),
      'isPinned': isPinned,
    };
  }

  MessageEntity copyWith({
    String? id,
    String? ref,
    String? roomId,
    String? accountId,
    String? message,
    MessageType? type,
    List<MessageFileModel>? files,
    List<MessageLinkModel>? links,
    MessageMetaModel? meta,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? sequence,
    bool? isSending,
    bool? isSendFailed,
    bool? isHidden,
    bool? isEdited,
    ContactModel? account,
    ContactModel? contact,
    MobileContactModel? mobileContact,
    String? shareContactId,
    MessageModel? replyMessage,
    MessageSystemModel? systemMessage,
    MessageCallModel? callMessage,
    bool? isParentDeleted,
    bool? isEncrypted,
    bool? isDecryptFailed,
    bool? isAlreadyShowAnimatedAndSound,
    String? bookmarkMessageId,
    List<LastEmojiEntity>? lastEmojis,
    List<String>? selectedReactionList,
    List<BookmarkTagModel>? bookmarkEmojiTags,
    int? emojiAmount,
    String? originalMessageId,
    String? originalRoomId,
    String? historyForAccountId,
    String? collapseId,
    bool? isLocked,
    bool? isCurrentlyUnlock,
    bool? isMyNote,
    List<MentionModel>? mentionList,
    RoomModel? room,
    bool? isPinned,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      ref: ref ?? this.ref,
      roomId: roomId ?? this.roomId,
      accountId: accountId ?? this.accountId,
      message: message ?? this.message,
      type: type ?? this.type,
      files: files ?? this.files,
      links: links ?? this.links,
      meta: meta ?? this.meta,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sequence: sequence ?? this.sequence,
      isSending: isSending ?? this.isSending,
      isSendFailed: isSendFailed ?? this.isSendFailed,
      isHidden: isHidden ?? this.isHidden,
      isEdited: isEdited ?? this.isEdited,
      account: account ?? this.account,
      contact: contact ?? this.contact,
      mobileContact: mobileContact ?? this.mobileContact,
      shareContactId: shareContactId ?? this.shareContactId,
      replyMessage: replyMessage ?? this.replyMessage,
      systemMessage: systemMessage ?? this.systemMessage,
      callMessage: callMessage ?? this.callMessage,
      isParentDeleted: isParentDeleted ?? this.isParentDeleted,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      isDecryptFailed: isDecryptFailed ?? this.isDecryptFailed,
      isAlreadyShowAnimatedAndSound: isAlreadyShowAnimatedAndSound ?? this.isAlreadyShowAnimatedAndSound,
      bookmarkMessageId: bookmarkMessageId ?? this.bookmarkMessageId,
      lastEmojis: lastEmojis ?? this.lastEmojis,
      selectedReactionList: selectedReactionList ?? this.selectedReactionList,
      bookmarkEmojiTags: bookmarkEmojiTags ?? this.bookmarkEmojiTags,
      emojiAmount: emojiAmount ?? this.emojiAmount,
      originalMessageId: originalMessageId ?? this.originalMessageId,
      originalRoomId: originalRoomId ?? this.originalRoomId,
      historyForAccountId: historyForAccountId ?? this.historyForAccountId,
      collapseId: collapseId ?? this.collapseId,
      isLocked: isLocked ?? this.isLocked,
      isCurrentlyUnlock: isCurrentlyUnlock ?? this.isCurrentlyUnlock,
      isMyNote: isMyNote ?? this.isMyNote,
      mentionList: mentionList ?? this.mentionList,
      room: room ?? this.room,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  /// Whether the message has been sent successfully.
  bool get isSent => isSending != true && isSendFailed != true;

  /// Get the first file if available.
  MessageFileModel? get file => files?.isNotEmpty == true ? files!.first : null;

  /// Get date key for grouping messages by date.
  String get dateKey {
    if (createdAt != null) {
      final date = createdAt!.toLocal();
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
    final now = DateTime.now().toLocal();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Get formatted time string.
  String? get timeString {
    if (sequence != null) {
      final sentAt = DateTime.fromMillisecondsSinceEpoch(sequence!).toLocal();
      return '${sentAt.hour.toString().padLeft(2, '0')}:${sentAt.minute.toString().padLeft(2, '0')}';
    }
    if (createdAt != null) {
      final date = createdAt!.toLocal();
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
    return null;
  }

  String get senderName {
    return account?.displayName ?? 'Unknown';
  }

  bool get canReact {
    // Can not react to these type.
    return ![
      MessageType.system,
      MessageType.callMsg,
      MessageType.remove,
      MessageType.removeOthers,
      MessageType.album,
    ].contains(type);
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //   return other is MessageEntity && other.ref == ref;
  // }

  // @override
  // int get hashCode => ref.hashCode;

  @override
  String toString() {
    return 'MessageEntity(id: $id, ref: $ref, message: $message, type: $type, isEncrypted: $isEncrypted)';
  }
}
