// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_admin_permission_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const GroupAdminPermissionModelSchema = Schema(
  name: r'GroupAdminPermissionModel',
  id: -2858088864162055582,
  properties: {
    r'changeGroupInfo': PropertySchema(
      id: 0,
      name: r'changeGroupInfo',
      type: IsarType.bool,
    ),
    r'deleteOtherMessages': PropertySchema(
      id: 1,
      name: r'deleteOtherMessages',
      type: IsarType.bool,
    ),
    r'groupMemberSetting': PropertySchema(
      id: 2,
      name: r'groupMemberSetting',
      type: IsarType.bool,
    ),
    r'groupTypeInviteLinkSetting': PropertySchema(
      id: 3,
      name: r'groupTypeInviteLinkSetting',
      type: IsarType.bool,
    ),
    r'pinMessages': PropertySchema(
      id: 4,
      name: r'pinMessages',
      type: IsarType.bool,
    ),
    r'setGroupPermissions': PropertySchema(
      id: 5,
      name: r'setGroupPermissions',
      type: IsarType.bool,
    )
  },
  estimateSize: _groupAdminPermissionModelEstimateSize,
  serialize: _groupAdminPermissionModelSerialize,
  deserialize: _groupAdminPermissionModelDeserialize,
  deserializeProp: _groupAdminPermissionModelDeserializeProp,
);

int _groupAdminPermissionModelEstimateSize(
  GroupAdminPermissionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _groupAdminPermissionModelSerialize(
  GroupAdminPermissionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.changeGroupInfo);
  writer.writeBool(offsets[1], object.deleteOtherMessages);
  writer.writeBool(offsets[2], object.groupMemberSetting);
  writer.writeBool(offsets[3], object.groupTypeInviteLinkSetting);
  writer.writeBool(offsets[4], object.pinMessages);
  writer.writeBool(offsets[5], object.setGroupPermissions);
}

GroupAdminPermissionModel _groupAdminPermissionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroupAdminPermissionModel(
    changeGroupInfo: reader.readBoolOrNull(offsets[0]),
    deleteOtherMessages: reader.readBoolOrNull(offsets[1]),
    groupMemberSetting: reader.readBoolOrNull(offsets[2]),
    groupTypeInviteLinkSetting: reader.readBoolOrNull(offsets[3]),
    pinMessages: reader.readBoolOrNull(offsets[4]),
    setGroupPermissions: reader.readBoolOrNull(offsets[5]),
  );
  return object;
}

P _groupAdminPermissionModelDeserializeProp<P>(
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
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension GroupAdminPermissionModelQueryFilter on QueryBuilder<
    GroupAdminPermissionModel, GroupAdminPermissionModel, QFilterCondition> {
  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> changeGroupInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'changeGroupInfo',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> changeGroupInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'changeGroupInfo',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> changeGroupInfoEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'changeGroupInfo',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> deleteOtherMessagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deleteOtherMessages',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> deleteOtherMessagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deleteOtherMessages',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> deleteOtherMessagesEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleteOtherMessages',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> groupMemberSettingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupMemberSetting',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> groupMemberSettingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupMemberSetting',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> groupMemberSettingEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupMemberSetting',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> groupTypeInviteLinkSettingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupTypeInviteLinkSetting',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> groupTypeInviteLinkSettingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupTypeInviteLinkSetting',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> groupTypeInviteLinkSettingEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupTypeInviteLinkSetting',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> pinMessagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pinMessages',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> pinMessagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pinMessages',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> pinMessagesEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pinMessages',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> setGroupPermissionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'setGroupPermissions',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> setGroupPermissionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'setGroupPermissions',
      ));
    });
  }

  QueryBuilder<GroupAdminPermissionModel, GroupAdminPermissionModel,
      QAfterFilterCondition> setGroupPermissionsEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'setGroupPermissions',
        value: value,
      ));
    });
  }
}

extension GroupAdminPermissionModelQueryObject on QueryBuilder<
    GroupAdminPermissionModel, GroupAdminPermissionModel, QFilterCondition> {}
