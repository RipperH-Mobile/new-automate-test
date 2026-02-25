import 'package:uchat/features/chat_room/data/models/collections/message_reaction_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/last_emoji_model.dart';
import 'package:uchat/features/chat_room/data/models/responses/message_reaction_response.dart';
import 'package:uchat/features/chat_room/domain/entities/get_message_reaction_model.dart';
import 'package:uchat/features/chat_room/domain/entities/last_emoji_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_response_entity.dart';

extension MessageCollectionExtensions on MessageCollection {
  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      ref: ref,
      roomId: roomId,
      accountId: accountId,
      message: message,
      type: type,
      files: files,
      links: links,
      meta: meta,
      createdAt: createdAt,
      updatedAt: updatedAt,
      sequence: sequence,
      isSending: isSending,
      isSendFailed: isSendFailed,
      isHidden: isHidden,
      isEdited: isEdited,
      account: account,
      contact: contact,
      mobileContact: mobileContact,
      shareContactId: shareContactId,
      replyMessage: replyMessage,
      systemMessage: systemMessage,
      callMessage: callMessage,
      isParentDeleted: isParentDeleted,
      isEncrypted: isEncrypted,
      isDecryptFailed: isDecryptFailed,
      isAlreadyShowAnimatedAndSound: isAlreadyShowAnimatedAndSound,
      bookmarkMessageId: bookmarkMessageId,
      lastEmojis: lastEmojis?.toEntities(),
      selectedReactionList: selectedReactionList,
      bookmarkEmojiTags: bookmarkEmojiTags,
      emojiAmount: emojiAmount,
      originalMessageId: originalMessageId,
      originalRoomId: originalRoomId,
      historyForAccountId: historyForAccountId,
      collapseId: collapseId,
      isLocked: isLocked,
      isCurrentlyUnlock: isCurrentlyUnlock,
      isMyNote: isMyNote,
      mentionList: mentionList,
      room: room,
      isPinned: isPinned,
    );
  }
}

extension MessageEntityExtensions on MessageEntity {
  MessageCollection toCollection() {
    return MessageCollection(
      id: id,
      ref: ref,
      roomId: roomId,
      accountId: accountId,
      message: message,
      searchMessage: message,
      type: type,
      files: files,
      links: links,
      meta: meta,
      createdAt: createdAt,
      updatedAt: updatedAt,
      sequence: sequence,
      isSending: isSending,
      isSendFailed: isSendFailed,
      originalIsHidden: isHidden,
      originalIsEdited: isEdited,
      account: account,
      contact: contact,
      mobileContact: mobileContact,
      shareContactId: shareContactId,
      replyMessage: replyMessage,
      systemMessage: systemMessage,
      callMessage: callMessage,
      isParentDeleted: isParentDeleted,
      isEncrypted: isEncrypted,
      isDecryptFailed: isDecryptFailed,
      isAlreadyShowAnimatedAndSound: isAlreadyShowAnimatedAndSound,
      bookmarkMessageId: bookmarkMessageId,
      originalMessageId: originalMessageId,
      originalRoomId: originalRoomId,
      historyForAccountId: historyForAccountId,
      collapseId: collapseId,
      isLocked: isLocked,
      lastEmojis: lastEmojis?.toModels(),
      selectedReactionList: selectedReactionList,
      mentionList: mentionList,
      emojiAmount: emojiAmount,
      isMyNote: isMyNote,
      bookmarkEmojiTags: bookmarkEmojiTags,
      isCurrentlyUnlock: isCurrentlyUnlock,
      room: room,
      isPinned: isPinned,
    );
  }
}

extension MessageCollectionListExtensions on List<MessageCollection> {
  List<MessageEntity> toEntities() {
    return map((collection) => collection.toEntity()).toList();
  }
}

extension MessageEntityListExtensions on List<MessageEntity> {
  List<MessageCollection> toCollections() {
    return map((entity) => entity.toCollection()).toList();
  }
}

extension MessageModelExtensions on MessageModel {
  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      ref: ref,
      roomId: roomId,
      accountId: accountId,
      message: message,
      type: type,
      files: files,
      links: links,
      meta: meta,
      createdAt: createdAt,
      updatedAt: updatedAt,
      sequence: sequence,
      isSending: isSending,
      isSendFailed: isSendFailed,
      isHidden: originalIsHidden,
      isEdited: originalIsEdited,
      account: account,
      contact: contact,
      mobileContact: mobileContact,
      shareContactId: shareContactId,
      replyMessage: replyMessage,
      systemMessage: systemMessage,
      callMessage: callMessage,
      isParentDeleted: isParentDeleted,
      isEncrypted: isEncrypted,
      isDecryptFailed: isDecryptFailed,
      isAlreadyShowAnimatedAndSound: isAlreadyShowAnimatedAndSound,
      bookmarkMessageId: bookmarkMessageId,
      lastEmojis: lastEmojis?.toEntities(),
      selectedReactionList: selectedReactionList,
      bookmarkEmojiTags: bookmarkEmojiTags,
      emojiAmount: emojiAmount,
      originalMessageId: originalMessageId,
      originalRoomId: originalRoomId,
      historyForAccountId: historyForAccountId,
      collapseId: collapseId,
      isLocked: isLocked,
      isCurrentlyUnlock: isCurrentlyUnlock,
      isMyNote: isMyNote,
      mentionList: mentionList,
      room: room,
      isPinned: isPinned,
    );
  }
}

