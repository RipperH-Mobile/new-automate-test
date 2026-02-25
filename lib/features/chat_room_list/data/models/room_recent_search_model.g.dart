// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_recent_search_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RoomRecentSearchModelSchema = Schema(
  name: r'RoomRecentSearchModel',
  id: -7213295212766205034,
  properties: {
    r'accessType': PropertySchema(
      id: 0,
      name: r'accessType',
      type: IsarType.string,
      enumMap: _RoomRecentSearchModelaccessTypeEnumValueMap,
    ),
    r'callStatus': PropertySchema(
      id: 1,
      name: r'callStatus',
      type: IsarType.string,
      enumMap: _RoomRecentSearchModelcallStatusEnumValueMap,
    ),
    r'callType': PropertySchema(
      id: 2,
      name: r'callType',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deleted': PropertySchema(
      id: 4,
      name: r'deleted',
      type: IsarType.bool,
    ),
    r'draftMessage': PropertySchema(
      id: 5,
      name: r'draftMessage',
      type: IsarType.string,
    ),
    r'draftReplyMessage': PropertySchema(
      id: 6,
      name: r'draftReplyMessage',
      type: IsarType.object,
      target: r'MessageModel',
    ),
    r'expireAt': PropertySchema(
      id: 7,
      name: r'expireAt',
      type: IsarType.dateTime,
    ),
    r'expireIn': PropertySchema(
      id: 8,
      name: r'expireIn',
      type: IsarType.long,
    ),
    r'groupRef': PropertySchema(
      id: 9,
      name: r'groupRef',
      type: IsarType.string,
    ),
    r'hasFailedMessage': PropertySchema(
      id: 10,
      name: r'hasFailedMessage',
      type: IsarType.bool,
    ),
    r'hashCode': PropertySchema(
      id: 11,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 12,
      name: r'id',
      type: IsarType.string,
    ),
    r'isDirect': PropertySchema(
      id: 13,
      name: r'isDirect',
      type: IsarType.bool,
    ),
    r'isGroup': PropertySchema(
      id: 14,
      name: r'isGroup',
      type: IsarType.bool,
    ),
    r'isJoined': PropertySchema(
      id: 15,
      name: r'isJoined',
      type: IsarType.bool,
    ),
    r'isRequesting': PropertySchema(
      id: 16,
      name: r'isRequesting',
      type: IsarType.bool,
    ),
    r'latestSearch': PropertySchema(
      id: 17,
      name: r'latestSearch',
      type: IsarType.dateTime,
    ),
    r'latestShare': PropertySchema(
      id: 18,
      name: r'latestShare',
      type: IsarType.dateTime,
    ),
    r'memberCount': PropertySchema(
      id: 19,
      name: r'memberCount',
      type: IsarType.long,
    ),
    r'memberRequestCount': PropertySchema(
      id: 20,
      name: r'memberRequestCount',
      type: IsarType.long,
    ),
    r'meta': PropertySchema(
      id: 21,
      name: r'meta',
      type: IsarType.object,
      target: r'RoomMetaModel',
    ),
    r'notRequireToFetchOld': PropertySchema(
      id: 22,
      name: r'notRequireToFetchOld',
      type: IsarType.bool,
    ),
    r'originalRoomName': PropertySchema(
      id: 23,
      name: r'originalRoomName',
      type: IsarType.string,
    ),
    r'otherPublicKey': PropertySchema(
      id: 24,
      name: r'otherPublicKey',
      type: IsarType.string,
    ),
    r'ownerId': PropertySchema(
      id: 25,
      name: r'ownerId',
      type: IsarType.string,
    ),
    r'photoBlurhash': PropertySchema(
      id: 26,
      name: r'photoBlurhash',
      type: IsarType.string,
    ),
    r'photoId': PropertySchema(
      id: 27,
      name: r'photoId',
      type: IsarType.string,
    ),
    r'roomCryptoKey': PropertySchema(
      id: 28,
      name: r'roomCryptoKey',
      type: IsarType.string,
    ),
    r'roomName': PropertySchema(
      id: 29,
      name: r'roomName',
      type: IsarType.string,
    ),
    r'roomPublicKey': PropertySchema(
      id: 30,
      name: r'roomPublicKey',
      type: IsarType.string,
    ),
    r'roomType': PropertySchema(
      id: 31,
      name: r'roomType',
      type: IsarType.string,
      enumMap: _RoomRecentSearchModelroomTypeEnumValueMap,
    ),
    r'selfPrivateKey': PropertySchema(
      id: 32,
      name: r'selfPrivateKey',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 33,
      name: r'title',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 34,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _roomRecentSearchModelEstimateSize,
  serialize: _roomRecentSearchModelSerialize,
  deserialize: _roomRecentSearchModelDeserialize,
  deserializeProp: _roomRecentSearchModelDeserializeProp,
);

int _roomRecentSearchModelEstimateSize(
  RoomRecentSearchModel object,
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
    final value = object.roomName;
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
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _roomRecentSearchModelSerialize(
  RoomRecentSearchModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accessType?.name);
  writer.writeString(offsets[1], object.callStatus?.name);
  writer.writeString(offsets[2], object.callType);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeBool(offsets[4], object.deleted);
  writer.writeString(offsets[5], object.draftMessage);
  writer.writeObject<MessageModel>(
    offsets[6],
    allOffsets,
    MessageModelSchema.serialize,
    object.draftReplyMessage,
  );
  writer.writeDateTime(offsets[7], object.expireAt);
  writer.writeLong(offsets[8], object.expireIn);
  writer.writeString(offsets[9], object.groupRef);
  writer.writeBool(offsets[10], object.hasFailedMessage);
  writer.writeLong(offsets[11], object.hashCode);
  writer.writeString(offsets[12], object.id);
  writer.writeBool(offsets[13], object.isDirect);
  writer.writeBool(offsets[14], object.isGroup);
  writer.writeBool(offsets[15], object.isJoined);
  writer.writeBool(offsets[16], object.isRequesting);
  writer.writeDateTime(offsets[17], object.latestSearch);
  writer.writeDateTime(offsets[18], object.latestShare);
  writer.writeLong(offsets[19], object.memberCount);
  writer.writeLong(offsets[20], object.memberRequestCount);
  writer.writeObject<RoomMetaModel>(
    offsets[21],
    allOffsets,
    RoomMetaModelSchema.serialize,
    object.meta,
  );
  writer.writeBool(offsets[22], object.notRequireToFetchOld);
  writer.writeString(offsets[23], object.originalRoomName);
  writer.writeString(offsets[24], object.otherPublicKey);
  writer.writeString(offsets[25], object.ownerId);
  writer.writeString(offsets[26], object.photoBlurhash);
  writer.writeString(offsets[27], object.photoId);
  writer.writeString(offsets[28], object.roomCryptoKey);
  writer.writeString(offsets[29], object.roomName);
  writer.writeString(offsets[30], object.roomPublicKey);
  writer.writeString(offsets[31], object.roomType?.name);
  writer.writeString(offsets[32], object.selfPrivateKey);
  writer.writeString(offsets[33], object.title);
  writer.writeDateTime(offsets[34], object.updatedAt);
}

RoomRecentSearchModel _roomRecentSearchModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomRecentSearchModel(
    accessType: _RoomRecentSearchModelaccessTypeValueEnumMap[
        reader.readStringOrNull(offsets[0])],
    callStatus: _RoomRecentSearchModelcallStatusValueEnumMap[
        reader.readStringOrNull(offsets[1])],
    callType: reader.readStringOrNull(offsets[2]),
    createdAt: reader.readDateTimeOrNull(offsets[3]),
    deleted: reader.readBoolOrNull(offsets[4]),
    draftMessage: reader.readStringOrNull(offsets[5]),
    draftReplyMessage: reader.readObjectOrNull<MessageModel>(
      offsets[6],
      MessageModelSchema.deserialize,
      allOffsets,
    ),
    groupRef: reader.readStringOrNull(offsets[9]),
    hasFailedMessage: reader.readBoolOrNull(offsets[10]),
    id: reader.readStringOrNull(offsets[12]),
    isDirect: reader.readBoolOrNull(offsets[13]),
    isGroup: reader.readBoolOrNull(offsets[14]),
    memberCount: reader.readLongOrNull(offsets[19]),
    memberRequestCount: reader.readLongOrNull(offsets[20]),
    meta: reader.readObjectOrNull<RoomMetaModel>(
      offsets[21],
      RoomMetaModelSchema.deserialize,
      allOffsets,
    ),
    notRequireToFetchOld: reader.readBoolOrNull(offsets[22]) ?? false,
    originalRoomName: reader.readStringOrNull(offsets[23]),
    otherPublicKey: reader.readStringOrNull(offsets[24]),
    ownerId: reader.readStringOrNull(offsets[25]),
    photoId: reader.readStringOrNull(offsets[27]),
    roomName: reader.readStringOrNull(offsets[29]),
    roomPublicKey: reader.readStringOrNull(offsets[30]),
    roomType: _RoomRecentSearchModelroomTypeValueEnumMap[
        reader.readStringOrNull(offsets[31])],
    selfPrivateKey: reader.readStringOrNull(offsets[32]),
    title: reader.readStringOrNull(offsets[33]),
    updatedAt: reader.readDateTimeOrNull(offsets[34]),
  );
  object.expireAt = reader.readDateTimeOrNull(offsets[7]);
  object.expireIn = reader.readLongOrNull(offsets[8]);
  object.isJoined = reader.readBoolOrNull(offsets[15]);
  object.isRequesting = reader.readBoolOrNull(offsets[16]);
  object.latestSearch = reader.readDateTimeOrNull(offsets[17]);
  object.latestShare = reader.readDateTimeOrNull(offsets[18]);
  object.photoBlurhash = reader.readStringOrNull(offsets[26]);
  object.roomCryptoKey = reader.readStringOrNull(offsets[28]);
  return object;
}

