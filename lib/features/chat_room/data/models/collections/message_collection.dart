import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/file_manager/file_manager.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/album_task_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/message_interface.dart';
import 'package:uchat/features/chat_room/data/models/mixin/message_mixin.dart';
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
import 'package:uchat/features/chat_room/data/models/models/room_model.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/fast_hash.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

part 'message_collection.g.dart';

final _log = useLogger();

@Collection(accessor: 'messages')
@Name('Message')
class MessageCollection with MessageMixin implements MessageInterface {
  @override
  @Index()
  String? id;

  @override
  @Index(unique: true, replace: true)
  String? ref;

  Id get isarId => fastHash(ref ?? id!);

  @override
  ContactModel? account;

  @override
  @Index()
  String? accountId;

  @override
  @Index()
  DateTime? createdAt;

  @override
  List<MessageFileModel>? files;

  @override
  bool? originalIsEdited;

  @override
  bool? originalIsHidden;

  @override
  @Index(composite: [CompositeIndex('roomId')])
  bool? isSendFailed;

  @override
  @Index(composite: [CompositeIndex('roomId')])
  bool? isSending;

  @override
  List<MessageLinkModel>? links;

  @override
  String? message;

  String? searchMessage;

  @override
  MessageMetaModel? meta;

  @override
  MessageModel? replyMessage;

  @override
  @Index()
  @Index(composite: [CompositeIndex('sequence')])
  String? roomId;

  @override
  @Index(composite: [CompositeIndex('roomId')])
  int? sequence;

  @override
  MessageSystemModel? systemMessage;

  @override
  MessageCallModel? callMessage;

  @override
  @Enumerated(EnumType.name)
  MessageType? type;

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

  /// Whether this message has failed to decrypt.
  /// This variable is used to show can not read this message in ui.
  @override
  bool? isDecryptFailed;

  @override
  bool? isAlreadyShowAnimatedAndSound;

  @override
  @Index()
  String? bookmarkMessageId;

  @override
  @Index()
  String? originalMessageId;

  @override
  @Index()
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
  @Index()
  bool? isMyNote;

  @override
  List<BookmarkTagModel>? bookmarkEmojiTags;

  @ignore
  @override
  bool? isCurrentlyUnlock;

  @override
  @Index()
  bool? isPinned;

