// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_member_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRoomMemberCollectionCollection on Isar {
  IsarCollection<RoomMemberCollection> get roomMember => this.collection();
}

const RoomMemberCollectionSchema = CollectionSchema(
  name: r'RoomMember',
  id: 8378385004166137828,
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
    r'firstSequence': PropertySchema(
      id: 2,
      name: r'firstSequence',
      type: IsarType.long,
    ),
    r'groupRole': PropertySchema(
      id: 3,
      name: r'groupRole',
      type: IsarType.object,
      target: r'GroupMemberRoleModel',
    ),
    r'isAdmin': PropertySchema(
      id: 4,
      name: r'isAdmin',
      type: IsarType.bool,
    ),
    r'isAdminOrAbove': PropertySchema(
      id: 5,
      name: r'isAdminOrAbove',
      type: IsarType.bool,
    ),
    r'isDirect': PropertySchema(
      id: 6,
      name: r'isDirect',
      type: IsarType.bool,
    ),
    r'isGroup': PropertySchema(
      id: 7,
      name: r'isGroup',
      type: IsarType.bool,
    ),
    r'isMe': PropertySchema(
      id: 8,
      name: r'isMe',
      type: IsarType.bool,
    ),
    r'isOwner': PropertySchema(
      id: 9,
      name: r'isOwner',
      type: IsarType.bool,
    ),
    r'isSystem': PropertySchema(
      id: 10,
      name: r'isSystem',
      type: IsarType.bool,
    ),
    r'joinedAt': PropertySchema(
      id: 11,
      name: r'joinedAt',
      type: IsarType.dateTime,
    ),
    r'lastSeenMessageAt': PropertySchema(
      id: 12,
      name: r'lastSeenMessageAt',
      type: IsarType.dateTime,
    ),
    r'lastTypedAt': PropertySchema(
      id: 13,
      name: r'lastTypedAt',
      type: IsarType.dateTime,
    ),
    r'localDbId': PropertySchema(
      id: 14,
      name: r'localDbId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 15,
      name: r'name',
      type: IsarType.string,
    ),
    r'nameLowercase': PropertySchema(
      id: 16,
      name: r'nameLowercase',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 17,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'roomType': PropertySchema(
      id: 18,
      name: r'roomType',
      type: IsarType.string,
      enumMap: _RoomMemberCollectionroomTypeEnumValueMap,
    ),
    r'rowId': PropertySchema(
      id: 19,
      name: r'rowId',
      type: IsarType.string,
    )
  },
  estimateSize: _roomMemberCollectionEstimateSize,
  serialize: _roomMemberCollectionSerialize,
  deserialize: _roomMemberCollectionDeserialize,
  deserializeProp: _roomMemberCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
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
    r'localDbId': IndexSchema(
      id: 8389096383111614337,
      name: r'localDbId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'localDbId',
          type: IndexType.hash,
          caseSensitive: true,
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
    r'GroupMemberRoleModel': GroupMemberRoleModelSchema,
    r'GroupAdminPermissionModel': GroupAdminPermissionModelSchema
  },
  getId: _roomMemberCollectionGetId,
  getLinks: _roomMemberCollectionGetLinks,
  attach: _roomMemberCollectionAttach,
  version: '3.3.0-dev.3',
);

