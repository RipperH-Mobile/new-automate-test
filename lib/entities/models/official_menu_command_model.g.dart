// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'official_menu_command_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const OfficialMenuCommandModelSchema = Schema(
  name: r'OfficialMenuCommandModel',
  id: 8810720564207062300,
  properties: {
    r'arg': PropertySchema(
      id: 0,
      name: r'arg',
      type: IsarType.object,
      target: r'OfficialMenuCommandArgModel',
    ),
    r'command': PropertySchema(
      id: 1,
      name: r'command',
      type: IsarType.string,
    ),
    r'height': PropertySchema(
      id: 2,
      name: r'height',
      type: IsarType.double,
    ),
    r'imageFileId': PropertySchema(
      id: 3,
      name: r'imageFileId',
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
    r'isJoinGroup': PropertySchema(
      id: 6,
      name: r'isJoinGroup',
      type: IsarType.bool,
    ),
    r'width': PropertySchema(
      id: 7,
      name: r'width',
      type: IsarType.double,
    ),
    r'x': PropertySchema(
      id: 8,
      name: r'x',
      type: IsarType.long,
    ),
    r'y': PropertySchema(
      id: 9,
      name: r'y',
      type: IsarType.long,
    )
  },
  estimateSize: _officialMenuCommandModelEstimateSize,
  serialize: _officialMenuCommandModelSerialize,
  deserialize: _officialMenuCommandModelDeserialize,
  deserializeProp: _officialMenuCommandModelDeserializeProp,
);

int _officialMenuCommandModelEstimateSize(
  OfficialMenuCommandModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.arg;
    if (value != null) {
      bytesCount += 3 +
          OfficialMenuCommandArgModelSchema.estimateSize(
              value, allOffsets[OfficialMenuCommandArgModel]!, allOffsets);
    }
  }
  {
    final value = object.command;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imageFileId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _officialMenuCommandModelSerialize(
  OfficialMenuCommandModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<OfficialMenuCommandArgModel>(
    offsets[0],
    allOffsets,
    OfficialMenuCommandArgModelSchema.serialize,
    object.arg,
  );
  writer.writeString(offsets[1], object.command);
  writer.writeDouble(offsets[2], object.height);
  writer.writeString(offsets[3], object.imageFileId);
  writer.writeBool(offsets[4], object.isCmdAddFriendAndChat);
  writer.writeBool(offsets[5], object.isCmdOpenUrl);
  writer.writeBool(offsets[6], object.isJoinGroup);
  writer.writeDouble(offsets[7], object.width);
  writer.writeLong(offsets[8], object.x);
  writer.writeLong(offsets[9], object.y);
}

OfficialMenuCommandModel _officialMenuCommandModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OfficialMenuCommandModel(
    command: reader.readStringOrNull(offsets[1]),
    height: reader.readDoubleOrNull(offsets[2]),
    imageFileId: reader.readStringOrNull(offsets[3]),
    width: reader.readDoubleOrNull(offsets[7]),
  );
  object.arg = reader.readObjectOrNull<OfficialMenuCommandArgModel>(
    offsets[0],
    OfficialMenuCommandArgModelSchema.deserialize,
    allOffsets,
  );
  object.x = reader.readLongOrNull(offsets[8]);
  object.y = reader.readLongOrNull(offsets[9]);
  return object;
}

P _officialMenuCommandModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<OfficialMenuCommandArgModel>(
        offset,
        OfficialMenuCommandArgModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension OfficialMenuCommandModelQueryFilter on QueryBuilder<
    OfficialMenuCommandModel, OfficialMenuCommandModel, QFilterCondition> {
  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> argIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'arg',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> argIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'arg',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'command',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'command',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandEqualTo(
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

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandGreaterThan(
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

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandLessThan(
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

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandBetween(
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

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandStartsWith(
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

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandEndsWith(
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

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
          QAfterFilterCondition>
      commandContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'command',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
          QAfterFilterCondition>
      commandMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'command',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'command',
        value: '',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> commandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'command',
        value: '',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> heightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> heightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> heightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> heightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageFileId',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageFileId',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageFileId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
          QAfterFilterCondition>
      imageFileIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
          QAfterFilterCondition>
      imageFileIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageFileId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFileId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> imageFileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageFileId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> isCmdAddFriendAndChatEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCmdAddFriendAndChat',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> isCmdOpenUrlEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCmdOpenUrl',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> isJoinGroupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isJoinGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> widthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> widthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> widthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> widthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> widthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> widthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> xIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'x',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> xIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'x',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> xEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'x',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> xGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'x',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> xLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'x',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> xBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'x',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> yIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'y',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> yIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'y',
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> yEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'y',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> yGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'y',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> yLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'y',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> yBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'y',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OfficialMenuCommandModelQueryObject on QueryBuilder<
    OfficialMenuCommandModel, OfficialMenuCommandModel, QFilterCondition> {
  QueryBuilder<OfficialMenuCommandModel, OfficialMenuCommandModel,
      QAfterFilterCondition> arg(FilterQuery<OfficialMenuCommandArgModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'arg');
    });
  }
}
