import 'package:isar_community/isar.dart';
import 'package:uchat/constants/uchat_constant.dart';

import 'package:uchat/controllers.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/entities/models/mobile_contact_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/message_interface.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mixin/message_mixin.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/features/chat_room/data/models/models/last_emoji_model.dart';
import 'package:uchat/features/chat_room/data/models/models/mention_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_model.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

part 'message_model.g.dart';

final _log = useLogger();

@embedded
class MessageModel with MessageMixin implements MessageInterface {
  @override
  ContactModel? account;

  @override
  String? accountId;

  @override
  DateTime? createdAt;

  @override
  List<MessageFileModel>? files;

  @override
  String? id;

  @override
  bool? originalIsEdited;

  @override
  bool? originalIsHidden;

  @override
  bool? isSendFailed;

  @override
  bool? isSending;

  @override
  List<MessageLinkModel>? links;

  @override
  String? message;

  @override
  MessageMetaModel? meta;

  @override
  String? ref;

  @override
  MessageModel? replyMessage;

  @override
  String? roomId;

  @override
  int? sequence;

  @override
  MessageSystemModel? systemMessage;

  @override
  @Enumerated(EnumType.name)
  MessageType? type;

  @override
  MessageCallModel? callMessage;

  @override
  @ignore
  RoomModel? room;

  @override
  String? shareContactId;

  @override
  ContactModel? contact;

  @override
  MobileContactModel? mobileContact;

  /// Whether reply message of this message is deleted or not.
  /// Will be true only when this message has reply to another message
  /// and the message that this message reply to is deleted (not unsent)
  /// by deleting room.
  /// Will be false otherwise.
  @override
  bool? isParentDeleted;

  @override
  bool? isEncrypted;

  @override
  String? bookmarkMessageId;

  @override
  String? originalMessageId;

  @override
  String? originalRoomId;

  @override
  String? historyForAccountId;

  @override
  DateTime? updatedAt;

  @override
  String? collapseId;

  @override
  bool? isLocked;

  @override
  List<LastEmojiModel>? lastEmojis;

  @override
  List<String>? selectedReactionList;

  @override
  List<MentionModel>? mentionList;

  @override
  int? emojiAmount;

  @override
  bool? isMyNote;

  @override
  List<BookmarkTagModel>? bookmarkEmojiTags;

  @ignore
  @override
  bool? isCurrentlyUnlock;

  /// Whether this message has failed to decrypt.
  /// This variable is used to show can not read this message in ui.
  @override
  bool? isDecryptFailed;

  @override
  bool? isPinned;

