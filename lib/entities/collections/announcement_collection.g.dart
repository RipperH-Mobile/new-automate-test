// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnnouncementCollectionCollection on Isar {
  IsarCollection<AnnouncementCollection> get announcement => this.collection();
}

const AnnouncementCollectionSchema = CollectionSchema(
  name: r'Announcement',
  id: -8618021732165391233,
  properties: {
    r'announceAt': PropertySchema(
      id: 0,
      name: r'announceAt',
      type: IsarType.dateTime,
    ),
    r'announceType': PropertySchema(
      id: 1,
      name: r'announceType',
      type: IsarType.string,
    ),
    r'deleted': PropertySchema(
      id: 2,
      name: r'deleted',
      type: IsarType.bool,
    ),
    r'dontShowToday': PropertySchema(
      id: 3,
      name: r'dontShowToday',
      type: IsarType.dateTime,
    ),
    r'endMaintenanceAt': PropertySchema(
      id: 4,
      name: r'endMaintenanceAt',
      type: IsarType.dateTime,
    ),
    r'expireAt': PropertySchema(
      id: 5,
      name: r'expireAt',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.string,
    ),
    r'image': PropertySchema(
      id: 7,
      name: r'image',
      type: IsarType.objectList,
      target: r'AnnouncementDataModel',
    ),
    r'isBroadcasted': PropertySchema(
      id: 8,
      name: r'isBroadcasted',
      type: IsarType.bool,
    ),
    r'isExpired': PropertySchema(
      id: 9,
      name: r'isExpired',
      type: IsarType.bool,
    ),
    r'isUseBroadcast': PropertySchema(
      id: 10,
      name: r'isUseBroadcast',
      type: IsarType.bool,
    ),
    r'startMaintenanceAt': PropertySchema(
      id: 11,
      name: r'startMaintenanceAt',
      type: IsarType.dateTime,
    ),
    r'text': PropertySchema(
      id: 12,
      name: r'text',
      type: IsarType.objectList,
      target: r'AnnouncementDataModel',
    )
  },
  estimateSize: _announcementCollectionEstimateSize,
  serialize: _announcementCollectionSerialize,
  deserialize: _announcementCollectionDeserialize,
  deserializeProp: _announcementCollectionDeserializeProp,
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
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'AnnouncementDataModel': AnnouncementDataModelSchema},
  getId: _announcementCollectionGetId,
  getLinks: _announcementCollectionGetLinks,
  attach: _announcementCollectionAttach,
  version: '3.3.0-dev.3',
);

int _announcementCollectionEstimateSize(
  AnnouncementCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.announceType;
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
    final list = object.image;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[AnnouncementDataModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += AnnouncementDataModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.text;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[AnnouncementDataModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += AnnouncementDataModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _announcementCollectionSerialize(
  AnnouncementCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.announceAt);
  writer.writeString(offsets[1], object.announceType);
  writer.writeBool(offsets[2], object.deleted);
  writer.writeDateTime(offsets[3], object.dontShowToday);
  writer.writeDateTime(offsets[4], object.endMaintenanceAt);
  writer.writeDateTime(offsets[5], object.expireAt);
  writer.writeString(offsets[6], object.id);
  writer.writeObjectList<AnnouncementDataModel>(
    offsets[7],
    allOffsets,
    AnnouncementDataModelSchema.serialize,
    object.image,
  );
  writer.writeBool(offsets[8], object.isBroadcasted);
  writer.writeBool(offsets[9], object.isExpired);
  writer.writeBool(offsets[10], object.isUseBroadcast);
  writer.writeDateTime(offsets[11], object.startMaintenanceAt);
  writer.writeObjectList<AnnouncementDataModel>(
    offsets[12],
    allOffsets,
    AnnouncementDataModelSchema.serialize,
    object.text,
  );
}

AnnouncementCollection _announcementCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnnouncementCollection(
    announceAt: reader.readDateTime(offsets[0]),
    announceType: reader.readStringOrNull(offsets[1]),
    deleted: reader.readBoolOrNull(offsets[2]),
    dontShowToday: reader.readDateTimeOrNull(offsets[3]),
    endMaintenanceAt: reader.readDateTimeOrNull(offsets[4]),
    expireAt: reader.readDateTime(offsets[5]),
    id: reader.readStringOrNull(offsets[6]),
    image: reader.readObjectList<AnnouncementDataModel>(
      offsets[7],
      AnnouncementDataModelSchema.deserialize,
      allOffsets,
      AnnouncementDataModel(),
    ),
    isBroadcasted: reader.readBoolOrNull(offsets[8]),
    isUseBroadcast: reader.readBoolOrNull(offsets[10]),
    startMaintenanceAt: reader.readDateTimeOrNull(offsets[11]),
    text: reader.readObjectList<AnnouncementDataModel>(
      offsets[12],
      AnnouncementDataModelSchema.deserialize,
      allOffsets,
      AnnouncementDataModel(),
    ),
  );
  return object;
}

P _announcementCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readObjectList<AnnouncementDataModel>(
        offset,
        AnnouncementDataModelSchema.deserialize,
        allOffsets,
        AnnouncementDataModel(),
      )) as P;
    case 8:
      return (reader.readBoolOrNull(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readObjectList<AnnouncementDataModel>(
        offset,
        AnnouncementDataModelSchema.deserialize,
        allOffsets,
        AnnouncementDataModel(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _announcementCollectionGetId(AnnouncementCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _announcementCollectionGetLinks(
    AnnouncementCollection object) {
  return [];
}

void _announcementCollectionAttach(
    IsarCollection<dynamic> col, Id id, AnnouncementCollection object) {}

extension AnnouncementCollectionQueryWhereSort
    on QueryBuilder<AnnouncementCollection, AnnouncementCollection, QWhere> {
  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'id'),
      );
    });
  }
}

