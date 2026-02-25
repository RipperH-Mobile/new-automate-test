// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_package_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPremiumPackageCollectionCollection on Isar {
  IsarCollection<PremiumPackageCollection> get premiumPackages =>
      this.collection();
}

const PremiumPackageCollectionSchema = CollectionSchema(
  name: r'PremiumPackage',
  id: -5520019934570381032,
  properties: {
    r'appleRef': PropertySchema(
      id: 0,
      name: r'appleRef',
      type: IsarType.string,
    ),
    r'compareTheme': PropertySchema(
      id: 1,
      name: r'compareTheme',
      type: IsarType.object,
      target: r'CompareThemeModel',
    ),
    r'dialogTheme': PropertySchema(
      id: 2,
      name: r'dialogTheme',
      type: IsarType.object,
      target: r'DialogThemeModel',
    ),
    r'features': PropertySchema(
      id: 3,
      name: r'features',
      type: IsarType.object,
      target: r'FeatureModel',
    ),
    r'googleRef': PropertySchema(
      id: 4,
      name: r'googleRef',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 5,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.string,
    ),
    r'isPublish': PropertySchema(
      id: 7,
      name: r'isPublish',
      type: IsarType.bool,
    ),
    r'level': PropertySchema(
      id: 8,
      name: r'level',
      type: IsarType.long,
    ),
    r'linkUrl': PropertySchema(
      id: 9,
      name: r'linkUrl',
      type: IsarType.string,
    ),
    r'monthlyPrice': PropertySchema(
      id: 10,
      name: r'monthlyPrice',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'packDetailTheme': PropertySchema(
      id: 12,
      name: r'packDetailTheme',
      type: IsarType.object,
      target: r'PackDetailThemeModel',
    ),
    r'storeTheme': PropertySchema(
      id: 13,
      name: r'storeTheme',
      type: IsarType.object,
      target: r'StoreThemeModel',
    ),
    r'updateAt': PropertySchema(
      id: 14,
      name: r'updateAt',
      type: IsarType.dateTime,
    ),
    r'yearlyPrice': PropertySchema(
      id: 15,
      name: r'yearlyPrice',
      type: IsarType.double,
    )
  },
  estimateSize: _premiumPackageCollectionEstimateSize,
  serialize: _premiumPackageCollectionSerialize,
  deserialize: _premiumPackageCollectionDeserialize,
  deserializeProp: _premiumPackageCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: false,
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
    r'FeatureModel': FeatureModelSchema,
    r'FeatureAbilitySecretRoomModel': FeatureAbilitySecretRoomModelSchema,
    r'CompareThemeContentModel': CompareThemeContentModelSchema,
    r'PremiumPackageLanguageModel': PremiumPackageLanguageModelSchema,
    r'DetailThemeContentModel': DetailThemeContentModelSchema,
    r'MultipleAccountFeatureFlagModel': MultipleAccountFeatureFlagModelSchema,
    r'FeatureAbilityPinModel': FeatureAbilityPinModelSchema,
    r'HoldChatFeatureFlagModel': HoldChatFeatureFlagModelSchema,
    r'FeatureFlagBase': FeatureFlagBaseSchema,
    r'ChatFolderFeatureFlagModel': ChatFolderFeatureFlagModelSchema,
    r'FeatureAbilityLiveLocationModel': FeatureAbilityLiveLocationModelSchema,
    r'CompareThemeModel': CompareThemeModelSchema,
    r'StoreThemeModel': StoreThemeModelSchema,
    r'PackDetailThemeModel': PackDetailThemeModelSchema,
    r'DialogThemeModel': DialogThemeModelSchema
  },
  getId: _premiumPackageCollectionGetId,
  getLinks: _premiumPackageCollectionGetLinks,
  attach: _premiumPackageCollectionAttach,
  version: '3.3.0-dev.3',
);

