// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_ability_live_location_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FeatureAbilityLiveLocationModelSchema = Schema(
  name: r'FeatureAbilityLiveLocationModel',
  id: -5249717140283701982,
  properties: {
    r'compareThemeContent': PropertySchema(
      id: 0,
      name: r'compareThemeContent',
      type: IsarType.object,
      target: r'CompareThemeContentModel',
    ),
    r'detailThemeContentModel': PropertySchema(
      id: 1,
      name: r'detailThemeContentModel',
      type: IsarType.object,
      target: r'DetailThemeContentModel',
    ),
    r'enabled': PropertySchema(
      id: 2,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'maxMinutes': PropertySchema(
      id: 3,
      name: r'maxMinutes',
      type: IsarType.long,
    )
  },
  estimateSize: _featureAbilityLiveLocationModelEstimateSize,
  serialize: _featureAbilityLiveLocationModelSerialize,
  deserialize: _featureAbilityLiveLocationModelDeserialize,
  deserializeProp: _featureAbilityLiveLocationModelDeserializeProp,
);

int _featureAbilityLiveLocationModelEstimateSize(
  FeatureAbilityLiveLocationModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.compareThemeContent;
    if (value != null) {
      bytesCount += 3 +
          CompareThemeContentModelSchema.estimateSize(
              value, allOffsets[CompareThemeContentModel]!, allOffsets);
    }
  }
  {
    final value = object.detailThemeContentModel;
    if (value != null) {
      bytesCount += 3 +
          DetailThemeContentModelSchema.estimateSize(
              value, allOffsets[DetailThemeContentModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _featureAbilityLiveLocationModelSerialize(
  FeatureAbilityLiveLocationModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<CompareThemeContentModel>(
    offsets[0],
    allOffsets,
    CompareThemeContentModelSchema.serialize,
    object.compareThemeContent,
  );
  writer.writeObject<DetailThemeContentModel>(
    offsets[1],
    allOffsets,
    DetailThemeContentModelSchema.serialize,
    object.detailThemeContentModel,
  );
  writer.writeBool(offsets[2], object.enabled);
  writer.writeLong(offsets[3], object.maxMinutes);
}

FeatureAbilityLiveLocationModel _featureAbilityLiveLocationModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FeatureAbilityLiveLocationModel(
    compareThemeContent: reader.readObjectOrNull<CompareThemeContentModel>(
      offsets[0],
      CompareThemeContentModelSchema.deserialize,
      allOffsets,
    ),
    detailThemeContentModel: reader.readObjectOrNull<DetailThemeContentModel>(
      offsets[1],
      DetailThemeContentModelSchema.deserialize,
      allOffsets,
    ),
    enabled: reader.readBoolOrNull(offsets[2]),
    maxMinutes: reader.readLongOrNull(offsets[3]),
  );
  return object;
}

P _featureAbilityLiveLocationModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<CompareThemeContentModel>(
        offset,
        CompareThemeContentModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectOrNull<DetailThemeContentModel>(
        offset,
        DetailThemeContentModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FeatureAbilityLiveLocationModelQueryFilter on QueryBuilder<
    FeatureAbilityLiveLocationModel,
    FeatureAbilityLiveLocationModel,
    QFilterCondition> {
  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> compareThemeContentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> compareThemeContentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> detailThemeContentModelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> detailThemeContentModelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> maxMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxMinutes',
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> maxMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxMinutes',
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> maxMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> maxMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> maxMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
      QAfterFilterCondition> maxMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FeatureAbilityLiveLocationModelQueryObject on QueryBuilder<
    FeatureAbilityLiveLocationModel,
    FeatureAbilityLiveLocationModel,
    QFilterCondition> {
  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
          QAfterFilterCondition>
      compareThemeContent(FilterQuery<CompareThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'compareThemeContent');
    });
  }

  QueryBuilder<FeatureAbilityLiveLocationModel, FeatureAbilityLiveLocationModel,
          QAfterFilterCondition>
      detailThemeContentModel(FilterQuery<DetailThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'detailThemeContentModel');
    });
  }
}
