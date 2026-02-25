// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_permission_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGroupPermissionCollectionCollection on Isar {
  IsarCollection<GroupPermissionCollection> get groupPermissions =>
      this.collection();
}

const GroupPermissionCollectionSchema = CollectionSchema(
  name: r'GroupPermission',
  id: -7191370067287341294,
  properties: {
    r'applyToAdmin': PropertySchema(
      id: 0,
      name: r'applyToAdmin',
      type: IsarType.bool,
    ),
    r'canAddDeleteAlbum': PropertySchema(
      id: 1,
      name: r'canAddDeleteAlbum',
      type: IsarType.bool,
    ),
    r'canEditOwnMessage': PropertySchema(
      id: 2,
      name: r'canEditOwnMessage',
      type: IsarType.bool,
    ),
    r'canMentionAll': PropertySchema(
      id: 3,
      name: r'canMentionAll',
      type: IsarType.bool,
    ),
    r'canReactions': PropertySchema(
      id: 4,
      name: r'canReactions',
      type: IsarType.bool,
    ),
    r'canSendMedia': PropertySchema(
      id: 5,
      name: r'canSendMedia',
      type: IsarType.bool,
    ),
    r'canSendMessages': PropertySchema(
      id: 6,
      name: r'canSendMessages',
      type: IsarType.bool,
    ),
    r'canUnsendOwnMessage': PropertySchema(
      id: 7,
      name: r'canUnsendOwnMessage',
      type: IsarType.bool,
    ),
    r'createdAt': PropertySchema(
      id: 8,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'enable': PropertySchema(
      id: 9,
      name: r'enable',
      type: IsarType.bool,
    ),
    r'hashCode': PropertySchema(
      id: 10,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'roomId': PropertySchema(
      id: 11,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 12,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _groupPermissionCollectionEstimateSize,
  serialize: _groupPermissionCollectionSerialize,
  deserialize: _groupPermissionCollectionDeserialize,
  deserializeProp: _groupPermissionCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'roomId': IndexSchema(
      id: -3609232324653216207,
      name: r'roomId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _groupPermissionCollectionGetId,
  getLinks: _groupPermissionCollectionGetLinks,
  attach: _groupPermissionCollectionAttach,
  version: '3.3.0-dev.3',
);

int _groupPermissionCollectionEstimateSize(
  GroupPermissionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.roomId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _groupPermissionCollectionSerialize(
  GroupPermissionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.applyToAdmin);
  writer.writeBool(offsets[1], object.canAddDeleteAlbum);
  writer.writeBool(offsets[2], object.canEditOwnMessage);
  writer.writeBool(offsets[3], object.canMentionAll);
  writer.writeBool(offsets[4], object.canReactions);
  writer.writeBool(offsets[5], object.canSendMedia);
  writer.writeBool(offsets[6], object.canSendMessages);
  writer.writeBool(offsets[7], object.canUnsendOwnMessage);
  writer.writeDateTime(offsets[8], object.createdAt);
  writer.writeBool(offsets[9], object.enable);
  writer.writeLong(offsets[10], object.hashCode);
  writer.writeString(offsets[11], object.roomId);
  writer.writeDateTime(offsets[12], object.updatedAt);
}

GroupPermissionCollection _groupPermissionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroupPermissionCollection(
    applyToAdmin: reader.readBoolOrNull(offsets[0]),
    canAddDeleteAlbum: reader.readBoolOrNull(offsets[1]),
    canEditOwnMessage: reader.readBoolOrNull(offsets[2]),
    canMentionAll: reader.readBoolOrNull(offsets[3]),
    canReactions: reader.readBoolOrNull(offsets[4]),
    canSendMedia: reader.readBoolOrNull(offsets[5]),
    canSendMessages: reader.readBoolOrNull(offsets[6]),
    canUnsendOwnMessage: reader.readBoolOrNull(offsets[7]),
    createdAt: reader.readDateTimeOrNull(offsets[8]),
    enable: reader.readBoolOrNull(offsets[9]),
    roomId: reader.readStringOrNull(offsets[11]),
    updatedAt: reader.readDateTimeOrNull(offsets[12]),
  );
  return object;
}

P _groupPermissionCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readBoolOrNull(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _groupPermissionCollectionGetId(GroupPermissionCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _groupPermissionCollectionGetLinks(
    GroupPermissionCollection object) {
  return [];
}

void _groupPermissionCollectionAttach(
    IsarCollection<dynamic> col, Id id, GroupPermissionCollection object) {}

extension GroupPermissionCollectionByIndex
    on IsarCollection<GroupPermissionCollection> {
  Future<GroupPermissionCollection?> getByRoomId(String? roomId) {
    return getByIndex(r'roomId', [roomId]);
  }

  GroupPermissionCollection? getByRoomIdSync(String? roomId) {
    return getByIndexSync(r'roomId', [roomId]);
  }

  Future<bool> deleteByRoomId(String? roomId) {
    return deleteByIndex(r'roomId', [roomId]);
  }

  bool deleteByRoomIdSync(String? roomId) {
    return deleteByIndexSync(r'roomId', [roomId]);
  }

  Future<List<GroupPermissionCollection?>> getAllByRoomId(
      List<String?> roomIdValues) {
    final values = roomIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'roomId', values);
  }

  List<GroupPermissionCollection?> getAllByRoomIdSync(
      List<String?> roomIdValues) {
    final values = roomIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'roomId', values);
  }

  Future<int> deleteAllByRoomId(List<String?> roomIdValues) {
    final values = roomIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'roomId', values);
  }

  int deleteAllByRoomIdSync(List<String?> roomIdValues) {
    final values = roomIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'roomId', values);
  }

  Future<Id> putByRoomId(GroupPermissionCollection object) {
    return putByIndex(r'roomId', object);
  }

  Id putByRoomIdSync(GroupPermissionCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'roomId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRoomId(List<GroupPermissionCollection> objects) {
    return putAllByIndex(r'roomId', objects);
  }

  List<Id> putAllByRoomIdSync(List<GroupPermissionCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'roomId', objects, saveLinks: saveLinks);
  }
}

extension GroupPermissionCollectionQueryWhereSort on QueryBuilder<
    GroupPermissionCollection, GroupPermissionCollection, QWhere> {
  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GroupPermissionCollectionQueryWhere on QueryBuilder<
    GroupPermissionCollection, GroupPermissionCollection, QWhereClause> {
  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterWhereClause> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterWhereClause> roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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
}

extension GroupPermissionCollectionQueryFilter on QueryBuilder<
    GroupPermissionCollection, GroupPermissionCollection, QFilterCondition> {
  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> applyToAdminIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'applyToAdmin',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> applyToAdminIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'applyToAdmin',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> applyToAdminEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applyToAdmin',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canAddDeleteAlbumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canAddDeleteAlbum',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canAddDeleteAlbumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canAddDeleteAlbum',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canAddDeleteAlbumEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canAddDeleteAlbum',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canEditOwnMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canEditOwnMessage',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canEditOwnMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canEditOwnMessage',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canEditOwnMessageEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canEditOwnMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canMentionAllIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canMentionAll',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canMentionAllIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canMentionAll',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canMentionAllEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canMentionAll',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canReactionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canReactions',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canReactionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canReactions',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canReactionsEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canReactions',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canSendMediaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canSendMedia',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canSendMediaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canSendMedia',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canSendMediaEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canSendMedia',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canSendMessagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canSendMessages',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canSendMessagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canSendMessages',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canSendMessagesEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canSendMessages',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canUnsendOwnMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canUnsendOwnMessage',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canUnsendOwnMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canUnsendOwnMessage',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> canUnsendOwnMessageEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canUnsendOwnMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> enableIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enable',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> enableIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enable',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> enableEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enable',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
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

extension GroupPermissionCollectionQueryObject on QueryBuilder<
    GroupPermissionCollection, GroupPermissionCollection, QFilterCondition> {}

extension GroupPermissionCollectionQueryLinks on QueryBuilder<
    GroupPermissionCollection, GroupPermissionCollection, QFilterCondition> {}

extension GroupPermissionCollectionQuerySortBy on QueryBuilder<
    GroupPermissionCollection, GroupPermissionCollection, QSortBy> {
  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByApplyToAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyToAdmin', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByApplyToAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyToAdmin', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanAddDeleteAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddDeleteAlbum', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanAddDeleteAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddDeleteAlbum', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanEditOwnMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canEditOwnMessage', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanEditOwnMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canEditOwnMessage', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanMentionAll() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canMentionAll', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanMentionAllDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canMentionAll', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanReactions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReactions', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanReactionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReactions', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanSendMedia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canSendMedia', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanSendMediaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canSendMedia', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanSendMessages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canSendMessages', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanSendMessagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canSendMessages', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanUnsendOwnMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canUnsendOwnMessage', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCanUnsendOwnMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canUnsendOwnMessage', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension GroupPermissionCollectionQuerySortThenBy on QueryBuilder<
    GroupPermissionCollection, GroupPermissionCollection, QSortThenBy> {
  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByApplyToAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyToAdmin', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByApplyToAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applyToAdmin', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanAddDeleteAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddDeleteAlbum', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanAddDeleteAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canAddDeleteAlbum', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanEditOwnMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canEditOwnMessage', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanEditOwnMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canEditOwnMessage', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanMentionAll() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canMentionAll', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanMentionAllDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canMentionAll', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanReactions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReactions', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanReactionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canReactions', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanSendMedia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canSendMedia', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanSendMediaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canSendMedia', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanSendMessages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canSendMessages', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanSendMessagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canSendMessages', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanUnsendOwnMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canUnsendOwnMessage', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCanUnsendOwnMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canUnsendOwnMessage', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection,
      QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension GroupPermissionCollectionQueryWhereDistinct on QueryBuilder<
    GroupPermissionCollection, GroupPermissionCollection, QDistinct> {
  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByApplyToAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'applyToAdmin');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByCanAddDeleteAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canAddDeleteAlbum');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByCanEditOwnMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canEditOwnMessage');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByCanMentionAll() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canMentionAll');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByCanReactions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canReactions');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByCanSendMedia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canSendMedia');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByCanSendMessages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canSendMessages');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByCanUnsendOwnMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canUnsendOwnMessage');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enable');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension GroupPermissionCollectionQueryProperty on QueryBuilder<
    GroupPermissionCollection, GroupPermissionCollection, QQueryProperty> {
  QueryBuilder<GroupPermissionCollection, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<GroupPermissionCollection, bool?, QQueryOperations>
      applyToAdminProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applyToAdmin');
    });
  }

  QueryBuilder<GroupPermissionCollection, bool?, QQueryOperations>
      canAddDeleteAlbumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canAddDeleteAlbum');
    });
  }

  QueryBuilder<GroupPermissionCollection, bool?, QQueryOperations>
      canEditOwnMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canEditOwnMessage');
    });
  }

  QueryBuilder<GroupPermissionCollection, bool?, QQueryOperations>
      canMentionAllProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canMentionAll');
    });
  }

  QueryBuilder<GroupPermissionCollection, bool?, QQueryOperations>
      canReactionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canReactions');
    });
  }

  QueryBuilder<GroupPermissionCollection, bool?, QQueryOperations>
      canSendMediaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canSendMedia');
    });
  }

  QueryBuilder<GroupPermissionCollection, bool?, QQueryOperations>
      canSendMessagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canSendMessages');
    });
  }

  QueryBuilder<GroupPermissionCollection, bool?, QQueryOperations>
      canUnsendOwnMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canUnsendOwnMessage');
    });
  }

  QueryBuilder<GroupPermissionCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<GroupPermissionCollection, bool?, QQueryOperations>
      enableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enable');
    });
  }

  QueryBuilder<GroupPermissionCollection, int, QQueryOperations>
      hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<GroupPermissionCollection, String?, QQueryOperations>
      roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<GroupPermissionCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
