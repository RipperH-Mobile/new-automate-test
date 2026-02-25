// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rich_menu_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RichMenuModelSchema = Schema(
  name: r'RichMenuModel',
  id: -7772033031332349856,
  properties: {
    r'hasPublishedMenu': PropertySchema(
      id: 0,
      name: r'hasPublishedMenu',
      type: IsarType.bool,
    ),
    r'officialAccountId': PropertySchema(
      id: 1,
      name: r'officialAccountId',
      type: IsarType.string,
    ),
    r'publishMenu': PropertySchema(
      id: 2,
      name: r'publishMenu',
      type: IsarType.object,
      target: r'RichMenuPublishModel',
    ),
    r'publishedAt': PropertySchema(
      id: 3,
      name: r'publishedAt',
      type: IsarType.dateTime,
    ),
    r'updatedAt': PropertySchema(
      id: 4,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _richMenuModelEstimateSize,
  serialize: _richMenuModelSerialize,
  deserialize: _richMenuModelDeserialize,
  deserializeProp: _richMenuModelDeserializeProp,
);

int _richMenuModelEstimateSize(
  RichMenuModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.officialAccountId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.publishMenu;
    if (value != null) {
      bytesCount += 3 +
          RichMenuPublishModelSchema.estimateSize(
              value, allOffsets[RichMenuPublishModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _richMenuModelSerialize(
  RichMenuModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.hasPublishedMenu);
  writer.writeString(offsets[1], object.officialAccountId);
  writer.writeObject<RichMenuPublishModel>(
    offsets[2],
    allOffsets,
    RichMenuPublishModelSchema.serialize,
    object.publishMenu,
  );
  writer.writeDateTime(offsets[3], object.publishedAt);
  writer.writeDateTime(offsets[4], object.updatedAt);
}

RichMenuModel _richMenuModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RichMenuModel(
    officialAccountId: reader.readStringOrNull(offsets[1]),
    publishMenu: reader.readObjectOrNull<RichMenuPublishModel>(
      offsets[2],
      RichMenuPublishModelSchema.deserialize,
      allOffsets,
    ),
    publishedAt: reader.readDateTimeOrNull(offsets[3]),
    updatedAt: reader.readDateTimeOrNull(offsets[4]),
  );
  return object;
}

P _richMenuModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<RichMenuPublishModel>(
        offset,
        RichMenuPublishModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RichMenuModelQueryFilter
    on QueryBuilder<RichMenuModel, RichMenuModel, QFilterCondition> {
  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      hasPublishedMenuEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasPublishedMenu',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'officialAccountId',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'officialAccountId',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officialAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'officialAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'officialAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'officialAccountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'officialAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'officialAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'officialAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'officialAccountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officialAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      officialAccountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'officialAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      publishMenuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'publishMenu',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      publishMenuIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'publishMenu',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      publishedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'publishedAt',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      publishedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'publishedAt',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      publishedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      publishedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'publishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      publishedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'publishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      publishedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'publishedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RichMenuModelQueryObject
    on QueryBuilder<RichMenuModel, RichMenuModel, QFilterCondition> {
  QueryBuilder<RichMenuModel, RichMenuModel, QAfterFilterCondition> publishMenu(
      FilterQuery<RichMenuPublishModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'publishMenu');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RichMenuPublishModelSchema = Schema(
  name: r'RichMenuPublishModel',
  id: 6272546856970551100,
  properties: {
    r'actions': PropertySchema(
      id: 0,
      name: r'actions',
      type: IsarType.objectList,
      target: r'RichMenuFunctionModel',
    ),
    r'container': PropertySchema(
      id: 1,
      name: r'container',
      type: IsarType.object,
      target: r'RichMenuContainerModel',
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    )
  },
  estimateSize: _richMenuPublishModelEstimateSize,
  serialize: _richMenuPublishModelSerialize,
  deserialize: _richMenuPublishModelDeserialize,
  deserializeProp: _richMenuPublishModelDeserializeProp,
);

int _richMenuPublishModelEstimateSize(
  RichMenuPublishModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.actions;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[RichMenuFunctionModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += RichMenuFunctionModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.container;
    if (value != null) {
      bytesCount += 3 +
          RichMenuContainerModelSchema.estimateSize(
              value, allOffsets[RichMenuContainerModel]!, allOffsets);
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _richMenuPublishModelSerialize(
  RichMenuPublishModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<RichMenuFunctionModel>(
    offsets[0],
    allOffsets,
    RichMenuFunctionModelSchema.serialize,
    object.actions,
  );
  writer.writeObject<RichMenuContainerModel>(
    offsets[1],
    allOffsets,
    RichMenuContainerModelSchema.serialize,
    object.container,
  );
  writer.writeString(offsets[2], object.id);
}

RichMenuPublishModel _richMenuPublishModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RichMenuPublishModel(
    actions: reader.readObjectList<RichMenuFunctionModel>(
      offsets[0],
      RichMenuFunctionModelSchema.deserialize,
      allOffsets,
      RichMenuFunctionModel(),
    ),
    container: reader.readObjectOrNull<RichMenuContainerModel>(
      offsets[1],
      RichMenuContainerModelSchema.deserialize,
      allOffsets,
    ),
    id: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _richMenuPublishModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<RichMenuFunctionModel>(
        offset,
        RichMenuFunctionModelSchema.deserialize,
        allOffsets,
        RichMenuFunctionModel(),
      )) as P;
    case 1:
      return (reader.readObjectOrNull<RichMenuContainerModel>(
        offset,
        RichMenuContainerModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RichMenuPublishModelQueryFilter on QueryBuilder<RichMenuPublishModel,
    RichMenuPublishModel, QFilterCondition> {
  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> actionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'actions',
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> actionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'actions',
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> actionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> actionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> actionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> actionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> actionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> actionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'actions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> containerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'container',
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> containerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'container',
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
          QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
          QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }
}

extension RichMenuPublishModelQueryObject on QueryBuilder<RichMenuPublishModel,
    RichMenuPublishModel, QFilterCondition> {
  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
          QAfterFilterCondition>
      actionsElement(FilterQuery<RichMenuFunctionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'actions');
    });
  }

  QueryBuilder<RichMenuPublishModel, RichMenuPublishModel,
      QAfterFilterCondition> container(FilterQuery<RichMenuContainerModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'container');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RichMenuContainerModelSchema = Schema(
  name: r'RichMenuContainerModel',
  id: 8411665903815791135,
  properties: {
    r'height': PropertySchema(
      id: 0,
      name: r'height',
      type: IsarType.double,
    ),
    r'imageId': PropertySchema(
      id: 1,
      name: r'imageId',
      type: IsarType.string,
    ),
    r'width': PropertySchema(
      id: 2,
      name: r'width',
      type: IsarType.double,
    )
  },
  estimateSize: _richMenuContainerModelEstimateSize,
  serialize: _richMenuContainerModelSerialize,
  deserialize: _richMenuContainerModelDeserialize,
  deserializeProp: _richMenuContainerModelDeserializeProp,
);

int _richMenuContainerModelEstimateSize(
  RichMenuContainerModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _richMenuContainerModelSerialize(
  RichMenuContainerModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.height);
  writer.writeString(offsets[1], object.imageId);
  writer.writeDouble(offsets[2], object.width);
}

RichMenuContainerModel _richMenuContainerModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RichMenuContainerModel(
    height: reader.readDoubleOrNull(offsets[0]) ?? 300,
    imageId: reader.readStringOrNull(offsets[1]),
    width: reader.readDoubleOrNull(offsets[2]) ?? 400,
  );
  return object;
}

P _richMenuContainerModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 300) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 400) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RichMenuContainerModelQueryFilter on QueryBuilder<
    RichMenuContainerModel, RichMenuContainerModel, QFilterCondition> {
  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> heightEqualTo(
    double value, {
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

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> heightGreaterThan(
    double value, {
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

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> heightLessThan(
    double value, {
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

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> heightBetween(
    double lower,
    double upper, {
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

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageId',
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageId',
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
          QAfterFilterCondition>
      imageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
          QAfterFilterCondition>
      imageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageId',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> imageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageId',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> widthEqualTo(
    double value, {
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

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> widthGreaterThan(
    double value, {
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

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> widthLessThan(
    double value, {
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

  QueryBuilder<RichMenuContainerModel, RichMenuContainerModel,
      QAfterFilterCondition> widthBetween(
    double lower,
    double upper, {
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
}

extension RichMenuContainerModelQueryObject on QueryBuilder<
    RichMenuContainerModel, RichMenuContainerModel, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RichMenuBoundsModelSchema = Schema(
  name: r'RichMenuBoundsModel',
  id: -5163767882481367592,
  properties: {
    r'height': PropertySchema(
      id: 0,
      name: r'height',
      type: IsarType.double,
    ),
    r'width': PropertySchema(
      id: 1,
      name: r'width',
      type: IsarType.double,
    ),
    r'x': PropertySchema(
      id: 2,
      name: r'x',
      type: IsarType.double,
    ),
    r'y': PropertySchema(
      id: 3,
      name: r'y',
      type: IsarType.double,
    )
  },
  estimateSize: _richMenuBoundsModelEstimateSize,
  serialize: _richMenuBoundsModelSerialize,
  deserialize: _richMenuBoundsModelDeserialize,
  deserializeProp: _richMenuBoundsModelDeserializeProp,
);

int _richMenuBoundsModelEstimateSize(
  RichMenuBoundsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _richMenuBoundsModelSerialize(
  RichMenuBoundsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.height);
  writer.writeDouble(offsets[1], object.width);
  writer.writeDouble(offsets[2], object.x);
  writer.writeDouble(offsets[3], object.y);
}

RichMenuBoundsModel _richMenuBoundsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RichMenuBoundsModel(
    height: reader.readDoubleOrNull(offsets[0]) ?? 0,
    width: reader.readDoubleOrNull(offsets[1]) ?? 0,
    x: reader.readDoubleOrNull(offsets[2]) ?? 0,
    y: reader.readDoubleOrNull(offsets[3]) ?? 0,
  );
  return object;
}

P _richMenuBoundsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RichMenuBoundsModelQueryFilter on QueryBuilder<RichMenuBoundsModel,
    RichMenuBoundsModel, QFilterCondition> {
  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      heightEqualTo(
    double value, {
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

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      heightGreaterThan(
    double value, {
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

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      heightLessThan(
    double value, {
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

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      heightBetween(
    double lower,
    double upper, {
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

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      widthEqualTo(
    double value, {
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

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      widthGreaterThan(
    double value, {
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

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      widthLessThan(
    double value, {
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

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      widthBetween(
    double lower,
    double upper, {
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

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      xEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'x',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      xGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'x',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      xLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'x',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      xBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'x',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      yEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'y',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      yGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'y',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      yLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'y',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuBoundsModel, RichMenuBoundsModel, QAfterFilterCondition>
      yBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'y',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension RichMenuBoundsModelQueryObject on QueryBuilder<RichMenuBoundsModel,
    RichMenuBoundsModel, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RichMenuFunctionModelSchema = Schema(
  name: r'RichMenuFunctionModel',
  id: -5439007080104248742,
  properties: {
    r'bounds': PropertySchema(
      id: 0,
      name: r'bounds',
      type: IsarType.object,
      target: r'RichMenuBoundsModel',
    ),
    r'command': PropertySchema(
      id: 1,
      name: r'command',
      type: IsarType.string,
    ),
    r'commandArg': PropertySchema(
      id: 2,
      name: r'commandArg',
      type: IsarType.object,
      target: r'RichMenuCommandArgModel',
    ),
    r'height': PropertySchema(
      id: 3,
      name: r'height',
      type: IsarType.double,
    ),
    r'index': PropertySchema(
      id: 4,
      name: r'index',
      type: IsarType.long,
    ),
    r'isNone': PropertySchema(
      id: 5,
      name: r'isNone',
      type: IsarType.bool,
    ),
    r'isOpenUrl': PropertySchema(
      id: 6,
      name: r'isOpenUrl',
      type: IsarType.bool,
    ),
    r'isSendMessage': PropertySchema(
      id: 7,
      name: r'isSendMessage',
      type: IsarType.bool,
    ),
    r'width': PropertySchema(
      id: 8,
      name: r'width',
      type: IsarType.double,
    ),
    r'x': PropertySchema(
      id: 9,
      name: r'x',
      type: IsarType.double,
    ),
    r'y': PropertySchema(
      id: 10,
      name: r'y',
      type: IsarType.double,
    )
  },
  estimateSize: _richMenuFunctionModelEstimateSize,
  serialize: _richMenuFunctionModelSerialize,
  deserialize: _richMenuFunctionModelDeserialize,
  deserializeProp: _richMenuFunctionModelDeserializeProp,
);

int _richMenuFunctionModelEstimateSize(
  RichMenuFunctionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bounds;
    if (value != null) {
      bytesCount += 3 +
          RichMenuBoundsModelSchema.estimateSize(
              value, allOffsets[RichMenuBoundsModel]!, allOffsets);
    }
  }
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
          RichMenuCommandArgModelSchema.estimateSize(
              value, allOffsets[RichMenuCommandArgModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _richMenuFunctionModelSerialize(
  RichMenuFunctionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<RichMenuBoundsModel>(
    offsets[0],
    allOffsets,
    RichMenuBoundsModelSchema.serialize,
    object.bounds,
  );
  writer.writeString(offsets[1], object.command);
  writer.writeObject<RichMenuCommandArgModel>(
    offsets[2],
    allOffsets,
    RichMenuCommandArgModelSchema.serialize,
    object.commandArg,
  );
  writer.writeDouble(offsets[3], object.height);
  writer.writeLong(offsets[4], object.index);
  writer.writeBool(offsets[5], object.isNone);
  writer.writeBool(offsets[6], object.isOpenUrl);
  writer.writeBool(offsets[7], object.isSendMessage);
  writer.writeDouble(offsets[8], object.width);
  writer.writeDouble(offsets[9], object.x);
  writer.writeDouble(offsets[10], object.y);
}

RichMenuFunctionModel _richMenuFunctionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RichMenuFunctionModel(
    bounds: reader.readObjectOrNull<RichMenuBoundsModel>(
      offsets[0],
      RichMenuBoundsModelSchema.deserialize,
      allOffsets,
    ),
    command: reader.readStringOrNull(offsets[1]),
    commandArg: reader.readObjectOrNull<RichMenuCommandArgModel>(
      offsets[2],
      RichMenuCommandArgModelSchema.deserialize,
      allOffsets,
    ),
    index: reader.readLongOrNull(offsets[4]),
  );
  return object;
}

P _richMenuFunctionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<RichMenuBoundsModel>(
        offset,
        RichMenuBoundsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<RichMenuCommandArgModel>(
        offset,
        RichMenuCommandArgModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RichMenuFunctionModelQueryFilter on QueryBuilder<
    RichMenuFunctionModel, RichMenuFunctionModel, QFilterCondition> {
  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> boundsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bounds',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> boundsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bounds',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> commandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'command',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> commandIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'command',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> commandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'command',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> commandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'command',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> commandArgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'commandArg',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> commandArgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'commandArg',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> indexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'index',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> indexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'index',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> indexEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> indexGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> indexLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> indexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> isNoneEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isNone',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> isOpenUrlEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOpenUrl',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> isSendMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSendMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> widthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> widthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
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

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> xIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'x',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> xIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'x',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> xEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'x',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> xGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'x',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> xLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'x',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> xBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'x',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> yIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'y',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> yIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'y',
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> yEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'y',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> yGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'y',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> yLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'y',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> yBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'y',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension RichMenuFunctionModelQueryObject on QueryBuilder<
    RichMenuFunctionModel, RichMenuFunctionModel, QFilterCondition> {
  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
      QAfterFilterCondition> bounds(FilterQuery<RichMenuBoundsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'bounds');
    });
  }

  QueryBuilder<RichMenuFunctionModel, RichMenuFunctionModel,
          QAfterFilterCondition>
      commandArg(FilterQuery<RichMenuCommandArgModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'commandArg');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RichMenuCommandArgModelSchema = Schema(
  name: r'RichMenuCommandArgModel',
  id: -2747901409274356362,
  properties: {
    r'message': PropertySchema(
      id: 0,
      name: r'message',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 1,
      name: r'url',
      type: IsarType.string,
    )
  },
  estimateSize: _richMenuCommandArgModelEstimateSize,
  serialize: _richMenuCommandArgModelSerialize,
  deserialize: _richMenuCommandArgModelDeserialize,
  deserializeProp: _richMenuCommandArgModelDeserializeProp,
);

int _richMenuCommandArgModelEstimateSize(
  RichMenuCommandArgModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.message;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.url;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _richMenuCommandArgModelSerialize(
  RichMenuCommandArgModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.message);
  writer.writeString(offsets[1], object.url);
}

RichMenuCommandArgModel _richMenuCommandArgModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RichMenuCommandArgModel(
    message: reader.readStringOrNull(offsets[0]),
    url: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _richMenuCommandArgModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RichMenuCommandArgModelQueryFilter on QueryBuilder<
    RichMenuCommandArgModel, RichMenuCommandArgModel, QFilterCondition> {
  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
          QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
          QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'url',
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'url',
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
          QAfterFilterCondition>
      urlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
          QAfterFilterCondition>
      urlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<RichMenuCommandArgModel, RichMenuCommandArgModel,
      QAfterFilterCondition> urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension RichMenuCommandArgModelQueryObject on QueryBuilder<
    RichMenuCommandArgModel, RichMenuCommandArgModel, QFilterCondition> {}
