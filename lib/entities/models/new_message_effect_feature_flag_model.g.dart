// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_message_effect_feature_flag_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const NewMessageEffectFeatureFlagModelSchema = Schema(
  name: r'NewMessageEffectFeatureFlagModel',
  id: -7499566821801059818,
  properties: {
    r'animation': PropertySchema(
      id: 0,
      name: r'animation',
      type: IsarType.bool,
    ),
    r'enabled': PropertySchema(
      id: 1,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'sound': PropertySchema(
      id: 2,
      name: r'sound',
      type: IsarType.bool,
    )
  },
  estimateSize: _newMessageEffectFeatureFlagModelEstimateSize,
  serialize: _newMessageEffectFeatureFlagModelSerialize,
  deserialize: _newMessageEffectFeatureFlagModelDeserialize,
  deserializeProp: _newMessageEffectFeatureFlagModelDeserializeProp,
);

int _newMessageEffectFeatureFlagModelEstimateSize(
  NewMessageEffectFeatureFlagModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _newMessageEffectFeatureFlagModelSerialize(
  NewMessageEffectFeatureFlagModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.animation);
  writer.writeBool(offsets[1], object.enabled);
  writer.writeBool(offsets[2], object.sound);
}

NewMessageEffectFeatureFlagModel _newMessageEffectFeatureFlagModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NewMessageEffectFeatureFlagModel(
    animation: reader.readBoolOrNull(offsets[0]),
    enabled: reader.readBoolOrNull(offsets[1]),
    sound: reader.readBoolOrNull(offsets[2]),
  );
  return object;
}

P _newMessageEffectFeatureFlagModelDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension NewMessageEffectFeatureFlagModelQueryFilter on QueryBuilder<
    NewMessageEffectFeatureFlagModel,
    NewMessageEffectFeatureFlagModel,
    QFilterCondition> {
  QueryBuilder<
      NewMessageEffectFeatureFlagModel,
      NewMessageEffectFeatureFlagModel,
      QAfterFilterCondition> animationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'animation',
      ));
    });
  }

  QueryBuilder<
      NewMessageEffectFeatureFlagModel,
      NewMessageEffectFeatureFlagModel,
      QAfterFilterCondition> animationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'animation',
      ));
    });
  }

  QueryBuilder<
      NewMessageEffectFeatureFlagModel,
      NewMessageEffectFeatureFlagModel,
      QAfterFilterCondition> animationEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animation',
        value: value,
      ));
    });
  }

  QueryBuilder<NewMessageEffectFeatureFlagModel,
      NewMessageEffectFeatureFlagModel, QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<
      NewMessageEffectFeatureFlagModel,
      NewMessageEffectFeatureFlagModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<
      NewMessageEffectFeatureFlagModel,
      NewMessageEffectFeatureFlagModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<NewMessageEffectFeatureFlagModel,
      NewMessageEffectFeatureFlagModel, QAfterFilterCondition> soundIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sound',
      ));
    });
  }

  QueryBuilder<
      NewMessageEffectFeatureFlagModel,
      NewMessageEffectFeatureFlagModel,
      QAfterFilterCondition> soundIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sound',
      ));
    });
  }

  QueryBuilder<
      NewMessageEffectFeatureFlagModel,
      NewMessageEffectFeatureFlagModel,
      QAfterFilterCondition> soundEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sound',
        value: value,
      ));
    });
  }
}

extension NewMessageEffectFeatureFlagModelQueryObject on QueryBuilder<
    NewMessageEffectFeatureFlagModel,
    NewMessageEffectFeatureFlagModel,
    QFilterCondition> {}
