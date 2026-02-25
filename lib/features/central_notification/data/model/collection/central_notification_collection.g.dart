// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'central_notification_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCentralNotificationCollectionCollection on Isar {
  IsarCollection<CentralNotificationCollection> get centralNotification =>
      this.collection();
}

const CentralNotificationCollectionSchema = CollectionSchema(
  name: r'CentralNotification',
  id: -7699437268414725223,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'data': PropertySchema(
      id: 1,
      name: r'data',
      type: IsarType.object,
      target: r'CentralNotificationDataModel',
    ),
    r'historyForAccountId': PropertySchema(
      id: 2,
      name: r'historyForAccountId',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'notiType': PropertySchema(
      id: 4,
      name: r'notiType',
      type: IsarType.string,
      enumMap: _CentralNotificationCollectionnotiTypeEnumValueMap,
    ),
    r'notiUnreadCount': PropertySchema(
      id: 5,
      name: r'notiUnreadCount',
      type: IsarType.string,
    )
  },
  estimateSize: _centralNotificationCollectionEstimateSize,
  serialize: _centralNotificationCollectionSerialize,
  deserialize: _centralNotificationCollectionDeserialize,
  deserializeProp: _centralNotificationCollectionDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {
    r'CentralNotificationDataModel': CentralNotificationDataModelSchema
  },
  getId: _centralNotificationCollectionGetId,
  getLinks: _centralNotificationCollectionGetLinks,
  attach: _centralNotificationCollectionAttach,
  version: '3.3.0-dev.3',
);

