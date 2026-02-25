// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_ability_pin_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FeatureAbilityPinModelSchema = Schema(
  name: r'FeatureAbilityPinModel',
  id: 920081658487227120,
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
    r'maxPin': PropertySchema(
      id: 3,
      name: r'maxPin',
      type: IsarType.long,
    )
  },
  estimateSize: _featureAbilityPinModelEstimateSize,
  serialize: _featureAbilityPinModelSerialize,
  deserialize: _featureAbilityPinModelDeserialize,
  deserializeProp: _featureAbilityPinModelDeserializeProp,
);

int _featureAbilityPinModelEstimateSize(
  FeatureAbilityPinModel object,
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

void _featureAbilityPinModelSerialize(
  FeatureAbilityPinModel object,
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
  writer.writeLong(offsets[3], object.maxPin);
}

FeatureAbilityPinModel _featureAbilityPinModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FeatureAbilityPinModel(
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
    maxPin: reader.readLongOrNull(offsets[3]),
  );
  return object;
}

P _featureAbilityPinModelDeserializeProp<P>(
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

extension FeatureAbilityPinModelQueryFilter on QueryBuilder<
    FeatureAbilityPinModel, FeatureAbilityPinModel, QFilterCondition> {
  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> compareThemeContentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> compareThemeContentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> detailThemeContentModelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> detailThemeContentModelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> maxPinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxPin',
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> maxPinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxPin',
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> maxPinEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxPin',
        value: value,
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> maxPinGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxPin',
        value: value,
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> maxPinLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxPin',
        value: value,
      ));
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
      QAfterFilterCondition> maxPinBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxPin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FeatureAbilityPinModelQueryObject on QueryBuilder<
    FeatureAbilityPinModel, FeatureAbilityPinModel, QFilterCondition> {
  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
          QAfterFilterCondition>
      compareThemeContent(FilterQuery<CompareThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'compareThemeContent');
    });
  }

  QueryBuilder<FeatureAbilityPinModel, FeatureAbilityPinModel,
          QAfterFilterCondition>
      detailThemeContentModel(FilterQuery<DetailThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'detailThemeContentModel');
    });
  }
}
