// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_role_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const GroupMemberRoleModelSchema = Schema(
  name: r'GroupMemberRoleModel',
  id: -8884027497455478536,
  properties: {
    r'customAdminName': PropertySchema(
      id: 0,
      name: r'customAdminName',
      type: IsarType.string,
    ),
    r'permissions': PropertySchema(
      id: 1,
      name: r'permissions',
      type: IsarType.object,
      target: r'GroupAdminPermissionModel',
    ),
    r'role': PropertySchema(
      id: 2,
      name: r'role',
      type: IsarType.string,
      enumMap: _GroupMemberRoleModelroleEnumValueMap,
    )
  },
  estimateSize: _groupMemberRoleModelEstimateSize,
  serialize: _groupMemberRoleModelSerialize,
  deserialize: _groupMemberRoleModelDeserialize,
  deserializeProp: _groupMemberRoleModelDeserializeProp,
);

int _groupMemberRoleModelEstimateSize(
  GroupMemberRoleModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.customAdminName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.permissions;
    if (value != null) {
      bytesCount += 3 +
          GroupAdminPermissionModelSchema.estimateSize(
              value, allOffsets[GroupAdminPermissionModel]!, allOffsets);
    }
  }
  {
    final value = object.role;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _groupMemberRoleModelSerialize(
  GroupMemberRoleModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.customAdminName);
  writer.writeObject<GroupAdminPermissionModel>(
    offsets[1],
    allOffsets,
    GroupAdminPermissionModelSchema.serialize,
    object.permissions,
  );
  writer.writeString(offsets[2], object.role?.name);
}

GroupMemberRoleModel _groupMemberRoleModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroupMemberRoleModel(
    customAdminName: reader.readStringOrNull(offsets[0]),
    permissions: reader.readObjectOrNull<GroupAdminPermissionModel>(
      offsets[1],
      GroupAdminPermissionModelSchema.deserialize,
      allOffsets,
    ),
    role: _GroupMemberRoleModelroleValueEnumMap[
        reader.readStringOrNull(offsets[2])],
  );
  return object;
}

P _groupMemberRoleModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<GroupAdminPermissionModel>(
        offset,
        GroupAdminPermissionModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (_GroupMemberRoleModelroleValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _GroupMemberRoleModelroleEnumValueMap = {
  r'owner': r'owner',
  r'admin': r'admin',
  r'member': r'member',
};
const _GroupMemberRoleModelroleValueEnumMap = {
  r'owner': RoomMemberRole.owner,
  r'admin': RoomMemberRole.admin,
  r'member': RoomMemberRole.member,
};

extension GroupMemberRoleModelQueryFilter on QueryBuilder<GroupMemberRoleModel,
    GroupMemberRoleModel, QFilterCondition> {
  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customAdminName',
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customAdminName',
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customAdminName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customAdminName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customAdminName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customAdminName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customAdminName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customAdminName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
          QAfterFilterCondition>
      customAdminNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customAdminName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
          QAfterFilterCondition>
      customAdminNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customAdminName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customAdminName',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> customAdminNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customAdminName',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> permissionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'permissions',
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> permissionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'permissions',
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'role',
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'role',
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleEqualTo(
    RoomMemberRole? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleGreaterThan(
    RoomMemberRole? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleLessThan(
    RoomMemberRole? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleBetween(
    RoomMemberRole? lower,
    RoomMemberRole? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'role',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
          QAfterFilterCondition>
      roleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
          QAfterFilterCondition>
      roleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'role',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
      QAfterFilterCondition> roleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'role',
        value: '',
      ));
    });
  }
}

extension GroupMemberRoleModelQueryObject on QueryBuilder<GroupMemberRoleModel,
    GroupMemberRoleModel, QFilterCondition> {
  QueryBuilder<GroupMemberRoleModel, GroupMemberRoleModel,
          QAfterFilterCondition>
      permissions(FilterQuery<GroupAdminPermissionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'permissions');
    });
  }
}
