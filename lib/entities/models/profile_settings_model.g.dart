// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_settings_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ProfileSettingsModelSchema = Schema(
  name: r'ProfileSettingsModel',
  id: 153203607116319619,
  properties: {
    r'enabled': PropertySchema(
      id: 0,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'hiddenPhoneNumber': PropertySchema(
      id: 1,
      name: r'hiddenPhoneNumber',
      type: IsarType.bool,
    )
  },
  estimateSize: _profileSettingsModelEstimateSize,
  serialize: _profileSettingsModelSerialize,
  deserialize: _profileSettingsModelDeserialize,
  deserializeProp: _profileSettingsModelDeserializeProp,
);

int _profileSettingsModelEstimateSize(
  ProfileSettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _profileSettingsModelSerialize(
  ProfileSettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enabled);
  writer.writeBool(offsets[1], object.hiddenPhoneNumber);
}

ProfileSettingsModel _profileSettingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProfileSettingsModel(
    enabled: reader.readBoolOrNull(offsets[0]),
    hiddenPhoneNumber: reader.readBoolOrNull(offsets[1]),
  );
  return object;
}

P _profileSettingsModelDeserializeProp<P>(
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

extension ProfileSettingsModelQueryFilter on QueryBuilder<ProfileSettingsModel,
    ProfileSettingsModel, QFilterCondition> {
  QueryBuilder<ProfileSettingsModel, ProfileSettingsModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<ProfileSettingsModel, ProfileSettingsModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<ProfileSettingsModel, ProfileSettingsModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileSettingsModel, ProfileSettingsModel,
      QAfterFilterCondition> hiddenPhoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hiddenPhoneNumber',
      ));
    });
  }

  QueryBuilder<ProfileSettingsModel, ProfileSettingsModel,
      QAfterFilterCondition> hiddenPhoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hiddenPhoneNumber',
      ));
    });
  }

  QueryBuilder<ProfileSettingsModel, ProfileSettingsModel,
      QAfterFilterCondition> hiddenPhoneNumberEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hiddenPhoneNumber',
        value: value,
      ));
    });
  }
}

extension ProfileSettingsModelQueryObject on QueryBuilder<ProfileSettingsModel,
    ProfileSettingsModel, QFilterCondition> {}
