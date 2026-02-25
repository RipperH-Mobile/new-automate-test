// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allow_friend_add_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AllowFriendAddModelSchema = Schema(
  name: r'AllowFriendAddModel',
  id: 1744637252187293039,
  properties: {
    r'canAddByPhoneNumber': PropertySchema(
      id: 0,
      name: r'canAddByPhoneNumber',
      type: IsarType.bool,
    ),
    r'canAddByUsername': PropertySchema(
      id: 1,
      name: r'canAddByUsername',
      type: IsarType.bool,
    ),
    r'canAddFromGroup': PropertySchema(
      id: 2,
      name: r'canAddFromGroup',
      type: IsarType.bool,
    ),
    r'enabled': PropertySchema(
      id: 3,
      name: r'enabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _allowFriendAddModelEstimateSize,
  serialize: _allowFriendAddModelSerialize,
  deserialize: _allowFriendAddModelDeserialize,
  deserializeProp: _allowFriendAddModelDeserializeProp,
);

int _allowFriendAddModelEstimateSize(
  AllowFriendAddModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _allowFriendAddModelSerialize(
  AllowFriendAddModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.canAddByPhoneNumber);
  writer.writeBool(offsets[1], object.canAddByUsername);
  writer.writeBool(offsets[2], object.canAddFromGroup);
  writer.writeBool(offsets[3], object.enabled);
}

AllowFriendAddModel _allowFriendAddModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AllowFriendAddModel(
    canAddByPhoneNumber: reader.readBoolOrNull(offsets[0]),
    canAddByUsername: reader.readBoolOrNull(offsets[1]),
    canAddFromGroup: reader.readBoolOrNull(offsets[2]),
    enabled: reader.readBoolOrNull(offsets[3]),
  );
  return object;
}

P _allowFriendAddModelDeserializeProp<P>(
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
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AllowFriendAddModelQueryFilter on QueryBuilder<AllowFriendAddModel,
    AllowFriendAddModel, QFilterCondition> {
  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      canAddByPhoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canAddByPhoneNumber',
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      canAddByPhoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canAddByPhoneNumber',
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      canAddByPhoneNumberEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canAddByPhoneNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      canAddByUsernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canAddByUsername',
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      canAddByUsernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canAddByUsername',
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      canAddByUsernameEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canAddByUsername',
        value: value,
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      canAddFromGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canAddFromGroup',
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      canAddFromGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canAddFromGroup',
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      canAddFromGroupEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canAddFromGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<AllowFriendAddModel, AllowFriendAddModel, QAfterFilterCondition>
      enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }
}

extension AllowFriendAddModelQueryObject on QueryBuilder<AllowFriendAddModel,
    AllowFriendAddModel, QFilterCondition> {}
