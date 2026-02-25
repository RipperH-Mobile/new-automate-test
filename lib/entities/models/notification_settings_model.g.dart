// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const NotificationSettingsModelSchema = Schema(
  name: r'NotificationSettingsModel',
  id: -7076790955702268685,
  properties: {
    r'enabled': PropertySchema(
      id: 0,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'hiddenMessage': PropertySchema(
      id: 1,
      name: r'hiddenMessage',
      type: IsarType.bool,
    )
  },
  estimateSize: _notificationSettingsModelEstimateSize,
  serialize: _notificationSettingsModelSerialize,
  deserialize: _notificationSettingsModelDeserialize,
  deserializeProp: _notificationSettingsModelDeserializeProp,
);

int _notificationSettingsModelEstimateSize(
  NotificationSettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _notificationSettingsModelSerialize(
  NotificationSettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enabled);
  writer.writeBool(offsets[1], object.hiddenMessage);
}

NotificationSettingsModel _notificationSettingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotificationSettingsModel(
    enabled: reader.readBoolOrNull(offsets[0]),
    hiddenMessage: reader.readBoolOrNull(offsets[1]),
  );
  return object;
}

P _notificationSettingsModelDeserializeProp<P>(
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

extension NotificationSettingsModelQueryFilter on QueryBuilder<
    NotificationSettingsModel, NotificationSettingsModel, QFilterCondition> {
  QueryBuilder<NotificationSettingsModel, NotificationSettingsModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<NotificationSettingsModel, NotificationSettingsModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<NotificationSettingsModel, NotificationSettingsModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationSettingsModel, NotificationSettingsModel,
      QAfterFilterCondition> hiddenMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hiddenMessage',
      ));
    });
  }

  QueryBuilder<NotificationSettingsModel, NotificationSettingsModel,
      QAfterFilterCondition> hiddenMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hiddenMessage',
      ));
    });
  }

  QueryBuilder<NotificationSettingsModel, NotificationSettingsModel,
      QAfterFilterCondition> hiddenMessageEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hiddenMessage',
        value: value,
      ));
    });
  }
}

extension NotificationSettingsModelQueryObject on QueryBuilder<
    NotificationSettingsModel, NotificationSettingsModel, QFilterCondition> {}
