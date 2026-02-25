// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCallLogCollectionCollection on Isar {
  IsarCollection<CallLogCollection> get callLogs => this.collection();
}

const CallLogCollectionSchema = CollectionSchema(
  name: r'CallLog',
  id: 5248633877952411755,
  properties: {
    r'callActionType': PropertySchema(
      id: 0,
      name: r'callActionType',
      type: IsarType.string,
      enumMap: _CallLogCollectioncallActionTypeEnumValueMap,
    ),
    r'callCount': PropertySchema(
      id: 1,
      name: r'callCount',
      type: IsarType.long,
    ),
    r'callType': PropertySchema(
      id: 2,
      name: r'callType',
      type: IsarType.string,
      enumMap: _CallLogCollectioncallTypeEnumValueMap,
    ),
    r'friendId': PropertySchema(
      id: 3,
      name: r'friendId',
      type: IsarType.string,
    ),
    r'historyForAccountId': PropertySchema(
      id: 4,
      name: r'historyForAccountId',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'lastStartedAt': PropertySchema(
      id: 6,
      name: r'lastStartedAt',
      type: IsarType.dateTime,
    ),
    r'roomId': PropertySchema(
      id: 7,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'roomType': PropertySchema(
      id: 8,
      name: r'roomType',
      type: IsarType.string,
      enumMap: _CallLogCollectionroomTypeEnumValueMap,
    ),
    r'totalDuration': PropertySchema(
      id: 9,
      name: r'totalDuration',
      type: IsarType.double,
    )
  },
  estimateSize: _callLogCollectionEstimateSize,
  serialize: _callLogCollectionSerialize,
  deserialize: _callLogCollectionDeserialize,
  deserializeProp: _callLogCollectionDeserializeProp,
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
    r'callActionType': IndexSchema(
      id: -7615413117530790990,
      name: r'callActionType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'callActionType',
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
    r'friendId': IndexSchema(
      id: 3009825909668687770,
      name: r'friendId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'friendId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _callLogCollectionGetId,
  getLinks: _callLogCollectionGetLinks,
  attach: _callLogCollectionAttach,
  version: '3.3.0-dev.3',
);

int _callLogCollectionEstimateSize(
  CallLogCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.callActionType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.callType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.friendId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
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
  return bytesCount;
}

void _callLogCollectionSerialize(
  CallLogCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.callActionType?.name);
  writer.writeLong(offsets[1], object.callCount);
  writer.writeString(offsets[2], object.callType?.name);
  writer.writeString(offsets[3], object.friendId);
  writer.writeString(offsets[4], object.historyForAccountId);
  writer.writeString(offsets[5], object.id);
  writer.writeDateTime(offsets[6], object.lastStartedAt);
  writer.writeString(offsets[7], object.roomId);
  writer.writeString(offsets[8], object.roomType?.name);
  writer.writeDouble(offsets[9], object.totalDuration);
}

CallLogCollection _callLogCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CallLogCollection(
    callActionType: _CallLogCollectioncallActionTypeValueEnumMap[
        reader.readStringOrNull(offsets[0])],
    callCount: reader.readLongOrNull(offsets[1]),
    callType: _CallLogCollectioncallTypeValueEnumMap[
        reader.readStringOrNull(offsets[2])],
    friendId: reader.readStringOrNull(offsets[3]),
    historyForAccountId: reader.readStringOrNull(offsets[4]),
    id: reader.readStringOrNull(offsets[5]),
    lastStartedAt: reader.readDateTimeOrNull(offsets[6]),
    roomId: reader.readStringOrNull(offsets[7]),
    roomType: _CallLogCollectionroomTypeValueEnumMap[
        reader.readStringOrNull(offsets[8])],
    totalDuration: reader.readDoubleOrNull(offsets[9]),
  );
  return object;
}

P _callLogCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CallLogCollectioncallActionTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (_CallLogCollectioncallTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (_CallLogCollectionroomTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CallLogCollectioncallActionTypeEnumValueMap = {
  r'outgoing': r'outgoing',
  r'incoming': r'incoming',
  r'missed': r'missed',
};
const _CallLogCollectioncallActionTypeValueEnumMap = {
  r'outgoing': CallActionType.outgoing,
  r'incoming': CallActionType.incoming,
  r'missed': CallActionType.missed,
};
const _CallLogCollectioncallTypeEnumValueMap = {
  r'video': r'video',
  r'voice': r'voice',
};
const _CallLogCollectioncallTypeValueEnumMap = {
  r'video': CallType.video,
  r'voice': CallType.voice,
};
const _CallLogCollectionroomTypeEnumValueMap = {
  r'direct': r'direct',
  r'group': r'group',
  r'directSecret': r'directSecret',
  r'bookmark': r'bookmark',
  r'system': r'system',
};
const _CallLogCollectionroomTypeValueEnumMap = {
  r'direct': RoomType.direct,
  r'group': RoomType.group,
  r'directSecret': RoomType.directSecret,
  r'bookmark': RoomType.bookmark,
  r'system': RoomType.system,
};

Id _callLogCollectionGetId(CallLogCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _callLogCollectionGetLinks(
    CallLogCollection object) {
  return [];
}

void _callLogCollectionAttach(
    IsarCollection<dynamic> col, Id id, CallLogCollection object) {}

extension CallLogCollectionByIndex on IsarCollection<CallLogCollection> {
  Future<CallLogCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  CallLogCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<CallLogCollection?>> getAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<CallLogCollection?> getAllByIdSync(List<String?> idValues) {
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

  Future<Id> putById(CallLogCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(CallLogCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<CallLogCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<CallLogCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension CallLogCollectionQueryWhereSort
    on QueryBuilder<CallLogCollection, CallLogCollection, QWhere> {
  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CallLogCollectionQueryWhere
    on QueryBuilder<CallLogCollection, CallLogCollection, QWhereClause> {
  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      callActionTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'callActionType',
        value: [null],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      callActionTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'callActionType',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      callActionTypeEqualTo(CallActionType? callActionType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'callActionType',
        value: [callActionType],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      callActionTypeNotEqualTo(CallActionType? callActionType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'callActionType',
              lower: [],
              upper: [callActionType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'callActionType',
              lower: [callActionType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'callActionType',
              lower: [callActionType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'callActionType',
              lower: [],
              upper: [callActionType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      friendIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'friendId',
        value: [null],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      friendIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'friendId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      friendIdEqualTo(String? friendId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'friendId',
        value: [friendId],
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterWhereClause>
      friendIdNotEqualTo(String? friendId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'friendId',
              lower: [],
              upper: [friendId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'friendId',
              lower: [friendId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'friendId',
              lower: [friendId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'friendId',
              lower: [],
              upper: [friendId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CallLogCollectionQueryFilter
    on QueryBuilder<CallLogCollection, CallLogCollection, QFilterCondition> {
  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callActionType',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callActionType',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeEqualTo(
    CallActionType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callActionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeGreaterThan(
    CallActionType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'callActionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeLessThan(
    CallActionType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'callActionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeBetween(
    CallActionType? lower,
    CallActionType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'callActionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'callActionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'callActionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callActionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callActionType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callActionType',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callActionTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callActionType',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callCount',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callCount',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'callCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'callCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'callCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callType',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callType',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeEqualTo(
    CallType? value, {
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeGreaterThan(
    CallType? value, {
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeLessThan(
    CallType? value, {
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeBetween(
    CallType? lower,
    CallType? upper, {
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callType',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      callTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callType',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'friendId',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'friendId',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friendId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'friendId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendId',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      friendIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'friendId',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      historyForAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'historyForAccountId',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      historyForAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'historyForAccountId',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      historyForAccountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'historyForAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      historyForAccountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'historyForAccountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      historyForAccountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historyForAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      historyForAccountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'historyForAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      lastStartedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastStartedAt',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      lastStartedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastStartedAt',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      lastStartedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastStartedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      lastStartedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastStartedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      lastStartedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastStartedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      lastStartedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastStartedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomType',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
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

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      roomTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomType',
        value: '',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      totalDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalDuration',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      totalDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalDuration',
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      totalDurationEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalDuration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      totalDurationGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalDuration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      totalDurationLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalDuration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>
      totalDurationBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension CallLogCollectionQueryObject
    on QueryBuilder<CallLogCollection, CallLogCollection, QFilterCondition> {}

extension CallLogCollectionQueryLinks
    on QueryBuilder<CallLogCollection, CallLogCollection, QFilterCondition> {}

extension CallLogCollectionQuerySortBy
    on QueryBuilder<CallLogCollection, CallLogCollection, QSortBy> {
  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByCallActionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callActionType', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByCallActionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callActionType', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByCallCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callCount', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByCallCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callCount', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByCallType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByCallTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByFriendId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendId', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByFriendIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendId', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByHistoryForAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByHistoryForAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByLastStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStartedAt', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByLastStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStartedAt', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByRoomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByRoomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      sortByTotalDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.desc);
    });
  }
}

extension CallLogCollectionQuerySortThenBy
    on QueryBuilder<CallLogCollection, CallLogCollection, QSortThenBy> {
  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByCallActionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callActionType', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByCallActionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callActionType', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByCallCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callCount', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByCallCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callCount', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByCallType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByCallTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByFriendId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendId', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByFriendIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendId', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByHistoryForAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByHistoryForAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByLastStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStartedAt', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByLastStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStartedAt', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByRoomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByRoomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomType', Sort.desc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.asc);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QAfterSortBy>
      thenByTotalDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.desc);
    });
  }
}

extension CallLogCollectionQueryWhereDistinct
    on QueryBuilder<CallLogCollection, CallLogCollection, QDistinct> {
  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct>
      distinctByCallActionType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callActionType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct>
      distinctByCallCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callCount');
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct>
      distinctByCallType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct>
      distinctByFriendId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct>
      distinctByHistoryForAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'historyForAccountId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct>
      distinctByLastStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastStartedAt');
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct>
      distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct>
      distinctByRoomType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CallLogCollection, CallLogCollection, QDistinct>
      distinctByTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalDuration');
    });
  }
}

extension CallLogCollectionQueryProperty
    on QueryBuilder<CallLogCollection, CallLogCollection, QQueryProperty> {
  QueryBuilder<CallLogCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CallLogCollection, CallActionType?, QQueryOperations>
      callActionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callActionType');
    });
  }

  QueryBuilder<CallLogCollection, int?, QQueryOperations> callCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callCount');
    });
  }

  QueryBuilder<CallLogCollection, CallType?, QQueryOperations>
      callTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callType');
    });
  }

  QueryBuilder<CallLogCollection, String?, QQueryOperations>
      friendIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendId');
    });
  }

  QueryBuilder<CallLogCollection, String?, QQueryOperations>
      historyForAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'historyForAccountId');
    });
  }

  QueryBuilder<CallLogCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CallLogCollection, DateTime?, QQueryOperations>
      lastStartedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastStartedAt');
    });
  }

  QueryBuilder<CallLogCollection, String?, QQueryOperations> roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<CallLogCollection, RoomType?, QQueryOperations>
      roomTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomType');
    });
  }

  QueryBuilder<CallLogCollection, double?, QQueryOperations>
      totalDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalDuration');
    });
  }
}