extension AnnouncementCollectionQueryWhere on QueryBuilder<
    AnnouncementCollection, AnnouncementCollection, QWhereClause> {
  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> idGreaterThan(
    String? id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [id],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> idLessThan(
    String? id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [],
        upper: [id],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> idBetween(
    String? lowerId,
    String? upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [lowerId],
        includeLower: includeLower,
        upper: [upperId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> idStartsWith(String IdPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [IdPrefix],
        upper: ['$IdPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [''],
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterWhereClause> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'id',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'id',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'id',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'id',
              upper: [''],
            ));
      }
    });
  }
}

extension AnnouncementCollectionQueryFilter on QueryBuilder<
    AnnouncementCollection, AnnouncementCollection, QFilterCondition> {
  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'announceAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'announceAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'announceAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'announceAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'announceType',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'announceType',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'announceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'announceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'announceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'announceType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'announceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'announceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
          QAfterFilterCondition>
      announceTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'announceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
          QAfterFilterCondition>
      announceTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'announceType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'announceType',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> announceTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'announceType',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> deletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> deletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> deletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleted',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> dontShowTodayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dontShowToday',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> dontShowTodayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dontShowToday',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> dontShowTodayEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dontShowToday',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> dontShowTodayGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dontShowToday',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> dontShowTodayLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dontShowToday',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> dontShowTodayBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dontShowToday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> endMaintenanceAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endMaintenanceAt',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> endMaintenanceAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endMaintenanceAt',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> endMaintenanceAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endMaintenanceAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> endMaintenanceAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endMaintenanceAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> endMaintenanceAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endMaintenanceAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> endMaintenanceAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endMaintenanceAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> expireAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> expireAtGreaterThan(
    DateTime value, {
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> expireAtLessThan(
    DateTime value, {
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> expireAtBetween(
    DateTime lower,
    DateTime upper, {
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> imageLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'image',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'image',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'image',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> imageLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'image',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> imageLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'image',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> imageLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'image',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> isBroadcastedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isBroadcasted',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> isBroadcastedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isBroadcasted',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> isBroadcastedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBroadcasted',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> isExpiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpired',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> isUseBroadcastIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isUseBroadcast',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> isUseBroadcastIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isUseBroadcast',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> isUseBroadcastEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUseBroadcast',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
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

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> startMaintenanceAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startMaintenanceAt',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> startMaintenanceAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startMaintenanceAt',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> startMaintenanceAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startMaintenanceAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> startMaintenanceAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startMaintenanceAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> startMaintenanceAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startMaintenanceAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> startMaintenanceAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startMaintenanceAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> textIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> textIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> textLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'text',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'text',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'text',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> textLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'text',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> textLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'text',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> textLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'text',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension AnnouncementCollectionQueryObject on QueryBuilder<
    AnnouncementCollection, AnnouncementCollection, QFilterCondition> {
  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
          QAfterFilterCondition>
      imageElement(FilterQuery<AnnouncementDataModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'image');
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection,
      QAfterFilterCondition> textElement(FilterQuery<AnnouncementDataModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'text');
    });
  }
}

extension AnnouncementCollectionQueryLinks on QueryBuilder<
    AnnouncementCollection, AnnouncementCollection, QFilterCondition> {}

extension AnnouncementCollectionQuerySortBy
    on QueryBuilder<AnnouncementCollection, AnnouncementCollection, QSortBy> {
  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByAnnounceAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'announceAt', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByAnnounceAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'announceAt', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByAnnounceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'announceType', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByAnnounceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'announceType', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByDontShowToday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dontShowToday', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByDontShowTodayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dontShowToday', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByEndMaintenanceAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMaintenanceAt', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByEndMaintenanceAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMaintenanceAt', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByExpireAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByIsBroadcasted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBroadcasted', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByIsBroadcastedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBroadcasted', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByIsUseBroadcast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUseBroadcast', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByIsUseBroadcastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUseBroadcast', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByStartMaintenanceAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMaintenanceAt', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      sortByStartMaintenanceAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMaintenanceAt', Sort.desc);
    });
  }
}