int _roomMemberCollectionEstimateSize(
  RoomMemberCollection object,
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
    final value = object.groupRole;
    if (value != null) {
      bytesCount += 3 +
          GroupMemberRoleModelSchema.estimateSize(
              value, allOffsets[GroupMemberRoleModel]!, allOffsets);
    }
  }
  {
    final value = object.localDbId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nameLowercase;
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
    final value = object.roomType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.rowId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _roomMemberCollectionSerialize(
  RoomMemberCollection object,
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
  writer.writeLong(offsets[2], object.firstSequence);
  writer.writeObject<GroupMemberRoleModel>(
    offsets[3],
    allOffsets,
    GroupMemberRoleModelSchema.serialize,
    object.groupRole,
  );
  writer.writeBool(offsets[4], object.isAdmin);
  writer.writeBool(offsets[5], object.isAdminOrAbove);
  writer.writeBool(offsets[6], object.isDirect);
  writer.writeBool(offsets[7], object.isGroup);
  writer.writeBool(offsets[8], object.isMe);
  writer.writeBool(offsets[9], object.isOwner);
  writer.writeBool(offsets[10], object.isSystem);
  writer.writeDateTime(offsets[11], object.joinedAt);
  writer.writeDateTime(offsets[12], object.lastSeenMessageAt);
  writer.writeDateTime(offsets[13], object.lastTypedAt);
  writer.writeString(offsets[14], object.localDbId);
  writer.writeString(offsets[15], object.name);
  writer.writeString(offsets[16], object.nameLowercase);
  writer.writeString(offsets[17], object.roomId);
  writer.writeString(offsets[18], object.roomType?.name);
  writer.writeString(offsets[19], object.rowId);
}

RoomMemberCollection _roomMemberCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomMemberCollection(
    account: reader.readObjectOrNull<ContactModel>(
      offsets[0],
      ContactModelSchema.deserialize,
      allOffsets,
    ),
    firstSequence: reader.readLongOrNull(offsets[2]),
    groupRole: reader.readObjectOrNull<GroupMemberRoleModel>(
      offsets[3],
      GroupMemberRoleModelSchema.deserialize,
      allOffsets,
    ),
    joinedAt: reader.readDateTimeOrNull(offsets[11]),
    lastSeenMessageAt: reader.readDateTimeOrNull(offsets[12]),
    lastTypedAt: reader.readDateTimeOrNull(offsets[13]),
    roomId: reader.readStringOrNull(offsets[17]),
    roomType: _RoomMemberCollectionroomTypeValueEnumMap[
        reader.readStringOrNull(offsets[18])],
    rowId: reader.readStringOrNull(offsets[19]),
  );
  return object;
}

P _roomMemberCollectionDeserializeProp<P>(
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
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<GroupMemberRoleModel>(
        offset,
        GroupMemberRoleModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readBool(offset)) as P;
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (_RoomMemberCollectionroomTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RoomMemberCollectionroomTypeEnumValueMap = {
  r'direct': r'direct',
  r'group': r'group',
  r'directSecret': r'directSecret',
  r'bookmark': r'bookmark',
  r'system': r'system',
};
const _RoomMemberCollectionroomTypeValueEnumMap = {
  r'direct': RoomType.direct,
  r'group': RoomType.group,
  r'directSecret': RoomType.directSecret,
  r'bookmark': RoomType.bookmark,
  r'system': RoomType.system,
};

Id _roomMemberCollectionGetId(RoomMemberCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _roomMemberCollectionGetLinks(
    RoomMemberCollection object) {
  return [];
}

void _roomMemberCollectionAttach(
    IsarCollection<dynamic> col, Id id, RoomMemberCollection object) {}

extension RoomMemberCollectionByIndex on IsarCollection<RoomMemberCollection> {
  Future<RoomMemberCollection?> getByLocalDbId(String? localDbId) {
    return getByIndex(r'localDbId', [localDbId]);
  }

  RoomMemberCollection? getByLocalDbIdSync(String? localDbId) {
    return getByIndexSync(r'localDbId', [localDbId]);
  }

  Future<bool> deleteByLocalDbId(String? localDbId) {
    return deleteByIndex(r'localDbId', [localDbId]);
  }

  bool deleteByLocalDbIdSync(String? localDbId) {
    return deleteByIndexSync(r'localDbId', [localDbId]);
  }

  Future<List<RoomMemberCollection?>> getAllByLocalDbId(
      List<String?> localDbIdValues) {
    final values = localDbIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'localDbId', values);
  }

  List<RoomMemberCollection?> getAllByLocalDbIdSync(
      List<String?> localDbIdValues) {
    final values = localDbIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'localDbId', values);
  }

  Future<int> deleteAllByLocalDbId(List<String?> localDbIdValues) {
    final values = localDbIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'localDbId', values);
  }

  int deleteAllByLocalDbIdSync(List<String?> localDbIdValues) {
    final values = localDbIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'localDbId', values);
  }

  Future<Id> putByLocalDbId(RoomMemberCollection object) {
    return putByIndex(r'localDbId', object);
  }

  Id putByLocalDbIdSync(RoomMemberCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'localDbId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocalDbId(List<RoomMemberCollection> objects) {
    return putAllByIndex(r'localDbId', objects);
  }

  List<Id> putAllByLocalDbIdSync(List<RoomMemberCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'localDbId', objects, saveLinks: saveLinks);
  }
}

