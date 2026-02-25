// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRoomCollectionCollection on Isar {
  IsarCollection<RoomCollection> get rooms => this.collection();
}

const RoomCollectionSchema = CollectionSchema(
  name: r'Room',
  id: -1093513927825131211,
  properties: {
    r'accessType': PropertySchema(
      id: 0,
      name: r'accessType',
      type: IsarType.string,
      enumMap: _RoomCollectionaccessTypeEnumValueMap,
    ),
    r'callStatus': PropertySchema(
      id: 1,
      name: r'callStatus',
      type: IsarType.string,
      enumMap: _RoomCollectioncallStatusEnumValueMap,
    ),
    r'callType': PropertySchema(
      id: 2,
      name: r'callType',
      type: IsarType.string,
    ),
    r'canAddAdmin': PropertySchema(
      id: 3,
      name: r'canAddAdmin',
      type: IsarType.bool,
    ),
    r'canLeaveGroup': PropertySchema(
      id: 4,
      name: r'canLeaveGroup',
      type: IsarType.bool,
    ),
    r'canRemoveAdmin': PropertySchema(
      id: 5,
      name: r'canRemoveAdmin',
      type: IsarType.bool,
    ),
    r'canShowInLatestSearch': PropertySchema(
      id: 6,
      name: r'canShowInLatestSearch',
      type: IsarType.bool,
    ),
    r'canTransferOwner': PropertySchema(
      id: 7,
      name: r'canTransferOwner',
      type: IsarType.bool,
    ),
    r'createdAt': PropertySchema(
      id: 8,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'defaultRoomAvatarUrl': PropertySchema(
      id: 9,
      name: r'defaultRoomAvatarUrl',
      type: IsarType.string,
    ),
    r'deleted': PropertySchema(
      id: 10,
      name: r'deleted',
      type: IsarType.bool,
    ),
    r'draftMessage': PropertySchema(
      id: 11,
      name: r'draftMessage',
      type: IsarType.string,
    ),
    r'draftReplyMessage': PropertySchema(
      id: 12,
      name: r'draftReplyMessage',
      type: IsarType.object,
      target: r'MessageModel',
    ),
    r'expireAt': PropertySchema(
      id: 13,
      name: r'expireAt',
      type: IsarType.dateTime,
    ),
    r'expireIn': PropertySchema(
      id: 14,
      name: r'expireIn',
      type: IsarType.long,
    ),
    r'groupRef': PropertySchema(
      id: 15,
      name: r'groupRef',
      type: IsarType.string,
    ),
    r'hasFailedMessage': PropertySchema(
      id: 16,
      name: r'hasFailedMessage',
      type: IsarType.bool,
    ),
    r'hasPhotoBlurhash': PropertySchema(
      id: 17,
      name: r'hasPhotoBlurhash',
      type: IsarType.bool,
    ),
    r'hasPhotoId': PropertySchema(
      id: 18,
      name: r'hasPhotoId',
      type: IsarType.bool,
    ),
    r'id': PropertySchema(
      id: 19,
      name: r'id',
      type: IsarType.string,
    ),
    r'isBookmark': PropertySchema(
      id: 20,
      name: r'isBookmark',
      type: IsarType.bool,
    ),
    r'isDirect': PropertySchema(
      id: 21,
      name: r'isDirect',
      type: IsarType.bool,
    ),
    r'isGroup': PropertySchema(
      id: 22,
      name: r'isGroup',
      type: IsarType.bool,
    ),
    r'isJoined': PropertySchema(
      id: 23,
      name: r'isJoined',
      type: IsarType.bool,
    ),
    r'isPrivateGroup': PropertySchema(
      id: 24,
      name: r'isPrivateGroup',
      type: IsarType.bool,
    ),
    r'isRequesting': PropertySchema(
      id: 25,
      name: r'isRequesting',
      type: IsarType.bool,
    ),
    r'isSecretRoom': PropertySchema(
      id: 26,
      name: r'isSecretRoom',
      type: IsarType.bool,
    ),
    r'isSystem': PropertySchema(
      id: 27,
      name: r'isSystem',
      type: IsarType.bool,
    ),
    r'latestSearch': PropertySchema(
      id: 28,
      name: r'latestSearch',
      type: IsarType.dateTime,
    ),
    r'meIsOwner': PropertySchema(
      id: 29,
      name: r'meIsOwner',
      type: IsarType.bool,
    ),
    r'memberCount': PropertySchema(
      id: 30,
      name: r'memberCount',
      type: IsarType.long,
    ),
    r'memberRequestCount': PropertySchema(
      id: 31,
      name: r'memberRequestCount',
      type: IsarType.long,
    ),
    r'meta': PropertySchema(
      id: 32,
      name: r'meta',
      type: IsarType.object,
      target: r'RoomMetaModel',
    ),
    r'nameLowercase': PropertySchema(
      id: 33,
      name: r'nameLowercase',
      type: IsarType.string,
    ),
    r'notRequireToFetchOld': PropertySchema(
      id: 34,
      name: r'notRequireToFetchOld',
      type: IsarType.bool,
    ),
    r'originalRoomName': PropertySchema(
      id: 35,
      name: r'originalRoomName',
      type: IsarType.string,
    ),
    r'otherPublicKey': PropertySchema(
      id: 36,
      name: r'otherPublicKey',
      type: IsarType.string,
    ),
    r'ownerId': PropertySchema(
      id: 37,
      name: r'ownerId',
      type: IsarType.string,
    ),
    r'photoBlurhash': PropertySchema(
      id: 38,
      name: r'photoBlurhash',
      type: IsarType.string,
    ),
    r'photoId': PropertySchema(
      id: 39,
      name: r'photoId',
      type: IsarType.string,
    ),
    r'roomCryptoKey': PropertySchema(
      id: 40,
      name: r'roomCryptoKey',
      type: IsarType.string,
    ),
    r'roomPublicKey': PropertySchema(
      id: 41,
      name: r'roomPublicKey',
      type: IsarType.string,
    ),
    r'roomType': PropertySchema(
      id: 42,
      name: r'roomType',
      type: IsarType.string,
      enumMap: _RoomCollectionroomTypeEnumValueMap,
    ),
    r'selfPrivateKey': PropertySchema(
      id: 43,
      name: r'selfPrivateKey',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 44,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'widgetKey': PropertySchema(
      id: 45,
      name: r'widgetKey',
      type: IsarType.string,
    )
  },
  estimateSize: _roomCollectionEstimateSize,
  serialize: _roomCollectionSerialize,
  deserialize: _roomCollectionDeserialize,
  deserializeProp: _roomCollectionDeserializeProp,
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
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'meIsOwner': IndexSchema(
      id: 4352014323103935139,
      name: r'meIsOwner',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'meIsOwner',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isDirect': IndexSchema(
      id: -3599030582179209117,
      name: r'isDirect',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isDirect',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isGroup': IndexSchema(
      id: -3432774364601311579,
      name: r'isGroup',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isGroup',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isSystem': IndexSchema(
      id: -1621690232649493676,
      name: r'isSystem',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isSystem',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInLatestSearch': IndexSchema(
      id: -1059521095921758823,
      name: r'canShowInLatestSearch',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInLatestSearch',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isPrivateGroup': IndexSchema(
      id: 6438488802466735286,
      name: r'isPrivateGroup',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPrivateGroup',
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
    r'RoomMetaModel': RoomMetaModelSchema,
    r'RoomMenuModel': RoomMenuModelSchema,
    r'RoomMenuActionModel': RoomMenuActionModelSchema,
    r'RoomMenuCommandArgModel': RoomMenuCommandArgModelSchema,
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
    r'BookmarkTagModel': BookmarkTagModelSchema
  },
  getId: _roomCollectionGetId,
  getLinks: _roomCollectionGetLinks,
  attach: _roomCollectionAttach,
  version: '3.3.0-dev.3',
);

int _roomCollectionEstimateSize(
  RoomCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.accessType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.callStatus;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.callType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.defaultRoomAvatarUrl.length * 3;
  {
    final value = object.draftMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.draftReplyMessage;
    if (value != null) {
      bytesCount += 3 +
          MessageModelSchema.estimateSize(
              value, allOffsets[MessageModel]!, allOffsets);
    }
  }
  {
    final value = object.groupRef;
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
    final value = object.meta;
    if (value != null) {
      bytesCount += 3 +
          RoomMetaModelSchema.estimateSize(
              value, allOffsets[RoomMetaModel]!, allOffsets);
    }
  }
  {
    final value = object.nameLowercase;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.originalRoomName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.otherPublicKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ownerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.photoBlurhash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.photoId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roomCryptoKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roomPublicKey;
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
  {
    final value = object.selfPrivateKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.widgetKey.length * 3;
  return bytesCount;
}

void _roomCollectionSerialize(
  RoomCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accessType?.name);
  writer.writeString(offsets[1], object.callStatus?.name);
  writer.writeString(offsets[2], object.callType);
  writer.writeBool(offsets[3], object.canAddAdmin);
  writer.writeBool(offsets[4], object.canLeaveGroup);
  writer.writeBool(offsets[5], object.canRemoveAdmin);
  writer.writeBool(offsets[6], object.canShowInLatestSearch);
  writer.writeBool(offsets[7], object.canTransferOwner);
  writer.writeDateTime(offsets[8], object.createdAt);
  writer.writeString(offsets[9], object.defaultRoomAvatarUrl);
  writer.writeBool(offsets[10], object.deleted);
  writer.writeString(offsets[11], object.draftMessage);
  writer.writeObject<MessageModel>(
    offsets[12],
    allOffsets,
    MessageModelSchema.serialize,
    object.draftReplyMessage,
  );
  writer.writeDateTime(offsets[13], object.expireAt);
  writer.writeLong(offsets[14], object.expireIn);
  writer.writeString(offsets[15], object.groupRef);
  writer.writeBool(offsets[16], object.hasFailedMessage);
  writer.writeBool(offsets[17], object.hasPhotoBlurhash);
  writer.writeBool(offsets[18], object.hasPhotoId);
  writer.writeString(offsets[19], object.id);
  writer.writeBool(offsets[20], object.isBookmark);
  writer.writeBool(offsets[21], object.isDirect);
  writer.writeBool(offsets[22], object.isGroup);
  writer.writeBool(offsets[23], object.isJoined);
  writer.writeBool(offsets[24], object.isPrivateGroup);
  writer.writeBool(offsets[25], object.isRequesting);
  writer.writeBool(offsets[26], object.isSecretRoom);
  writer.writeBool(offsets[27], object.isSystem);
  writer.writeDateTime(offsets[28], object.latestSearch);
  writer.writeBool(offsets[29], object.meIsOwner);
  writer.writeLong(offsets[30], object.memberCount);
  writer.writeLong(offsets[31], object.memberRequestCount);
  writer.writeObject<RoomMetaModel>(
    offsets[32],
    allOffsets,
    RoomMetaModelSchema.serialize,
    object.meta,
  );
  writer.writeString(offsets[33], object.nameLowercase);
  writer.writeBool(offsets[34], object.notRequireToFetchOld);
  writer.writeString(offsets[35], object.originalRoomName);
  writer.writeString(offsets[36], object.otherPublicKey);
  writer.writeString(offsets[37], object.ownerId);
  writer.writeString(offsets[38], object.photoBlurhash);
  writer.writeString(offsets[39], object.photoId);
  writer.writeString(offsets[40], object.roomCryptoKey);
  writer.writeString(offsets[41], object.roomPublicKey);
  writer.writeString(offsets[42], object.roomType?.name);
  writer.writeString(offsets[43], object.selfPrivateKey);
  writer.writeDateTime(offsets[44], object.updatedAt);
  writer.writeString(offsets[45], object.widgetKey);
}

RoomCollection _roomCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomCollection(
    accessType: _RoomCollectionaccessTypeValueEnumMap[
        reader.readStringOrNull(offsets[0])],
    callStatus: _RoomCollectioncallStatusValueEnumMap[
        reader.readStringOrNull(offsets[1])],
    callType: reader.readStringOrNull(offsets[2]),
    createdAt: reader.readDateTimeOrNull(offsets[8]),
    deleted: reader.readBoolOrNull(offsets[10]),
    draftMessage: reader.readStringOrNull(offsets[11]),
    draftReplyMessage: reader.readObjectOrNull<MessageModel>(
      offsets[12],
      MessageModelSchema.deserialize,
      allOffsets,
    ),
    groupRef: reader.readStringOrNull(offsets[15]),
    id: reader.readStringOrNull(offsets[19]),
    isJoined: reader.readBoolOrNull(offsets[23]),
    memberCount: reader.readLongOrNull(offsets[30]),
    memberRequestCount: reader.readLongOrNull(offsets[31]),
    meta: reader.readObjectOrNull<RoomMetaModel>(
      offsets[32],
      RoomMetaModelSchema.deserialize,
      allOffsets,
    ),
    notRequireToFetchOld: reader.readBoolOrNull(offsets[34]) ?? false,
    originalRoomName: reader.readStringOrNull(offsets[35]),
    otherPublicKey: reader.readStringOrNull(offsets[36]),
    ownerId: reader.readStringOrNull(offsets[37]),
    photoId: reader.readStringOrNull(offsets[39]),
    roomPublicKey: reader.readStringOrNull(offsets[41]),
    roomType: _RoomCollectionroomTypeValueEnumMap[
        reader.readStringOrNull(offsets[42])],
    selfPrivateKey: reader.readStringOrNull(offsets[43]),
    updatedAt: reader.readDateTimeOrNull(offsets[44]),
  );
  object.expireAt = reader.readDateTimeOrNull(offsets[13]);
  object.expireIn = reader.readLongOrNull(offsets[14]);
  object.hasFailedMessage = reader.readBoolOrNull(offsets[16]);
  object.isRequesting = reader.readBoolOrNull(offsets[25]);
  object.latestSearch = reader.readDateTimeOrNull(offsets[28]);
  object.photoBlurhash = reader.readStringOrNull(offsets[38]);
  object.roomCryptoKey = reader.readStringOrNull(offsets[40]);
  return object;
}

P _roomCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_RoomCollectionaccessTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 1:
      return (_RoomCollectioncallStatusValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readObjectOrNull<MessageModel>(
        offset,
        MessageModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readBoolOrNull(offset)) as P;
    case 17:
      return (reader.readBool(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readBool(offset)) as P;
    case 21:
      return (reader.readBool(offset)) as P;
    case 22:
      return (reader.readBool(offset)) as P;
    case 23:
      return (reader.readBoolOrNull(offset)) as P;
    case 24:
      return (reader.readBool(offset)) as P;
    case 25:
      return (reader.readBoolOrNull(offset)) as P;
    case 26:
      return (reader.readBool(offset)) as P;
    case 27:
      return (reader.readBool(offset)) as P;
    case 28:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 29:
      return (reader.readBool(offset)) as P;
    case 30:
      return (reader.readLongOrNull(offset)) as P;
    case 31:
      return (reader.readLongOrNull(offset)) as P;
    case 32:
      return (reader.readObjectOrNull<RoomMetaModel>(
        offset,
        RoomMetaModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    case 34:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 35:
      return (reader.readStringOrNull(offset)) as P;
    case 36:
      return (reader.readStringOrNull(offset)) as P;
    case 37:
      return (reader.readStringOrNull(offset)) as P;
    case 38:
      return (reader.readStringOrNull(offset)) as P;
    case 39:
      return (reader.readStringOrNull(offset)) as P;
    case 40:
      return (reader.readStringOrNull(offset)) as P;
    case 41:
      return (reader.readStringOrNull(offset)) as P;
    case 42:
      return (_RoomCollectionroomTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 43:
      return (reader.readStringOrNull(offset)) as P;
    case 44:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 45:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RoomCollectionaccessTypeEnumValueMap = {
  r'public': r'public',
  r'private': r'private',
};
const _RoomCollectionaccessTypeValueEnumMap = {
  r'public': RoomAccessType.public,
  r'private': RoomAccessType.private,
};
const _RoomCollectioncallStatusEnumValueMap = {
  r'newCall': r'newCall',
  r'created': r'created',
  r'startCall': r'startCall',
  r'calling': r'calling',
  r'inProgress': r'inProgress',
  r'failed': r'failed',
  r'completed': r'completed',
};
const _RoomCollectioncallStatusValueEnumMap = {
  r'newCall': CallStatusType.newCall,
  r'created': CallStatusType.created,
  r'startCall': CallStatusType.startCall,
  r'calling': CallStatusType.calling,
  r'inProgress': CallStatusType.inProgress,
  r'failed': CallStatusType.failed,
  r'completed': CallStatusType.completed,
};
const _RoomCollectionroomTypeEnumValueMap = {
  r'direct': r'direct',
  r'group': r'group',
  r'directSecret': r'directSecret',
  r'bookmark': r'bookmark',
  r'system': r'system',
};
const _RoomCollectionroomTypeValueEnumMap = {
  r'direct': RoomType.direct,
  r'group': RoomType.group,
  r'directSecret': RoomType.directSecret,
  r'bookmark': RoomType.bookmark,
  r'system': RoomType.system,
};

Id _roomCollectionGetId(RoomCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _roomCollectionGetLinks(RoomCollection object) {
  return [];
}

void _roomCollectionAttach(
    IsarCollection<dynamic> col, Id id, RoomCollection object) {}

extension RoomCollectionByIndex on IsarCollection<RoomCollection> {
  Future<RoomCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  RoomCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<RoomCollection?>> getAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<RoomCollection?> getAllByIdSync(List<String?> idValues) {
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

  Future<Id> putById(RoomCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(RoomCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<RoomCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<RoomCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension RoomCollectionQueryWhereSort
    on QueryBuilder<RoomCollection, RoomCollection, QWhere> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere> anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere> anyMeIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'meIsOwner'),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere> anyIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDirect'),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere> anyIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isGroup'),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere> anyIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isSystem'),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere>
      anyCanShowInLatestSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInLatestSearch'),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere>
      anyIsPrivateGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isPrivateGroup'),
      );
    });
  }
}

extension RoomCollectionQueryWhere
    on QueryBuilder<RoomCollection, RoomCollection, QWhereClause> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> idEqualTo(
      String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> idNotEqualTo(
      String? id) {
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      roomTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomType',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      roomTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomType',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      roomTypeEqualTo(RoomType? roomType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomType',
        value: [roomType],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      roomTypeNotEqualTo(RoomType? roomType) {
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      createdAtEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      updatedAtEqualTo(DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      updatedAtNotEqualTo(DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      updatedAtGreaterThan(
    DateTime? updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [updatedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      updatedAtLessThan(
    DateTime? updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [],
        upper: [updatedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      updatedAtBetween(
    DateTime? lowerUpdatedAt,
    DateTime? upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [lowerUpdatedAt],
        includeLower: includeLower,
        upper: [upperUpdatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      meIsOwnerEqualTo(bool meIsOwner) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'meIsOwner',
        value: [meIsOwner],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      meIsOwnerNotEqualTo(bool meIsOwner) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'meIsOwner',
              lower: [],
              upper: [meIsOwner],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'meIsOwner',
              lower: [meIsOwner],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'meIsOwner',
              lower: [meIsOwner],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'meIsOwner',
              lower: [],
              upper: [meIsOwner],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isDirectEqualTo(bool isDirect) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDirect',
        value: [isDirect],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isDirectNotEqualTo(bool isDirect) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDirect',
              lower: [],
              upper: [isDirect],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDirect',
              lower: [isDirect],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDirect',
              lower: [isDirect],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDirect',
              lower: [],
              upper: [isDirect],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isGroupEqualTo(bool isGroup) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isGroup',
        value: [isGroup],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isGroupNotEqualTo(bool isGroup) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isGroup',
              lower: [],
              upper: [isGroup],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isGroup',
              lower: [isGroup],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isGroup',
              lower: [isGroup],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isGroup',
              lower: [],
              upper: [isGroup],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isSystemEqualTo(bool isSystem) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSystem',
        value: [isSystem],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isSystemNotEqualTo(bool isSystem) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSystem',
              lower: [],
              upper: [isSystem],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSystem',
              lower: [isSystem],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSystem',
              lower: [isSystem],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSystem',
              lower: [],
              upper: [isSystem],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      canShowInLatestSearchEqualTo(bool canShowInLatestSearch) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInLatestSearch',
        value: [canShowInLatestSearch],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      canShowInLatestSearchNotEqualTo(bool canShowInLatestSearch) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInLatestSearch',
              lower: [],
              upper: [canShowInLatestSearch],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInLatestSearch',
              lower: [canShowInLatestSearch],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInLatestSearch',
              lower: [canShowInLatestSearch],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInLatestSearch',
              lower: [],
              upper: [canShowInLatestSearch],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isPrivateGroupEqualTo(bool isPrivateGroup) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPrivateGroup',
        value: [isPrivateGroup],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      isPrivateGroupNotEqualTo(bool isPrivateGroup) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPrivateGroup',
              lower: [],
              upper: [isPrivateGroup],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPrivateGroup',
              lower: [isPrivateGroup],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPrivateGroup',
              lower: [isPrivateGroup],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPrivateGroup',
              lower: [],
              upper: [isPrivateGroup],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      nameLowercaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameLowercase',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      nameLowercaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nameLowercase',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      nameLowercaseEqualTo(String? nameLowercase) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameLowercase',
        value: [nameLowercase],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      nameLowercaseNotEqualTo(String? nameLowercase) {
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

extension RoomCollectionQueryFilter
    on QueryBuilder<RoomCollection, RoomCollection, QFilterCondition> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accessType',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accessType',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeEqualTo(
    RoomAccessType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accessType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeGreaterThan(
    RoomAccessType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accessType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeLessThan(
    RoomAccessType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accessType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeBetween(
    RoomAccessType? lower,
    RoomAccessType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accessType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accessType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accessType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accessType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accessType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accessType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      accessTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accessType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callStatus',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callStatus',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusEqualTo(
    CallStatusType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusGreaterThan(
    CallStatusType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusLessThan(
    CallStatusType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusBetween(
    CallStatusType? lower,
    CallStatusType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'callStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callType',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callType',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'callType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'callType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'callType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'callType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'callType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      callTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      canAddAdminEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canAddAdmin',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      canLeaveGroupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canLeaveGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      canRemoveAdminEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canRemoveAdmin',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      canShowInLatestSearchEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInLatestSearch',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      canTransferOwnerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canTransferOwner',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultRoomAvatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultRoomAvatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultRoomAvatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultRoomAvatarUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultRoomAvatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultRoomAvatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultRoomAvatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultRoomAvatarUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultRoomAvatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      defaultRoomAvatarUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultRoomAvatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      deletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      deletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      deletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleted',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'draftMessage',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'draftMessage',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'draftMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'draftMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'draftMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'draftMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'draftMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'draftMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'draftMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'draftMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'draftMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'draftMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftReplyMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'draftReplyMessage',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftReplyMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'draftReplyMessage',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expireAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireInIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expireIn',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireInIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expireIn',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireInEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expireIn',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireInGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expireIn',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireInLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expireIn',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      expireInBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expireIn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupRef',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupRef',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupRef',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupRef',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupRef',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      groupRefIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupRef',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      hasFailedMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasFailedMessage',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      hasFailedMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasFailedMessage',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      hasFailedMessageEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasFailedMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      hasPhotoBlurhashEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasPhotoBlurhash',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      hasPhotoIdEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasPhotoId',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition> idMatches(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isBookmarkEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBookmark',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isDirectEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDirect',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isGroupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isJoinedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isJoined',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isJoinedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isJoined',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isJoinedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isJoined',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isPrivateGroupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPrivateGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isRequestingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isRequesting',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isRequestingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isRequesting',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isRequestingEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRequesting',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isSecretRoomEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSecretRoom',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isSystemEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystem',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      latestSearchIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latestSearch',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      latestSearchIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latestSearch',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      latestSearchEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latestSearch',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      latestSearchGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latestSearch',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      latestSearchLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latestSearch',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      latestSearchBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latestSearch',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      meIsOwnerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meIsOwner',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'memberCount',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'memberCount',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memberCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberRequestCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'memberRequestCount',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberRequestCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'memberRequestCount',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberRequestCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberRequestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberRequestCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memberRequestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberRequestCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memberRequestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      memberRequestCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memberRequestCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      metaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'meta',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      metaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'meta',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nameLowercase',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nameLowercase',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseEqualTo(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseGreaterThan(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseLessThan(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseBetween(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseStartsWith(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseEndsWith(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameLowercase',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameLowercase',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      nameLowercaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameLowercase',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      notRequireToFetchOldEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notRequireToFetchOld',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalRoomName',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalRoomName',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originalRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originalRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originalRoomName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'originalRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'originalRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalRoomName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalRoomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      originalRoomNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalRoomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otherPublicKey',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otherPublicKey',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otherPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'otherPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'otherPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'otherPublicKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'otherPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'otherPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'otherPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'otherPublicKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otherPublicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      otherPublicKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otherPublicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ownerId',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ownerId',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ownerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      ownerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoBlurhash',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoBlurhash',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoBlurhash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoBlurhash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoBlurhashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoId',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoId',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      photoIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomCryptoKey',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomCryptoKey',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomCryptoKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomCryptoKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomCryptoKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomCryptoKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomCryptoKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomCryptoKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomCryptoKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomCryptoKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomCryptoKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomCryptoKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomCryptoKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomPublicKey',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomPublicKey',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomPublicKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomPublicKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomPublicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomPublicKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomPublicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeEqualTo(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeGreaterThan(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeLessThan(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeBetween(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeStartsWith(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeEndsWith(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selfPrivateKey',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selfPrivateKey',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfPrivateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selfPrivateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selfPrivateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selfPrivateKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selfPrivateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selfPrivateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selfPrivateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selfPrivateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfPrivateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      selfPrivateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selfPrivateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyEqualTo(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyGreaterThan(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyLessThan(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyBetween(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyStartsWith(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyEndsWith(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'widgetKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'widgetKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      widgetKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'widgetKey',
        value: '',
      ));
    });
  }
}

extension RoomCollectionQueryObject
    on QueryBuilder<RoomCollection, RoomCollection, QFilterCondition> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      draftReplyMessage(FilterQuery<MessageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'draftReplyMessage');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition> meta(
      FilterQuery<RoomMetaModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'meta');
    });
  }
}

extension RoomCollectionQueryLinks
    on QueryBuilder<RoomCollection, RoomCollection, QFilterCondition> {}

extension RoomCollectionQuerySortBy
    on QueryBuilder<RoomCollection, RoomCollection, QSortBy> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByAccessType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessType', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByAccessTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessType', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCallStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCallStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByCallType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCallTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanAddAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddAdmin', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanAddAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddAdmin', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanLeaveGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canLeaveGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanLeaveGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canLeaveGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanRemoveAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canRemoveAdmin', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanRemoveAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canRemoveAdmin', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanShowInLatestSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInLatestSearch', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanShowInLatestSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInLatestSearch', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanTransferOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canTransferOwner', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCanTransferOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canTransferOwner', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByDefaultRoomAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultRoomAvatarUrl', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByDefaultRoomAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultRoomAvatarUrl', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByDraftMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draftMessage', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByDraftMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draftMessage', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByExpireAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByExpireIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireIn', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByExpireInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireIn', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByGroupRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupRef', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByGroupRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupRef', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByHasFailedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFailedMessage', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByHasFailedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFailedMessage', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByHasPhotoBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPhotoBlurhash', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByHasPhotoBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPhotoBlurhash', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByHasPhotoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPhotoId', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByHasPhotoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPhotoId', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsBookmark() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmark', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsBookmarkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmark', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsDirectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByIsJoined() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isJoined', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsJoinedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isJoined', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsPrivateGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrivateGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsPrivateGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrivateGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsRequesting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequesting', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsRequestingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequesting', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsSecretRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecretRoom', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsSecretRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecretRoom', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByLatestSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestSearch', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByLatestSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestSearch', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByMeIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meIsOwner', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByMeIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meIsOwner', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByMemberCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberCount', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByMemberCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberCount', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByMemberRequestCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberRequestCount', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByMemberRequestCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberRequestCount', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByNameLowercase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByNameLowercaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByNotRequireToFetchOld() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notRequireToFetchOld', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByNotRequireToFetchOldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notRequireToFetchOld', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByOriginalRoomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalRoomName', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByOriginalRoomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalRoomName', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByOtherPublicKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherPublicKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByOtherPublicKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherPublicKey', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByPhotoBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoBlurhash', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByPhotoBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoBlurhash', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByPhotoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoId', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByPhotoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoId', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByRoomCryptoKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomCryptoKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByRoomCryptoKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomCryptoKey', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByRoomPublicKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomPublicKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByRoomPublicKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomPublicKey', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByRoomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByRoomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortBySelfPrivateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfPrivateKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortBySelfPrivateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfPrivateKey', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByWidgetKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByWidgetKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetKey', Sort.desc);
    });
  }
}

extension RoomCollectionQuerySortThenBy
    on QueryBuilder<RoomCollection, RoomCollection, QSortThenBy> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByAccessType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessType', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByAccessTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessType', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCallStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCallStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByCallType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCallTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanAddAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddAdmin', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanAddAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddAdmin', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanLeaveGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canLeaveGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanLeaveGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canLeaveGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanRemoveAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canRemoveAdmin', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanRemoveAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canRemoveAdmin', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanShowInLatestSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInLatestSearch', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanShowInLatestSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInLatestSearch', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanTransferOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canTransferOwner', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCanTransferOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canTransferOwner', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByDefaultRoomAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultRoomAvatarUrl', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByDefaultRoomAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultRoomAvatarUrl', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByDraftMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draftMessage', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByDraftMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draftMessage', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByExpireAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByExpireIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireIn', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByExpireInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireIn', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByGroupRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupRef', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByGroupRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupRef', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByHasFailedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFailedMessage', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByHasFailedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFailedMessage', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByHasPhotoBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPhotoBlurhash', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByHasPhotoBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPhotoBlurhash', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByHasPhotoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPhotoId', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByHasPhotoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPhotoId', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsBookmark() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmark', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsBookmarkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmark', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsDirectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByIsJoined() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isJoined', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsJoinedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isJoined', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsPrivateGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrivateGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsPrivateGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrivateGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsRequesting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequesting', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsRequestingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequesting', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsSecretRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecretRoom', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsSecretRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSecretRoom', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByLatestSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestSearch', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByLatestSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestSearch', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByMeIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meIsOwner', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByMeIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meIsOwner', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByMemberCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberCount', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByMemberCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberCount', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByMemberRequestCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberRequestCount', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByMemberRequestCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberRequestCount', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByNameLowercase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByNameLowercaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByNotRequireToFetchOld() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notRequireToFetchOld', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByNotRequireToFetchOldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notRequireToFetchOld', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByOriginalRoomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalRoomName', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByOriginalRoomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalRoomName', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByOtherPublicKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherPublicKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByOtherPublicKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherPublicKey', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByPhotoBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoBlurhash', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByPhotoBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoBlurhash', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByPhotoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoId', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByPhotoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoId', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByRoomCryptoKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomCryptoKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByRoomCryptoKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomCryptoKey', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByRoomPublicKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomPublicKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByRoomPublicKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomPublicKey', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByRoomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByRoomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenBySelfPrivateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfPrivateKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenBySelfPrivateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfPrivateKey', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByWidgetKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetKey', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByWidgetKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetKey', Sort.desc);
    });
  }
}

extension RoomCollectionQueryWhereDistinct
    on QueryBuilder<RoomCollection, RoomCollection, QDistinct> {
  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByAccessType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accessType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByCallStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByCallType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByCanAddAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canAddAdmin');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByCanLeaveGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canLeaveGroup');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByCanRemoveAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canRemoveAdmin');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByCanShowInLatestSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInLatestSearch');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByCanTransferOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canTransferOwner');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByDefaultRoomAvatarUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultRoomAvatarUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deleted');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByDraftMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'draftMessage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expireAt');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByExpireIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expireIn');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByGroupRef(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupRef', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByHasFailedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasFailedMessage');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByHasPhotoBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasPhotoBlurhash');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByHasPhotoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasPhotoId');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByIsBookmark() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBookmark');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirect');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGroup');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByIsJoined() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isJoined');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByIsPrivateGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPrivateGroup');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByIsRequesting() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRequesting');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByIsSecretRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSecretRoom');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSystem');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByLatestSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latestSearch');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByMeIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meIsOwner');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByMemberCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberCount');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByMemberRequestCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberRequestCount');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByNameLowercase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameLowercase',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByNotRequireToFetchOld() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notRequireToFetchOld');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByOriginalRoomName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalRoomName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByOtherPublicKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'otherPublicKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByOwnerId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByPhotoBlurhash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoBlurhash',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByPhotoId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByRoomCryptoKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomCryptoKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByRoomPublicKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomPublicKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByRoomType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctBySelfPrivateKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selfPrivateKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByWidgetKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'widgetKey', caseSensitive: caseSensitive);
    });
  }
}

extension RoomCollectionQueryProperty
    on QueryBuilder<RoomCollection, RoomCollection, QQueryProperty> {
  QueryBuilder<RoomCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<RoomCollection, RoomAccessType?, QQueryOperations>
      accessTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accessType');
    });
  }

  QueryBuilder<RoomCollection, CallStatusType?, QQueryOperations>
      callStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callStatus');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations> callTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callType');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> canAddAdminProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canAddAdmin');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> canLeaveGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canLeaveGroup');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations>
      canRemoveAdminProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canRemoveAdmin');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations>
      canShowInLatestSearchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInLatestSearch');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations>
      canTransferOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canTransferOwner');
    });
  }

  QueryBuilder<RoomCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<RoomCollection, String, QQueryOperations>
      defaultRoomAvatarUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultRoomAvatarUrl');
    });
  }

  QueryBuilder<RoomCollection, bool?, QQueryOperations> deletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deleted');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations>
      draftMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'draftMessage');
    });
  }

  QueryBuilder<RoomCollection, MessageModel?, QQueryOperations>
      draftReplyMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'draftReplyMessage');
    });
  }

  QueryBuilder<RoomCollection, DateTime?, QQueryOperations> expireAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expireAt');
    });
  }

  QueryBuilder<RoomCollection, int?, QQueryOperations> expireInProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expireIn');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations> groupRefProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupRef');
    });
  }

  QueryBuilder<RoomCollection, bool?, QQueryOperations>
      hasFailedMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasFailedMessage');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations>
      hasPhotoBlurhashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasPhotoBlurhash');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> hasPhotoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasPhotoId');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> isBookmarkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBookmark');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> isDirectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirect');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> isGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGroup');
    });
  }

  QueryBuilder<RoomCollection, bool?, QQueryOperations> isJoinedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isJoined');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations>
      isPrivateGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPrivateGroup');
    });
  }

  QueryBuilder<RoomCollection, bool?, QQueryOperations> isRequestingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRequesting');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> isSecretRoomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSecretRoom');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> isSystemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSystem');
    });
  }

  QueryBuilder<RoomCollection, DateTime?, QQueryOperations>
      latestSearchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latestSearch');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> meIsOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meIsOwner');
    });
  }

  QueryBuilder<RoomCollection, int?, QQueryOperations> memberCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberCount');
    });
  }

  QueryBuilder<RoomCollection, int?, QQueryOperations>
      memberRequestCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberRequestCount');
    });
  }

  QueryBuilder<RoomCollection, RoomMetaModel?, QQueryOperations>
      metaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meta');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations>
      nameLowercaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameLowercase');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations>
      notRequireToFetchOldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notRequireToFetchOld');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations>
      originalRoomNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalRoomName');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations>
      otherPublicKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otherPublicKey');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations> ownerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownerId');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations>
      photoBlurhashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoBlurhash');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations> photoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoId');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations>
      roomCryptoKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomCryptoKey');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations>
      roomPublicKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomPublicKey');
    });
  }

  QueryBuilder<RoomCollection, RoomType?, QQueryOperations> roomTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomType');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations>
      selfPrivateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selfPrivateKey');
    });
  }

  QueryBuilder<RoomCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<RoomCollection, String, QQueryOperations> widgetKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'widgetKey');
    });
  }
}
