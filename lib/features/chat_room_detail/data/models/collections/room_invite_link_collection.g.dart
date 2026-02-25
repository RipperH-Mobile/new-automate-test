// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_invite_link_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRoomInviteLinkCollectionCollection on Isar {
  IsarCollection<RoomInviteLinkCollection> get roomInviteLinkCollections =>
      this.collection();
}

const RoomInviteLinkCollectionSchema = CollectionSchema(
  name: r'RoomInviteLinkCollection',
  id: -581546492623187772,
  properties: {
    r'enable': PropertySchema(
      id: 0,
      name: r'enable',
      type: IsarType.bool,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'inviteLink': PropertySchema(
      id: 2,
      name: r'inviteLink',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 3,
      name: r'roomId',
      type: IsarType.string,
    )
  },
  estimateSize: _roomInviteLinkCollectionEstimateSize,
  serialize: _roomInviteLinkCollectionSerialize,
  deserialize: _roomInviteLinkCollectionDeserialize,
  deserializeProp: _roomInviteLinkCollectionDeserializeProp,
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
  getId: _roomInviteLinkCollectionGetId,
  getLinks: _roomInviteLinkCollectionGetLinks,
  attach: _roomInviteLinkCollectionAttach,
  version: '3.3.0-dev.3',
);

int _roomInviteLinkCollectionEstimateSize(
  RoomInviteLinkCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.inviteLink;
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
  return bytesCount;
}

void _roomInviteLinkCollectionSerialize(
  RoomInviteLinkCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enable);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeString(offsets[2], object.inviteLink);
  writer.writeString(offsets[3], object.roomId);
}

RoomInviteLinkCollection _roomInviteLinkCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomInviteLinkCollection(
    enable: reader.readBoolOrNull(offsets[0]),
    inviteLink: reader.readStringOrNull(offsets[2]),
    roomId: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _roomInviteLinkCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _roomInviteLinkCollectionGetId(RoomInviteLinkCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _roomInviteLinkCollectionGetLinks(
    RoomInviteLinkCollection object) {
  return [];
}

void _roomInviteLinkCollectionAttach(
    IsarCollection<dynamic> col, Id id, RoomInviteLinkCollection object) {}

extension RoomInviteLinkCollectionByIndex
    on IsarCollection<RoomInviteLinkCollection> {
  Future<RoomInviteLinkCollection?> getByRoomId(String? roomId) {
    return getByIndex(r'roomId', [roomId]);
  }

  RoomInviteLinkCollection? getByRoomIdSync(String? roomId) {
    return getByIndexSync(r'roomId', [roomId]);
  }

  Future<bool> deleteByRoomId(String? roomId) {
    return deleteByIndex(r'roomId', [roomId]);
  }

  bool deleteByRoomIdSync(String? roomId) {
    return deleteByIndexSync(r'roomId', [roomId]);
  }

  Future<List<RoomInviteLinkCollection?>> getAllByRoomId(
      List<String?> roomIdValues) {
    final values = roomIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'roomId', values);
  }

  List<RoomInviteLinkCollection?> getAllByRoomIdSync(
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

  Future<Id> putByRoomId(RoomInviteLinkCollection object) {
    return putByIndex(r'roomId', object);
  }

  Id putByRoomIdSync(RoomInviteLinkCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'roomId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRoomId(List<RoomInviteLinkCollection> objects) {
    return putAllByIndex(r'roomId', objects);
  }

  List<Id> putAllByRoomIdSync(List<RoomInviteLinkCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'roomId', objects, saveLinks: saveLinks);
  }
}

extension RoomInviteLinkCollectionQueryWhereSort on QueryBuilder<
    RoomInviteLinkCollection, RoomInviteLinkCollection, QWhere> {
  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RoomInviteLinkCollectionQueryWhere on QueryBuilder<
    RoomInviteLinkCollection, RoomInviteLinkCollection, QWhereClause> {
  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterWhereClause> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterWhereClause> roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

extension RoomInviteLinkCollectionQueryFilter on QueryBuilder<
    RoomInviteLinkCollection, RoomInviteLinkCollection, QFilterCondition> {
  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> enableIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enable',
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> enableIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enable',
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> enableEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enable',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inviteLink',
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inviteLink',
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inviteLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inviteLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inviteLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inviteLink',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inviteLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inviteLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
          QAfterFilterCondition>
      inviteLinkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inviteLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
          QAfterFilterCondition>
      inviteLinkMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inviteLink',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inviteLink',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> inviteLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inviteLink',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
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

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection,
      QAfterFilterCondition> roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }
}

extension RoomInviteLinkCollectionQueryObject on QueryBuilder<
    RoomInviteLinkCollection, RoomInviteLinkCollection, QFilterCondition> {}

extension RoomInviteLinkCollectionQueryLinks on QueryBuilder<
    RoomInviteLinkCollection, RoomInviteLinkCollection, QFilterCondition> {}

extension RoomInviteLinkCollectionQuerySortBy on QueryBuilder<
    RoomInviteLinkCollection, RoomInviteLinkCollection, QSortBy> {
  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      sortByEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable', Sort.asc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      sortByEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable', Sort.desc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      sortByInviteLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inviteLink', Sort.asc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      sortByInviteLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inviteLink', Sort.desc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }
}

extension RoomInviteLinkCollectionQuerySortThenBy on QueryBuilder<
    RoomInviteLinkCollection, RoomInviteLinkCollection, QSortThenBy> {
  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable', Sort.asc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enable', Sort.desc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByInviteLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inviteLink', Sort.asc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByInviteLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inviteLink', Sort.desc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }
}

extension RoomInviteLinkCollectionQueryWhereDistinct on QueryBuilder<
    RoomInviteLinkCollection, RoomInviteLinkCollection, QDistinct> {
  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QDistinct>
      distinctByEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enable');
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QDistinct>
      distinctByInviteLink({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inviteLink', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomInviteLinkCollection, RoomInviteLinkCollection, QDistinct>
      distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }
}

extension RoomInviteLinkCollectionQueryProperty on QueryBuilder<
    RoomInviteLinkCollection, RoomInviteLinkCollection, QQueryProperty> {
  QueryBuilder<RoomInviteLinkCollection, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<RoomInviteLinkCollection, bool?, QQueryOperations>
      enableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enable');
    });
  }

  QueryBuilder<RoomInviteLinkCollection, int, QQueryOperations>
      hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<RoomInviteLinkCollection, String?, QQueryOperations>
      inviteLinkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inviteLink');
    });
  }

  QueryBuilder<RoomInviteLinkCollection, String?, QQueryOperations>
      roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }
}