  MessageCollection({
    this.id,
    this.roomId,
    this.ref,
    this.accountId,
    this.message,
    this.searchMessage,
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
    this.originalIsHidden = false,
    this.replyMessage,
    this.originalIsEdited = false,
    this.callMessage,
    this.shareContactId,
    this.contact,
    this.mobileContact,
    this.isParentDeleted,
    this.isEncrypted,
    this.isDecryptFailed,
    this.isAlreadyShowAnimatedAndSound,
    this.bookmarkMessageId,
    this.originalMessageId,
    this.historyForAccountId,
    this.updatedAt,
    this.collapseId,
    this.isLocked,
    this.lastEmojis,
    this.emojiAmount,
    this.isCurrentlyUnlock,
    this.bookmarkEmojiTags,
    this.originalRoomId,
    this.selectedReactionList,
    this.mentionList,
    this.isMyNote,
    this.room,
    this.isPinned,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['ref'] = ref;
    data['accountId'] = accountId;
    data['message'] = message;
    data['searchMessage'] = searchMessage;
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
    data['roomId'] = roomId;
    data['isPinned'] = isPinned;
    return data;
  }

  factory MessageCollection.fromInterface(MessageInterface? data) {
    return MessageCollection(
      id: data?.id,
      ref: data?.ref,
      account: data?.account,
      accountId: data?.accountId,
      createdAt: data?.createdAt,
      files: data?.files,
      originalIsEdited: data?.isEdited,
      originalIsHidden: data?.isHidden,
      isSendFailed: data?.isSendFailed,
      isSending: data?.isSending,
      links: data?.links,
      message: data?.message,
      meta: data?.meta,
      replyMessage: data?.replyMessage,
      roomId: data?.roomId,
      sequence: data?.sequence,
      systemMessage: data?.systemMessage,
      callMessage: data?.callMessage,
      type: data?.type,
      shareContactId: data?.shareContactId,
      contact: data?.contact,
      mobileContact: data?.mobileContact,
      isParentDeleted: data?.isParentDeleted,
      isEncrypted: data?.isEncrypted,
      isAlreadyShowAnimatedAndSound: data?.isAlreadyShowAnimatedAndSound,
    );
  }

  factory MessageCollection.fromMap(Map<String, dynamic> data) {
    // _log.i('MessageEntity.fromMap: $data');
    ContactModel? account;
    if (data['account'] != null) {
      try {
        account = ContactModel.fromMap(data['account']);
      } catch (e, stackTrace) {
        _log.e(
          'Error parse account. (${data['account']})',
          e,
          stackTrace,
        );
      }
    }

    ContactModel? contact;
    if (data['contact'] != null) {
      try {
        _log.d('contact data -> ${data['contact']}');
        contact = ContactModel.fromMap(data['contact']);
      } catch (e, stackTrace) {
        _log.e(
          'Error parse contact. (${data['contact']})',
          e,
          stackTrace,
        );
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
    final String? roomId = data['roomId'];
    final String? id = data['_id'];

    int? sequence = int.tryParse(data['sequence'] ?? '', radix: 16);

    MessageType? type;
    if (data['type'] != null) {
      type = MessageType.from(data['type']);
    } else if (data['fileType'] != null) {
      type = MessageType.from(data['fileType']);
    }

    var message = MessageCollection(
      id: id,
      roomId: roomId,
      accountId: data['accountId'],
      isSending: false,
      isSendFailed: false,
      ref: data['ref'] ?? id,
      account: account,
      message: data['message'],
      searchMessage: data['searchMessage'],
      type: type,
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
      isMyNote: data['isMyNote'],
      lastEmojis: data['lastEmojis'] != null
          ? (data['lastEmojis'] as List).map((e) => LastEmojiModel.fromJson(e)).toList()
          : [],
      isPinned: data['isPinned'],
    );

    if (data['bookmarkEmojiTags'] != null) {
      List<dynamic> emojiTags = data['bookmarkEmojiTags'];

      try {
        final List<BookmarkTagModel> emojiTagList = [];
        for (final tag in emojiTags) {
          if (tag == null) {
            continue;
          }

          emojiTagList.add(BookmarkTagModel.fromMap(tag));
        }

        message.bookmarkEmojiTags = emojiTagList;
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
            return MessageFileModel(
              messageId: id,
              albumId: message.meta?.albumId,
              id: file,
            );
          }
          return MessageFileModel.fromMap(file);
        }).toList();
      } catch (e, stackTrace) {
        _log.e('Error parse files. (${data['files']})', e, stackTrace);
      }
    }

    if (data['links'] != null) {
      List<dynamic> links = data['links'];
      try {
        // Fix error when List<dynamic> links = [null]
        final List<MessageLinkModel> tempLink = [];
        for (final link in links) {
          if (link == null) {
            continue;
          }
          tempLink.add(
            MessageLinkModel.fromMap(link)
              ..roomId = roomId
              ..messageId = id,
          );
        }
        message.links = tempLink;
      } catch (e, stackTrace) {
        _log.e('Error parse links. (${data['links']})', e, stackTrace);
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
        _log.e(
          'Error parse room. (${data['room']})',
          e,
          stackTrace,
        );
      }
    }

    return message;
  }

  @override
  @Index(composite: [CompositeIndex('roomId')])
  bool get isSent {
    return super.isSent;
  }

  @Index(composite: [CompositeIndex('roomId')])
  bool get canShowInSentMessageList {
    return isSent && !isUnsentMessage && !isRemoveMessage;
  }

  @override
  @Index(composite: [CompositeIndex('roomId')])
  bool get isHidden {
    return originalIsHidden ?? false;
  }

  @override
  @Index(composite: [CompositeIndex('roomId')])
  bool get isEdited {
    return originalIsEdited ?? false;
  }

  @override
  String toString() {
    return '[MessageCollection] ID: $id, REF: $ref, MESSAGE: ${msgMinimize()}, SEQUENCE: $sequence, searchMessage: $searchMessage, IS_ENCRYPTED: $isEncrypted';
  }

  MessageModel toModel() {
    return MessageModel(
      id: id,
      roomId: roomId,
      ref: ref,
      accountId: accountId,
      message: message,
      type: type,
      createdAt: createdAt,
      account: account,
      isSending: isSending,
      isSendFailed: isSendFailed,
      files: files,
      links: links,
      meta: meta,
      sequence: sequence,
      systemMessage: systemMessage,
      originalIsHidden: isHidden,
      replyMessage: replyMessage,
      originalIsEdited: isEdited,
      callMessage: callMessage,
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
      isParentDeleted: isParentDeleted,
      isPinned: isPinned,
    );
  }