int _centralNotificationCollectionEstimateSize(
  CentralNotificationCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.data;
    if (value != null) {
      bytesCount += 3 +
          CentralNotificationDataModelSchema.estimateSize(
              value, allOffsets[CentralNotificationDataModel]!, allOffsets);
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
    final value = object.notiType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.notiUnreadCount;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _centralNotificationCollectionSerialize(
  CentralNotificationCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeObject<CentralNotificationDataModel>(
    offsets[1],
    allOffsets,
    CentralNotificationDataModelSchema.serialize,
    object.data,
  );
  writer.writeString(offsets[2], object.historyForAccountId);
  writer.writeString(offsets[3], object.id);
  writer.writeString(offsets[4], object.notiType?.name);
  writer.writeString(offsets[5], object.notiUnreadCount);
}

CentralNotificationCollection _centralNotificationCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CentralNotificationCollection(
    createdAt: reader.readDateTimeOrNull(offsets[0]),
    data: reader.readObjectOrNull<CentralNotificationDataModel>(
      offsets[1],
      CentralNotificationDataModelSchema.deserialize,
      allOffsets,
    ),
    historyForAccountId: reader.readStringOrNull(offsets[2]),
    id: reader.readStringOrNull(offsets[3]),
    notiType: _CentralNotificationCollectionnotiTypeValueEnumMap[
        reader.readStringOrNull(offsets[4])],
    notiUnreadCount: reader.readStringOrNull(offsets[5]),
  );
  return object;
}

P _centralNotificationCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<CentralNotificationDataModel>(
        offset,
        CentralNotificationDataModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (_CentralNotificationCollectionnotiTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CentralNotificationCollectionnotiTypeEnumValueMap = {
  r'newFriend': r'newFriend',
  r'declineFriend': r'declineFriend',
  r'acceptFriend': r'acceptFriend',
  r'friendAccept': r'friendAccept',
  r'inviteGroup': r'inviteGroup',
  r'declineGroup': r'declineGroup',
  r'acceptGroup': r'acceptGroup',
  r'groupAccept': r'groupAccept',
  r'sendGiftSticker': r'sendGiftSticker',
  r'groupDeleted': r'groupDeleted',
  r'friendDeleted': r'friendDeleted',
  r'requestGroup': r'requestGroup',
  r'requestGroupApproved': r'requestGroupApproved',
  r'requestGroupDeclined': r'requestGroupDeclined',
  r'requestGroupJoined': r'requestGroupJoined',
  r'groupDeclined': r'groupDeclined',
  r'unknown': r'unknown',
};
const _CentralNotificationCollectionnotiTypeValueEnumMap = {
  r'newFriend': CentralNotiType.newFriend,
  r'declineFriend': CentralNotiType.declineFriend,
  r'acceptFriend': CentralNotiType.acceptFriend,
  r'friendAccept': CentralNotiType.friendAccept,
  r'inviteGroup': CentralNotiType.inviteGroup,
  r'declineGroup': CentralNotiType.declineGroup,
  r'acceptGroup': CentralNotiType.acceptGroup,
  r'groupAccept': CentralNotiType.groupAccept,
  r'sendGiftSticker': CentralNotiType.sendGiftSticker,
  r'groupDeleted': CentralNotiType.groupDeleted,
  r'friendDeleted': CentralNotiType.friendDeleted,
  r'requestGroup': CentralNotiType.requestGroup,
  r'requestGroupApproved': CentralNotiType.requestGroupApproved,
  r'requestGroupDeclined': CentralNotiType.requestGroupDeclined,
  r'requestGroupJoined': CentralNotiType.requestGroupJoined,
  r'groupDeclined': CentralNotiType.groupDeclined,
  r'unknown': CentralNotiType.unknown,
};

Id _centralNotificationCollectionGetId(CentralNotificationCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _centralNotificationCollectionGetLinks(
    CentralNotificationCollection object) {
  return [];
}

void _centralNotificationCollectionAttach(
    IsarCollection<dynamic> col, Id id, CentralNotificationCollection object) {}

extension CentralNotificationCollectionByIndex
    on IsarCollection<CentralNotificationCollection> {
  Future<CentralNotificationCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  CentralNotificationCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<CentralNotificationCollection?>> getAllById(
      List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<CentralNotificationCollection?> getAllByIdSync(List<String?> idValues) {
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

  Future<Id> putById(CentralNotificationCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(CentralNotificationCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<CentralNotificationCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<CentralNotificationCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension CentralNotificationCollectionQueryWhereSort on QueryBuilder<
    CentralNotificationCollection, CentralNotificationCollection, QWhere> {
  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CentralNotificationCollectionQueryWhere on QueryBuilder<
    CentralNotificationCollection,
    CentralNotificationCollection,
    QWhereClause> {
  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterWhereClause> idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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
}

extension CentralNotificationCollectionQueryFilter on QueryBuilder<
    CentralNotificationCollection,
    CentralNotificationCollection,
    QFilterCondition> {
  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'historyForAccountId',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'historyForAccountId',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdEqualTo(
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdGreaterThan(
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdLessThan(
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdBetween(
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdStartsWith(
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdEndsWith(
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
          QAfterFilterCondition>
      historyForAccountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'historyForAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
          QAfterFilterCondition>
      historyForAccountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'historyForAccountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historyForAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> historyForAccountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'historyForAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
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

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notiType',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notiType',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeEqualTo(
    CentralNotiType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notiType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeGreaterThan(
    CentralNotiType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notiType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeLessThan(
    CentralNotiType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notiType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeBetween(
    CentralNotiType? lower,
    CentralNotiType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notiType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notiType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notiType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
          QAfterFilterCondition>
      notiTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notiType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
          QAfterFilterCondition>
      notiTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notiType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notiType',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notiType',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notiUnreadCount',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notiUnreadCount',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notiUnreadCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notiUnreadCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notiUnreadCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notiUnreadCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notiUnreadCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notiUnreadCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
          QAfterFilterCondition>
      notiUnreadCountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notiUnreadCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
          QAfterFilterCondition>
      notiUnreadCountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notiUnreadCount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notiUnreadCount',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> notiUnreadCountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notiUnreadCount',
        value: '',
      ));
    });
  }
}

extension CentralNotificationCollectionQueryObject on QueryBuilder<
    CentralNotificationCollection,
    CentralNotificationCollection,
    QFilterCondition> {
  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterFilterCondition> data(FilterQuery<CentralNotificationDataModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'data');
    });
  }
}

extension CentralNotificationCollectionQueryLinks on QueryBuilder<
    CentralNotificationCollection,
    CentralNotificationCollection,
    QFilterCondition> {}

extension CentralNotificationCollectionQuerySortBy on QueryBuilder<
    CentralNotificationCollection, CentralNotificationCollection, QSortBy> {
  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortByHistoryForAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortByHistoryForAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.desc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortByNotiType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notiType', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortByNotiTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notiType', Sort.desc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortByNotiUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notiUnreadCount', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> sortByNotiUnreadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notiUnreadCount', Sort.desc);
    });
  }
}

extension CentralNotificationCollectionQuerySortThenBy on QueryBuilder<
    CentralNotificationCollection, CentralNotificationCollection, QSortThenBy> {
  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByHistoryForAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByHistoryForAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyForAccountId', Sort.desc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByNotiType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notiType', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByNotiTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notiType', Sort.desc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByNotiUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notiUnreadCount', Sort.asc);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QAfterSortBy> thenByNotiUnreadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notiUnreadCount', Sort.desc);
    });
  }
}

extension CentralNotificationCollectionQueryWhereDistinct on QueryBuilder<
    CentralNotificationCollection, CentralNotificationCollection, QDistinct> {
  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QDistinct> distinctByHistoryForAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'historyForAccountId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QDistinct> distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QDistinct> distinctByNotiType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notiType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationCollection,
      QDistinct> distinctByNotiUnreadCount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notiUnreadCount',
          caseSensitive: caseSensitive);
    });
  }
}

extension CentralNotificationCollectionQueryProperty on QueryBuilder<
    CentralNotificationCollection,
    CentralNotificationCollection,
    QQueryProperty> {
  QueryBuilder<CentralNotificationCollection, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CentralNotificationCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotificationDataModel?,
      QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<CentralNotificationCollection, String?, QQueryOperations>
      historyForAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'historyForAccountId');
    });
  }

  QueryBuilder<CentralNotificationCollection, String?, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CentralNotificationCollection, CentralNotiType?,
      QQueryOperations> notiTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notiType');
    });
  }

  QueryBuilder<CentralNotificationCollection, String?, QQueryOperations>
      notiUnreadCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notiUnreadCount');
    });
  }
}
