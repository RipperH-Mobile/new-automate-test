// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_settings_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FriendSettingsModelSchema = Schema(
  name: r'FriendSettingsModel',
  id: 1589029034108908949,
  properties: {
    r'allowFriendAdd': PropertySchema(
      id: 0,
      name: r'allowFriendAdd',
      type: IsarType.object,
      target: r'AllowFriendAddModel',
    ),
    r'canFriendSeeMyLastSeen': PropertySchema(
      id: 1,
      name: r'canFriendSeeMyLastSeen',
      type: IsarType.bool,
    ),
    r'enabled': PropertySchema(
      id: 2,
      name: r'enabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _friendSettingsModelEstimateSize,
  serialize: _friendSettingsModelSerialize,
  deserialize: _friendSettingsModelDeserialize,
  deserializeProp: _friendSettingsModelDeserializeProp,
);

int _friendSettingsModelEstimateSize(
  FriendSettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.allowFriendAdd;
    if (value != null) {
      bytesCount += 3 +
          AllowFriendAddModelSchema.estimateSize(
              value, allOffsets[AllowFriendAddModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _friendSettingsModelSerialize(
  FriendSettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<AllowFriendAddModel>(
    offsets[0],
    allOffsets,
    AllowFriendAddModelSchema.serialize,
    object.allowFriendAdd,
  );
  writer.writeBool(offsets[1], object.canFriendSeeMyLastSeen);
  writer.writeBool(offsets[2], object.enabled);
}

FriendSettingsModel _friendSettingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FriendSettingsModel(
    allowFriendAdd: reader.readObjectOrNull<AllowFriendAddModel>(
      offsets[0],
      AllowFriendAddModelSchema.deserialize,
      allOffsets,
    ),
    canFriendSeeMyLastSeen: reader.readBoolOrNull(offsets[1]),
    enabled: reader.readBoolOrNull(offsets[2]),
  );
  return object;
}

P _friendSettingsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<AllowFriendAddModel>(
        offset,
        AllowFriendAddModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FriendSettingsModelQueryFilter on QueryBuilder<FriendSettingsModel,
    FriendSettingsModel, QFilterCondition> {
  QueryBuilder<FriendSettingsModel, FriendSettingsModel, QAfterFilterCondition>
      allowFriendAddIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allowFriendAdd',
      ));
    });
  }

  QueryBuilder<FriendSettingsModel, FriendSettingsModel, QAfterFilterCondition>
      allowFriendAddIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allowFriendAdd',
      ));
    });
  }

  QueryBuilder<FriendSettingsModel, FriendSettingsModel, QAfterFilterCondition>
      canFriendSeeMyLastSeenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canFriendSeeMyLastSeen',
      ));
    });
  }

  QueryBuilder<FriendSettingsModel, FriendSettingsModel, QAfterFilterCondition>
      canFriendSeeMyLastSeenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canFriendSeeMyLastSeen',
      ));
    });
  }

  QueryBuilder<FriendSettingsModel, FriendSettingsModel, QAfterFilterCondition>
      canFriendSeeMyLastSeenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canFriendSeeMyLastSeen',
        value: value,
      ));
    });
  }

  QueryBuilder<FriendSettingsModel, FriendSettingsModel, QAfterFilterCondition>
      enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<FriendSettingsModel, FriendSettingsModel, QAfterFilterCondition>
      enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<FriendSettingsModel, FriendSettingsModel, QAfterFilterCondition>
      enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }
}

extension FriendSettingsModelQueryObject on QueryBuilder<FriendSettingsModel,
    FriendSettingsModel, QFilterCondition> {
  QueryBuilder<FriendSettingsModel, FriendSettingsModel, QAfterFilterCondition>
      allowFriendAdd(FilterQuery<AllowFriendAddModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'allowFriendAdd');
    });
  }
}
