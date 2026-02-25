// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_settings_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SecuritySettingsModelSchema = Schema(
  name: r'SecuritySettingsModel',
  id: 1957035959270028785,
  properties: {
    r'allowMultiFactor': PropertySchema(
      id: 0,
      name: r'allowMultiFactor',
      type: IsarType.bool,
    ),
    r'enabled': PropertySchema(
      id: 1,
      name: r'enabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _securitySettingsModelEstimateSize,
  serialize: _securitySettingsModelSerialize,
  deserialize: _securitySettingsModelDeserialize,
  deserializeProp: _securitySettingsModelDeserializeProp,
);

int _securitySettingsModelEstimateSize(
  SecuritySettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _securitySettingsModelSerialize(
  SecuritySettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.allowMultiFactor);
  writer.writeBool(offsets[1], object.enabled);
}

SecuritySettingsModel _securitySettingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SecuritySettingsModel(
    allowMultiFactor: reader.readBoolOrNull(offsets[0]),
    enabled: reader.readBoolOrNull(offsets[1]),
  );
  return object;
}

P _securitySettingsModelDeserializeProp<P>(
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

extension SecuritySettingsModelQueryFilter on QueryBuilder<
    SecuritySettingsModel, SecuritySettingsModel, QFilterCondition> {
  QueryBuilder<SecuritySettingsModel, SecuritySettingsModel,
      QAfterFilterCondition> allowMultiFactorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allowMultiFactor',
      ));
    });
  }

  QueryBuilder<SecuritySettingsModel, SecuritySettingsModel,
      QAfterFilterCondition> allowMultiFactorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allowMultiFactor',
      ));
    });
  }

  QueryBuilder<SecuritySettingsModel, SecuritySettingsModel,
      QAfterFilterCondition> allowMultiFactorEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowMultiFactor',
        value: value,
      ));
    });
  }

  QueryBuilder<SecuritySettingsModel, SecuritySettingsModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<SecuritySettingsModel, SecuritySettingsModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<SecuritySettingsModel, SecuritySettingsModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }
}

extension SecuritySettingsModelQueryObject on QueryBuilder<
    SecuritySettingsModel, SecuritySettingsModel, QFilterCondition> {}
