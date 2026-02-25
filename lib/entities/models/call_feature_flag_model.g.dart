// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_feature_flag_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CallFeatureFlagModelSchema = Schema(
  name: r'CallFeatureFlagModel',
  id: -6060268234795810272,
  properties: {
    r'enabled': PropertySchema(
      id: 0,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'isTest': PropertySchema(
      id: 1,
      name: r'isTest',
      type: IsarType.bool,
    )
  },
  estimateSize: _callFeatureFlagModelEstimateSize,
  serialize: _callFeatureFlagModelSerialize,
  deserialize: _callFeatureFlagModelDeserialize,
  deserializeProp: _callFeatureFlagModelDeserializeProp,
);

int _callFeatureFlagModelEstimateSize(
  CallFeatureFlagModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _callFeatureFlagModelSerialize(
  CallFeatureFlagModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enabled);
  writer.writeBool(offsets[1], object.isTest);
}

CallFeatureFlagModel _callFeatureFlagModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CallFeatureFlagModel(
    enabled: reader.readBoolOrNull(offsets[0]),
    isTest: reader.readBoolOrNull(offsets[1]),
  );
  return object;
}

P _callFeatureFlagModelDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CallFeatureFlagModelQueryFilter on QueryBuilder<CallFeatureFlagModel,
    CallFeatureFlagModel, QFilterCondition> {
  QueryBuilder<CallFeatureFlagModel, CallFeatureFlagModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<CallFeatureFlagModel, CallFeatureFlagModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<CallFeatureFlagModel, CallFeatureFlagModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<CallFeatureFlagModel, CallFeatureFlagModel,
      QAfterFilterCondition> isTestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isTest',
      ));
    });
  }

  QueryBuilder<CallFeatureFlagModel, CallFeatureFlagModel,
      QAfterFilterCondition> isTestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isTest',
      ));
    });
  }

  QueryBuilder<CallFeatureFlagModel, CallFeatureFlagModel,
      QAfterFilterCondition> isTestEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTest',
        value: value,
      ));
    });
  }
}

extension CallFeatureFlagModelQueryObject on QueryBuilder<CallFeatureFlagModel,
    CallFeatureFlagModel, QFilterCondition> {}
