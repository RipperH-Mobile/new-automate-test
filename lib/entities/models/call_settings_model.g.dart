// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_settings_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CallSettingsModelSchema = Schema(
  name: r'CallSettingsModel',
  id: -8373543570283084476,
  properties: {
    r'allowCallKit': PropertySchema(
      id: 0,
      name: r'allowCallKit',
      type: IsarType.bool,
    ),
    r'allowIncomingCall': PropertySchema(
      id: 1,
      name: r'allowIncomingCall',
      type: IsarType.bool,
    ),
    r'enabled': PropertySchema(
      id: 2,
      name: r'enabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _callSettingsModelEstimateSize,
  serialize: _callSettingsModelSerialize,
  deserialize: _callSettingsModelDeserialize,
  deserializeProp: _callSettingsModelDeserializeProp,
);

int _callSettingsModelEstimateSize(
  CallSettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _callSettingsModelSerialize(
  CallSettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.allowCallKit);
  writer.writeBool(offsets[1], object.allowIncomingCall);
  writer.writeBool(offsets[2], object.enabled);
}

CallSettingsModel _callSettingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CallSettingsModel(
    allowCallKit: reader.readBoolOrNull(offsets[0]),
    allowIncomingCall: reader.readBoolOrNull(offsets[1]),
    enabled: reader.readBoolOrNull(offsets[2]),
  );
  return object;
}

P _callSettingsModelDeserializeProp<P>(
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

extension CallSettingsModelQueryFilter
    on QueryBuilder<CallSettingsModel, CallSettingsModel, QFilterCondition> {
  QueryBuilder<CallSettingsModel, CallSettingsModel, QAfterFilterCondition>
      allowCallKitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allowCallKit',
      ));
    });
  }

  QueryBuilder<CallSettingsModel, CallSettingsModel, QAfterFilterCondition>
      allowCallKitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allowCallKit',
      ));
    });
  }

  QueryBuilder<CallSettingsModel, CallSettingsModel, QAfterFilterCondition>
      allowCallKitEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowCallKit',
        value: value,
      ));
    });
  }

  QueryBuilder<CallSettingsModel, CallSettingsModel, QAfterFilterCondition>
      allowIncomingCallIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allowIncomingCall',
      ));
    });
  }

  QueryBuilder<CallSettingsModel, CallSettingsModel, QAfterFilterCondition>
      allowIncomingCallIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allowIncomingCall',
      ));
    });
  }

  QueryBuilder<CallSettingsModel, CallSettingsModel, QAfterFilterCondition>
      allowIncomingCallEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowIncomingCall',
        value: value,
      ));
    });
  }

  QueryBuilder<CallSettingsModel, CallSettingsModel, QAfterFilterCondition>
      enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<CallSettingsModel, CallSettingsModel, QAfterFilterCondition>
      enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<CallSettingsModel, CallSettingsModel, QAfterFilterCondition>
      enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }
}

extension CallSettingsModelQueryObject
    on QueryBuilder<CallSettingsModel, CallSettingsModel, QFilterCondition> {}