int _premiumPackageCollectionEstimateSize(
  PremiumPackageCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.appleRef;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.compareTheme;
    if (value != null) {
      bytesCount += 3 +
          CompareThemeModelSchema.estimateSize(
              value, allOffsets[CompareThemeModel]!, allOffsets);
    }
  }
  {
    final value = object.dialogTheme;
    if (value != null) {
      bytesCount += 3 +
          DialogThemeModelSchema.estimateSize(
              value, allOffsets[DialogThemeModel]!, allOffsets);
    }
  }
  {
    final value = object.features;
    if (value != null) {
      bytesCount += 3 +
          FeatureModelSchema.estimateSize(
              value, allOffsets[FeatureModel]!, allOffsets);
    }
  }
  {
    final value = object.googleRef;
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
    final value = object.linkUrl;
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
    final value = object.packDetailTheme;
    if (value != null) {
      bytesCount += 3 +
          PackDetailThemeModelSchema.estimateSize(
              value, allOffsets[PackDetailThemeModel]!, allOffsets);
    }
  }
  {
    final value = object.storeTheme;
    if (value != null) {
      bytesCount += 3 +
          StoreThemeModelSchema.estimateSize(
              value, allOffsets[StoreThemeModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _premiumPackageCollectionSerialize(
  PremiumPackageCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appleRef);
  writer.writeObject<CompareThemeModel>(
    offsets[1],
    allOffsets,
    CompareThemeModelSchema.serialize,
    object.compareTheme,
  );
  writer.writeObject<DialogThemeModel>(
    offsets[2],
    allOffsets,
    DialogThemeModelSchema.serialize,
    object.dialogTheme,
  );
  writer.writeObject<FeatureModel>(
    offsets[3],
    allOffsets,
    FeatureModelSchema.serialize,
    object.features,
  );
  writer.writeString(offsets[4], object.googleRef);
  writer.writeLong(offsets[5], object.hashCode);
  writer.writeString(offsets[6], object.id);
  writer.writeBool(offsets[7], object.isPublish);
  writer.writeLong(offsets[8], object.level);
  writer.writeString(offsets[9], object.linkUrl);
  writer.writeDouble(offsets[10], object.monthlyPrice);
  writer.writeString(offsets[11], object.name);
  writer.writeObject<PackDetailThemeModel>(
    offsets[12],
    allOffsets,
    PackDetailThemeModelSchema.serialize,
    object.packDetailTheme,
  );
  writer.writeObject<StoreThemeModel>(
    offsets[13],
    allOffsets,
    StoreThemeModelSchema.serialize,
    object.storeTheme,
  );
  writer.writeDateTime(offsets[14], object.updateAt);
  writer.writeDouble(offsets[15], object.yearlyPrice);
}

PremiumPackageCollection _premiumPackageCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PremiumPackageCollection(
    appleRef: reader.readStringOrNull(offsets[0]),
    compareTheme: reader.readObjectOrNull<CompareThemeModel>(
      offsets[1],
      CompareThemeModelSchema.deserialize,
      allOffsets,
    ),
    dialogTheme: reader.readObjectOrNull<DialogThemeModel>(
      offsets[2],
      DialogThemeModelSchema.deserialize,
      allOffsets,
    ),
    features: reader.readObjectOrNull<FeatureModel>(
      offsets[3],
      FeatureModelSchema.deserialize,
      allOffsets,
    ),
    googleRef: reader.readStringOrNull(offsets[4]),
    id: reader.readStringOrNull(offsets[6]),
    isPublish: reader.readBoolOrNull(offsets[7]),
    level: reader.readLongOrNull(offsets[8]),
    linkUrl: reader.readStringOrNull(offsets[9]),
    monthlyPrice: reader.readDoubleOrNull(offsets[10]),
    name: reader.readStringOrNull(offsets[11]),
    packDetailTheme: reader.readObjectOrNull<PackDetailThemeModel>(
      offsets[12],
      PackDetailThemeModelSchema.deserialize,
      allOffsets,
    ),
    storeTheme: reader.readObjectOrNull<StoreThemeModel>(
      offsets[13],
      StoreThemeModelSchema.deserialize,
      allOffsets,
    ),
    updateAt: reader.readDateTimeOrNull(offsets[14]),
    yearlyPrice: reader.readDoubleOrNull(offsets[15]),
  );
  return object;
}

P _premiumPackageCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<CompareThemeModel>(
        offset,
        CompareThemeModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readObjectOrNull<DialogThemeModel>(
        offset,
        DialogThemeModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readObjectOrNull<FeatureModel>(
        offset,
        FeatureModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readObjectOrNull<PackDetailThemeModel>(
        offset,
        PackDetailThemeModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 13:
      return (reader.readObjectOrNull<StoreThemeModel>(
        offset,
        StoreThemeModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 14:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _premiumPackageCollectionGetId(PremiumPackageCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _premiumPackageCollectionGetLinks(
    PremiumPackageCollection object) {
  return [];
}

void _premiumPackageCollectionAttach(
    IsarCollection<dynamic> col, Id id, PremiumPackageCollection object) {}

extension PremiumPackageCollectionByIndex
    on IsarCollection<PremiumPackageCollection> {
  Future<PremiumPackageCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  PremiumPackageCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<PremiumPackageCollection?>> getAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<PremiumPackageCollection?> getAllByIdSync(List<String?> idValues) {
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

  Future<Id> putById(PremiumPackageCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(PremiumPackageCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<PremiumPackageCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<PremiumPackageCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension PremiumPackageCollectionQueryWhereSort on QueryBuilder<
    PremiumPackageCollection, PremiumPackageCollection, QWhere> {
  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PremiumPackageCollectionQueryWhere on QueryBuilder<
    PremiumPackageCollection, PremiumPackageCollection, QWhereClause> {
  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterWhereClause> idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

extension PremiumPackageCollectionQueryFilter on QueryBuilder<
    PremiumPackageCollection, PremiumPackageCollection, QFilterCondition> {
  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'appleRef',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'appleRef',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appleRef',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
          QAfterFilterCondition>
      appleRefContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
          QAfterFilterCondition>
      appleRefMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appleRef',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleRef',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> appleRefIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appleRef',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> compareThemeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'compareTheme',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> compareThemeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'compareTheme',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> dialogThemeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dialogTheme',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> dialogThemeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dialogTheme',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> featuresIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'features',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> featuresIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'features',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'googleRef',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'googleRef',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'googleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'googleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'googleRef',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'googleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'googleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
          QAfterFilterCondition>
      googleRefContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'googleRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
          QAfterFilterCondition>
      googleRefMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'googleRef',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleRef',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> googleRefIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'googleRef',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> isPublishIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPublish',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> isPublishIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPublish',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> isPublishEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPublish',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> levelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'level',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> levelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'level',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> levelEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> levelGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> levelLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> levelBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'level',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkUrl',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkUrl',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
          QAfterFilterCondition>
      linkUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
          QAfterFilterCondition>
      linkUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'linkUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> linkUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'linkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> monthlyPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'monthlyPrice',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> monthlyPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'monthlyPrice',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> monthlyPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthlyPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> monthlyPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monthlyPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> monthlyPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monthlyPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> monthlyPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monthlyPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
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

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> packDetailThemeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'packDetailTheme',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> packDetailThemeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'packDetailTheme',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> storeThemeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'storeTheme',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> storeThemeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'storeTheme',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> updateAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updateAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> updateAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updateAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> updateAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> updateAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> updateAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> updateAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updateAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> yearlyPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'yearlyPrice',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> yearlyPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'yearlyPrice',
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> yearlyPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yearlyPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> yearlyPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yearlyPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> yearlyPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yearlyPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> yearlyPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yearlyPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PremiumPackageCollectionQueryObject on QueryBuilder<
    PremiumPackageCollection, PremiumPackageCollection, QFilterCondition> {
  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> compareTheme(FilterQuery<CompareThemeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'compareTheme');
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> dialogTheme(FilterQuery<DialogThemeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'dialogTheme');
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> features(FilterQuery<FeatureModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'features');
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
          QAfterFilterCondition>
      packDetailTheme(FilterQuery<PackDetailThemeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'packDetailTheme');
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection,
      QAfterFilterCondition> storeTheme(FilterQuery<StoreThemeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'storeTheme');
    });
  }
}

extension PremiumPackageCollectionQueryLinks on QueryBuilder<
    PremiumPackageCollection, PremiumPackageCollection, QFilterCondition> {}

extension PremiumPackageCollectionQuerySortBy on QueryBuilder<
    PremiumPackageCollection, PremiumPackageCollection, QSortBy> {
  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByAppleRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleRef', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByAppleRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleRef', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByGoogleRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleRef', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByGoogleRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleRef', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByIsPublishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByLinkUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkUrl', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByLinkUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkUrl', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByMonthlyPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPrice', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByMonthlyPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPrice', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByYearlyPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearlyPrice', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      sortByYearlyPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearlyPrice', Sort.desc);
    });
  }
}

extension PremiumPackageCollectionQuerySortThenBy on QueryBuilder<
    PremiumPackageCollection, PremiumPackageCollection, QSortThenBy> {
  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByAppleRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleRef', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByAppleRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleRef', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByGoogleRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleRef', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByGoogleRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleRef', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByIsPublishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByLinkUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkUrl', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByLinkUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkUrl', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByMonthlyPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPrice', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByMonthlyPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyPrice', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByYearlyPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearlyPrice', Sort.asc);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QAfterSortBy>
      thenByYearlyPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearlyPrice', Sort.desc);
    });
  }
}

extension PremiumPackageCollectionQueryWhereDistinct on QueryBuilder<
    PremiumPackageCollection, PremiumPackageCollection, QDistinct> {
  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByAppleRef({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appleRef', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByGoogleRef({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'googleRef', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPublish');
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'level');
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByLinkUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByMonthlyPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthlyPrice');
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateAt');
    });
  }

  QueryBuilder<PremiumPackageCollection, PremiumPackageCollection, QDistinct>
      distinctByYearlyPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yearlyPrice');
    });
  }
}