extension RoomMemberCollectionQueryWhereSort
    on QueryBuilder<RoomMemberCollection, RoomMemberCollection, QWhere> {
  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RoomMemberCollectionQueryWhere
    on QueryBuilder<RoomMemberCollection, RoomMemberCollection, QWhereClause> {
  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      roomTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomType',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      roomTypeEqualTo(RoomType? roomType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomType',
        value: [roomType],
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      localDbIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localDbId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      localDbIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'localDbId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      localDbIdEqualTo(String? localDbId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localDbId',
        value: [localDbId],
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      localDbIdNotEqualTo(String? localDbId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDbId',
              lower: [],
              upper: [localDbId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDbId',
              lower: [localDbId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDbId',
              lower: [localDbId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDbId',
              lower: [],
              upper: [localDbId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      nameLowercaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameLowercase',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
      nameLowercaseEqualTo(String? nameLowercase) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameLowercase',
        value: [nameLowercase],
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterWhereClause>
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

extension RoomMemberCollectionQueryFilter on QueryBuilder<RoomMemberCollection,
    RoomMemberCollection, QFilterCondition> {
  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> accountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'account',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> accountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'account',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> firstSequenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firstSequence',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> firstSequenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firstSequence',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> firstSequenceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstSequence',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> groupRoleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupRole',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> groupRoleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupRole',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> isAdminEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAdmin',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> isAdminOrAboveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAdminOrAbove',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> isDirectEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDirect',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> isGroupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> isMeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMe',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> isOwnerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOwner',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> isSystemEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystem',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> joinedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'joinedAt',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> joinedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'joinedAt',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> joinedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'joinedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> joinedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'joinedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> joinedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'joinedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> joinedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'joinedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastSeenMessageAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSeenMessageAt',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastSeenMessageAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSeenMessageAt',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastSeenMessageAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSeenMessageAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastSeenMessageAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSeenMessageAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastSeenMessageAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSeenMessageAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastSeenMessageAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSeenMessageAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastTypedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTypedAt',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastTypedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTypedAt',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastTypedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTypedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastTypedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTypedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastTypedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTypedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> lastTypedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTypedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localDbId',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localDbId',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localDbId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
          QAfterFilterCondition>
      localDbIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
          QAfterFilterCondition>
      localDbIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localDbId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDbId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> localDbIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localDbId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameLowercaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nameLowercase',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameLowercaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nameLowercase',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameLowercaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameLowercase',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> nameLowercaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameLowercase',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> roomTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> roomTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
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

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> roomTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> roomTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rowId',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rowId',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rowId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rowId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rowId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rowId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rowId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
          QAfterFilterCondition>
      rowIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rowId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
          QAfterFilterCondition>
      rowIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rowId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> rowIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rowId',
        value: '',
      ));
    });
  }
}

extension RoomMemberCollectionQueryObject on QueryBuilder<RoomMemberCollection,
    RoomMemberCollection, QFilterCondition> {
  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> account(FilterQuery<ContactModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'account');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection,
      QAfterFilterCondition> groupRole(FilterQuery<GroupMemberRoleModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'groupRole');
    });
  }
}

extension RoomMemberCollectionQueryLinks on QueryBuilder<RoomMemberCollection,
    RoomMemberCollection, QFilterCondition> {}

extension RoomMemberCollectionQuerySortBy
    on QueryBuilder<RoomMemberCollection, RoomMemberCollection, QSortBy> {
  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByFirstSequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSequence', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByFirstSequenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSequence', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsAdminOrAbove() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdminOrAbove', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsAdminOrAboveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdminOrAbove', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsDirectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByIsSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByJoinedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedAt', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByJoinedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedAt', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByLastSeenMessageAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenMessageAt', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByLastSeenMessageAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenMessageAt', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByLastTypedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTypedAt', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByLastTypedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTypedAt', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByLocalDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByLocalDbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByNameLowercase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByNameLowercaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByRoomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByRoomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByRowId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowId', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      sortByRowIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowId', Sort.desc);
    });
  }
}

