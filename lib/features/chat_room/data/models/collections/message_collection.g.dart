// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMessageCollectionCollection on Isar {
  IsarCollection<MessageCollection> get messages => this.collection();
}

const MessageCollectionSchema = CollectionSchema(
  name: r'Message',
  id: 2463283977299753079,
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
    r'canShowInSentMessageList': PropertySchema(
      id: 16,
      name: r'canShowInSentMessageList',
      type: IsarType.bool,
    ),
    r'canUnHideMessage': PropertySchema(
      id: 17,
      name: r'canUnHideMessage',
      type: IsarType.bool,
    ),
    r'collapseId': PropertySchema(
      id: 18,
      name: r'collapseId',
      type: IsarType.string,
    ),
    r'contact': PropertySchema(
      id: 19,
      name: r'contact',
      type: IsarType.object,
      target: r'ContactModel',
    ),
    r'createdAt': PropertySchema(
      id: 20,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dateKey': PropertySchema(
      id: 21,
      name: r'dateKey',
      type: IsarType.string,
    ),
    r'emojiAmount': PropertySchema(
      id: 22,
      name: r'emojiAmount',
      type: IsarType.long,
    ),
    r'file': PropertySchema(
      id: 23,
      name: r'file',
      type: IsarType.object,
      target: r'MessageFileModel',
    ),
    r'files': PropertySchema(
      id: 24,
      name: r'files',
      type: IsarType.objectList,
      target: r'MessageFileModel',
    ),
    r'historyForAccountId': PropertySchema(
      id: 25,
      name: r'historyForAccountId',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 26,
      name: r'id',
      type: IsarType.string,
    ),
    r'isAlreadyShowAnimatedAndSound': PropertySchema(
      id: 27,
      name: r'isAlreadyShowAnimatedAndSound',
      type: IsarType.bool,
    ),
    r'isCallMessage': PropertySchema(
      id: 28,
      name: r'isCallMessage',
      type: IsarType.bool,
    ),
    r'isDecryptFailed': PropertySchema(
      id: 29,
      name: r'isDecryptFailed',
      type: IsarType.bool,
    ),
    r'isEdited': PropertySchema(
      id: 30,
      name: r'isEdited',
      type: IsarType.bool,
    ),
    r'isEncrypted': PropertySchema(
      id: 31,
      name: r'isEncrypted',
      type: IsarType.bool,
    ),
    r'isHidden': PropertySchema(
      id: 32,
      name: r'isHidden',
      type: IsarType.bool,
    ),
    r'isLocked': PropertySchema(
      id: 33,
      name: r'isLocked',
      type: IsarType.bool,
    ),
    r'isMediaMessage': PropertySchema(
      id: 34,
      name: r'isMediaMessage',
      type: IsarType.bool,
    ),
    r'isMyNote': PropertySchema(
      id: 35,
      name: r'isMyNote',
      type: IsarType.bool,
    ),
    r'isParentDeleted': PropertySchema(
      id: 36,
      name: r'isParentDeleted',
      type: IsarType.bool,
    ),
    r'isPinned': PropertySchema(
      id: 37,
      name: r'isPinned',
      type: IsarType.bool,
    ),
    r'isRemoveMessage': PropertySchema(
      id: 38,
      name: r'isRemoveMessage',
      type: IsarType.bool,
    ),
    r'isSendFailed': PropertySchema(
      id: 39,
      name: r'isSendFailed',
      type: IsarType.bool,
    ),
    r'isSending': PropertySchema(
      id: 40,
      name: r'isSending',
      type: IsarType.bool,
    ),
    r'isSent': PropertySchema(
      id: 41,
      name: r'isSent',
      type: IsarType.bool,
    ),
    r'isSystemMessage': PropertySchema(
      id: 42,
      name: r'isSystemMessage',
      type: IsarType.bool,
    ),
    r'isUnsentMessage': PropertySchema(
      id: 43,
      name: r'isUnsentMessage',
      type: IsarType.bool,
    ),
    r'lastEmojis': PropertySchema(
      id: 44,
      name: r'lastEmojis',
      type: IsarType.objectList,
      target: r'LastEmojiModel',
    ),
    r'links': PropertySchema(
      id: 45,
      name: r'links',
      type: IsarType.objectList,
      target: r'MessageLinkModel',
    ),
    r'mentionList': PropertySchema(
      id: 46,
      name: r'mentionList',
      type: IsarType.objectList,
      target: r'MentionModel',
    ),
    r'message': PropertySchema(
      id: 47,
      name: r'message',
      type: IsarType.string,
    ),
    r'meta': PropertySchema(
      id: 48,
      name: r'meta',
      type: IsarType.object,
      target: r'MessageMetaModel',
    ),
    r'mine': PropertySchema(
      id: 49,
      name: r'mine',
      type: IsarType.bool,
    ),
    r'mobileContact': PropertySchema(
      id: 50,
      name: r'mobileContact',
      type: IsarType.object,
      target: r'MobileContactModel',
    ),
    r'originalIsEdited': PropertySchema(
      id: 51,
      name: r'originalIsEdited',
      type: IsarType.bool,
    ),
    r'originalIsHidden': PropertySchema(
      id: 52,
      name: r'originalIsHidden',
      type: IsarType.bool,
    ),
    r'originalMessageId': PropertySchema(
      id: 53,
      name: r'originalMessageId',
      type: IsarType.string,
    ),
    r'originalRoomId': PropertySchema(
      id: 54,
      name: r'originalRoomId',
      type: IsarType.string,
    ),
    r'ref': PropertySchema(
      id: 55,
      name: r'ref',
      type: IsarType.string,
    ),
    r'replyMessage': PropertySchema(
      id: 56,
      name: r'replyMessage',
      type: IsarType.object,
      target: r'MessageModel',
    ),
    r'roomId': PropertySchema(
      id: 57,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'searchMessage': PropertySchema(
      id: 58,
      name: r'searchMessage',
      type: IsarType.string,
    ),
    r'selectedReactionList': PropertySchema(
      id: 59,
      name: r'selectedReactionList',
      type: IsarType.stringList,
    ),
    r'sentTime': PropertySchema(
      id: 60,
      name: r'sentTime',
      type: IsarType.string,
    ),
    r'sequence': PropertySchema(
      id: 61,
      name: r'sequence',
      type: IsarType.long,
    ),
    r'shareContactId': PropertySchema(
      id: 62,
      name: r'shareContactId',
      type: IsarType.string,
    ),
    r'systemMessage': PropertySchema(
      id: 63,
      name: r'systemMessage',
      type: IsarType.object,
      target: r'MessageSystemModel',
    ),
    r'timeString': PropertySchema(
      id: 64,
      name: r'timeString',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 65,
      name: r'type',
      type: IsarType.string,
      enumMap: _MessageCollectiontypeEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 66,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _messageCollectionEstimateSize,
  serialize: _messageCollectionSerialize,
  deserialize: _messageCollectionDeserialize,
  deserializeProp: _messageCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'ref': IndexSchema(
      id: -6066889550123943304,
      name: r'ref',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'ref',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'accountId': IndexSchema(
      id: -1591555361937770434,
      name: r'accountId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'accountId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isSendFailed_roomId': IndexSchema(
      id: -7415466075743325654,
      name: r'isSendFailed_roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isSendFailed',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isSending_roomId': IndexSchema(
      id: -5217756255800582474,
      name: r'isSending_roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isSending',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'roomId': IndexSchema(
      id: -3609232324653216207,
      name: r'roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'roomId_sequence': IndexSchema(
      id: 4177461709757175173,
      name: r'roomId_sequence',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'sequence',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'sequence_roomId': IndexSchema(
      id: -2419881921561227403,
      name: r'sequence_roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sequence',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'bookmarkMessageId': IndexSchema(
      id: -1844832955438201527,
      name: r'bookmarkMessageId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'bookmarkMessageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'originalMessageId': IndexSchema(
      id: -8471058615105819136,
      name: r'originalMessageId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'originalMessageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'originalRoomId': IndexSchema(
      id: -8272213310178167025,
      name: r'originalRoomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'originalRoomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isMyNote': IndexSchema(
      id: -2974421463761643955,
      name: r'isMyNote',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isMyNote',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isPinned': IndexSchema(
      id: 7607338673446676027,
      name: r'isPinned',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPinned',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isSent_roomId': IndexSchema(
      id: -8938145652590734729,
      name: r'isSent_roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isSent',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'canShowInSentMessageList_roomId': IndexSchema(
      id: 5055811116251608703,
      name: r'canShowInSentMessageList_roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInSentMessageList',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isHidden_roomId': IndexSchema(
      id: -4448401602079211347,
      name: r'isHidden_roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isHidden',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isEdited_roomId': IndexSchema(
      id: 3488251286039393422,
      name: r'isEdited_roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isEdited',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'ContactModel': ContactModelSchema,
    r'OfficialMenuModel': OfficialMenuModelSchema,
    r'OfficialMenuContainerModel': OfficialMenuContainerModelSchema,
    r'OfficialMenuCommandModel': OfficialMenuCommandModelSchema,
    r'OfficialMenuCommandArgModel': OfficialMenuCommandArgModelSchema,
    r'RichMenuModel': RichMenuModelSchema,
    r'RichMenuPublishModel': RichMenuPublishModelSchema,
    r'RichMenuContainerModel': RichMenuContainerModelSchema,
    r'RichMenuFunctionModel': RichMenuFunctionModelSchema,
    r'RichMenuBoundsModel': RichMenuBoundsModelSchema,
    r'RichMenuCommandArgModel': RichMenuCommandArgModelSchema,
    r'AccountSettingsModel': AccountSettingsModelSchema,
    r'CallSettingsModel': CallSettingsModelSchema,
    r'ChatSettingsModel': ChatSettingsModelSchema,
    r'FriendSettingsModel': FriendSettingsModelSchema,
    r'AllowFriendAddModel': AllowFriendAddModelSchema,
    r'NotificationSettingsModel': NotificationSettingsModelSchema,
    r'ProfileSettingsModel': ProfileSettingsModelSchema,
    r'SecuritySettingsModel': SecuritySettingsModelSchema,
    r'MessageFileModel': MessageFileModelSchema,
    r'MessageLinkModel': MessageLinkModelSchema,
    r'MessageLinkVideoModel': MessageLinkVideoModelSchema,
    r'MessageMetaModel': MessageMetaModelSchema,
    r'DeletedByAccountModel': DeletedByAccountModelSchema,
    r'AlbumTaskModel': AlbumTaskModelSchema,
    r'MessageModel': MessageModelSchema,
    r'MessageSystemModel': MessageSystemModelSchema,
    r'MessageSystemPayloadModel': MessageSystemPayloadModelSchema,
    r'MessageSystemPayloadMemberModel': MessageSystemPayloadMemberModelSchema,
    r'MessageCallModel': MessageCallModelSchema,
    r'MessageCallPayloadModel': MessageCallPayloadModelSchema,
    r'MobileContactModel': MobileContactModelSchema,
    r'LastEmojiModel': LastEmojiModelSchema,
    r'MentionModel': MentionModelSchema,
    r'BookmarkTagModel': BookmarkTagModelSchema
  },
  getId: _messageCollectionGetId,
  getLinks: _messageCollectionGetLinks,
  attach: _messageCollectionAttach,
  version: '3.3.0-dev.3',
);

int _messageCollectionEstimateSize(
  MessageCollection object,
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
    final value = object.searchMessage;
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

void _messageCollectionSerialize(
  MessageCollection object,
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
  writer.writeBool(offsets[16], object.canShowInSentMessageList);
  writer.writeBool(offsets[17], object.canUnHideMessage);
  writer.writeString(offsets[18], object.collapseId);
  writer.writeObject<ContactModel>(
    offsets[19],
    allOffsets,
    ContactModelSchema.serialize,
    object.contact,
  );
  writer.writeDateTime(offsets[20], object.createdAt);
  writer.writeString(offsets[21], object.dateKey);
  writer.writeLong(offsets[22], object.emojiAmount);
  writer.writeObject<MessageFileModel>(
    offsets[23],
    allOffsets,
    MessageFileModelSchema.serialize,
    object.file,
  );
  writer.writeObjectList<MessageFileModel>(
    offsets[24],
    allOffsets,
    MessageFileModelSchema.serialize,
    object.files,
  );
  writer.writeString(offsets[25], object.historyForAccountId);
  writer.writeString(offsets[26], object.id);
  writer.writeBool(offsets[27], object.isAlreadyShowAnimatedAndSound);
  writer.writeBool(offsets[28], object.isCallMessage);
  writer.writeBool(offsets[29], object.isDecryptFailed);
  writer.writeBool(offsets[30], object.isEdited);
  writer.writeBool(offsets[31], object.isEncrypted);
  writer.writeBool(offsets[32], object.isHidden);
  writer.writeBool(offsets[33], object.isLocked);
  writer.writeBool(offsets[34], object.isMediaMessage);
  writer.writeBool(offsets[35], object.isMyNote);
  writer.writeBool(offsets[36], object.isParentDeleted);
  writer.writeBool(offsets[37], object.isPinned);
  writer.writeBool(offsets[38], object.isRemoveMessage);
  writer.writeBool(offsets[39], object.isSendFailed);
  writer.writeBool(offsets[40], object.isSending);
  writer.writeBool(offsets[41], object.isSent);
  writer.writeBool(offsets[42], object.isSystemMessage);
  writer.writeBool(offsets[43], object.isUnsentMessage);
  writer.writeObjectList<LastEmojiModel>(
    offsets[44],
    allOffsets,
    LastEmojiModelSchema.serialize,
    object.lastEmojis,
  );
  writer.writeObjectList<MessageLinkModel>(
    offsets[45],
    allOffsets,
    MessageLinkModelSchema.serialize,
    object.links,
  );
  writer.writeObjectList<MentionModel>(
    offsets[46],
    allOffsets,
    MentionModelSchema.serialize,
    object.mentionList,
  );
  writer.writeString(offsets[47], object.message);
  writer.writeObject<MessageMetaModel>(
    offsets[48],
    allOffsets,
    MessageMetaModelSchema.serialize,
    object.meta,
  );
  writer.writeBool(offsets[49], object.mine);
  writer.writeObject<MobileContactModel>(
    offsets[50],
    allOffsets,
    MobileContactModelSchema.serialize,
    object.mobileContact,
  );
  writer.writeBool(offsets[51], object.originalIsEdited);
  writer.writeBool(offsets[52], object.originalIsHidden);
  writer.writeString(offsets[53], object.originalMessageId);
  writer.writeString(offsets[54], object.originalRoomId);
  writer.writeString(offsets[55], object.ref);
  writer.writeObject<MessageModel>(
    offsets[56],
    allOffsets,
    MessageModelSchema.serialize,
    object.replyMessage,
  );
  writer.writeString(offsets[57], object.roomId);
  writer.writeString(offsets[58], object.searchMessage);
  writer.writeStringList(offsets[59], object.selectedReactionList);
  writer.writeString(offsets[60], object.sentTime);
  writer.writeLong(offsets[61], object.sequence);
  writer.writeString(offsets[62], object.shareContactId);
  writer.writeObject<MessageSystemModel>(
    offsets[63],
    allOffsets,
    MessageSystemModelSchema.serialize,
    object.systemMessage,
  );
  writer.writeString(offsets[64], object.timeString);
  writer.writeString(offsets[65], object.type?.name);
  writer.writeDateTime(offsets[66], object.updatedAt);
}

MessageCollection _messageCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageCollection(
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
    collapseId: reader.readStringOrNull(offsets[18]),
    contact: reader.readObjectOrNull<ContactModel>(
      offsets[19],
      ContactModelSchema.deserialize,
      allOffsets,
    ),
    createdAt: reader.readDateTimeOrNull(offsets[20]),
    emojiAmount: reader.readLongOrNull(offsets[22]),
    files: reader.readObjectList<MessageFileModel>(
      offsets[24],
      MessageFileModelSchema.deserialize,
      allOffsets,
      MessageFileModel(),
    ),
    historyForAccountId: reader.readStringOrNull(offsets[25]),
    id: reader.readStringOrNull(offsets[26]),
    isAlreadyShowAnimatedAndSound: reader.readBoolOrNull(offsets[27]),
    isDecryptFailed: reader.readBoolOrNull(offsets[29]),
    isEncrypted: reader.readBoolOrNull(offsets[31]),
    isLocked: reader.readBoolOrNull(offsets[33]),
    isMyNote: reader.readBoolOrNull(offsets[35]),
    isParentDeleted: reader.readBoolOrNull(offsets[36]),
    isPinned: reader.readBoolOrNull(offsets[37]),
    isSendFailed: reader.readBoolOrNull(offsets[39]),
    isSending: reader.readBoolOrNull(offsets[40]),
    lastEmojis: reader.readObjectList<LastEmojiModel>(
      offsets[44],
      LastEmojiModelSchema.deserialize,
      allOffsets,
      LastEmojiModel(),
    ),
    links: reader.readObjectList<MessageLinkModel>(
      offsets[45],
      MessageLinkModelSchema.deserialize,
      allOffsets,
      MessageLinkModel(),
    ),
    mentionList: reader.readObjectList<MentionModel>(
      offsets[46],
      MentionModelSchema.deserialize,
      allOffsets,
      MentionModel(),
    ),
    message: reader.readStringOrNull(offsets[47]),
    meta: reader.readObjectOrNull<MessageMetaModel>(
      offsets[48],
      MessageMetaModelSchema.deserialize,
      allOffsets,
    ),
    mobileContact: reader.readObjectOrNull<MobileContactModel>(
      offsets[50],
      MobileContactModelSchema.deserialize,
      allOffsets,
    ),
    originalIsEdited: reader.readBoolOrNull(offsets[51]),
    originalIsHidden: reader.readBoolOrNull(offsets[52]),
    originalMessageId: reader.readStringOrNull(offsets[53]),
    originalRoomId: reader.readStringOrNull(offsets[54]),
    ref: reader.readStringOrNull(offsets[55]),
    replyMessage: reader.readObjectOrNull<MessageModel>(
      offsets[56],
      MessageModelSchema.deserialize,
      allOffsets,
    ),
    roomId: reader.readStringOrNull(offsets[57]),
    searchMessage: reader.readStringOrNull(offsets[58]),
    selectedReactionList: reader.readStringList(offsets[59]),
    sequence: reader.readLongOrNull(offsets[61]),
    shareContactId: reader.readStringOrNull(offsets[62]),
    systemMessage: reader.readObjectOrNull<MessageSystemModel>(
      offsets[63],
      MessageSystemModelSchema.deserialize,
      allOffsets,
    ),
    type: _MessageCollectiontypeValueEnumMap[
        reader.readStringOrNull(offsets[65])],
    updatedAt: reader.readDateTimeOrNull(offsets[66]),
  );
  return object;
}

P _messageCollectionDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readObjectOrNull<ContactModel>(
        offset,
        ContactModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 20:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readLongOrNull(offset)) as P;
    case 23:
      return (reader.readObjectOrNull<MessageFileModel>(
        offset,
        MessageFileModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 24:
      return (reader.readObjectList<MessageFileModel>(
        offset,
        MessageFileModelSchema.deserialize,
        allOffsets,
        MessageFileModel(),
      )) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readBoolOrNull(offset)) as P;
    case 28:
      return (reader.readBool(offset)) as P;
    case 29:
      return (reader.readBoolOrNull(offset)) as P;
    case 30:
      return (reader.readBool(offset)) as P;
    case 31:
      return (reader.readBoolOrNull(offset)) as P;
    case 32:
      return (reader.readBool(offset)) as P;
    case 33:
      return (reader.readBoolOrNull(offset)) as P;
    case 34:
      return (reader.readBool(offset)) as P;
    case 35:
      return (reader.readBoolOrNull(offset)) as P;
    case 36:
      return (reader.readBoolOrNull(offset)) as P;
    case 37:
      return (reader.readBoolOrNull(offset)) as P;
    case 38:
      return (reader.readBool(offset)) as P;
    case 39:
      return (reader.readBoolOrNull(offset)) as P;
    case 40:
      return (reader.readBoolOrNull(offset)) as P;
    case 41:
      return (reader.readBool(offset)) as P;
    case 42:
      return (reader.readBool(offset)) as P;
    case 43:
      return (reader.readBool(offset)) as P;
    case 44:
      return (reader.readObjectList<LastEmojiModel>(
        offset,
        LastEmojiModelSchema.deserialize,
        allOffsets,
        LastEmojiModel(),
      )) as P;
    case 45:
      return (reader.readObjectList<MessageLinkModel>(
        offset,
        MessageLinkModelSchema.deserialize,
        allOffsets,
        MessageLinkModel(),
      )) as P;
    case 46:
      return (reader.readObjectList<MentionModel>(
        offset,
        MentionModelSchema.deserialize,
        allOffsets,
        MentionModel(),
      )) as P;
    case 47:
      return (reader.readStringOrNull(offset)) as P;
    case 48:
      return (reader.readObjectOrNull<MessageMetaModel>(
        offset,
        MessageMetaModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 49:
      return (reader.readBool(offset)) as P;
    case 50:
      return (reader.readObjectOrNull<MobileContactModel>(
        offset,
        MobileContactModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 51:
      return (reader.readBoolOrNull(offset)) as P;
    case 52:
      return (reader.readBoolOrNull(offset)) as P;
    case 53:
      return (reader.readStringOrNull(offset)) as P;
    case 54:
      return (reader.readStringOrNull(offset)) as P;
    case 55:
      return (reader.readStringOrNull(offset)) as P;
    case 56:
      return (reader.readObjectOrNull<MessageModel>(
        offset,
        MessageModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 57:
      return (reader.readStringOrNull(offset)) as P;
    case 58:
      return (reader.readStringOrNull(offset)) as P;
    case 59:
      return (reader.readStringList(offset)) as P;
    case 60:
      return (reader.readString(offset)) as P;
    case 61:
      return (reader.readLongOrNull(offset)) as P;
    case 62:
      return (reader.readStringOrNull(offset)) as P;
    case 63:
      return (reader.readObjectOrNull<MessageSystemModel>(
        offset,
        MessageSystemModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 64:
      return (reader.readStringOrNull(offset)) as P;
    case 65:
      return (_MessageCollectiontypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 66:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MessageCollectiontypeEnumValueMap = {
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
const _MessageCollectiontypeValueEnumMap = {
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

Id _messageCollectionGetId(MessageCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _messageCollectionGetLinks(
    MessageCollection object) {
  return [];
}

void _messageCollectionAttach(
    IsarCollection<dynamic> col, Id id, MessageCollection object) {}

extension MessageCollectionByIndex on IsarCollection<MessageCollection> {
  Future<MessageCollection?> getByRef(String? ref) {
    return getByIndex(r'ref', [ref]);
  }

  MessageCollection? getByRefSync(String? ref) {
    return getByIndexSync(r'ref', [ref]);
  }

  Future<bool> deleteByRef(String? ref) {
    return deleteByIndex(r'ref', [ref]);
  }

  bool deleteByRefSync(String? ref) {
    return deleteByIndexSync(r'ref', [ref]);
  }

  Future<List<MessageCollection?>> getAllByRef(List<String?> refValues) {
    final values = refValues.map((e) => [e]).toList();
    return getAllByIndex(r'ref', values);
  }

  List<MessageCollection?> getAllByRefSync(List<String?> refValues) {
    final values = refValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'ref', values);
  }

  Future<int> deleteAllByRef(List<String?> refValues) {
    final values = refValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'ref', values);
  }

  int deleteAllByRefSync(List<String?> refValues) {
    final values = refValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'ref', values);
  }

  Future<Id> putByRef(MessageCollection object) {
    return putByIndex(r'ref', object);
  }

  Id putByRefSync(MessageCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'ref', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRef(List<MessageCollection> objects) {
    return putAllByIndex(r'ref', objects);
  }

  List<Id> putAllByRefSync(List<MessageCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'ref', objects, saveLinks: saveLinks);
  }
}

extension MessageCollectionQueryWhereSort
    on QueryBuilder<MessageCollection, MessageCollection, QWhere> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhere>
      anyIsMyNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isMyNote'),
      );
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhere>
      anyIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isPinned'),
      );
    });
  }
}

extension MessageCollectionQueryWhere
    on QueryBuilder<MessageCollection, MessageCollection, QWhereClause> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      idNotEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      refIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ref',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      refIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ref',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      refEqualTo(String? ref) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ref',
        value: [ref],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      refNotEqualTo(String? ref) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ref',
              lower: [],
              upper: [ref],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ref',
              lower: [ref],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ref',
              lower: [ref],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ref',
              lower: [],
              upper: [ref],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      accountIdEqualTo(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [accountId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      accountIdNotEqualTo(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId',
              lower: [],
              upper: [accountId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId',
              lower: [accountId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId',
              lower: [accountId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId',
              lower: [],
              upper: [accountId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtNotEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtLessThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtBetween(
    DateTime? lowerCreatedAt,
    DateTime? upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendFailedIsNullAnyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSendFailed_roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendFailedIsNotNullAnyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isSendFailed_roomId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendFailedEqualToAnyRoomId(bool? isSendFailed) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSendFailed_roomId',
        value: [isSendFailed],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendFailedNotEqualToAnyRoomId(bool? isSendFailed) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSendFailed_roomId',
              lower: [],
              upper: [isSendFailed],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSendFailed_roomId',
              lower: [isSendFailed],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSendFailed_roomId',
              lower: [isSendFailed],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSendFailed_roomId',
              lower: [],
              upper: [isSendFailed],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendFailedEqualToRoomIdIsNull(bool? isSendFailed) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSendFailed_roomId',
        value: [isSendFailed, null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendFailedEqualToRoomIdIsNotNull(bool? isSendFailed) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isSendFailed_roomId',
        lower: [isSendFailed, null],
        includeLower: false,
        upper: [
          isSendFailed,
        ],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendFailedRoomIdEqualTo(bool? isSendFailed, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSendFailed_roomId',
        value: [isSendFailed, roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendFailedEqualToRoomIdNotEqualTo(bool? isSendFailed, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSendFailed_roomId',
              lower: [isSendFailed],
              upper: [isSendFailed, roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSendFailed_roomId',
              lower: [isSendFailed, roomId],
              includeLower: false,
              upper: [isSendFailed],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSendFailed_roomId',
              lower: [isSendFailed, roomId],
              includeLower: false,
              upper: [isSendFailed],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSendFailed_roomId',
              lower: [isSendFailed],
              upper: [isSendFailed, roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendingIsNullAnyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSending_roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendingIsNotNullAnyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isSending_roomId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendingEqualToAnyRoomId(bool? isSending) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSending_roomId',
        value: [isSending],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendingNotEqualToAnyRoomId(bool? isSending) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSending_roomId',
              lower: [],
              upper: [isSending],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSending_roomId',
              lower: [isSending],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSending_roomId',
              lower: [isSending],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSending_roomId',
              lower: [],
              upper: [isSending],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendingEqualToRoomIdIsNull(bool? isSending) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSending_roomId',
        value: [isSending, null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendingEqualToRoomIdIsNotNull(bool? isSending) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isSending_roomId',
        lower: [isSending, null],
        includeLower: false,
        upper: [
          isSending,
        ],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendingRoomIdEqualTo(bool? isSending, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSending_roomId',
        value: [isSending, roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSendingEqualToRoomIdNotEqualTo(bool? isSending, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSending_roomId',
              lower: [isSending],
              upper: [isSending, roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSending_roomId',
              lower: [isSending, roomId],
              includeLower: false,
              upper: [isSending],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSending_roomId',
              lower: [isSending, roomId],
              includeLower: false,
              upper: [isSending],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSending_roomId',
              lower: [isSending],
              upper: [isSending, roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdNotEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdIsNullAnySequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId_sequence',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdIsNotNullAnySequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId_sequence',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdEqualToAnySequence(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId_sequence',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdNotEqualToAnySequence(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_sequence',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_sequence',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_sequence',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_sequence',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdEqualToSequenceIsNull(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId_sequence',
        value: [roomId, null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdEqualToSequenceIsNotNull(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId_sequence',
        lower: [roomId, null],
        includeLower: false,
        upper: [
          roomId,
        ],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdSequenceEqualTo(String? roomId, int? sequence) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId_sequence',
        value: [roomId, sequence],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdEqualToSequenceNotEqualTo(String? roomId, int? sequence) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_sequence',
              lower: [roomId],
              upper: [roomId, sequence],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_sequence',
              lower: [roomId, sequence],
              includeLower: false,
              upper: [roomId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_sequence',
              lower: [roomId, sequence],
              includeLower: false,
              upper: [roomId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_sequence',
              lower: [roomId],
              upper: [roomId, sequence],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdEqualToSequenceGreaterThan(
    String? roomId,
    int? sequence, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId_sequence',
        lower: [roomId, sequence],
        includeLower: include,
        upper: [roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdEqualToSequenceLessThan(
    String? roomId,
    int? sequence, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId_sequence',
        lower: [roomId],
        upper: [roomId, sequence],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdEqualToSequenceBetween(
    String? roomId,
    int? lowerSequence,
    int? upperSequence, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId_sequence',
        lower: [roomId, lowerSequence],
        includeLower: includeLower,
        upper: [roomId, upperSequence],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceIsNullAnyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sequence_roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceIsNotNullAnyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sequence_roomId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceEqualToAnyRoomId(int? sequence) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sequence_roomId',
        value: [sequence],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceNotEqualToAnyRoomId(int? sequence) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sequence_roomId',
              lower: [],
              upper: [sequence],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sequence_roomId',
              lower: [sequence],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sequence_roomId',
              lower: [sequence],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sequence_roomId',
              lower: [],
              upper: [sequence],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceGreaterThanAnyRoomId(
    int? sequence, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sequence_roomId',
        lower: [sequence],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceLessThanAnyRoomId(
    int? sequence, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sequence_roomId',
        lower: [],
        upper: [sequence],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceBetweenAnyRoomId(
    int? lowerSequence,
    int? upperSequence, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sequence_roomId',
        lower: [lowerSequence],
        includeLower: includeLower,
        upper: [upperSequence],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceEqualToRoomIdIsNull(int? sequence) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sequence_roomId',
        value: [sequence, null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceEqualToRoomIdIsNotNull(int? sequence) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sequence_roomId',
        lower: [sequence, null],
        includeLower: false,
        upper: [
          sequence,
        ],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceRoomIdEqualTo(int? sequence, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sequence_roomId',
        value: [sequence, roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      sequenceEqualToRoomIdNotEqualTo(int? sequence, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sequence_roomId',
              lower: [sequence],
              upper: [sequence, roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sequence_roomId',
              lower: [sequence, roomId],
              includeLower: false,
              upper: [sequence],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sequence_roomId',
              lower: [sequence, roomId],
              includeLower: false,
              upper: [sequence],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sequence_roomId',
              lower: [sequence],
              upper: [sequence, roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      bookmarkMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'bookmarkMessageId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      bookmarkMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'bookmarkMessageId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      bookmarkMessageIdEqualTo(String? bookmarkMessageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'bookmarkMessageId',
        value: [bookmarkMessageId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      bookmarkMessageIdNotEqualTo(String? bookmarkMessageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookmarkMessageId',
              lower: [],
              upper: [bookmarkMessageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookmarkMessageId',
              lower: [bookmarkMessageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookmarkMessageId',
              lower: [bookmarkMessageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookmarkMessageId',
              lower: [],
              upper: [bookmarkMessageId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      originalMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'originalMessageId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      originalMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'originalMessageId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      originalMessageIdEqualTo(String? originalMessageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'originalMessageId',
        value: [originalMessageId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      originalMessageIdNotEqualTo(String? originalMessageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalMessageId',
              lower: [],
              upper: [originalMessageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalMessageId',
              lower: [originalMessageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalMessageId',
              lower: [originalMessageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalMessageId',
              lower: [],
              upper: [originalMessageId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      originalRoomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'originalRoomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      originalRoomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'originalRoomId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      originalRoomIdEqualTo(String? originalRoomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'originalRoomId',
        value: [originalRoomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      originalRoomIdNotEqualTo(String? originalRoomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalRoomId',
              lower: [],
              upper: [originalRoomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalRoomId',
              lower: [originalRoomId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalRoomId',
              lower: [originalRoomId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalRoomId',
              lower: [],
              upper: [originalRoomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isMyNoteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isMyNote',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isMyNoteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isMyNote',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isMyNoteEqualTo(bool? isMyNote) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isMyNote',
        value: [isMyNote],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isMyNoteNotEqualTo(bool? isMyNote) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isMyNote',
              lower: [],
              upper: [isMyNote],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isMyNote',
              lower: [isMyNote],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isMyNote',
              lower: [isMyNote],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isMyNote',
              lower: [],
              upper: [isMyNote],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isPinnedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPinned',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isPinnedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isPinned',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isPinnedEqualTo(bool? isPinned) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPinned',
        value: [isPinned],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isPinnedNotEqualTo(bool? isPinned) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPinned',
              lower: [],
              upper: [isPinned],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPinned',
              lower: [isPinned],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPinned',
              lower: [isPinned],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPinned',
              lower: [],
              upper: [isPinned],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSentEqualToAnyRoomId(bool isSent) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSent_roomId',
        value: [isSent],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSentNotEqualToAnyRoomId(bool isSent) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSent_roomId',
              lower: [],
              upper: [isSent],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSent_roomId',
              lower: [isSent],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSent_roomId',
              lower: [isSent],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSent_roomId',
              lower: [],
              upper: [isSent],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSentEqualToRoomIdIsNull(bool isSent) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSent_roomId',
        value: [isSent, null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSentEqualToRoomIdIsNotNull(bool isSent) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isSent_roomId',
        lower: [isSent, null],
        includeLower: false,
        upper: [
          isSent,
        ],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSentRoomIdEqualTo(bool isSent, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSent_roomId',
        value: [isSent, roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isSentEqualToRoomIdNotEqualTo(bool isSent, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSent_roomId',
              lower: [isSent],
              upper: [isSent, roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSent_roomId',
              lower: [isSent, roomId],
              includeLower: false,
              upper: [isSent],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSent_roomId',
              lower: [isSent, roomId],
              includeLower: false,
              upper: [isSent],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSent_roomId',
              lower: [isSent],
              upper: [isSent, roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      canShowInSentMessageListEqualToAnyRoomId(bool canShowInSentMessageList) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInSentMessageList_roomId',
        value: [canShowInSentMessageList],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      canShowInSentMessageListNotEqualToAnyRoomId(
          bool canShowInSentMessageList) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInSentMessageList_roomId',
              lower: [],
              upper: [canShowInSentMessageList],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInSentMessageList_roomId',
              lower: [canShowInSentMessageList],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInSentMessageList_roomId',
              lower: [canShowInSentMessageList],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInSentMessageList_roomId',
              lower: [],
              upper: [canShowInSentMessageList],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      canShowInSentMessageListEqualToRoomIdIsNull(
          bool canShowInSentMessageList) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInSentMessageList_roomId',
        value: [canShowInSentMessageList, null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      canShowInSentMessageListEqualToRoomIdIsNotNull(
          bool canShowInSentMessageList) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'canShowInSentMessageList_roomId',
        lower: [canShowInSentMessageList, null],
        includeLower: false,
        upper: [
          canShowInSentMessageList,
        ],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      canShowInSentMessageListRoomIdEqualTo(
          bool canShowInSentMessageList, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInSentMessageList_roomId',
        value: [canShowInSentMessageList, roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      canShowInSentMessageListEqualToRoomIdNotEqualTo(
          bool canShowInSentMessageList, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInSentMessageList_roomId',
              lower: [canShowInSentMessageList],
              upper: [canShowInSentMessageList, roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInSentMessageList_roomId',
              lower: [canShowInSentMessageList, roomId],
              includeLower: false,
              upper: [canShowInSentMessageList],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInSentMessageList_roomId',
              lower: [canShowInSentMessageList, roomId],
              includeLower: false,
              upper: [canShowInSentMessageList],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInSentMessageList_roomId',
              lower: [canShowInSentMessageList],
              upper: [canShowInSentMessageList, roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isHiddenEqualToAnyRoomId(bool isHidden) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isHidden_roomId',
        value: [isHidden],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isHiddenNotEqualToAnyRoomId(bool isHidden) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden_roomId',
              lower: [],
              upper: [isHidden],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden_roomId',
              lower: [isHidden],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden_roomId',
              lower: [isHidden],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden_roomId',
              lower: [],
              upper: [isHidden],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isHiddenEqualToRoomIdIsNull(bool isHidden) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isHidden_roomId',
        value: [isHidden, null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isHiddenEqualToRoomIdIsNotNull(bool isHidden) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isHidden_roomId',
        lower: [isHidden, null],
        includeLower: false,
        upper: [
          isHidden,
        ],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isHiddenRoomIdEqualTo(bool isHidden, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isHidden_roomId',
        value: [isHidden, roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isHiddenEqualToRoomIdNotEqualTo(bool isHidden, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden_roomId',
              lower: [isHidden],
              upper: [isHidden, roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden_roomId',
              lower: [isHidden, roomId],
              includeLower: false,
              upper: [isHidden],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden_roomId',
              lower: [isHidden, roomId],
              includeLower: false,
              upper: [isHidden],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden_roomId',
              lower: [isHidden],
              upper: [isHidden, roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isEditedEqualToAnyRoomId(bool isEdited) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isEdited_roomId',
        value: [isEdited],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isEditedNotEqualToAnyRoomId(bool isEdited) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEdited_roomId',
              lower: [],
              upper: [isEdited],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEdited_roomId',
              lower: [isEdited],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEdited_roomId',
              lower: [isEdited],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEdited_roomId',
              lower: [],
              upper: [isEdited],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isEditedEqualToRoomIdIsNull(bool isEdited) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isEdited_roomId',
        value: [isEdited, null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isEditedEqualToRoomIdIsNotNull(bool isEdited) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isEdited_roomId',
        lower: [isEdited, null],
        includeLower: false,
        upper: [
          isEdited,
        ],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isEditedRoomIdEqualTo(bool isEdited, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isEdited_roomId',
        value: [isEdited, roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      isEditedEqualToRoomIdNotEqualTo(bool isEdited, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEdited_roomId',
              lower: [isEdited],
              upper: [isEdited, roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEdited_roomId',
              lower: [isEdited, roomId],
              includeLower: false,
              upper: [isEdited],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEdited_roomId',
              lower: [isEdited, roomId],
              includeLower: false,
              upper: [isEdited],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEdited_roomId',
              lower: [isEdited],
              upper: [isEdited, roomId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MessageCollectionQueryFilter
    on QueryBuilder<MessageCollection, MessageCollection, QFilterCondition> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      accountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'account',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      accountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'account',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      accountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      accountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      bookmarkEmojiTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      bookmarkEmojiTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      bookmarkMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bookmarkMessageId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      bookmarkMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bookmarkMessageId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      bookmarkMessageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bookmarkMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      bookmarkMessageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bookmarkMessageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      bookmarkMessageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarkMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      bookmarkMessageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bookmarkMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      callMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callMessage',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      callMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callMessage',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canAddToAlbumEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canAddToAlbum',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canBookmarkEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canBookmark',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canCopyMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canCopyMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canDeleteMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canDeleteMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canDeleteOthersMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canDeleteOthersMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canEditMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canEditMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canHideMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canHideMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canReactEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canReact',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canReplyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canReply',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canReportMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canReportMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canShareEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShare',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canShowInSentMessageListEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInSentMessageList',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      canUnHideMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canUnHideMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      collapseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'collapseId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      collapseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'collapseId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      collapseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'collapseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      collapseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'collapseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      collapseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collapseId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      collapseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'collapseId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      contactIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contact',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      contactIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contact',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      dateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      dateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      dateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      dateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      emojiAmountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiAmount',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      emojiAmountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiAmount',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      emojiAmountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      fileIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'file',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      fileIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'file',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      filesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'files',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      filesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'files',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      historyForAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'historyForAccountId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      historyForAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'historyForAccountId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      historyForAccountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'historyForAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      historyForAccountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'historyForAccountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      historyForAccountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historyForAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      historyForAccountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'historyForAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idEqualTo(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idEndsWith(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isAlreadyShowAnimatedAndSoundIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isAlreadyShowAnimatedAndSound',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isAlreadyShowAnimatedAndSoundIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isAlreadyShowAnimatedAndSound',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isAlreadyShowAnimatedAndSoundEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAlreadyShowAnimatedAndSound',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isCallMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCallMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isDecryptFailedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDecryptFailed',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isDecryptFailedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDecryptFailed',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isDecryptFailedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDecryptFailed',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isEditedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEdited',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isEncryptedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isEncrypted',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isEncryptedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isEncrypted',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isEncryptedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEncrypted',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isHiddenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isLockedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isLocked',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isLockedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isLocked',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isLockedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLocked',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isMediaMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMediaMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isMyNoteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isMyNote',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isMyNoteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isMyNote',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isMyNoteEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMyNote',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isParentDeletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isParentDeleted',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isParentDeletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isParentDeleted',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isParentDeletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isParentDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isPinnedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPinned',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isPinnedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPinned',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isPinnedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPinned',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isRemoveMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRemoveMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isSendFailedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isSendFailed',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isSendFailedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isSendFailed',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isSendFailedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSendFailed',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isSendingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isSending',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isSendingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isSending',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isSendingEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSending',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isSentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSent',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isSystemMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystemMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isUnsentMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUnsentMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      lastEmojisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastEmojis',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      lastEmojisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastEmojis',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      linksIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'links',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      linksIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'links',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      mentionListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mentionList',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      mentionListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mentionList',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      metaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'meta',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      metaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'meta',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      mineEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mine',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      mobileContactIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mobileContact',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      mobileContactIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mobileContact',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalIsEditedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalIsEdited',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalIsEditedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalIsEdited',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalIsEditedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalIsEdited',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalIsHiddenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalIsHidden',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalIsHiddenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalIsHidden',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalIsHiddenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalIsHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalMessageId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalMessageId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalMessageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalMessageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalMessageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalMessageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalMessageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalRoomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalRoomId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalRoomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalRoomId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalRoomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalRoomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalRoomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalRoomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalRoomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalRoomId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      originalRoomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalRoomId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ref',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ref',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refEqualTo(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refLessThan(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refBetween(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refStartsWith(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refEndsWith(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ref',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ref',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      refIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ref',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      replyMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'replyMessage',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      replyMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'replyMessage',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdEqualTo(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdBetween(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'searchMessage',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'searchMessage',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      searchMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      selectedReactionListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selectedReactionList',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      selectedReactionListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selectedReactionList',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      selectedReactionListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedReactionList',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      selectedReactionListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selectedReactionList',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      sentTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sentTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      sentTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sentTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      sentTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sentTime',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      sentTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sentTime',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      sequenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sequence',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      sequenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sequence',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      sequenceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sequence',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      shareContactIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shareContactId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      shareContactIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shareContactId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      shareContactIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shareContactId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      shareContactIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shareContactId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      shareContactIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shareContactId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      shareContactIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shareContactId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      systemMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'systemMessage',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      systemMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'systemMessage',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      timeStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeString',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      timeStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeString',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      timeStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      timeStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timeString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      timeStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeString',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      timeStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timeString',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeEqualTo(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeLessThan(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeBetween(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeEndsWith(
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
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

extension MessageCollectionQueryObject
    on QueryBuilder<MessageCollection, MessageCollection, QFilterCondition> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      account(FilterQuery<ContactModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'account');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      bookmarkEmojiTagsElement(FilterQuery<BookmarkTagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'bookmarkEmojiTags');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      callMessage(FilterQuery<MessageCallModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'callMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      contact(FilterQuery<ContactModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'contact');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      file(FilterQuery<MessageFileModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'file');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      filesElement(FilterQuery<MessageFileModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'files');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      lastEmojisElement(FilterQuery<LastEmojiModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lastEmojis');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      linksElement(FilterQuery<MessageLinkModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'links');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      mentionListElement(FilterQuery<MentionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mentionList');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      meta(FilterQuery<MessageMetaModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'meta');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      mobileContact(FilterQuery<MobileContactModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mobileContact');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      replyMessage(FilterQuery<MessageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'replyMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      systemMessage(FilterQuery<MessageSystemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'systemMessage');
    });
  }
}

extension MessageCollectionQueryLinks
    on QueryBuilder<MessageCollection, MessageCollection, QFilterCondition> {}

extension MessageCollectionQuerySortBy
    on QueryBuilder<MessageCollection, MessageCollection, QSortBy> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByBookmarkMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkMessageId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByBookmarkMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkMessageId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanAddToAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddToAlbum', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanAddToAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddToAlbum', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanBookmark() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canBookmark', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanBookmarkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canBookmark', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanCopyMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canCopyMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanCopyMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canCopyMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanDeleteMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canDeleteMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanDeleteMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canDeleteMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanDeleteOthersMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canDeleteOthersMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanDeleteOthersMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canDeleteOthersMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanEditMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canEditMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanEditMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canEditMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanHideMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canHideMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanHideMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canHideMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanReact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReact', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanReactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReact', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanReply() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReply', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanReplyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReply', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanReportMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReportMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanReportMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReportMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShare', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanShareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShare', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanShowInSentMessageList() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInSentMessageList', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanShowInSentMessageListDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInSentMessageList', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanUnHideMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canUnHideMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCanUnHideMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canUnHideMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCollapseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collapseId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCollapseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collapseId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByDateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByDateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByEmojiAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiAmount', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByEmojiAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiAmount', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByHistoryForAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByHistoryForAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsAlreadyShowAnimatedAndSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAlreadyShowAnimatedAndSound', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsAlreadyShowAnimatedAndSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAlreadyShowAnimatedAndSound', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsCallMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCallMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsCallMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCallMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsDecryptFailed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDecryptFailed', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsDecryptFailedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDecryptFailed', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsEncryptedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsLocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocked', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsLockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocked', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsMediaMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMediaMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsMediaMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMediaMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsMyNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMyNote', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsMyNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMyNote', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsParentDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isParentDeleted', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsParentDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isParentDeleted', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsRemoveMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRemoveMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsRemoveMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRemoveMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsSendFailed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSendFailed', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsSendFailedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSendFailed', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsSending() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSending', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsSendingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSending', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSent', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSent', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsSystemMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsSystemMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsUnsentMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnsentMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByIsUnsentMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnsentMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByMine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mine', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByMineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mine', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByOriginalIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsEdited', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByOriginalIsEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsEdited', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByOriginalIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsHidden', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByOriginalIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsHidden', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByOriginalMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalMessageId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByOriginalMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalMessageId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByOriginalRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalRoomId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByOriginalRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalRoomId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy> sortByRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ref', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ref', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortBySearchMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortBySearchMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortBySentTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentTime', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortBySentTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentTime', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortBySequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sequence', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortBySequenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sequence', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByShareContactId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareContactId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByShareContactIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareContactId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByTimeString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeString', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByTimeStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeString', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension MessageCollectionQuerySortThenBy
    on QueryBuilder<MessageCollection, MessageCollection, QSortThenBy> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByBookmarkMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkMessageId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByBookmarkMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkMessageId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanAddToAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddToAlbum', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanAddToAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddToAlbum', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanBookmark() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canBookmark', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanBookmarkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canBookmark', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanCopyMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canCopyMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanCopyMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canCopyMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanDeleteMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canDeleteMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanDeleteMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canDeleteMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanDeleteOthersMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canDeleteOthersMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanDeleteOthersMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canDeleteOthersMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanEditMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canEditMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanEditMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canEditMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanHideMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canHideMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanHideMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canHideMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanReact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReact', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanReactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReact', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanReply() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReply', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanReplyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReply', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanReportMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReportMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanReportMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReportMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShare', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanShareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShare', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanShowInSentMessageList() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInSentMessageList', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanShowInSentMessageListDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInSentMessageList', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanUnHideMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canUnHideMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCanUnHideMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canUnHideMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCollapseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collapseId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCollapseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collapseId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByDateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByDateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateKey', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByEmojiAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiAmount', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByEmojiAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiAmount', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByHistoryForAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByHistoryForAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsAlreadyShowAnimatedAndSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAlreadyShowAnimatedAndSound', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsAlreadyShowAnimatedAndSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAlreadyShowAnimatedAndSound', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsCallMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCallMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsCallMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCallMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsDecryptFailed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDecryptFailed', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsDecryptFailedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDecryptFailed', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEdited', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsEncryptedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsLocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocked', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsLockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocked', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsMediaMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMediaMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsMediaMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMediaMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsMyNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMyNote', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsMyNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMyNote', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsParentDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isParentDeleted', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsParentDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isParentDeleted', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsRemoveMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRemoveMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsRemoveMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRemoveMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsSendFailed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSendFailed', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsSendFailedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSendFailed', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsSending() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSending', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsSendingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSending', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSent', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSent', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsSystemMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsSystemMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsUnsentMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnsentMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsUnsentMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnsentMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByMine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mine', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByMineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mine', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByOriginalIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsEdited', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByOriginalIsEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsEdited', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByOriginalIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsHidden', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByOriginalIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsHidden', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByOriginalMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalMessageId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByOriginalMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalMessageId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByOriginalRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalRoomId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByOriginalRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalRoomId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy> thenByRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ref', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ref', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenBySearchMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchMessage', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenBySearchMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchMessage', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenBySentTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentTime', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenBySentTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentTime', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenBySequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sequence', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenBySequenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sequence', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByShareContactId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareContactId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByShareContactIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shareContactId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByTimeString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeString', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByTimeStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeString', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension MessageCollectionQueryWhereDistinct
    on QueryBuilder<MessageCollection, MessageCollection, QDistinct> {
  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByBookmarkMessageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarkMessageId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanAddToAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canAddToAlbum');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanBookmark() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canBookmark');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanCopyMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canCopyMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanDeleteMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canDeleteMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanDeleteOthersMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canDeleteOthersMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanEditMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canEditMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanHideMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canHideMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanReact() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canReact');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanReply() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canReply');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanReportMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canReportMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShare');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanShowInSentMessageList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInSentMessageList');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCanUnHideMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canUnHideMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCollapseId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'collapseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByDateKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByEmojiAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emojiAmount');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByHistoryForAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'historyForAccountId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsAlreadyShowAnimatedAndSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAlreadyShowAnimatedAndSound');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsCallMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCallMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsDecryptFailed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDecryptFailed');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEdited');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEncrypted');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHidden');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsLocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLocked');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsMediaMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMediaMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsMyNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMyNote');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsParentDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isParentDeleted');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPinned');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsRemoveMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRemoveMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsSendFailed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSendFailed');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsSending() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSending');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSent');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsSystemMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSystemMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByIsUnsentMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUnsentMessage');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByMine() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mine');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByOriginalIsEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalIsEdited');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByOriginalIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalIsHidden');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByOriginalMessageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalMessageId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByOriginalRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalRoomId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct> distinctByRef(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ref', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctBySearchMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctBySelectedReactionList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedReactionList');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctBySentTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sentTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctBySequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sequence');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByShareContactId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shareContactId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByTimeString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeString', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension MessageCollectionQueryProperty
    on QueryBuilder<MessageCollection, MessageCollection, QQueryProperty> {
  QueryBuilder<MessageCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<MessageCollection, ContactModel?, QQueryOperations>
      accountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'account');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations>
      accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<MessageCollection, List<BookmarkTagModel>?, QQueryOperations>
      bookmarkEmojiTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarkEmojiTags');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations>
      bookmarkMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarkMessageId');
    });
  }

  QueryBuilder<MessageCollection, MessageCallModel?, QQueryOperations>
      callMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callMessage');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canAddToAlbumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canAddToAlbum');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canBookmarkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canBookmark');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canCopyMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canCopyMessage');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canDeleteMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canDeleteMessage');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canDeleteOthersMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canDeleteOthersMessage');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canEditMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canEditMessage');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canHideMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canHideMessage');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations> canReactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canReact');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations> canReplyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canReply');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canReportMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canReportMessage');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations> canShareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShare');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canShowInSentMessageListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInSentMessageList');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      canUnHideMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canUnHideMessage');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations>
      collapseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collapseId');
    });
  }

  QueryBuilder<MessageCollection, ContactModel?, QQueryOperations>
      contactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contact');
    });
  }

  QueryBuilder<MessageCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MessageCollection, String, QQueryOperations> dateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateKey');
    });
  }

  QueryBuilder<MessageCollection, int?, QQueryOperations>
      emojiAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emojiAmount');
    });
  }

  QueryBuilder<MessageCollection, MessageFileModel?, QQueryOperations>
      fileProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'file');
    });
  }

  QueryBuilder<MessageCollection, List<MessageFileModel>?, QQueryOperations>
      filesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'files');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations>
      historyForAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'historyForAccountId');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations>
      isAlreadyShowAnimatedAndSoundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAlreadyShowAnimatedAndSound');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      isCallMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCallMessage');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations>
      isDecryptFailedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDecryptFailed');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations> isEditedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEdited');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations>
      isEncryptedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEncrypted');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations> isHiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHidden');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations> isLockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLocked');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      isMediaMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMediaMessage');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations> isMyNoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMyNote');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations>
      isParentDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isParentDeleted');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations> isPinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPinned');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      isRemoveMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRemoveMessage');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations>
      isSendFailedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSendFailed');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations> isSendingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSending');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations> isSentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSent');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      isSystemMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSystemMessage');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations>
      isUnsentMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUnsentMessage');
    });
  }

  QueryBuilder<MessageCollection, List<LastEmojiModel>?, QQueryOperations>
      lastEmojisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastEmojis');
    });
  }

  QueryBuilder<MessageCollection, List<MessageLinkModel>?, QQueryOperations>
      linksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'links');
    });
  }

  QueryBuilder<MessageCollection, List<MentionModel>?, QQueryOperations>
      mentionListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionList');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<MessageCollection, MessageMetaModel?, QQueryOperations>
      metaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meta');
    });
  }

  QueryBuilder<MessageCollection, bool, QQueryOperations> mineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mine');
    });
  }

  QueryBuilder<MessageCollection, MobileContactModel?, QQueryOperations>
      mobileContactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobileContact');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations>
      originalIsEditedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalIsEdited');
    });
  }

  QueryBuilder<MessageCollection, bool?, QQueryOperations>
      originalIsHiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalIsHidden');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations>
      originalMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalMessageId');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations>
      originalRoomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalRoomId');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations> refProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ref');
    });
  }

  QueryBuilder<MessageCollection, MessageModel?, QQueryOperations>
      replyMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'replyMessage');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations> roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations>
      searchMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchMessage');
    });
  }

  QueryBuilder<MessageCollection, List<String>?, QQueryOperations>
      selectedReactionListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedReactionList');
    });
  }

  QueryBuilder<MessageCollection, String, QQueryOperations> sentTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sentTime');
    });
  }

  QueryBuilder<MessageCollection, int?, QQueryOperations> sequenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sequence');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations>
      shareContactIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shareContactId');
    });
  }

  QueryBuilder<MessageCollection, MessageSystemModel?, QQueryOperations>
      systemMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'systemMessage');
    });
  }

  QueryBuilder<MessageCollection, String?, QQueryOperations>
      timeStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeString');
    });
  }

  QueryBuilder<MessageCollection, MessageType?, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<MessageCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
