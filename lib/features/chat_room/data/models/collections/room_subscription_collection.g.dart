// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_subscription_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRoomSubscriptionCollectionCollection on Isar {
  IsarCollection<RoomSubscriptionCollection> get roomSubscription =>
      this.collection();
}

const RoomSubscriptionCollectionSchema = CollectionSchema(
  name: r'RoomSubscription',
  id: -5243307724398789413,
  properties: {
    r'accountId': PropertySchema(
      id: 0,
      name: r'accountId',
      type: IsarType.string,
    ),
    r'canShowInChatList': PropertySchema(
      id: 1,
      name: r'canShowInChatList',
      type: IsarType.bool,
    ),
    r'canShowInDirectSearch': PropertySchema(
      id: 2,
      name: r'canShowInDirectSearch',
      type: IsarType.bool,
    ),
    r'canShowInGroupSearch': PropertySchema(
      id: 3,
      name: r'canShowInGroupSearch',
      type: IsarType.bool,
    ),
    r'canShowInLatestShare': PropertySchema(
      id: 4,
      name: r'canShowInLatestShare',
      type: IsarType.bool,
    ),
    r'canShowInShare': PropertySchema(
      id: 5,
      name: r'canShowInShare',
      type: IsarType.bool,
    ),
    r'chatFolders': PropertySchema(
      id: 6,
      name: r'chatFolders',
      type: IsarType.objectList,
      target: r'ChatFolderModel',
    ),
    r'createdAt': PropertySchema(
      id: 7,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'firstSequence': PropertySchema(
      id: 8,
      name: r'firstSequence',
      type: IsarType.long,
    ),
    r'hasCryptoKey': PropertySchema(
      id: 9,
      name: r'hasCryptoKey',
      type: IsarType.bool,
    ),
    r'hasFirstOtherInRoom': PropertySchema(
      id: 10,
      name: r'hasFirstOtherInRoom',
      type: IsarType.bool,
    ),
    r'hasMessage': PropertySchema(
      id: 11,
      name: r'hasMessage',
      type: IsarType.bool,
    ),
    r'hiddenAt': PropertySchema(
      id: 12,
      name: r'hiddenAt',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(
      id: 13,
      name: r'id',
      type: IsarType.string,
    ),
    r'isBookmark': PropertySchema(
      id: 14,
      name: r'isBookmark',
      type: IsarType.bool,
    ),
    r'isDirect': PropertySchema(
      id: 15,
      name: r'isDirect',
      type: IsarType.bool,
    ),
    r'isDirectChatBlocked': PropertySchema(
      id: 16,
      name: r'isDirectChatBlocked',
      type: IsarType.bool,
    ),
    r'isDirectChatFriend': PropertySchema(
      id: 17,
      name: r'isDirectChatFriend',
      type: IsarType.bool,
    ),
    r'isGroup': PropertySchema(
      id: 18,
      name: r'isGroup',
      type: IsarType.bool,
    ),
    r'isHidden': PropertySchema(
      id: 19,
      name: r'isHidden',
      type: IsarType.bool,
    ),
    r'isHideMessageNotification': PropertySchema(
      id: 20,
      name: r'isHideMessageNotification',
      type: IsarType.bool,
    ),
    r'isLocalDeleting': PropertySchema(
      id: 21,
      name: r'isLocalDeleting',
      type: IsarType.bool,
    ),
    r'isMentioned': PropertySchema(
      id: 22,
      name: r'isMentioned',
      type: IsarType.bool,
    ),
    r'isMuted': PropertySchema(
      id: 23,
      name: r'isMuted',
      type: IsarType.bool,
    ),
    r'isMutedCall': PropertySchema(
      id: 24,
      name: r'isMutedCall',
      type: IsarType.bool,
    ),
    r'isPinned': PropertySchema(
      id: 25,
      name: r'isPinned',
      type: IsarType.bool,
    ),
    r'isRoomDeleted': PropertySchema(
      id: 26,
      name: r'isRoomDeleted',
      type: IsarType.bool,
    ),
    r'isSecretRoom': PropertySchema(
      id: 27,
      name: r'isSecretRoom',
      type: IsarType.bool,
    ),
    r'isShowExpireTime': PropertySchema(
      id: 28,
      name: r'isShowExpireTime',
      type: IsarType.bool,
    ),
    r'isSystem': PropertySchema(
      id: 29,
      name: r'isSystem',
      type: IsarType.bool,
    ),
    r'lastMessage': PropertySchema(
      id: 30,
      name: r'lastMessage',
      type: IsarType.object,
      target: r'MessageModel',
    ),
    r'lastMessageTime': PropertySchema(
      id: 31,
      name: r'lastMessageTime',
      type: IsarType.string,
    ),
    r'latestShare': PropertySchema(
      id: 32,
      name: r'latestShare',
      type: IsarType.dateTime,
    ),
    r'nameLowercase': PropertySchema(
      id: 33,
      name: r'nameLowercase',
      type: IsarType.string,
    ),
    r'newestMsgSeq': PropertySchema(
      id: 34,
      name: r'newestMsgSeq',
      type: IsarType.long,
    ),
    r'oldestMsgSeq': PropertySchema(
      id: 35,
      name: r'oldestMsgSeq',
      type: IsarType.long,
    ),
    r'password': PropertySchema(
      id: 36,
      name: r'password',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 37,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'roomLocalDateTime': PropertySchema(
      id: 38,
      name: r'roomLocalDateTime',
      type: IsarType.dateTime,
    ),
    r'roomName': PropertySchema(
      id: 39,
      name: r'roomName',
      type: IsarType.string,
    ),
    r'roomType': PropertySchema(
      id: 40,
      name: r'roomType',
      type: IsarType.string,
      enumMap: _RoomSubscriptionCollectionroomTypeEnumValueMap,
    ),
    r'theme': PropertySchema(
      id: 41,
      name: r'theme',
      type: IsarType.long,
    ),
    r'unreadCount': PropertySchema(
      id: 42,
      name: r'unreadCount',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 43,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'widgetKey': PropertySchema(
      id: 44,
      name: r'widgetKey',
      type: IsarType.string,
    )
  },
  estimateSize: _roomSubscriptionCollectionEstimateSize,
  serialize: _roomSubscriptionCollectionSerialize,
  deserialize: _roomSubscriptionCollectionDeserialize,
  deserializeProp: _roomSubscriptionCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
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
    r'isHidden': IndexSchema(
      id: 1012074769999104596,
      name: r'isHidden',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isHidden',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'hiddenAt': IndexSchema(
      id: 348734768726160760,
      name: r'hiddenAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hiddenAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'roomType': IndexSchema(
      id: -7176150448782802928,
      name: r'roomType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'roomType',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isRoomDeleted': IndexSchema(
      id: -2120098038457673940,
      name: r'isRoomDeleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isRoomDeleted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isLocalDeleting': IndexSchema(
      id: 2238571790862760398,
      name: r'isLocalDeleting',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isLocalDeleting',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInShare': IndexSchema(
      id: -4593769216299089736,
      name: r'canShowInShare',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInShare',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInLatestShare': IndexSchema(
      id: -1414328997897592239,
      name: r'canShowInLatestShare',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInLatestShare',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInGroupSearch': IndexSchema(
      id: 3033236971301748884,
      name: r'canShowInGroupSearch',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInGroupSearch',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInDirectSearch': IndexSchema(
      id: 2786940076715593993,
      name: r'canShowInDirectSearch',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInDirectSearch',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'hasMessage': IndexSchema(
      id: -625111834825687873,
      name: r'hasMessage',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hasMessage',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInChatList': IndexSchema(
      id: -6200818484895756935,
      name: r'canShowInChatList',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInChatList',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'nameLowercase': IndexSchema(
      id: 2300966750611771008,
      name: r'nameLowercase',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nameLowercase',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'MessageModel': MessageModelSchema,
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
    r'MessageSystemModel': MessageSystemModelSchema,
    r'MessageSystemPayloadModel': MessageSystemPayloadModelSchema,
    r'MessageSystemPayloadMemberModel': MessageSystemPayloadMemberModelSchema,
    r'MessageCallModel': MessageCallModelSchema,
    r'MessageCallPayloadModel': MessageCallPayloadModelSchema,
    r'MobileContactModel': MobileContactModelSchema,
    r'LastEmojiModel': LastEmojiModelSchema,
    r'MentionModel': MentionModelSchema,
    r'BookmarkTagModel': BookmarkTagModelSchema,
    r'ChatFolderModel': ChatFolderModelSchema
  },
  getId: _roomSubscriptionCollectionGetId,
  getLinks: _roomSubscriptionCollectionGetLinks,
  attach: _roomSubscriptionCollectionAttach,
  version: '3.3.0-dev.3',
);

int _roomSubscriptionCollectionEstimateSize(
  RoomSubscriptionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.accountId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.chatFolders;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[ChatFolderModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              ChatFolderModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastMessage;
    if (value != null) {
      bytesCount += 3 +
          MessageModelSchema.estimateSize(
              value, allOffsets[MessageModel]!, allOffsets);
    }
  }
  bytesCount += 3 + object.lastMessageTime.length * 3;
  {
    final value = object.nameLowercase;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.password;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roomId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roomName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roomType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.widgetKey.length * 3;
  return bytesCount;
}

void _roomSubscriptionCollectionSerialize(
  RoomSubscriptionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountId);
  writer.writeBool(offsets[1], object.canShowInChatList);
  writer.writeBool(offsets[2], object.canShowInDirectSearch);
  writer.writeBool(offsets[3], object.canShowInGroupSearch);
  writer.writeBool(offsets[4], object.canShowInLatestShare);
  writer.writeBool(offsets[5], object.canShowInShare);
  writer.writeObjectList<ChatFolderModel>(
    offsets[6],
    allOffsets,
    ChatFolderModelSchema.serialize,
    object.chatFolders,
  );
  writer.writeDateTime(offsets[7], object.createdAt);
  writer.writeLong(offsets[8], object.firstSequence);
  writer.writeBool(offsets[9], object.hasCryptoKey);
  writer.writeBool(offsets[10], object.hasFirstOtherInRoom);
  writer.writeBool(offsets[11], object.hasMessage);
  writer.writeDateTime(offsets[12], object.hiddenAt);
  writer.writeString(offsets[13], object.id);
  writer.writeBool(offsets[14], object.isBookmark);
  writer.writeBool(offsets[15], object.isDirect);
  writer.writeBool(offsets[16], object.isDirectChatBlocked);
  writer.writeBool(offsets[17], object.isDirectChatFriend);
  writer.writeBool(offsets[18], object.isGroup);
  writer.writeBool(offsets[19], object.isHidden);
  writer.writeBool(offsets[20], object.isHideMessageNotification);
  writer.writeBool(offsets[21], object.isLocalDeleting);
  writer.writeBool(offsets[22], object.isMentioned);
  writer.writeBool(offsets[23], object.isMuted);
  writer.writeBool(offsets[24], object.isMutedCall);
  writer.writeBool(offsets[25], object.isPinned);
  writer.writeBool(offsets[26], object.isRoomDeleted);
  writer.writeBool(offsets[27], object.isSecretRoom);
  writer.writeBool(offsets[28], object.isShowExpireTime);
  writer.writeBool(offsets[29], object.isSystem);
  writer.writeObject<MessageModel>(
    offsets[30],
    allOffsets,
    MessageModelSchema.serialize,
    object.lastMessage,
  );
  writer.writeString(offsets[31], object.lastMessageTime);
  writer.writeDateTime(offsets[32], object.latestShare);
  writer.writeString(offsets[33], object.nameLowercase);
  writer.writeLong(offsets[34], object.newestMsgSeq);
  writer.writeLong(offsets[35], object.oldestMsgSeq);
  writer.writeString(offsets[36], object.password);
  writer.writeString(offsets[37], object.roomId);
  writer.writeDateTime(offsets[38], object.roomLocalDateTime);
  writer.writeString(offsets[39], object.roomName);
  writer.writeString(offsets[40], object.roomType?.name);
  writer.writeLong(offsets[41], object.theme);
  writer.writeLong(offsets[42], object.unreadCount);
  writer.writeDateTime(offsets[43], object.updatedAt);
  writer.writeString(offsets[44], object.widgetKey);
}

RoomSubscriptionCollection _roomSubscriptionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomSubscriptionCollection(
    accountId: reader.readStringOrNull(offsets[0]),
    chatFolders: reader.readObjectList<ChatFolderModel>(
      offsets[6],
      ChatFolderModelSchema.deserialize,
      allOffsets,
      ChatFolderModel(),
    ),
    createdAt: reader.readDateTimeOrNull(offsets[7]),
    firstSequence: reader.readLongOrNull(offsets[8]),
    hasCryptoKey: reader.readBoolOrNull(offsets[9]),
    hasFirstOtherInRoom: reader.readBoolOrNull(offsets[10]),
    hiddenAt: reader.readDateTimeOrNull(offsets[12]),
    id: reader.readStringOrNull(offsets[13]),
    isDirectChatBlocked: reader.readBoolOrNull(offsets[16]),
    isDirectChatFriend: reader.readBoolOrNull(offsets[17]),
    isHidden: reader.readBoolOrNull(offsets[19]),
    isHideMessageNotification: reader.readBoolOrNull(offsets[20]),
    isLocalDeleting: reader.readBoolOrNull(offsets[21]),
    isMentioned: reader.readBoolOrNull(offsets[22]),
    isMuted: reader.readBoolOrNull(offsets[23]),
    isMutedCall: reader.readBoolOrNull(offsets[24]),
    isPinned: reader.readBoolOrNull(offsets[25]),
    isRoomDeleted: reader.readBoolOrNull(offsets[26]),
    isShowExpireTime: reader.readBoolOrNull(offsets[28]),
    lastMessage: reader.readObjectOrNull<MessageModel>(
      offsets[30],
      MessageModelSchema.deserialize,
      allOffsets,
    ),
    latestShare: reader.readDateTimeOrNull(offsets[32]),
    newestMsgSeq: reader.readLongOrNull(offsets[34]),
    oldestMsgSeq: reader.readLongOrNull(offsets[35]),
    password: reader.readStringOrNull(offsets[36]),
    roomId: reader.readStringOrNull(offsets[37]),
    roomName: reader.readStringOrNull(offsets[39]),
    roomType: _RoomSubscriptionCollectionroomTypeValueEnumMap[
        reader.readStringOrNull(offsets[40])],
    theme: reader.readLongOrNull(offsets[41]),
    unreadCount: reader.readLongOrNull(offsets[42]),
    updatedAt: reader.readDateTimeOrNull(offsets[43]),
  );
  return object;
}

P _roomSubscriptionCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readObjectList<ChatFolderModel>(
        offset,
        ChatFolderModelSchema.deserialize,
        allOffsets,
        ChatFolderModel(),
      )) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readBoolOrNull(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readBoolOrNull(offset)) as P;
    case 17:
      return (reader.readBoolOrNull(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readBoolOrNull(offset)) as P;
    case 20:
      return (reader.readBoolOrNull(offset)) as P;
    case 21:
      return (reader.readBoolOrNull(offset)) as P;
    case 22:
      return (reader.readBoolOrNull(offset)) as P;
    case 23:
      return (reader.readBoolOrNull(offset)) as P;
    case 24:
      return (reader.readBoolOrNull(offset)) as P;
    case 25:
      return (reader.readBoolOrNull(offset)) as P;
    case 26:
      return (reader.readBoolOrNull(offset)) as P;
    case 27:
      return (reader.readBool(offset)) as P;
    case 28:
      return (reader.readBoolOrNull(offset)) as P;
    case 29:
      return (reader.readBool(offset)) as P;
    case 30:
      return (reader.readObjectOrNull<MessageModel>(
        offset,
        MessageModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 31:
      return (reader.readString(offset)) as P;
    case 32:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    case 34:
      return (reader.readLongOrNull(offset)) as P;
    case 35:
      return (reader.readLongOrNull(offset)) as P;
    case 36:
      return (reader.readStringOrNull(offset)) as P;
    case 37:
      return (reader.readStringOrNull(offset)) as P;
    case 38:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 39:
      return (reader.readStringOrNull(offset)) as P;
    case 40:
      return (_RoomSubscriptionCollectionroomTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 41:
      return (reader.readLongOrNull(offset)) as P;
    case 42:
      return (reader.readLongOrNull(offset)) as P;
    case 43:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 44:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RoomSubscriptionCollectionroomTypeEnumValueMap = {
  r'direct': r'direct',
  r'group': r'group',
  r'directSecret': r'directSecret',
  r'bookmark': r'bookmark',
  r'system': r'system',
};
const _RoomSubscriptionCollectionroomTypeValueEnumMap = {
  r'direct': RoomType.direct,
  r'group': RoomType.group,
  r'directSecret': RoomType.directSecret,
  r'bookmark': RoomType.bookmark,
  r'system': RoomType.system,
};

Id _roomSubscriptionCollectionGetId(RoomSubscriptionCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _roomSubscriptionCollectionGetLinks(
    RoomSubscriptionCollection object) {
  return [];
}

void _roomSubscriptionCollectionAttach(
    IsarCollection<dynamic> col, Id id, RoomSubscriptionCollection object) {}

extension RoomSubscriptionCollectionByIndex
    on IsarCollection<RoomSubscriptionCollection> {
  Future<RoomSubscriptionCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  RoomSubscriptionCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<RoomSubscriptionCollection?>> getAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<RoomSubscriptionCollection?> getAllByIdSync(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(RoomSubscriptionCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(RoomSubscriptionCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<RoomSubscriptionCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<RoomSubscriptionCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension RoomSubscriptionCollectionQueryWhereSort on QueryBuilder<
    RoomSubscriptionCollection, RoomSubscriptionCollection, QWhere> {
  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isHidden'),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyHiddenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'hiddenAt'),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyIsRoomDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isRoomDeleted'),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyIsLocalDeleting() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isLocalDeleting'),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyCanShowInShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInShare'),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyCanShowInLatestShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInLatestShare'),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyCanShowInGroupSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInGroupSearch'),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyCanShowInDirectSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInDirectSearch'),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyHasMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'hasMessage'),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhere> anyCanShowInChatList() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInChatList'),
      );
    });
  }
}

extension RoomSubscriptionCollectionQueryWhere on QueryBuilder<
    RoomSubscriptionCollection, RoomSubscriptionCollection, QWhereClause> {
  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> idNotEqualTo(String? id) {
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> roomIdNotEqualTo(String? roomId) {
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> accountIdEqualTo(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [accountId],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> accountIdNotEqualTo(String? accountId) {
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isHiddenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isHidden',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isHiddenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isHidden',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isHiddenEqualTo(bool? isHidden) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isHidden',
        value: [isHidden],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isHiddenNotEqualTo(bool? isHidden) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [],
              upper: [isHidden],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [isHidden],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [isHidden],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [],
              upper: [isHidden],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> hiddenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hiddenAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> hiddenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hiddenAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> hiddenAtEqualTo(DateTime? hiddenAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hiddenAt',
        value: [hiddenAt],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> hiddenAtNotEqualTo(DateTime? hiddenAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hiddenAt',
              lower: [],
              upper: [hiddenAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hiddenAt',
              lower: [hiddenAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hiddenAt',
              lower: [hiddenAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hiddenAt',
              lower: [],
              upper: [hiddenAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> hiddenAtGreaterThan(
    DateTime? hiddenAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hiddenAt',
        lower: [hiddenAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> hiddenAtLessThan(
    DateTime? hiddenAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hiddenAt',
        lower: [],
        upper: [hiddenAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> hiddenAtBetween(
    DateTime? lowerHiddenAt,
    DateTime? upperHiddenAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hiddenAt',
        lower: [lowerHiddenAt],
        includeLower: includeLower,
        upper: [upperHiddenAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> roomTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomType',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> roomTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomType',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> roomTypeEqualTo(RoomType? roomType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomType',
        value: [roomType],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> roomTypeNotEqualTo(RoomType? roomType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomType',
              lower: [],
              upper: [roomType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomType',
              lower: [roomType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomType',
              lower: [roomType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomType',
              lower: [],
              upper: [roomType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isRoomDeletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isRoomDeleted',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isRoomDeletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isRoomDeleted',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isRoomDeletedEqualTo(bool? isRoomDeleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isRoomDeleted',
        value: [isRoomDeleted],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isRoomDeletedNotEqualTo(bool? isRoomDeleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isRoomDeleted',
              lower: [],
              upper: [isRoomDeleted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isRoomDeleted',
              lower: [isRoomDeleted],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isRoomDeleted',
              lower: [isRoomDeleted],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isRoomDeleted',
              lower: [],
              upper: [isRoomDeleted],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isLocalDeletingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isLocalDeleting',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isLocalDeletingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isLocalDeleting',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isLocalDeletingEqualTo(bool? isLocalDeleting) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isLocalDeleting',
        value: [isLocalDeleting],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> isLocalDeletingNotEqualTo(bool? isLocalDeleting) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isLocalDeleting',
              lower: [],
              upper: [isLocalDeleting],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isLocalDeleting',
              lower: [isLocalDeleting],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isLocalDeleting',
              lower: [isLocalDeleting],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isLocalDeleting',
              lower: [],
              upper: [isLocalDeleting],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> canShowInShareEqualTo(bool canShowInShare) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInShare',
        value: [canShowInShare],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> canShowInShareNotEqualTo(bool canShowInShare) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInShare',
              lower: [],
              upper: [canShowInShare],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInShare',
              lower: [canShowInShare],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInShare',
              lower: [canShowInShare],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInShare',
              lower: [],
              upper: [canShowInShare],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterWhereClause>
      canShowInLatestShareEqualTo(bool canShowInLatestShare) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInLatestShare',
        value: [canShowInLatestShare],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterWhereClause>
      canShowInLatestShareNotEqualTo(bool canShowInLatestShare) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInLatestShare',
              lower: [],
              upper: [canShowInLatestShare],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInLatestShare',
              lower: [canShowInLatestShare],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInLatestShare',
              lower: [canShowInLatestShare],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInLatestShare',
              lower: [],
              upper: [canShowInLatestShare],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterWhereClause>
      canShowInGroupSearchEqualTo(bool canShowInGroupSearch) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInGroupSearch',
        value: [canShowInGroupSearch],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterWhereClause>
      canShowInGroupSearchNotEqualTo(bool canShowInGroupSearch) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInGroupSearch',
              lower: [],
              upper: [canShowInGroupSearch],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInGroupSearch',
              lower: [canShowInGroupSearch],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInGroupSearch',
              lower: [canShowInGroupSearch],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInGroupSearch',
              lower: [],
              upper: [canShowInGroupSearch],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterWhereClause>
      canShowInDirectSearchEqualTo(bool canShowInDirectSearch) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInDirectSearch',
        value: [canShowInDirectSearch],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterWhereClause>
      canShowInDirectSearchNotEqualTo(bool canShowInDirectSearch) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInDirectSearch',
              lower: [],
              upper: [canShowInDirectSearch],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInDirectSearch',
              lower: [canShowInDirectSearch],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInDirectSearch',
              lower: [canShowInDirectSearch],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInDirectSearch',
              lower: [],
              upper: [canShowInDirectSearch],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> hasMessageEqualTo(bool hasMessage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hasMessage',
        value: [hasMessage],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> hasMessageNotEqualTo(bool hasMessage) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hasMessage',
              lower: [],
              upper: [hasMessage],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hasMessage',
              lower: [hasMessage],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hasMessage',
              lower: [hasMessage],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hasMessage',
              lower: [],
              upper: [hasMessage],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> canShowInChatListEqualTo(bool canShowInChatList) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInChatList',
        value: [canShowInChatList],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> canShowInChatListNotEqualTo(bool canShowInChatList) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInChatList',
              lower: [],
              upper: [canShowInChatList],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInChatList',
              lower: [canShowInChatList],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInChatList',
              lower: [canShowInChatList],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInChatList',
              lower: [],
              upper: [canShowInChatList],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> nameLowercaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameLowercase',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> nameLowercaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nameLowercase',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> nameLowercaseEqualTo(String? nameLowercase) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameLowercase',
        value: [nameLowercase],
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterWhereClause> nameLowercaseNotEqualTo(String? nameLowercase) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLowercase',
              lower: [],
              upper: [nameLowercase],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLowercase',
              lower: [nameLowercase],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLowercase',
              lower: [nameLowercase],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLowercase',
              lower: [],
              upper: [nameLowercase],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RoomSubscriptionCollectionQueryFilter on QueryBuilder<
    RoomSubscriptionCollection, RoomSubscriptionCollection, QFilterCondition> {
  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdEqualTo(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdGreaterThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdLessThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdBetween(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdStartsWith(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdEndsWith(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      accountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      accountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> canShowInChatListEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInChatList',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> canShowInDirectSearchEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInDirectSearch',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> canShowInGroupSearchEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInGroupSearch',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> canShowInLatestShareEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInLatestShare',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> canShowInShareEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInShare',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> chatFoldersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chatFolders',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> chatFoldersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chatFolders',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> chatFoldersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chatFolders',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> chatFoldersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chatFolders',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> chatFoldersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chatFolders',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> chatFoldersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chatFolders',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> chatFoldersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chatFolders',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> chatFoldersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chatFolders',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> firstSequenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firstSequence',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> firstSequenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firstSequence',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> firstSequenceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstSequence',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> firstSequenceGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstSequence',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> firstSequenceLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstSequence',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> firstSequenceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstSequence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hasCryptoKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasCryptoKey',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hasCryptoKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasCryptoKey',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hasCryptoKeyEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasCryptoKey',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hasFirstOtherInRoomIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasFirstOtherInRoom',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hasFirstOtherInRoomIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasFirstOtherInRoom',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hasFirstOtherInRoomEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasFirstOtherInRoom',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hasMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hiddenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hiddenAt',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hiddenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hiddenAt',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hiddenAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hiddenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hiddenAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hiddenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hiddenAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hiddenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> hiddenAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hiddenAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isBookmarkEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBookmark',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isDirectEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDirect',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isDirectChatBlockedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDirectChatBlocked',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isDirectChatBlockedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDirectChatBlocked',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isDirectChatBlockedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDirectChatBlocked',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isDirectChatFriendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDirectChatFriend',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isDirectChatFriendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDirectChatFriend',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isDirectChatFriendEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDirectChatFriend',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isGroupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isHiddenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isHidden',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isHiddenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isHidden',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isHiddenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isHideMessageNotificationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isHideMessageNotification',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isHideMessageNotificationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isHideMessageNotification',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isHideMessageNotificationEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHideMessageNotification',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isLocalDeletingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isLocalDeleting',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isLocalDeletingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isLocalDeleting',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isLocalDeletingEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLocalDeleting',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isMentionedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isMentioned',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isMentionedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isMentioned',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isMentionedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMentioned',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isMutedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isMuted',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isMutedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isMuted',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isMutedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMuted',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isMutedCallIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isMutedCall',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isMutedCallIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isMutedCall',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isMutedCallEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMutedCall',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isPinnedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPinned',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isPinnedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPinned',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isPinnedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPinned',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isRoomDeletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isRoomDeleted',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isRoomDeletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isRoomDeleted',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isRoomDeletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRoomDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isSecretRoomEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSecretRoom',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isShowExpireTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isShowExpireTime',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isShowExpireTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isShowExpireTime',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isShowExpireTimeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isShowExpireTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isSystemEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystem',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessage',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessage',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessageTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastMessageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastMessageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      lastMessageTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastMessageTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      lastMessageTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastMessageTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageTime',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessageTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastMessageTime',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> latestShareIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latestShare',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> latestShareIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latestShare',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> latestShareEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latestShare',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> latestShareGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latestShare',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> latestShareLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latestShare',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> latestShareBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latestShare',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nameLowercase',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nameLowercase',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameLowercase',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      nameLowercaseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      nameLowercaseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameLowercase',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameLowercase',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> nameLowercaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameLowercase',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> newestMsgSeqIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newestMsgSeq',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> newestMsgSeqIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newestMsgSeq',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> newestMsgSeqEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newestMsgSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> newestMsgSeqGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newestMsgSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> newestMsgSeqLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newestMsgSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> newestMsgSeqBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newestMsgSeq',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> oldestMsgSeqIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'oldestMsgSeq',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> oldestMsgSeqIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'oldestMsgSeq',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> oldestMsgSeqEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'oldestMsgSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> oldestMsgSeqGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'oldestMsgSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> oldestMsgSeqLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'oldestMsgSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> oldestMsgSeqBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'oldestMsgSeq',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'password',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'password',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'password',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      passwordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      passwordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'password',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> passwordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdEqualTo(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdGreaterThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdLessThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdBetween(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdStartsWith(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdEndsWith(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomLocalDateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomLocalDateTime',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomLocalDateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomLocalDateTime',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomLocalDateTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomLocalDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomLocalDateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomLocalDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomLocalDateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomLocalDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomLocalDateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomLocalDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomName',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomName',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      roomNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      roomNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeEqualTo(
    RoomType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeGreaterThan(
    RoomType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeLessThan(
    RoomType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeBetween(
    RoomType? lower,
    RoomType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      roomTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      roomTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> roomTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> themeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'theme',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> themeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'theme',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> themeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> themeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'theme',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> themeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'theme',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> themeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'theme',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> unreadCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unreadCount',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> unreadCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unreadCount',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> unreadCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unreadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> unreadCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unreadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> unreadCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unreadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> unreadCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unreadCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> updatedAtBetween(
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

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> widgetKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> widgetKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'widgetKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> widgetKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'widgetKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> widgetKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'widgetKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> widgetKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'widgetKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> widgetKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'widgetKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      widgetKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'widgetKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      widgetKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'widgetKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> widgetKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> widgetKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'widgetKey',
        value: '',
      ));
    });
  }
}

extension RoomSubscriptionCollectionQueryObject on QueryBuilder<
    RoomSubscriptionCollection, RoomSubscriptionCollection, QFilterCondition> {
  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
          QAfterFilterCondition>
      chatFoldersElement(FilterQuery<ChatFolderModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'chatFolders');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterFilterCondition> lastMessage(FilterQuery<MessageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lastMessage');
    });
  }
}

extension RoomSubscriptionCollectionQueryLinks on QueryBuilder<
    RoomSubscriptionCollection, RoomSubscriptionCollection, QFilterCondition> {}

extension RoomSubscriptionCollectionQuerySortBy on QueryBuilder<
    RoomSubscriptionCollection, RoomSubscriptionCollection, QSortBy> {
  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInChatList() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInChatList', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInChatListDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInChatList', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInDirectSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInDirectSearch', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInDirectSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInDirectSearch', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInGroupSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInGroupSearch', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInGroupSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInGroupSearch', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInLatestShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInLatestShare', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInLatestShareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInLatestShare', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInShare', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCanShowInShareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInShare', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByFirstSequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSequence', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByFirstSequenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSequence', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByHasCryptoKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCryptoKey', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByHasCryptoKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCryptoKey', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByHasFirstOtherInRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFirstOtherInRoom', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByHasFirstOtherInRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFirstOtherInRoom', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByHasMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasMessage', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByHasMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasMessage', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByHiddenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenAt', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByHiddenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenAt', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsBookmark() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmark', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsBookmarkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmark', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsDirectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsDirectChatBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirectChatBlocked', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsDirectChatBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirectChatBlocked', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsDirectChatFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirectChatFriend', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsDirectChatFriendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirectChatFriend', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsHideMessageNotification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHideMessageNotification', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsHideMessageNotificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHideMessageNotification', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsLocalDeleting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocalDeleting', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsLocalDeletingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocalDeleting', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsMentioned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMentioned', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsMentionedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMentioned', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsMuted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMuted', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsMutedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMuted', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsMutedCall() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMutedCall', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsMutedCallDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMutedCall', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsRoomDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoomDeleted', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsRoomDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoomDeleted', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsSecretRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecretRoom', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsSecretRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecretRoom', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsShowExpireTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isShowExpireTime', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsShowExpireTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isShowExpireTime', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByIsSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByLastMessageTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageTime', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByLastMessageTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageTime', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByLatestShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestShare', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByLatestShareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestShare', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByNameLowercase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByNameLowercaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByNewestMsgSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newestMsgSeq', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByNewestMsgSeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newestMsgSeq', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByOldestMsgSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oldestMsgSeq', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByOldestMsgSeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oldestMsgSeq', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByRoomLocalDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomLocalDateTime', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByRoomLocalDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomLocalDateTime', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByRoomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomName', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByRoomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomName', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByRoomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByRoomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByUnreadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByWidgetKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetKey', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> sortByWidgetKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetKey', Sort.desc);
    });
  }
}

extension RoomSubscriptionCollectionQuerySortThenBy on QueryBuilder<
    RoomSubscriptionCollection, RoomSubscriptionCollection, QSortThenBy> {
  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInChatList() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInChatList', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInChatListDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInChatList', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInDirectSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInDirectSearch', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInDirectSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInDirectSearch', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInGroupSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInGroupSearch', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInGroupSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInGroupSearch', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInLatestShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInLatestShare', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInLatestShareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInLatestShare', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInShare', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCanShowInShareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInShare', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByFirstSequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSequence', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByFirstSequenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSequence', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByHasCryptoKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCryptoKey', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByHasCryptoKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCryptoKey', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByHasFirstOtherInRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFirstOtherInRoom', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByHasFirstOtherInRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFirstOtherInRoom', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByHasMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasMessage', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByHasMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasMessage', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByHiddenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenAt', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByHiddenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenAt', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsBookmark() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmark', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsBookmarkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmark', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsDirectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsDirectChatBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirectChatBlocked', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsDirectChatBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirectChatBlocked', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsDirectChatFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirectChatFriend', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsDirectChatFriendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirectChatFriend', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsHideMessageNotification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHideMessageNotification', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsHideMessageNotificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHideMessageNotification', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsLocalDeleting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocalDeleting', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsLocalDeletingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocalDeleting', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsMentioned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMentioned', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsMentionedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMentioned', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsMuted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMuted', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsMutedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMuted', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsMutedCall() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMutedCall', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsMutedCallDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMutedCall', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsRoomDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoomDeleted', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsRoomDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoomDeleted', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsSecretRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecretRoom', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsSecretRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecretRoom', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsShowExpireTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isShowExpireTime', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsShowExpireTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isShowExpireTime', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByLastMessageTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageTime', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByLastMessageTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageTime', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByLatestShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestShare', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByLatestShareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestShare', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByNameLowercase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByNameLowercaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByNewestMsgSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newestMsgSeq', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByNewestMsgSeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newestMsgSeq', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByOldestMsgSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oldestMsgSeq', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByOldestMsgSeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'oldestMsgSeq', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByRoomLocalDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomLocalDateTime', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByRoomLocalDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomLocalDateTime', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByRoomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomName', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByRoomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomName', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByRoomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByRoomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByUnreadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByWidgetKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetKey', Sort.asc);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QAfterSortBy> thenByWidgetKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetKey', Sort.desc);
    });
  }
}

extension RoomSubscriptionCollectionQueryWhereDistinct on QueryBuilder<
    RoomSubscriptionCollection, RoomSubscriptionCollection, QDistinct> {
  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByCanShowInChatList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInChatList');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByCanShowInDirectSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInDirectSearch');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByCanShowInGroupSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInGroupSearch');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByCanShowInLatestShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInLatestShare');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByCanShowInShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInShare');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByFirstSequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstSequence');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByHasCryptoKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasCryptoKey');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByHasFirstOtherInRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasFirstOtherInRoom');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByHasMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasMessage');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByHiddenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hiddenAt');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsBookmark() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBookmark');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirect');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsDirectChatBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirectChatBlocked');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsDirectChatFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirectChatFriend');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGroup');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHidden');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsHideMessageNotification() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHideMessageNotification');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsLocalDeleting() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLocalDeleting');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsMentioned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMentioned');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsMuted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMuted');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsMutedCall() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMutedCall');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPinned');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsRoomDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRoomDeleted');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsSecretRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSecretRoom');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsShowExpireTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isShowExpireTime');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSystem');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByLastMessageTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessageTime',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByLatestShare() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latestShare');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByNameLowercase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameLowercase',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByNewestMsgSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newestMsgSeq');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByOldestMsgSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'oldestMsgSeq');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByPassword({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'password', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByRoomLocalDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomLocalDateTime');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByRoomName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByRoomType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'theme');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unreadCount');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomSubscriptionCollection,
      QDistinct> distinctByWidgetKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'widgetKey', caseSensitive: caseSensitive);
    });
  }
}

extension RoomSubscriptionCollectionQueryProperty on QueryBuilder<
    RoomSubscriptionCollection, RoomSubscriptionCollection, QQueryProperty> {
  QueryBuilder<RoomSubscriptionCollection, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, String?, QQueryOperations>
      accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      canShowInChatListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInChatList');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      canShowInDirectSearchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInDirectSearch');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      canShowInGroupSearchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInGroupSearch');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      canShowInLatestShareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInLatestShare');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      canShowInShareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInShare');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, List<ChatFolderModel>?,
      QQueryOperations> chatFoldersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chatFolders');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, int?, QQueryOperations>
      firstSequenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstSequence');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      hasCryptoKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasCryptoKey');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      hasFirstOtherInRoomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasFirstOtherInRoom');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      hasMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasMessage');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, DateTime?, QQueryOperations>
      hiddenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hiddenAt');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, String?, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      isBookmarkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBookmark');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      isDirectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirect');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isDirectChatBlockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirectChatBlocked');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isDirectChatFriendProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirectChatFriend');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      isGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGroup');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isHiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHidden');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isHideMessageNotificationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHideMessageNotification');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isLocalDeletingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLocalDeleting');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isMentionedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMentioned');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isMutedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMuted');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isMutedCallProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMutedCall');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isPinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPinned');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isRoomDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRoomDeleted');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      isSecretRoomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSecretRoom');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool?, QQueryOperations>
      isShowExpireTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isShowExpireTime');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, bool, QQueryOperations>
      isSystemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSystem');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, MessageModel?, QQueryOperations>
      lastMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessage');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, String, QQueryOperations>
      lastMessageTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessageTime');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, DateTime?, QQueryOperations>
      latestShareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latestShare');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, String?, QQueryOperations>
      nameLowercaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameLowercase');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, int?, QQueryOperations>
      newestMsgSeqProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newestMsgSeq');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, int?, QQueryOperations>
      oldestMsgSeqProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'oldestMsgSeq');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, String?, QQueryOperations>
      passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'password');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, String?, QQueryOperations>
      roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, DateTime?, QQueryOperations>
      roomLocalDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomLocalDateTime');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, String?, QQueryOperations>
      roomNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomName');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, RoomType?, QQueryOperations>
      roomTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomType');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, int?, QQueryOperations>
      themeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'theme');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, int?, QQueryOperations>
      unreadCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unreadCount');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<RoomSubscriptionCollection, String, QQueryOperations>
      widgetKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'widgetKey');
    });
  }
}