extension RoomMemberCollectionQuerySortThenBy
    on QueryBuilder<RoomMemberCollection, RoomMemberCollection, QSortThenBy> {
  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByFirstSequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSequence', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByFirstSequenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSequence', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsAdminOrAbove() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdminOrAbove', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsAdminOrAboveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdminOrAbove', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsDirectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirect', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByJoinedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedAt', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByJoinedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedAt', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByLastSeenMessageAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenMessageAt', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByLastSeenMessageAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenMessageAt', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByLastTypedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTypedAt', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByLastTypedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTypedAt', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByLocalDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByLocalDbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByNameLowercase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByNameLowercaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByRoomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByRoomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.desc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByRowId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowId', Sort.asc);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterSortBy>
      thenByRowIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowId', Sort.desc);
    });
  }
}

extension RoomMemberCollectionQueryWhereDistinct
    on QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct> {
  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByFirstSequence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstSequence');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByIsAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAdmin');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByIsAdminOrAbove() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAdminOrAbove');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByIsDirect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirect');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGroup');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMe');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOwner');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSystem');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByJoinedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'joinedAt');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByLastSeenMessageAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSeenMessageAt');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByLastTypedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTypedAt');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByLocalDbId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localDbId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByNameLowercase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameLowercase',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByRoomType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomMemberCollection, RoomMemberCollection, QDistinct>
      distinctByRowId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rowId', caseSensitive: caseSensitive);
    });
  }
}

extension RoomMemberCollectionQueryProperty on QueryBuilder<
    RoomMemberCollection, RoomMemberCollection, QQueryProperty> {
  QueryBuilder<RoomMemberCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<RoomMemberCollection, ContactModel?, QQueryOperations>
      accountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'account');
    });
  }

  QueryBuilder<RoomMemberCollection, String?, QQueryOperations>
      accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<RoomMemberCollection, int?, QQueryOperations>
      firstSequenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstSequence');
    });
  }

  QueryBuilder<RoomMemberCollection, GroupMemberRoleModel?, QQueryOperations>
      groupRoleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupRole');
    });
  }

  QueryBuilder<RoomMemberCollection, bool, QQueryOperations> isAdminProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAdmin');
    });
  }

  QueryBuilder<RoomMemberCollection, bool, QQueryOperations>
      isAdminOrAboveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAdminOrAbove');
    });
  }

  QueryBuilder<RoomMemberCollection, bool, QQueryOperations>
      isDirectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirect');
    });
  }

  QueryBuilder<RoomMemberCollection, bool, QQueryOperations> isGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGroup');
    });
  }

  QueryBuilder<RoomMemberCollection, bool, QQueryOperations> isMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMe');
    });
  }

  QueryBuilder<RoomMemberCollection, bool, QQueryOperations> isOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOwner');
    });
  }

  QueryBuilder<RoomMemberCollection, bool, QQueryOperations>
      isSystemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSystem');
    });
  }

  QueryBuilder<RoomMemberCollection, DateTime?, QQueryOperations>
      joinedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'joinedAt');
    });
  }

  QueryBuilder<RoomMemberCollection, DateTime?, QQueryOperations>
      lastSeenMessageAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSeenMessageAt');
    });
  }

  QueryBuilder<RoomMemberCollection, DateTime?, QQueryOperations>
      lastTypedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTypedAt');
    });
  }

  QueryBuilder<RoomMemberCollection, String?, QQueryOperations>
      localDbIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localDbId');
    });
  }

  QueryBuilder<RoomMemberCollection, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<RoomMemberCollection, String?, QQueryOperations>
      nameLowercaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameLowercase');
    });
  }

  QueryBuilder<RoomMemberCollection, String?, QQueryOperations>
      roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<RoomMemberCollection, RoomType?, QQueryOperations>
      roomTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomType');
    });
  }

  QueryBuilder<RoomMemberCollection, String?, QQueryOperations>
      rowIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rowId');
    });
  }
}
