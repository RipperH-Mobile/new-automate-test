// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_menu_action_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RoomMenuActionModelSchema = Schema(
  name: r'RoomMenuActionModel',
  id: -610762679772283643,
  properties: {
    r'command': PropertySchema(
      id: 0,
      name: r'command',
      type: IsarType.string,
    ),
    r'commandArg': PropertySchema(
      id: 1,
      name: r'commandArg',
      type: IsarType.object,
      target: r'RoomMenuCommandArgModel',
    ),
    r'commandHumanName': PropertySchema(
      id: 2,
      name: r'commandHumanName',
      type: IsarType.string,
    ),
    r'commandHumanValue': PropertySchema(
      id: 3,
      name: r'commandHumanValue',
      type: IsarType.string,
    ),
    r'isCmdAddFriendAndChat': PropertySchema(
      id: 4,
      name: r'isCmdAddFriendAndChat',
      type: IsarType.bool,
    ),
    r'isCmdOpenUrl': PropertySchema(
      id: 5,
      name: r'isCmdOpenUrl',
      type: IsarType.bool,
    ),
    r'isEmptyCommand': PropertySchema(
      id: 6,
      name: r'isEmptyCommand',
      type: IsarType.bool,
    ),
    r'isJoinGroup': PropertySchema(
      id: 7,
      name: r'isJoinGroup',
      type: IsarType.bool,
    ),
    r'title': PropertySchema(
      id: 8,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _roomMenuActionModelEstimateSize,
  serialize: _roomMenuActionModelSerialize,
  deserialize: _roomMenuActionModelDeserialize,
  deserializeProp: _roomMenuActionModelDeserializeProp,
);

int _roomMenuActionModelEstimateSize(
  RoomMenuActionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.command;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.commandArg;
    if (value != null) {
      bytesCount += 3 +
          RoomMenuCommandArgModelSchema.estimateSize(
              value, allOffsets[RoomMenuCommandArgModel]!, allOffsets);
    }
  }
  {
    final value = object.commandHumanName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.commandHumanValue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _roomMenuActionModelSerialize(
  RoomMenuActionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.command);
  writer.writeObject<RoomMenuCommandArgModel>(
    offsets[1],
    allOffsets,
    RoomMenuCommandArgModelSchema.serialize,
    object.commandArg,
  );
  writer.writeString(offsets[2], object.commandHumanName);
  writer.writeString(offsets[3], object.commandHumanValue);
  writer.writeBool(offsets[4], object.isCmdAddFriendAndChat);
  writer.writeBool(offsets[5], object.isCmdOpenUrl);
  writer.writeBool(offsets[6], object.isEmptyCommand);
  writer.writeBool(offsets[7], object.isJoinGroup);
  writer.writeString(offsets[8], object.title);
}

RoomMenuActionModel _roomMenuActionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomMenuActionModel(
    command: reader.readStringOrNull(offsets[0]),
    commandArg: reader.readObjectOrNull<RoomMenuCommandArgModel>(
      offsets[1],
      RoomMenuCommandArgModelSchema.deserialize,
      allOffsets,
    ),
    title: reader.readStringOrNull(offsets[8]),
  );
  return object;
}

P _roomMenuActionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<RoomMenuCommandArgModel>(
        offset,
        RoomMenuCommandArgModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RoomMenuActionModelQueryFilter on QueryBuilder<RoomMenuActionModel,
    RoomMenuActionModel, QFilterCondition> {
  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'command',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'command',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'command',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'command',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'command',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'command',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'command',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'command',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'command',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'command',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'command',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'command',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandArgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'commandArg',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandArgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'commandArg',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'commandHumanName',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'commandHumanName',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commandHumanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commandHumanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commandHumanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commandHumanName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commandHumanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commandHumanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commandHumanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commandHumanName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commandHumanName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commandHumanName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'commandHumanValue',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'commandHumanValue',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commandHumanValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commandHumanValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commandHumanValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commandHumanValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commandHumanValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commandHumanValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commandHumanValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commandHumanValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commandHumanValue',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandHumanValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commandHumanValue',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      isCmdAddFriendAndChatEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCmdAddFriendAndChat',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      isCmdOpenUrlEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCmdOpenUrl',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      isEmptyCommandEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEmptyCommand',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      isJoinGroupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isJoinGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension RoomMenuActionModelQueryObject on QueryBuilder<RoomMenuActionModel,
    RoomMenuActionModel, QFilterCondition> {
  QueryBuilder<RoomMenuActionModel, RoomMenuActionModel, QAfterFilterCondition>
      commandArg(FilterQuery<RoomMenuCommandArgModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'commandArg');
    });
  }
}