extension MessageEntityToModelExtensions on MessageEntity {
  MessageModel toModel() {
    final model = MessageModel(
      id: id,
      ref: ref,
      roomId: roomId,
      accountId: accountId,
      message: message,
      type: type,
      files: files,
      links: links,
      meta: meta,
      createdAt: createdAt,
      updatedAt: updatedAt,
      sequence: sequence,
      isSending: isSending,
      isSendFailed: isSendFailed,
      originalIsHidden: isHidden,
      originalIsEdited: isEdited,
      account: account,
      contact: contact,
      mobileContact: mobileContact,
      shareContactId: shareContactId,
      replyMessage: replyMessage,
      systemMessage: systemMessage,
      callMessage: callMessage,
      isParentDeleted: isParentDeleted,
      isEncrypted: isEncrypted,
      isAlreadyShowAnimatedAndSound: isAlreadyShowAnimatedAndSound,
      bookmarkMessageId: bookmarkMessageId,
      lastEmojis: lastEmojis?.toModels(),
      selectedReactionList: selectedReactionList,
      bookmarkEmojiTags: bookmarkEmojiTags,
      emojiAmount: emojiAmount,
      originalMessageId: originalMessageId,
      originalRoomId: originalRoomId,
      historyForAccountId: historyForAccountId,
      collapseId: collapseId,
      isLocked: isLocked,
      isCurrentlyUnlock: isCurrentlyUnlock,
      isMyNote: isMyNote,
      mentionList: mentionList,
      room: room,
      isPinned: isPinned,
    );

    // Set properties that aren't in the constructor
    model.isDecryptFailed = isDecryptFailed;

    return model;
  }
}

extension MessageEntityListToModelExtensions on List<MessageEntity> {
  List<MessageModel> toModels() {
    return map((entity) => entity.toModel()).toList();
  }
}

extension MessageReactionCollectionExtensions on MessageReactionCollection {
  MessageReactionEntity toEntity() {
    return MessageReactionEntity(
      emojiId: emojiId,
      fileId: fileId,
      accountId: accountId,
      displayName: displayName,
      avatarPath: avatarPath,
      createdAt: createdAt,
    );
  }
}

extension MessageReactionCollectionListExtensions on List<MessageReactionCollection> {
  List<MessageReactionEntity> toEntities() {
    return map((collection) => collection.toEntity()).toList();
  }
}

extension MessageReactionEntityExtensions on MessageReactionEntity {
  MessageReactionCollection toCollection({required String msgId, required String roomId}) {
    return MessageReactionCollection(
      msgId: msgId,
      roomId: roomId,
      emojiId: emojiId,
      fileId: fileId,
      accountId: accountId,
      displayName: displayName,
      avatarPath: avatarPath,
      createdAt: createdAt,
    );
  }
}

// Last Emoji Extensions
extension LastEmojiModelExtensions on LastEmojiModel {
  LastEmojiEntity toEntity() {
    return LastEmojiEntity(
      emojiId: emojiId,
      fileId: fileId,
      amount: amount,
      accountIds: accountIds?.toSet(),
      updatedAt: updatedAt,
    );
  }
}

extension LastEmojiModelListExtensions on List<LastEmojiModel> {
  List<LastEmojiEntity> toEntities() {
    return map((model) => model.toEntity()).toList();
  }
}

extension LastEmojiEntityExtensions on LastEmojiEntity {
  LastEmojiModel toModel() {
    return LastEmojiModel(
      emojiId: emojiId,
      fileId: fileId,
      amount: amount,
      accountIds: accountIds?.toList(),
      updatedAt: updatedAt,
    );
  }
}

extension LastEmojiEntityListExtensions on List<LastEmojiEntity> {
  List<LastEmojiModel> toModels() {
    return map((entity) => entity.toModel()).toList();
  }
}

extension MessageReactionResponseEntityExtensions on MessageReactionResponseEntity {
  MessageReactionResponse toResponse() {
    return MessageReactionResponse(
      msgId: msgId,
      roomId: roomId,
      lastEmojis: lastEmojis?.toModels(),
      emojiAmount: emojiAmount,
    );
  }
}

extension MessageReactionResponseListExtensions on List<MessageReactionResponseEntity> {
  List<MessageReactionResponse> toResponses() {
    return map((entity) => entity.toResponse()).toList();
  }
}

extension MessageReactionResponseExtensions on MessageReactionResponse {
  MessageReactionResponseEntity toEntity() {
    return MessageReactionResponseEntity(
      msgId: msgId,
      roomId: roomId,
      lastEmojis: lastEmojis?.toEntities(),
      emojiAmount: emojiAmount,
    );
  }
}

extension MessageReactionResponseListEntityExtensions on List<MessageReactionResponse> {
  List<MessageReactionResponseEntity> toEntities() {
    return map((response) => response.toEntity()).toList();
  }
}

extension GetMessageReactionModelExtensions on GetMessageReactionModel {
  MessageReactionEntity toEntity() {
    return MessageReactionEntity(
      emojiId: emojiId,
      fileId: fileId,
      accountId: accountId,
      displayName: displayName,
      avatarPath: avatarPath,
      createdAt: createdAt,
    );
  }
}

extension GetMessageReactionModelListExtensions on List<GetMessageReactionModel> {
  List<MessageReactionEntity> toEntities() {
    return map((model) => model.toEntity()).toList();
  }
}