  MessageModel({
    this.id,
    this.roomId,
    this.ref,
    this.accountId,
    this.message,
    this.type,
    this.createdAt,
    this.account,
    this.isSending = false,
    this.isSendFailed = false,
    this.files,
    this.links,
    this.meta,
    this.sequence,
    this.systemMessage,
    this.originalIsHidden,
    this.replyMessage,
    this.originalIsEdited,
    this.callMessage,
    this.room,
    this.shareContactId,
    this.contact,
    this.mobileContact,
    this.isParentDeleted,
    this.isEncrypted,
    this.isAlreadyShowAnimatedAndSound,
    this.bookmarkMessageId,
    this.originalMessageId,
    this.originalRoomId,
    this.historyForAccountId,
    this.updatedAt,
    this.collapseId,
    this.isLocked,
    this.lastEmojis,
    this.emojiAmount,
    this.isCurrentlyUnlock,
    this.bookmarkEmojiTags,
    this.selectedReactionList,
    this.mentionList,
    this.isMyNote = false,
    this.isPinned,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['roomId'] = roomId;
    data['ref'] = ref;
    data['accountId'] = accountId;
    data['message'] = message;
    if (type != null) {
      data['type'] = type!.value;
    }
    data['createdAt'] = createdAt?.toIso8601String();
    if (account != null) {
      data['account'] = account!.toMap();
    }
    data['isSending'] = isSending;
    data['isSendFailed'] = isSendFailed;
    if (files != null) {
      data['files'] = files!.map((v) => v.toMap()).toList();
    }
    if (links != null) {
      data['links'] = links!.map((v) => v.toMap()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toMap();
    }
    if (sequence != null) {
      data['sequence'] = sequence!.toRadixString(16);
    }
    if (systemMessage != null) {
      data['systemMessage'] = systemMessage!.toMap();
    }
    data['isHidden'] = originalIsHidden;
    if (replyMessage != null) {
      data['replyMessage'] = replyMessage!.toMap();
    }
    data['isEdited'] = originalIsEdited;
    if (callMessage != null) {
      data['callMessage'] = callMessage!.toMap();
    }
    data['contactId'] = shareContactId;
    if (contact != null) {
      data['contact'] = contact!.toMap();
    }
    if (mobileContact != null) {
      data['mobileContact'] = mobileContact!.toJson();
    }
    data['isParentDeleted'] = isParentDeleted;
    data['isEncrypted'] = isEncrypted;
    data['isDecryptFailed'] = isDecryptFailed;
    data['bookmarkMessageId'] = bookmarkMessageId;
    data['originalMessageId'] = originalMessageId;
    data['historyForAccountId'] = historyForAccountId;
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['collapseId'] = collapseId;
    data['isLocked'] = isLocked;
    if (lastEmojis != null) {
      data['lastEmojis'] = lastEmojis!.map((v) => v.toJson()).toList();
    }
    data['emojiAmount'] = emojiAmount;
    if (bookmarkEmojiTags != null) {
      data['bookmarkEmojiTags'] = bookmarkEmojiTags!.map((v) => v.toMap()).toList();
    }
    data['originalRoomId'] = originalRoomId;
    if (selectedReactionList != null) {
      data['emojiItemsSelected'] = selectedReactionList;
    }
    if (mentionList != null) {
      data['mentions'] = mentionList!.map((v) => v.toMap()).toList();
    }
    data['isMyNote'] = isMyNote;
    data['isPinned'] = isPinned;
    return data;
  }

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    // _log.i('MessageModel.fromMap: $data');
    ContactModel? account;
    if (data['account'] != null) {
      try {
        account = ContactModel.fromMap(data['account']);
      } catch (e, stackTrace) {
        _log.e('Error parse account. (${data['account']})', e, stackTrace);
      }
    }

    ContactModel? contact;
    if (data['contact'] != null) {
      try {
        contact = ContactModel.fromMap(data['contact']);
      } catch (e, stackTrace) {
        _log.e('Error parse contact. (${data['contact']})', e, stackTrace);
      }
    }

    MobileContactModel? mobileContact;
    if (data['mobileContact'] != null) {
      try {
        _log.d('mobileContact data -> ${data['mobileContact']}');
        mobileContact = MobileContactModel.fromMap(data['mobileContact']);
      } catch (e, stackTrace) {
        _log.e(
          'Error parse mobileContact. (${data['mobileContact']})',
          e,
          stackTrace,
        );
      }
    }

    final String? shareContactId = data['contactId'];
    final String roomId = data['roomId'];
    final String? id = data['_id'];

    int? sequence = int.tryParse(data['sequence'] ?? '', radix: 16);

    var message = MessageModel(
      id: id,
      roomId: roomId,
      accountId: data['accountId'],
      isSending: false,
      isSendFailed: false,
      ref: data['ref'] ?? id,
      account: account,
      message: data['message'],
      type: data['type'] != null ? MessageType.from(data['type']) : null,
      sequence: sequence,
      originalIsHidden: data['isHidden'],
      createdAt: strToDateTime(data['createdAt']),
      originalIsEdited: data['isEdited'],
      shareContactId: shareContactId,
      contact: contact,
      mobileContact: mobileContact,
      isParentDeleted: data['isParentDeleted'],
      isEncrypted: data['isEncrypted'],
      bookmarkMessageId: data['bookmarkMessageId'],
      originalMessageId: data['originalMessageId'],
      historyForAccountId: data['historyForAccountId'],
      updatedAt: strToDateTime(data['updatedAt']),
      isLocked: data['isLocked'],
      emojiAmount: data['emojiAmount'] ?? 0,
      collapseId: data['collapseId'],
      originalRoomId: data['originalRoomId'],
      isMyNote: data['isMyNote'] ?? false,
      lastEmojis: data['lastEmojis'] != null
          ? (data['lastEmojis'] as List).map((e) => LastEmojiModel.fromJson(e)).toList()
          : [],
      isPinned: data['isPinned'],
    );

    if (data['bookmarkEmojiTags'] != null) {
      List<dynamic> bookmarkTagList = data['bookmarkEmojiTags'];

      try {
        final List<BookmarkTagModel> tagList = [];
        for (final tag in bookmarkTagList) {
          if (tag == null) {
            continue;
          }

          tagList.add(BookmarkTagModel.fromMap(tag));
        }
        message.bookmarkEmojiTags = tagList;
      } catch (e, stackTrace) {
        _log.e('Error parse bookmarkEmojiTags. (${data['bookmarkEmojiTags']})', e, stackTrace);
      }
    }

    if (data['emojiItemsSelected'] != null) {
      List<dynamic> selectedList = data['emojiItemsSelected'];

      try {
        final List<String> selectedReactionList = [];
        for (final emojiId in selectedList) {
          if (emojiId == null) {
            continue;
          }

          selectedReactionList.add(emojiId);
        }
        message.selectedReactionList = selectedReactionList;
      } catch (e, stackTrace) {
        _log.e('Error parse emojiItemsSelected. (${data['emojiItemsSelected']})', e, stackTrace);
      }
    }

    if (data['mentions'] != null) {
      List<dynamic> selectedList = data['mentions'];

      try {
        final List<MentionModel> mentions = [];
        for (final mention in selectedList) {
          if (mention == null) {
            continue;
          }

          mentions.add(MentionModel.fromMap(mention));
        }
        message.mentionList = mentions;
      } catch (e, stackTrace) {
        _log.e('Error parse mentions. (${data['mentions']})', e, stackTrace);
      }
    }

    if (data['meta'] != null) {
      try {
        message.meta = MessageMetaModel.fromMap(data['meta']);
      } catch (e, stackTrace) {
        _log.e('Error parse meta. (${data['meta']})', e, stackTrace);
      }
    }

    if (data['systemMessage'] != null) {
      try {
        message.systemMessage = MessageSystemModel.fromMap(
          data['systemMessage'],
        );
      } catch (e, stackTrace) {
        _log.e(
          'Error parse system message. (${data['systemMessage']})',
          e,
          stackTrace,
        );
      }
    }

    if (data['callMessage'] != null) {
      try {
        message.callMessage = MessageCallModel.fromMap(
          data['callMessage'],
        );
      } catch (e, stackTrace) {
        _log.e(
          'Error parse call message. (${data['callMessage']})',
          e,
          stackTrace,
        );
      }
    }

    if (data['files'] != null) {
      List<dynamic> files = data['files'];
      try {
        message.files = files.map((file) {
          if (file is Map<String, dynamic>) {
            return MessageFileModel.fromMap(file)
              ..roomId = roomId
              ..messageId = id;
          } else if (file is String) {
            return MessageFileModel(messageId: id, albumId: message.meta?.albumId, id: file);
          }
          return MessageFileModel.fromMap(file);
        }).toList();
      } catch (e, stackTrace) {
        _log.e('Error parse files. (${data['files']})', e, stackTrace);
      }
    }

    if (data['links'] != null) {
      List<dynamic> links = data['links'];
      if (links.isNotEmpty) {
        try {
          // _log.d('links data -> $links');
          message.links = links.where((element) => element != null).map((link) {
            return MessageLinkModel.fromMap(link)
              ..roomId = roomId
              ..messageId = id;
          }).toList();
        } catch (e, stackTrace) {
          _log.e('Error parse links. (${data['links']})', e, stackTrace);
        }
      }
    }

    if (data['replyMessage'] != null) {
      try {
        message.replyMessage = MessageModel.fromMap(data['replyMessage']);
      } catch (e, stackTrace) {
        _log.e(
          'Error parse reply message. (${data['replyMessage']})',
          e,
          stackTrace,
        );
      }
    }

    if (data['room'] != null) {
      try {
        message.room = RoomModel.fromMap(data['room']);
      } catch (e, stackTrace) {
        _log.e('Error parse room. (${data['room']})', e, stackTrace);
      }
    }

    return message;
  }

  MessageCollection toCollection() {
    return MessageCollection(
      id: id,
      ref: ref,
      account: account,
      accountId: accountId,
      createdAt: createdAt,
      files: files,
      originalIsEdited: isEdited,
      originalIsHidden: isHidden,
      isSendFailed: isSendFailed,
      isSending: isSending,
      links: links,
      message: message,
      meta: meta,
      replyMessage: replyMessage,
      roomId: roomId,
      sequence: sequence,
      systemMessage: systemMessage,
      callMessage: callMessage,
      type: type,
      shareContactId: shareContactId,
      contact: contact,
      isEncrypted: isEncrypted,
      isAlreadyShowAnimatedAndSound: isAlreadyShowAnimatedAndSound,
      bookmarkMessageId: bookmarkMessageId,
      originalMessageId: originalMessageId,
      originalRoomId: originalRoomId,
      lastEmojis: lastEmojis,
      selectedReactionList: selectedReactionList,
      mentionList: mentionList,
      emojiAmount: emojiAmount,
      isMyNote: isMyNote,
      isLocked: isLocked,
      isCurrentlyUnlock: isCurrentlyUnlock,
    );
  }

  @override
  bool get mine {
    return UserController.instance.currentUser()?.id == accountId;
  }

  @override
  bool get isHidden {
    return originalIsHidden ?? false;
  }

  @override
  bool get isEdited {
    return originalIsEdited ?? false;
  }

  @override
  String toString() {
    return '[MessageModel] ID: $id, REF: $ref, MESSAGE: $message, SEQUENCE: $sequence, roomfileid: ${files?.map((e) => e.roomFileId)}';
  }

  @override
  bool operator ==(Object other) {
    return other is MessageModel && ref == other.ref;
  }

  @ignore
  @override
  int get hashCode => ref.hashCode;

  @override
  bool? isAlreadyShowAnimatedAndSound;

  @override
  String msgMinimize() {
    String message = this.message ?? '';
    if (message.effectiveLength > UChatConstant.maxTextLengthShow) {
      return message.subStr(UChatConstant.maxTextLengthShow);
    }
    return message;
  }

  @Deprecated('Use MessageEntity.toModel() instead')
  static MessageModel fromEntity(MessageEntity entity) {
    return entity.toModel();
  }

  MessageModel copyWith({
    ContactModel? account,
    String? accountId,
    DateTime? createdAt,
    List<MessageFileModel>? files,
    String? id,
    bool? originalIsEdited,
    bool? originalIsHidden,
    bool? isSendFailed,
    bool? isSending,
    List<MessageLinkModel>? links,
    String? message,
    MessageMetaModel? meta,
    String? ref,
    MessageModel? replyMessage,
    String? roomId,
    int? sequence,
    MessageSystemModel? systemMessage,
    MessageType? type,
    MessageCallModel? callMessage,
    RoomModel? room,
    String? shareContactId,
    ContactModel? contact,
    MobileContactModel? mobileContact,
    bool? isParentDeleted,
    bool? isEncrypted,
    bool? isAlreadyShowAnimatedAndSound,
    String? bookmarkMessageId,
    String? originalMessageId,
    String? originalRoomId,
    String? historyForAccountId,
    DateTime? updatedAt,
    String? collapseId,
    bool? isLocked,
    List<LastEmojiModel>? lastEmojis,
    List<String>? selectedReactionList,
    List<MentionModel>? mentionList,
    int? emojiAmount,
    bool? isMyNote,
    List<BookmarkTagModel>? bookmarkEmojiTags,
    bool? isCurrentlyUnlock,
    bool? isDecryptFailed,
    bool? isPinned,
  }) {
    return MessageModel(
      account: account ?? this.account,
      accountId: accountId ?? this.accountId,
      createdAt: createdAt ?? this.createdAt,
      files: files ?? this.files,
      id: id ?? this.id,
      originalIsEdited: originalIsEdited ?? this.originalIsEdited,
      originalIsHidden: originalIsHidden ?? this.originalIsHidden,
      isSendFailed: isSendFailed ?? this.isSendFailed,
      isSending: isSending ?? this.isSending,
      links: links ?? this.links,
      message: message ?? this.message,
      meta: meta ?? this.meta,
      ref: ref ?? this.ref,
      replyMessage: replyMessage ?? this.replyMessage,
      roomId: roomId ?? this.roomId,
      sequence: sequence ?? this.sequence,
      systemMessage: systemMessage ?? this.systemMessage,
      type: type ?? this.type,
      callMessage: callMessage ?? this.callMessage,
      room: room ?? this.room,
      shareContactId: shareContactId ?? this.shareContactId,
      contact: contact ?? this.contact,
      mobileContact: mobileContact ?? this.mobileContact,
      isParentDeleted: isParentDeleted ?? this.isParentDeleted,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      isAlreadyShowAnimatedAndSound: isAlreadyShowAnimatedAndSound ?? this.isAlreadyShowAnimatedAndSound,
      bookmarkMessageId: bookmarkMessageId ?? this.bookmarkMessageId,
      originalMessageId: originalMessageId ?? this.originalMessageId,
      originalRoomId: originalRoomId ?? this.originalRoomId,
      historyForAccountId: historyForAccountId ?? this.historyForAccountId,
      updatedAt: updatedAt ?? this.updatedAt,
      collapseId: collapseId ?? this.collapseId,
      isLocked: isLocked ?? this.isLocked,
      lastEmojis: lastEmojis ?? this.lastEmojis,
      selectedReactionList: selectedReactionList ?? this.selectedReactionList,
      mentionList: mentionList ?? this.mentionList,
      emojiAmount: emojiAmount ?? this.emojiAmount,
      isMyNote: isMyNote ?? this.isMyNote,
      bookmarkEmojiTags: bookmarkEmojiTags ?? this.bookmarkEmojiTags,
      isCurrentlyUnlock: isCurrentlyUnlock ?? this.isCurrentlyUnlock,
      isPinned: isPinned ?? this.isPinned,
    )..isDecryptFailed = isDecryptFailed ?? this.isDecryptFailed;
  }
}
