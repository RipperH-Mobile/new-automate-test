// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MessageModelSchema = Schema(
  name: r'MessageModel',
  id: -902762555029995869,
  properties: {
    r'account': PropertySchema(
      id: 0,
      name: r'account',
      type: IsarType.object,
      target: r'ContactModel',
    ),
    r'accountId': PropertySchema(
      id: 1,
      name: r'accountId',
      type: IsarType.string,
    ),
    r'bookmarkEmojiTags': PropertySchema(
      id: 2,
      name: r'bookmarkEmojiTags',
      type: IsarType.objectList,
      target: r'BookmarkTagModel',
    ),
    r'bookmarkMessageId': PropertySchema(
      id: 3,
      name: r'bookmarkMessageId',
      type: IsarType.string,
    ),
    r'callMessage': PropertySchema(
      id: 4,
      name: r'callMessage',
      type: IsarType.object,
      target: r'MessageCallModel',
    ),
    r'canAddToAlbum': PropertySchema(
      id: 5,
      name: r'canAddToAlbum',
      type: IsarType.bool,
    ),
    r'canBookmark': PropertySchema(
      id: 6,
      name: r'canBookmark',
      type: IsarType.bool,
    ),
    r'canCopyMessage': PropertySchema(
      id: 7,
      name: r'canCopyMessage',
      type: IsarType.bool,
    ),
    r'canDeleteMessage': PropertySchema(
      id: 8,
      name: r'canDeleteMessage',
      type: IsarType.bool,
    ),
    r'canDeleteOthersMessage': PropertySchema(
      id: 9,
      name: r'canDeleteOthersMessage',
      type: IsarType.bool,
    ),
    r'canEditMessage': PropertySchema(
      id: 10,
      name: r'canEditMessage',
      type: IsarType.bool,
    ),
    r'canHideMessage': PropertySchema(
      id: 11,
      name: r'canHideMessage',
      type: IsarType.bool,
    ),
    r'canReact': PropertySchema(
      id: 12,
      name: r'canReact',
      type: IsarType.bool,
    ),
    r'canReply': PropertySchema(
      id: 13,
      name: r'canReply',
      type: IsarType.bool,
    ),
    r'canReportMessage': PropertySchema(
      id: 14,
      name: r'canReportMessage',
      type: IsarType.bool,
    ),
    r'canShare': PropertySchema(
      id: 15,
      name: r'canShare',
      type: IsarType.bool,
    ),
    r'canUnHideMessage': PropertySchema(
      id: 16,
      name: r'canUnHideMessage',
      type: IsarType.bool,
    ),
    r'collapseId': PropertySchema(
      id: 17,
      name: r'collapseId',
      type: IsarType.string,
    ),
    r'contact': PropertySchema(
      id: 18,
      name: r'contact',
      type: IsarType.object,
      target: r'ContactModel',
    ),
    r'createdAt': PropertySchema(
      id: 19,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dateKey': PropertySchema(
      id: 20,
      name: r'dateKey',
      type: IsarType.string,
    ),
    r'emojiAmount': PropertySchema(
      id: 21,
      name: r'emojiAmount',
      type: IsarType.long,
    ),
    r'file': PropertySchema(
      id: 22,
      name: r'file',
      type: IsarType.object,
      target: r'MessageFileModel',
    ),
    r'files': PropertySchema(
      id: 23,
      name: r'files',
      type: IsarType.objectList,
      target: r'MessageFileModel',
    ),
    r'historyForAccountId': PropertySchema(
      id: 24,
      name: r'historyForAccountId',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 25,
      name: r'id',
      type: IsarType.string,
    ),
    r'isAlreadyShowAnimatedAndSound': PropertySchema(
      id: 26,
      name: r'isAlreadyShowAnimatedAndSound',
      type: IsarType.bool,
    ),
    r'isCallMessage': PropertySchema(
      id: 27,
      name: r'isCallMessage',
      type: IsarType.bool,
    ),
    r'isDecryptFailed': PropertySchema(
      id: 28,
      name: r'isDecryptFailed',
      type: IsarType.bool,
    ),
    r'isEdited': PropertySchema(
      id: 29,
      name: r'isEdited',
      type: IsarType.bool,
    ),
    r'isEncrypted': PropertySchema(
      id: 30,
      name: r'isEncrypted',
      type: IsarType.bool,
    ),
    r'isHidden': PropertySchema(
      id: 31,
      name: r'isHidden',
      type: IsarType.bool,
    ),
    r'isLocked': PropertySchema(
      id: 32,
      name: r'isLocked',
      type: IsarType.bool,
    ),
    r'isMediaMessage': PropertySchema(
      id: 33,
      name: r'isMediaMessage',
      type: IsarType.bool,
    ),
    r'isMyNote': PropertySchema(
      id: 34,
      name: r'isMyNote',
      type: IsarType.bool,
    ),
    r'isParentDeleted': PropertySchema(
      id: 35,
      name: r'isParentDeleted',
      type: IsarType.bool,
    ),
    r'isPinned': PropertySchema(
      id: 36,
      name: r'isPinned',
      type: IsarType.bool,
    ),
    r'isRemoveMessage': PropertySchema(
      id: 37,
      name: r'isRemoveMessage',
      type: IsarType.bool,
    ),
    r'isSendFailed': PropertySchema(
      id: 38,
      name: r'isSendFailed',
      type: IsarType.bool,
    ),
    r'isSending': PropertySchema(
      id: 39,
      name: r'isSending',
      type: IsarType.bool,
    ),
    r'isSent': PropertySchema(
      id: 40,
      name: r'isSent',
      type: IsarType.bool,
    ),
    r'isSystemMessage': PropertySchema(
      id: 41,
      name: r'isSystemMessage',
      type: IsarType.bool,
    ),
    r'isUnsentMessage': PropertySchema(
      id: 42,
      name: r'isUnsentMessage',
      type: IsarType.bool,
    ),
    r'lastEmojis': PropertySchema(
      id: 43,
      name: r'lastEmojis',
      type: IsarType.objectList,
      target: r'LastEmojiModel',
    ),
    r'links': PropertySchema(
      id: 44,
      name: r'links',
      type: IsarType.objectList,
      target: r'MessageLinkModel',
    ),
    r'mentionList': PropertySchema(
      id: 45,
      name: r'mentionList',
      type: IsarType.objectList,
      target: r'MentionModel',
    ),
    r'message': PropertySchema(
      id: 46,
      name: r'message',
      type: IsarType.string,
    ),
    r'meta': PropertySchema(
      id: 47,
      name: r'meta',
      type: IsarType.object,
      target: r'MessageMetaModel',
    ),
    r'mine': PropertySchema(
      id: 48,
      name: r'mine',
      type: IsarType.bool,
    ),
    r'mobileContact': PropertySchema(
      id: 49,
      name: r'mobileContact',
      type: IsarType.object,
      target: r'MobileContactModel',
    ),
    r'originalIsEdited': PropertySchema(
      id: 50,
      name: r'originalIsEdited',
      type: IsarType.bool,
    ),
    r'originalIsHidden': PropertySchema(
      id: 51,
      name: r'originalIsHidden',
      type: IsarType.bool,
    ),
    r'originalMessageId': PropertySchema(
      id: 52,
      name: r'originalMessageId',
      type: IsarType.string,
    ),
    r'originalRoomId': PropertySchema(
      id: 53,
      name: r'originalRoomId',
      type: IsarType.string,
    ),
    r'ref': PropertySchema(
      id: 54,
      name: r'ref',
      type: IsarType.string,
    ),
    r'replyMessage': PropertySchema(
      id: 55,
      name: r'replyMessage',
      type: IsarType.object,
      target: r'MessageModel',
    ),
    r'roomId': PropertySchema(
      id: 56,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'selectedReactionList': PropertySchema(
      id: 57,
      name: r'selectedReactionList',
      type: IsarType.stringList,
    ),
    r'sentTime': PropertySchema(
      id: 58,
      name: r'sentTime',
      type: IsarType.string,
    ),
    r'sequence': PropertySchema(
      id: 59,
      name: r'sequence',
      type: IsarType.long,
    ),
    r'shareContactId': PropertySchema(
      id: 60,
      name: r'shareContactId',
      type: IsarType.string,
    ),
    r'systemMessage': PropertySchema(
      id: 61,
      name: r'systemMessage',
      type: IsarType.object,
      target: r'MessageSystemModel',
    ),
    r'timeString': PropertySchema(
      id: 62,
      name: r'timeString',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 63,
      name: r'type',
      type: IsarType.string,
      enumMap: _MessageModeltypeEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 64,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _messageModelEstimateSize,
  serialize: _messageModelSerialize,
  deserialize: _messageModelDeserialize,
  deserializeProp: _messageModelDeserializeProp,
);

int _messageModelEstimateSize(
  MessageModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.account;
    if (value != null) {
      bytesCount += 3 +
          ContactModelSchema.estimateSize(
              value, allOffsets[ContactModel]!, allOffsets);
    }
  }
  {
    final value = object.accountId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.bookmarkEmojiTags;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[BookmarkTagModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              BookmarkTagModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.bookmarkMessageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.callMessage;
    if (value != null) {
      bytesCount += 3 +
          MessageCallModelSchema.estimateSize(
              value, allOffsets[MessageCallModel]!, allOffsets);
    }
  }
  {
    final value = object.collapseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contact;
    if (value != null) {
      bytesCount += 3 +
          ContactModelSchema.estimateSize(
              value, allOffsets[ContactModel]!, allOffsets);
    }
  }
  bytesCount += 3 + object.dateKey.length * 3;
  {
    final value = object.file;
    if (value != null) {
      bytesCount += 3 +
          MessageFileModelSchema.estimateSize(
              value, allOffsets[MessageFileModel]!, allOffsets);
    }
  }
  {
    final list = object.files;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[MessageFileModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              MessageFileModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.historyForAccountId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.lastEmojis;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[LastEmojiModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              LastEmojiModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.links;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[MessageLinkModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              MessageLinkModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.mentionList;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[MentionModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              MentionModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.message;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.meta;
    if (value != null) {
      bytesCount += 3 +
          MessageMetaModelSchema.estimateSize(
              value, allOffsets[MessageMetaModel]!, allOffsets);
    }
  }
  {
    final value = object.mobileContact;
    if (value != null) {
      bytesCount += 3 +
          MobileContactModelSchema.estimateSize(
              value, allOffsets[MobileContactModel]!, allOffsets);
    }
  }
  {
    final value = object.originalMessageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.originalRoomId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ref;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.replyMessage;
    if (value != null) {
      bytesCount += 3 +
          MessageModelSchema.estimateSize(
              value, allOffsets[MessageModel]!, allOffsets);
    }
  }
  {
    final value = object.roomId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.selectedReactionList;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  bytesCount += 3 + object.sentTime.length * 3;
  {
    final value = object.shareContactId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.systemMessage;
    if (value != null) {
      bytesCount += 3 +
          MessageSystemModelSchema.estimateSize(
              value, allOffsets[MessageSystemModel]!, allOffsets);
    }
  }
  {
    final value = object.timeString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _messageModelSerialize(
  MessageModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<ContactModel>(
    offsets[0],
    allOffsets,
    ContactModelSchema.serialize,
    object.account,
  );
  writer.writeString(offsets[1], object.accountId);
  writer.writeObjectList<BookmarkTagModel>(
    offsets[2],
    allOffsets,
    BookmarkTagModelSchema.serialize,
    object.bookmarkEmojiTags,
  );
  writer.writeString(offsets[3], object.bookmarkMessageId);
  writer.writeObject<MessageCallModel>(
    offsets[4],
    allOffsets,
    MessageCallModelSchema.serialize,
    object.callMessage,
  );
  writer.writeBool(offsets[5], object.canAddToAlbum);
  writer.writeBool(offsets[6], object.canBookmark);
  writer.writeBool(offsets[7], object.canCopyMessage);
  writer.writeBool(offsets[8], object.canDeleteMessage);
  writer.writeBool(offsets[9], object.canDeleteOthersMessage);
  writer.writeBool(offsets[10], object.canEditMessage);
  writer.writeBool(offsets[11], object.canHideMessage);
  writer.writeBool(offsets[12], object.canReact);
  writer.writeBool(offsets[13], object.canReply);
  writer.writeBool(offsets[14], object.canReportMessage);
  writer.writeBool(offsets[15], object.canShare);
  writer.writeBool(offsets[16], object.canUnHideMessage);
  writer.writeString(offsets[17], object.collapseId);
  writer.writeObject<ContactModel>(
    offsets[18],
    allOffsets,
    ContactModelSchema.serialize,
    object.contact,
  );
  writer.writeDateTime(offsets[19], object.createdAt);
  writer.writeString(offsets[20], object.dateKey);
  writer.writeLong(offsets[21], object.emojiAmount);
  writer.writeObject<MessageFileModel>(
    offsets[22],
    allOffsets,
    MessageFileModelSchema.serialize,
    object.file,
  );
  writer.writeObjectList<MessageFileModel>(
    offsets[23],
    allOffsets,
    MessageFileModelSchema.serialize,
    object.files,
  );
  writer.writeString(offsets[24], object.historyForAccountId);
  writer.writeString(offsets[25], object.id);
  writer.writeBool(offsets[26], object.isAlreadyShowAnimatedAndSound);
  writer.writeBool(offsets[27], object.isCallMessage);
  writer.writeBool(offsets[28], object.isDecryptFailed);
  writer.writeBool(offsets[29], object.isEdited);
  writer.writeBool(offsets[30], object.isEncrypted);
  writer.writeBool(offsets[31], object.isHidden);
  writer.writeBool(offsets[32], object.isLocked);
  writer.writeBool(offsets[33], object.isMediaMessage);
  writer.writeBool(offsets[34], object.isMyNote);
  writer.writeBool(offsets[35], object.isParentDeleted);
  writer.writeBool(offsets[36], object.isPinned);
  writer.writeBool(offsets[37], object.isRemoveMessage);
  writer.writeBool(offsets[38], object.isSendFailed);
  writer.writeBool(offsets[39], object.isSending);
  writer.writeBool(offsets[40], object.isSent);
  writer.writeBool(offsets[41], object.isSystemMessage);
  writer.writeBool(offsets[42], object.isUnsentMessage);
  writer.writeObjectList<LastEmojiModel>(
    offsets[43],
    allOffsets,
    LastEmojiModelSchema.serialize,
    object.lastEmojis,
  );
  writer.writeObjectList<MessageLinkModel>(
    offsets[44],
    allOffsets,
    MessageLinkModelSchema.serialize,
    object.links,
  );
  writer.writeObjectList<MentionModel>(
    offsets[45],
    allOffsets,
    MentionModelSchema.serialize,
    object.mentionList,
  );
  writer.writeString(offsets[46], object.message);
  writer.writeObject<MessageMetaModel>(
    offsets[47],
    allOffsets,
    MessageMetaModelSchema.serialize,
    object.meta,
  );
  writer.writeBool(offsets[48], object.mine);
  writer.writeObject<MobileContactModel>(
    offsets[49],
    allOffsets,
    MobileContactModelSchema.serialize,
    object.mobileContact,
  );
  writer.writeBool(offsets[50], object.originalIsEdited);
  writer.writeBool(offsets[51], object.originalIsHidden);
  writer.writeString(offsets[52], object.originalMessageId);
  writer.writeString(offsets[53], object.originalRoomId);
  writer.writeString(offsets[54], object.ref);
  writer.writeObject<MessageModel>(
    offsets[55],
    allOffsets,
    MessageModelSchema.serialize,
    object.replyMessage,
  );
  writer.writeString(offsets[56], object.roomId);
  writer.writeStringList(offsets[57], object.selectedReactionList);
  writer.writeString(offsets[58], object.sentTime);
  writer.writeLong(offsets[59], object.sequence);
  writer.writeString(offsets[60], object.shareContactId);
  writer.writeObject<MessageSystemModel>(
    offsets[61],
    allOffsets,
    MessageSystemModelSchema.serialize,
    object.systemMessage,
  );
  writer.writeString(offsets[62], object.timeString);
  writer.writeString(offsets[63], object.type?.name);
  writer.writeDateTime(offsets[64], object.updatedAt);
}

MessageModel _messageModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageModel(
    account: reader.readObjectOrNull<ContactModel>(
      offsets[0],
      ContactModelSchema.deserialize,
      allOffsets,
    ),
    accountId: reader.readStringOrNull(offsets[1]),
    bookmarkEmojiTags: reader.readObjectList<BookmarkTagModel>(
      offsets[2],
      BookmarkTagModelSchema.deserialize,
      allOffsets,
      BookmarkTagModel(),
    ),
    bookmarkMessageId: reader.readStringOrNull(offsets[3]),
    callMessage: reader.readObjectOrNull<MessageCallModel>(
      offsets[4],
      MessageCallModelSchema.deserialize,
      allOffsets,
    ),
    collapseId: reader.readStringOrNull(offsets[17]),
    contact: reader.readObjectOrNull<ContactModel>(
      offsets[18],
      ContactModelSchema.deserialize,
      allOffsets,
    ),
    createdAt: reader.readDateTimeOrNull(offsets[19]),
    emojiAmount: reader.readLongOrNull(offsets[21]),
    files: reader.readObjectList<MessageFileModel>(
      offsets[23],
      MessageFileModelSchema.deserialize,
      allOffsets,
      MessageFileModel(),
    ),
    historyForAccountId: reader.readStringOrNull(offsets[24]),
    id: reader.readStringOrNull(offsets[25]),
    isAlreadyShowAnimatedAndSound: reader.readBoolOrNull(offsets[26]),
    isEncrypted: reader.readBoolOrNull(offsets[30]),
    isLocked: reader.readBoolOrNull(offsets[32]),
    isMyNote: reader.readBoolOrNull(offsets[34]),
    isParentDeleted: reader.readBoolOrNull(offsets[35]),
    isPinned: reader.readBoolOrNull(offsets[36]),
    isSendFailed: reader.readBoolOrNull(offsets[38]),
    isSending: reader.readBoolOrNull(offsets[39]),
    lastEmojis: reader.readObjectList<LastEmojiModel>(
      offsets[43],
      LastEmojiModelSchema.deserialize,
      allOffsets,
      LastEmojiModel(),
    ),
    links: reader.readObjectList<MessageLinkModel>(
      offsets[44],
      MessageLinkModelSchema.deserialize,
      allOffsets,
      MessageLinkModel(),
    ),
    mentionList: reader.readObjectList<MentionModel>(
      offsets[45],
      MentionModelSchema.deserialize,
      allOffsets,
      MentionModel(),
    ),
    message: reader.readStringOrNull(offsets[46]),
    meta: reader.readObjectOrNull<MessageMetaModel>(
      offsets[47],
      MessageMetaModelSchema.deserialize,
      allOffsets,
    ),
    mobileContact: reader.readObjectOrNull<MobileContactModel>(
      offsets[49],
      MobileContactModelSchema.deserialize,
      allOffsets,
    ),
    originalIsEdited: reader.readBoolOrNull(offsets[50]),
    originalIsHidden: reader.readBoolOrNull(offsets[51]),
    originalMessageId: reader.readStringOrNull(offsets[52]),
    originalRoomId: reader.readStringOrNull(offsets[53]),
    ref: reader.readStringOrNull(offsets[54]),
    replyMessage: reader.readObjectOrNull<MessageModel>(
      offsets[55],
      MessageModelSchema.deserialize,
      allOffsets,
    ),
    roomId: reader.readStringOrNull(offsets[56]),
    selectedReactionList: reader.readStringList(offsets[57]),
    sequence: reader.readLongOrNull(offsets[59]),
    shareContactId: reader.readStringOrNull(offsets[60]),
    systemMessage: reader.readObjectOrNull<MessageSystemModel>(
      offsets[61],
      MessageSystemModelSchema.deserialize,
      allOffsets,
    ),
    type: _MessageModeltypeValueEnumMap[reader.readStringOrNull(offsets[63])],
    updatedAt: reader.readDateTimeOrNull(offsets[64]),
  );
  object.isDecryptFailed = reader.readBoolOrNull(offsets[28]);
  return object;
}

P _messageModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<ContactModel>(
        offset,
        ContactModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<BookmarkTagModel>(
        offset,
        BookmarkTagModelSchema.deserialize,
        allOffsets,
        BookmarkTagModel(),
      )) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<MessageCallModel>(
        offset,
        MessageCallModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readObjectOrNull<ContactModel>(
        offset,
        ContactModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 19:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readObjectOrNull<MessageFileModel>(
        offset,
        MessageFileModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 23:
      return (reader.readObjectList<MessageFileModel>(
        offset,
        MessageFileModelSchema.deserialize,
        allOffsets,
        MessageFileModel(),
      )) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readBoolOrNull(offset)) as P;
    case 27:
      return (reader.readBool(offset)) as P;
    case 28:
      return (reader.readBoolOrNull(offset)) as P;
    case 29:
      return (reader.readBool(offset)) as P;
    case 30:
      return (reader.readBoolOrNull(offset)) as P;
    case 31:
      return (reader.readBool(offset)) as P;
    case 32:
      return (reader.readBoolOrNull(offset)) as P;
    case 33:
      return (reader.readBool(offset)) as P;
    case 34:
      return (reader.readBoolOrNull(offset)) as P;
    case 35:
      return (reader.readBoolOrNull(offset)) as P;
    case 36:
      return (reader.readBoolOrNull(offset)) as P;
    case 37:
      return (reader.readBool(offset)) as P;
    case 38:
      return (reader.readBoolOrNull(offset)) as P;
    case 39:
      return (reader.readBoolOrNull(offset)) as P;
    case 40:
      return (reader.readBool(offset)) as P;
    case 41:
      return (reader.readBool(offset)) as P;
    case 42:
      return (reader.readBool(offset)) as P;
    case 43:
      return (reader.readObjectList<LastEmojiModel>(
        offset,
        LastEmojiModelSchema.deserialize,
        allOffsets,
        LastEmojiModel(),
      )) as P;
    case 44:
      return (reader.readObjectList<MessageLinkModel>(
        offset,
        MessageLinkModelSchema.deserialize,
        allOffsets,
        MessageLinkModel(),
      )) as P;
    case 45:
      return (reader.readObjectList<MentionModel>(
        offset,
        MentionModelSchema.deserialize,
        allOffsets,
        MentionModel(),
      )) as P;
    case 46:
      return (reader.readStringOrNull(offset)) as P;
    case 47:
      return (reader.readObjectOrNull<MessageMetaModel>(
        offset,
        MessageMetaModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 48:
      return (reader.readBool(offset)) as P;
    case 49:
      return (reader.readObjectOrNull<MobileContactModel>(
        offset,
        MobileContactModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 50:
      return (reader.readBoolOrNull(offset)) as P;
    case 51:
      return (reader.readBoolOrNull(offset)) as P;
    case 52:
      return (reader.readStringOrNull(offset)) as P;
    case 53:
      return (reader.readStringOrNull(offset)) as P;
    case 54:
      return (reader.readStringOrNull(offset)) as P;
    case 55:
      return (reader.readObjectOrNull<MessageModel>(
        offset,
        MessageModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 56:
      return (reader.readStringOrNull(offset)) as P;
    case 57:
      return (reader.readStringList(offset)) as P;
    case 58:
      return (reader.readString(offset)) as P;
    case 59:
      return (reader.readLongOrNull(offset)) as P;
    case 60:
      return (reader.readStringOrNull(offset)) as P;
    case 61:
      return (reader.readObjectOrNull<MessageSystemModel>(
        offset,
        MessageSystemModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 62:
      return (reader.readStringOrNull(offset)) as P;
    case 63:
      return (_MessageModeltypeValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 64:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MessageModeltypeEnumValueMap = {
  r'text': r'text',
  r'sticker': r'sticker',
  r'stickerGift': r'stickerGift',
  r'stickerSharing': r'stickerSharing',
  r'file': r'file',
  r'image': r'image',
  r'audio': r'audio',
  r'video': r'video',
  r'gif': r'gif',
  r'system': r'system',
  r'unsent': r'unsent',
  r'remove': r'remove',
  r'removeOthers': r'removeOthers',
  r'edit': r'edit',
  r'album': r'album',
  r'location': r'location',
  r'callMsg': r'callMsg',
  r'contact': r'contact',
  r'mobileContact': r'mobileContact',
};
const _MessageModeltypeValueEnumMap = {
  r'text': MessageType.text,
  r'sticker': MessageType.sticker,
  r'stickerGift': MessageType.stickerGift,
  r'stickerSharing': MessageType.stickerSharing,
  r'file': MessageType.file,
  r'image': MessageType.image,
  r'audio': MessageType.audio,
  r'video': MessageType.video,
  r'gif': MessageType.gif,
  r'system': MessageType.system,
  r'unsent': MessageType.unsent,
  r'remove': MessageType.remove,
  r'removeOthers': MessageType.removeOthers,
  r'edit': MessageType.edit,
  r'album': MessageType.album,
  r'location': MessageType.location,
  r'callMsg': MessageType.callMsg,
  r'contact': MessageType.contact,
  r'mobileContact': MessageType.mobileContact,
};

extension MessageModelQueryFilter
    on QueryBuilder<MessageModel, MessageModel, QFilterCondition> {
  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'account',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'account',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkEmojiTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkEmojiTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkEmojiTagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarkEmojiTags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkEmojiTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarkEmojiTags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkEmojiTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarkEmojiTags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkEmojiTagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarkEmojiTags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkEmojiTagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarkEmojiTags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkEmojiTagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarkEmojiTags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bookmarkMessageId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bookmarkMessageId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarkMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookmarkMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookmarkMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookmarkMessageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bookmarkMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bookmarkMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bookmarkMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bookmarkMessageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarkMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkMessageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bookmarkMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      callMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callMessage',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      callMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callMessage',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canAddToAlbumEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canAddToAlbum',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canBookmarkEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canBookmark',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canCopyMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canCopyMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canDeleteMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canDeleteMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canDeleteOthersMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canDeleteOthersMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canEditMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canEditMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canHideMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canHideMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canReactEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canReact',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canReplyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canReply',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canReportMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canReportMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canShareEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShare',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      canUnHideMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canUnHideMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'collapseId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'collapseId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collapseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'collapseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'collapseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'collapseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'collapseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'collapseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'collapseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'collapseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collapseId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      collapseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'collapseId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contactIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contact',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contactIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contact',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      dateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      emojiAmountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiAmount',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      emojiAmountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiAmount',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      emojiAmountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      emojiAmountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emojiAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      emojiAmountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emojiAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      emojiAmountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emojiAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> fileIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'file',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      fileIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'file',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      filesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'files',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      filesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'files',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      filesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      filesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      filesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      filesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      filesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      filesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'historyForAccountId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'historyForAccountId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historyForAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'historyForAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'historyForAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'historyForAccountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'historyForAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'historyForAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'historyForAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'historyForAccountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historyForAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      historyForAccountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'historyForAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isAlreadyShowAnimatedAndSoundIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isAlreadyShowAnimatedAndSound',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isAlreadyShowAnimatedAndSoundIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isAlreadyShowAnimatedAndSound',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isAlreadyShowAnimatedAndSoundEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAlreadyShowAnimatedAndSound',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isCallMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCallMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isDecryptFailedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDecryptFailed',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isDecryptFailedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDecryptFailed',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isDecryptFailedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDecryptFailed',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isEditedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEdited',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isEncryptedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isEncrypted',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isEncryptedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isEncrypted',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isEncryptedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEncrypted',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isHiddenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isLockedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isLocked',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isLockedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isLocked',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isLockedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLocked',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isMediaMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMediaMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isMyNoteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isMyNote',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isMyNoteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isMyNote',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isMyNoteEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMyNote',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isParentDeletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isParentDeleted',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isParentDeletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isParentDeleted',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isParentDeletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isParentDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isPinnedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPinned',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isPinnedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPinned',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isPinnedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPinned',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isRemoveMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRemoveMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isSendFailedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isSendFailed',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isSendFailedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isSendFailed',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isSendFailedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSendFailed',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isSendingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isSending',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isSendingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isSending',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isSendingEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSending',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> isSentEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSent',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isSystemMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystemMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      isUnsentMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUnsentMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      lastEmojisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastEmojis',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      lastEmojisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastEmojis',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      lastEmojisLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastEmojis',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      lastEmojisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastEmojis',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      lastEmojisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastEmojis',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      lastEmojisLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastEmojis',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      lastEmojisLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastEmojis',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      lastEmojisLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastEmojis',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      linksIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'links',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      linksIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'links',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      linksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'links',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      linksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'links',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      linksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'links',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      linksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'links',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      linksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'links',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      linksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'links',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mentionListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mentionList',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mentionListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mentionList',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mentionListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mentionListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mentionListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mentionListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mentionListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mentionListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> metaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'meta',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      metaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'meta',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> mineEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mine',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mobileContactIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mobileContact',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mobileContactIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mobileContact',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalIsEditedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalIsEdited',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalIsEditedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalIsEdited',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalIsEditedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalIsEdited',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalIsHiddenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalIsHidden',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalIsHiddenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalIsHidden',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalIsHiddenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalIsHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalMessageId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalMessageId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originalMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originalMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originalMessageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'originalMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'originalMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalMessageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalMessageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalRoomId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalRoomId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalRoomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originalRoomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originalRoomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originalRoomId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'originalRoomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'originalRoomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalRoomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalRoomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalRoomId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      originalRoomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalRoomId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> refIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ref',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      refIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ref',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> refEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      refGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> refLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> refBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ref',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> refStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> refEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> refContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> refMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ref',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> refIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ref',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      refIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ref',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      replyMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'replyMessage',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      replyMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'replyMessage',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> roomIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      roomIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      roomIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> roomIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      roomIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      roomIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> roomIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selectedReactionList',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selectedReactionList',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedReactionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedReactionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedReactionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedReactionList',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selectedReactionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selectedReactionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selectedReactionList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selectedReactionList',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedReactionList',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selectedReactionList',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedReactionList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedReactionList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedReactionList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedReactionList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedReactionList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      selectedReactionListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedReactionList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sentTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sentTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sentTime',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sentTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sentTime',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sequenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sequence',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sequenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sequence',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sequenceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sequence',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sequenceGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sequence',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sequenceLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sequence',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      sequenceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sequence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shareContactId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shareContactId',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shareContactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shareContactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shareContactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shareContactId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shareContactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shareContactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shareContactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shareContactId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shareContactId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      shareContactIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shareContactId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      systemMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'systemMessage',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      systemMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'systemMessage',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeString',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeString',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timeString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeString',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      timeStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timeString',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> typeEqualTo(
    MessageType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      typeGreaterThan(
    MessageType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> typeLessThan(
    MessageType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> typeBetween(
    MessageType? lower,
    MessageType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MessageModelQueryObject
    on QueryBuilder<MessageModel, MessageModel, QFilterCondition> {
  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> account(
      FilterQuery<ContactModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'account');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      bookmarkEmojiTagsElement(FilterQuery<BookmarkTagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'bookmarkEmojiTags');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> callMessage(
      FilterQuery<MessageCallModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'callMessage');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> contact(
      FilterQuery<ContactModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'contact');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> file(
      FilterQuery<MessageFileModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'file');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> filesElement(
      FilterQuery<MessageFileModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'files');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      lastEmojisElement(FilterQuery<LastEmojiModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lastEmojis');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> linksElement(
      FilterQuery<MessageLinkModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'links');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      mentionListElement(FilterQuery<MentionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mentionList');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> meta(
      FilterQuery<MessageMetaModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'meta');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> mobileContact(
      FilterQuery<MobileContactModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mobileContact');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> replyMessage(
      FilterQuery<MessageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'replyMessage');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> systemMessage(
      FilterQuery<MessageSystemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'systemMessage');
    });
  }
}