  MessageCollection copy() {
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
      mobileContact: mobileContact,
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
      isPinned: isPinned,
    );
  }

  MessageCollection copyWith({
    String? id,
    String? roomId,
    String? ref,
    String? accountId,
    String? message,
    String? searchMessage,
    MessageType? type,
    DateTime? createdAt,
    ContactModel? account,
    bool? isSending,
    bool? isSendFailed,
    List<MessageFileModel>? files,
    List<MessageLinkModel>? links,
    MessageMetaModel? meta,
    int? sequence,
    MessageSystemModel? systemMessage,
    bool? originalIsHidden,
    MessageModel? replyMessage,
    bool? originalIsEdited,
    MessageCallModel? callMessage,
    String? shareContactId,
    ContactModel? contact,
    MobileContactModel? mobileContact,
    bool? isParentDeleted,
    bool? isEncrypted,
    bool? isDecryptFailed,
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
    RoomModel? room,
    bool? isPinned,
  }) {
    return MessageCollection(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      ref: ref ?? this.ref,
      accountId: accountId ?? this.accountId,
      message: message ?? this.message,
      searchMessage: searchMessage ?? this.searchMessage,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      account: account ?? this.account,
      isSending: isSending ?? this.isSending,
      isSendFailed: isSendFailed ?? this.isSendFailed,
      files: files ?? this.files,
      links: links ?? this.links,
      meta: meta ?? this.meta,
      sequence: sequence ?? this.sequence,
      systemMessage: systemMessage ?? this.systemMessage,
      originalIsHidden: originalIsHidden ?? this.originalIsHidden,
      replyMessage: replyMessage ?? this.replyMessage,
      originalIsEdited: originalIsEdited ?? this.originalIsEdited,
      callMessage: callMessage ?? this.callMessage,
      shareContactId: shareContactId ?? this.shareContactId,
      contact: contact ?? this.contact,
      mobileContact: mobileContact ?? this.mobileContact,
      isParentDeleted: isParentDeleted ?? this.isParentDeleted,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      isDecryptFailed: isDecryptFailed ?? this.isDecryptFailed,
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
      room: room ?? this.room,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MessageCollection && ref == other.ref;
  }

  @ignore
  @override
  int get hashCode => ref.hashCode;

  @override
  String msgMinimize() {
    String message = this.message ?? '';
    if (message.effectiveLength > UChatConstant.maxTextCharacter) {
      return message.subStr(UChatConstant.maxTextCharacter);
    }
    return message;
  }

  static MessageCollection generateFileMessageCollection({
    required String ref,
    required String roomId,
    required List<MessageFileModel> files,
    String? messageText,
    bool isLocked = false,
    bool isCurrentlyUnlock = false,
    String? lockMessageSalt,
    String? lockMessageIv,
    bool? isMyNote,
  }) {
    MessageType messageType = MessageType.file;
    final mime = files.firstOrNull?.mime;
    if (mime != null && mime.isNotEmpty) {
      if (isImageTypeSupported(mime)) {
        messageType = MessageType.image;
      }

      if (isVideoTypeSupported(mime)) {
        messageType = MessageType.video;
      }

      if (mime.contains(RegExp(r'audio/'))) {
        messageType = MessageType.audio;
      }
    }

    MessageCollection message = MessageCollection()
      ..id = ref
      ..ref = ref
      ..roomId = roomId
      ..isSending = true
      ..account = UserController.instance.currentUser()!.toContact()
      ..accountId = UserController.instance.currentUser()!.id
      ..files = files
      ..createdAt = DateTime.now().toLocal()
      ..message = messageText != null ? messageText.trim() : ''
      ..type = messageType
      ..isLocked = isLocked
      ..isCurrentlyUnlock = isCurrentlyUnlock
      ..isMyNote = isMyNote;

    if (lockMessageSalt != null || lockMessageIv != null) {
      message.meta = MessageMetaModel(
        lockMessageSalt: lockMessageSalt,
        lockMessageIv: lockMessageIv,
      );
    }

    return message;
  }

  // for show avatar in chat room
  ContactInterface? getContact() {
    if (accountId == null) {
      return null;
    }

    // Try to get the contact using the accountId
    final contact = GetIt.I<GetContactSyncUseCase>().call(accountId!);
    if (contact != null) {
      return contact;
    }

    // If roomId is null, return null
    if (roomId == null) {
      return null;
    }

    // Try to get the contact from the room member database
    // TODO: refactor getOneMemberInRoomSync to  useCase -> repository -> db
    final roomMember = GetIt.I<RoomMemberDb>().getOneMemberInRoomSync(roomId!, accountId!);
    if (roomMember != null) {
      return roomMember.account;
    }

    // Fallback to the account property
    return account;
  }
}