P _roomRecentSearchModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_RoomRecentSearchModelaccessTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 1:
      return (_RoomRecentSearchModelcallStatusValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readObjectOrNull<MessageModel>(
        offset,
        MessageModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readBoolOrNull(offset)) as P;
    case 14:
      return (reader.readBoolOrNull(offset)) as P;
    case 15:
      return (reader.readBoolOrNull(offset)) as P;
    case 16:
      return (reader.readBoolOrNull(offset)) as P;
    case 17:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 18:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 19:
      return (reader.readLongOrNull(offset)) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (reader.readObjectOrNull<RoomMetaModel>(
        offset,
        RoomMetaModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 22:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readStringOrNull(offset)) as P;
    case 29:
      return (reader.readStringOrNull(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (_RoomRecentSearchModelroomTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 32:
      return (reader.readStringOrNull(offset)) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    case 34:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RoomRecentSearchModelaccessTypeEnumValueMap = {
  r'public': r'public',
  r'private': r'private',
};
const _RoomRecentSearchModelaccessTypeValueEnumMap = {
  r'public': RoomAccessType.public,
  r'private': RoomAccessType.private,
};
const _RoomRecentSearchModelcallStatusEnumValueMap = {
  r'newCall': r'newCall',
  r'created': r'created',
  r'startCall': r'startCall',
  r'calling': r'calling',
  r'inProgress': r'inProgress',
  r'failed': r'failed',
  r'completed': r'completed',
};
const _RoomRecentSearchModelcallStatusValueEnumMap = {
  r'newCall': CallStatusType.newCall,
  r'created': CallStatusType.created,
  r'startCall': CallStatusType.startCall,
  r'calling': CallStatusType.calling,
  r'inProgress': CallStatusType.inProgress,
  r'failed': CallStatusType.failed,
  r'completed': CallStatusType.completed,
};
const _RoomRecentSearchModelroomTypeEnumValueMap = {
  r'direct': r'direct',
  r'group': r'group',
  r'directSecret': r'directSecret',
  r'bookmark': r'bookmark',
  r'system': r'system',
};
const _RoomRecentSearchModelroomTypeValueEnumMap = {
  r'direct': RoomType.direct,
  r'group': RoomType.group,
  r'directSecret': RoomType.directSecret,
  r'bookmark': RoomType.bookmark,
  r'system': RoomType.system,
};

extension RoomRecentSearchModelQueryFilter on QueryBuilder<
    RoomRecentSearchModel, RoomRecentSearchModel, QFilterCondition> {
  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accessType',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accessType',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      accessTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accessType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      accessTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accessType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accessType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> accessTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accessType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callStatus',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callStatus',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      callStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      callStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callType',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callType',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      callTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      callTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> callTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> deletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> deletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> deletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleted',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'draftMessage',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'draftMessage',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      draftMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'draftMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      draftMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'draftMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'draftMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'draftMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftReplyMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'draftReplyMessage',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftReplyMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'draftReplyMessage',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireAtGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireAtLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireAtBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireInIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expireIn',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireInIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expireIn',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireInEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expireIn',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireInGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireInLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> expireInBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupRef',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupRef',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      groupRefContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      groupRefMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupRef',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupRef',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> groupRefIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupRef',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> hasFailedMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasFailedMessage',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> hasFailedMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasFailedMessage',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> hasFailedMessageEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasFailedMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isDirectIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDirect',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isDirectIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDirect',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isDirectEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDirect',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isGroup',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isGroup',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isGroupEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isJoinedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isJoined',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isJoinedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isJoined',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isJoinedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isJoined',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isRequestingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isRequesting',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isRequestingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isRequesting',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> isRequestingEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRequesting',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> latestSearchIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latestSearch',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> latestSearchIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latestSearch',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> latestSearchEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latestSearch',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> latestSearchGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> latestSearchLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> latestSearchBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> latestShareIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latestShare',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> latestShareIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latestShare',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> latestShareEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latestShare',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'memberCount',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'memberCount',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberCountGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberCountLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberCountBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberRequestCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'memberRequestCount',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberRequestCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'memberRequestCount',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberRequestCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberRequestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberRequestCountGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberRequestCountLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> memberRequestCountBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> metaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'meta',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> metaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'meta',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> notRequireToFetchOldEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notRequireToFetchOld',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalRoomName',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalRoomName',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      originalRoomNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      originalRoomNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalRoomName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalRoomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> originalRoomNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalRoomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'otherPublicKey',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'otherPublicKey',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      otherPublicKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'otherPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      otherPublicKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'otherPublicKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'otherPublicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> otherPublicKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'otherPublicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ownerId',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ownerId',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      ownerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      ownerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> ownerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoBlurhash',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoBlurhash',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      photoBlurhashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      photoBlurhashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoBlurhash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoBlurhashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoId',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoId',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      photoIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      photoIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> photoIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomCryptoKey',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomCryptoKey',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      roomCryptoKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomCryptoKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      roomCryptoKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomCryptoKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomCryptoKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomCryptoKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomCryptoKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomName',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomName',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomPublicKey',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomPublicKey',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      roomPublicKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomPublicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      roomPublicKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomPublicKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomPublicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomPublicKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomPublicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> roomTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selfPrivateKey',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selfPrivateKey',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyEqualTo(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyGreaterThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyLessThan(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyBetween(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyStartsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyEndsWith(
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      selfPrivateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selfPrivateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      selfPrivateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selfPrivateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfPrivateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> selfPrivateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selfPrivateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
          QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
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
}

extension RoomRecentSearchModelQueryObject on QueryBuilder<
    RoomRecentSearchModel, RoomRecentSearchModel, QFilterCondition> {
  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> draftReplyMessage(FilterQuery<MessageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'draftReplyMessage');
    });
  }

  QueryBuilder<RoomRecentSearchModel, RoomRecentSearchModel,
      QAfterFilterCondition> meta(FilterQuery<RoomMetaModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'meta');
    });
  }
}
