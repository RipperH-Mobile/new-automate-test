import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/entities/models/mobile_contact_model.dart';
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

abstract class MessageInterface {
  String? id;
  String? roomId;
  String? ref;
  MessageType? type;
  DateTime? createdAt;
  bool? isSending;
  bool? isSendFailed;
  int? sequence;
  String? message;
  String? accountId;
  bool? originalIsHidden;
  bool? originalIsEdited;
  List<MessageFileModel>? files = [];
  List<MessageLinkModel>? links = [];
  MessageMetaModel? meta;
  ContactModel? account;
  MessageSystemModel? systemMessage;
  MessageCallModel? callMessage;
  MessageModel? replyMessage;
  String? shareContactId;
  ContactModel? contact;
  MobileContactModel? mobileContact;
  String? historyForAccountId;
  DateTime? updatedAt;
  String? collapseId;
  bool? isLocked;
  List<LastEmojiModel>? lastEmojis;
  List<String>? selectedReactionList;
  int? emojiAmount;
  @ignore
  bool? isCurrentlyUnlock;
  bool? isMyNote;
  bool? isPinned;
  List<BookmarkTagModel>? bookmarkEmojiTags;
  List<MentionModel>? mentionList;

  /// Whether reply message of this message is deleted or not.
  /// Will be true only when this message has reply to another message
  /// and the message that this message reply to is deleted (not unsent)
  /// by deleting room.
  /// Will be false otherwise.
  bool? isParentDeleted;

  /// Whether this message is encrypted.
  /// Will be null for older message before encryption is implemented.
  bool? isEncrypted;

  /// Whether this message has failed to decrypt.
  /// This variable is used to show can not read this message in ui.
  bool? isDecryptFailed;

  bool? isAlreadyShowAnimatedAndSound;

  /// Whether this message is saved to bookmark.
  /// [bookmarkMessageId] is null -> unsaved
  /// [bookmarkMessageId] isn't null -> saved
  String? bookmarkMessageId;

  String? originalMessageId;
  String? originalRoomId;

  @ignore
  RoomModel? room;

  bool get mine;

  MessageFileModel? get file;

  @ignore
  String get displayName;

  // @ignore
  // String? get previewMessage;

  String get dateKey;

  String? get timeString;

  bool get isSent;

  @ignore
  String get systemText;

  bool get isSystemMessage;

  bool get isCallMessage;

  bool get isUnsentMessage;

  bool get isRemoveMessage;

  bool get isMediaMessage;

  bool get canCopyMessage;

  bool get canEditMessage;

  bool get canShare;

  bool get canBookmark;

  bool get canReportMessage;

  bool get canHideMessage;

  bool get canUnHideMessage;

  bool get canDeleteMessage;

  bool get canDeleteOthersMessage;

  bool get canReply;

  bool get canReact;

  bool get canAddToAlbum;

  bool get isHidden;

  bool get isEdited;

  // String get msgMinimize;

  void update(MessageInterface updateMessage);

  String msgMinimize();
}
