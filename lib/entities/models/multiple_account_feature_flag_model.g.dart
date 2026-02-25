// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_account_feature_flag_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MultipleAccountFeatureFlagModelSchema = Schema(
  name: r'MultipleAccountFeatureFlagModel',
  id: 8994525522494640480,
  properties: {
    r'canHideFromList': PropertySchema(
      id: 0,
      name: r'canHideFromList',
      type: IsarType.bool,
    ),
    r'canUseShortCutPasscode': PropertySchema(
      id: 1,
      name: r'canUseShortCutPasscode',
      type: IsarType.bool,
    ),
    r'compareThemeContent': PropertySchema(
      id: 2,
      name: r'compareThemeContent',
      type: IsarType.object,
      target: r'CompareThemeContentModel',
    ),
    r'detailThemeContentModel': PropertySchema(
      id: 3,
      name: r'detailThemeContentModel',
      type: IsarType.object,
      target: r'DetailThemeContentModel',
    ),
    r'enabled': PropertySchema(
      id: 4,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'maxMultipleAccount': PropertySchema(
      id: 5,
      name: r'maxMultipleAccount',
      type: IsarType.long,
    )
  },
  estimateSize: _multipleAccountFeatureFlagModelEstimateSize,
  serialize: _multipleAccountFeatureFlagModelSerialize,
  deserialize: _multipleAccountFeatureFlagModelDeserialize,
  deserializeProp: _multipleAccountFeatureFlagModelDeserializeProp,
);

int _multipleAccountFeatureFlagModelEstimateSize(
  MultipleAccountFeatureFlagModel object,
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

void _multipleAccountFeatureFlagModelSerialize(
  MultipleAccountFeatureFlagModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.canHideFromList);
  writer.writeBool(offsets[1], object.canUseShortCutPasscode);
  writer.writeObject<CompareThemeContentModel>(
    offsets[2],
    allOffsets,
    CompareThemeContentModelSchema.serialize,
    object.compareThemeContent,
  );
  writer.writeObject<DetailThemeContentModel>(
    offsets[3],
    allOffsets,
    DetailThemeContentModelSchema.serialize,
    object.detailThemeContentModel,
  );
  writer.writeBool(offsets[4], object.enabled);
  writer.writeLong(offsets[5], object.maxMultipleAccount);
}

MultipleAccountFeatureFlagModel _multipleAccountFeatureFlagModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MultipleAccountFeatureFlagModel(
    canHideFromList: reader.readBoolOrNull(offsets[0]),
    canUseShortCutPasscode: reader.readBoolOrNull(offsets[1]),
    compareThemeContent: reader.readObjectOrNull<CompareThemeContentModel>(
      offsets[2],
      CompareThemeContentModelSchema.deserialize,
      allOffsets,
    ),
    detailThemeContentModel: reader.readObjectOrNull<DetailThemeContentModel>(
      offsets[3],
      DetailThemeContentModelSchema.deserialize,
      allOffsets,
    ),
    enabled: reader.readBoolOrNull(offsets[4]),
    maxMultipleAccount: reader.readLongOrNull(offsets[5]),
  );
  return object;
}

P _multipleAccountFeatureFlagModelDeserializeProp<P>(
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
      return (reader.readObjectOrNull<CompareThemeContentModel>(
        offset,
        CompareThemeContentModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readObjectOrNull<DetailThemeContentModel>(
        offset,
        DetailThemeContentModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MultipleAccountFeatureFlagModelQueryFilter on QueryBuilder<
    MultipleAccountFeatureFlagModel,
    MultipleAccountFeatureFlagModel,
    QFilterCondition> {
  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> canHideFromListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canHideFromList',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> canHideFromListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canHideFromList',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> canHideFromListEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canHideFromList',
        value: value,
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> canUseShortCutPasscodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canUseShortCutPasscode',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> canUseShortCutPasscodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canUseShortCutPasscode',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> canUseShortCutPasscodeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canUseShortCutPasscode',
        value: value,
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> compareThemeContentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> compareThemeContentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> detailThemeContentModelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> detailThemeContentModelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> maxMultipleAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxMultipleAccount',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> maxMultipleAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxMultipleAccount',
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> maxMultipleAccountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxMultipleAccount',
        value: value,
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> maxMultipleAccountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxMultipleAccount',
        value: value,
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> maxMultipleAccountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxMultipleAccount',
        value: value,
      ));
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
      QAfterFilterCondition> maxMultipleAccountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxMultipleAccount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MultipleAccountFeatureFlagModelQueryObject on QueryBuilder<
    MultipleAccountFeatureFlagModel,
    MultipleAccountFeatureFlagModel,
    QFilterCondition> {
  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
          QAfterFilterCondition>
      compareThemeContent(FilterQuery<CompareThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'compareThemeContent');
    });
  }

  QueryBuilder<MultipleAccountFeatureFlagModel, MultipleAccountFeatureFlagModel,
          QAfterFilterCondition>
      detailThemeContentModel(FilterQuery<DetailThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'detailThemeContentModel');
    });
  }
}
