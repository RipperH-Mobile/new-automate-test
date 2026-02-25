// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hold_chat_feature_flag_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const HoldChatFeatureFlagModelSchema = Schema(
  name: r'HoldChatFeatureFlagModel',
  id: 783877427615421694,
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
    r'withScroll': PropertySchema(
      id: 3,
      name: r'withScroll',
      type: IsarType.bool,
    )
  },
  estimateSize: _holdChatFeatureFlagModelEstimateSize,
  serialize: _holdChatFeatureFlagModelSerialize,
  deserialize: _holdChatFeatureFlagModelDeserialize,
  deserializeProp: _holdChatFeatureFlagModelDeserializeProp,
);

int _holdChatFeatureFlagModelEstimateSize(
  HoldChatFeatureFlagModel object,
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

void _holdChatFeatureFlagModelSerialize(
  HoldChatFeatureFlagModel object,
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
  writer.writeBool(offsets[3], object.withScroll);
}

HoldChatFeatureFlagModel _holdChatFeatureFlagModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HoldChatFeatureFlagModel(
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
    withScroll: reader.readBoolOrNull(offsets[3]),
  );
  return object;
}

P _holdChatFeatureFlagModelDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension HoldChatFeatureFlagModelQueryFilter on QueryBuilder<
    HoldChatFeatureFlagModel, HoldChatFeatureFlagModel, QFilterCondition> {
  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> compareThemeContentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> compareThemeContentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'compareThemeContent',
      ));
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> detailThemeContentModelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> detailThemeContentModelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'detailThemeContentModel',
      ));
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> withScrollIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'withScroll',
      ));
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> withScrollIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'withScroll',
      ));
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
      QAfterFilterCondition> withScrollEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'withScroll',
        value: value,
      ));
    });
  }
}

extension HoldChatFeatureFlagModelQueryObject on QueryBuilder<
    HoldChatFeatureFlagModel, HoldChatFeatureFlagModel, QFilterCondition> {
  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
          QAfterFilterCondition>
      compareThemeContent(FilterQuery<CompareThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'compareThemeContent');
    });
  }

  QueryBuilder<HoldChatFeatureFlagModel, HoldChatFeatureFlagModel,
          QAfterFilterCondition>
      detailThemeContentModel(FilterQuery<DetailThemeContentModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'detailThemeContentModel');
    });
  }
}