extension AnnouncementCollectionQuerySortThenBy on QueryBuilder<
    AnnouncementCollection, AnnouncementCollection, QSortThenBy> {
  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByAnnounceAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'announceAt', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByAnnounceAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'announceAt', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByAnnounceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'announceType', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByAnnounceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'announceType', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByDontShowToday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dontShowToday', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByDontShowTodayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dontShowToday', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByEndMaintenanceAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMaintenanceAt', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByEndMaintenanceAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMaintenanceAt', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByExpireAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByIsBroadcasted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBroadcasted', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByIsBroadcastedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBroadcasted', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByIsUseBroadcast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUseBroadcast', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByIsUseBroadcastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUseBroadcast', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByStartMaintenanceAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMaintenanceAt', Sort.asc);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QAfterSortBy>
      thenByStartMaintenanceAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMaintenanceAt', Sort.desc);
    });
  }
}

extension AnnouncementCollectionQueryWhereDistinct
    on QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct> {
  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByAnnounceAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'announceAt');
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByAnnounceType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'announceType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deleted');
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByDontShowToday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dontShowToday');
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByEndMaintenanceAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endMaintenanceAt');
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expireAt');
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByIsBroadcasted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBroadcasted');
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpired');
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByIsUseBroadcast() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUseBroadcast');
    });
  }

  QueryBuilder<AnnouncementCollection, AnnouncementCollection, QDistinct>
      distinctByStartMaintenanceAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startMaintenanceAt');
    });
  }
}

extension AnnouncementCollectionQueryProperty on QueryBuilder<
    AnnouncementCollection, AnnouncementCollection, QQueryProperty> {
  QueryBuilder<AnnouncementCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<AnnouncementCollection, DateTime, QQueryOperations>
      announceAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'announceAt');
    });
  }

  QueryBuilder<AnnouncementCollection, String?, QQueryOperations>
      announceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'announceType');
    });
  }

  QueryBuilder<AnnouncementCollection, bool?, QQueryOperations>
      deletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deleted');
    });
  }

  QueryBuilder<AnnouncementCollection, DateTime?, QQueryOperations>
      dontShowTodayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dontShowToday');
    });
  }

  QueryBuilder<AnnouncementCollection, DateTime?, QQueryOperations>
      endMaintenanceAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endMaintenanceAt');
    });
  }

  QueryBuilder<AnnouncementCollection, DateTime, QQueryOperations>
      expireAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expireAt');
    });
  }

  QueryBuilder<AnnouncementCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnnouncementCollection, List<AnnouncementDataModel>?,
      QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<AnnouncementCollection, bool?, QQueryOperations>
      isBroadcastedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBroadcasted');
    });
  }

  QueryBuilder<AnnouncementCollection, bool, QQueryOperations>
      isExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpired');
    });
  }

  QueryBuilder<AnnouncementCollection, bool?, QQueryOperations>
      isUseBroadcastProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUseBroadcast');
    });
  }

  QueryBuilder<AnnouncementCollection, DateTime?, QQueryOperations>
      startMaintenanceAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startMaintenanceAt');
    });
  }

  QueryBuilder<AnnouncementCollection, List<AnnouncementDataModel>?,
      QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}