extension PremiumPackageCollectionQueryProperty on QueryBuilder<
    PremiumPackageCollection, PremiumPackageCollection, QQueryProperty> {
  QueryBuilder<PremiumPackageCollection, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<PremiumPackageCollection, String?, QQueryOperations>
      appleRefProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appleRef');
    });
  }

  QueryBuilder<PremiumPackageCollection, CompareThemeModel?, QQueryOperations>
      compareThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compareTheme');
    });
  }

  QueryBuilder<PremiumPackageCollection, DialogThemeModel?, QQueryOperations>
      dialogThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dialogTheme');
    });
  }

  QueryBuilder<PremiumPackageCollection, FeatureModel?, QQueryOperations>
      featuresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'features');
    });
  }

  QueryBuilder<PremiumPackageCollection, String?, QQueryOperations>
      googleRefProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'googleRef');
    });
  }

  QueryBuilder<PremiumPackageCollection, int, QQueryOperations>
      hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<PremiumPackageCollection, String?, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PremiumPackageCollection, bool?, QQueryOperations>
      isPublishProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPublish');
    });
  }

  QueryBuilder<PremiumPackageCollection, int?, QQueryOperations>
      levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'level');
    });
  }

  QueryBuilder<PremiumPackageCollection, String?, QQueryOperations>
      linkUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkUrl');
    });
  }

  QueryBuilder<PremiumPackageCollection, double?, QQueryOperations>
      monthlyPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthlyPrice');
    });
  }

  QueryBuilder<PremiumPackageCollection, String?, QQueryOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PremiumPackageCollection, PackDetailThemeModel?,
      QQueryOperations> packDetailThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'packDetailTheme');
    });
  }

  QueryBuilder<PremiumPackageCollection, StoreThemeModel?, QQueryOperations>
      storeThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storeTheme');
    });
  }

  QueryBuilder<PremiumPackageCollection, DateTime?, QQueryOperations>
      updateAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateAt');
    });
  }

  QueryBuilder<PremiumPackageCollection, double?, QQueryOperations>
      yearlyPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yearlyPrice');
    });
  }
}
