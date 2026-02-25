// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'official_menu_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const OfficialMenuModelSchema = Schema(
  name: r'OfficialMenuModel',
  id: 878738107083163309,
  properties: {
    r'commands': PropertySchema(
      id: 0,
      name: r'commands',
      type: IsarType.objectList,
      target: r'OfficialMenuCommandModel',
    ),
    r'container': PropertySchema(
      id: 1,
      name: r'container',
      type: IsarType.object,
      target: r'OfficialMenuContainerModel',
    ),
    r'lastUpdatedAt': PropertySchema(
      id: 2,
      name: r'lastUpdatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _officialMenuModelEstimateSize,
  serialize: _officialMenuModelSerialize,
  deserialize: _officialMenuModelDeserialize,
  deserializeProp: _officialMenuModelDeserializeProp,
);

int _officialMenuModelEstimateSize(
  OfficialMenuModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.commands;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[OfficialMenuCommandModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += OfficialMenuCommandModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.container;
    if (value != null) {
      bytesCount += 3 +
          OfficialMenuContainerModelSchema.estimateSize(
              value, allOffsets[OfficialMenuContainerModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _officialMenuModelSerialize(
  OfficialMenuModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<OfficialMenuCommandModel>(
    offsets[0],
    allOffsets,
    OfficialMenuCommandModelSchema.serialize,
    object.commands,
  );
  writer.writeObject<OfficialMenuContainerModel>(
    offsets[1],
    allOffsets,
    OfficialMenuContainerModelSchema.serialize,
    object.container,
  );
  writer.writeDateTime(offsets[2], object.lastUpdatedAt);
}

OfficialMenuModel _officialMenuModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OfficialMenuModel(
    commands: reader.readObjectList<OfficialMenuCommandModel>(
      offsets[0],
      OfficialMenuCommandModelSchema.deserialize,
      allOffsets,
      OfficialMenuCommandModel(),
    ),
    container: reader.readObjectOrNull<OfficialMenuContainerModel>(
      offsets[1],
      OfficialMenuContainerModelSchema.deserialize,
      allOffsets,
    ),
  );
  object.lastUpdatedAt = reader.readDateTimeOrNull(offsets[2]);
  return object;
}

P _officialMenuModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<OfficialMenuCommandModel>(
        offset,
        OfficialMenuCommandModelSchema.deserialize,
        allOffsets,
        OfficialMenuCommandModel(),
      )) as P;
    case 1:
      return (reader.readObjectOrNull<OfficialMenuContainerModel>(
        offset,
        OfficialMenuContainerModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension OfficialMenuModelQueryFilter
    on QueryBuilder<OfficialMenuModel, OfficialMenuModel, QFilterCondition> {
  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      commandsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'commands',
      ));
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      commandsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'commands',
      ));
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      commandsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      commandsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      commandsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      commandsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      commandsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      commandsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commands',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      containerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'container',
      ));
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      containerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'container',
      ));
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      lastUpdatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUpdatedAt',
      ));
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      lastUpdatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUpdatedAt',
      ));
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      lastUpdatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      lastUpdatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      lastUpdatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      lastUpdatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OfficialMenuModelQueryObject
    on QueryBuilder<OfficialMenuModel, OfficialMenuModel, QFilterCondition> {
  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      commandsElement(FilterQuery<OfficialMenuCommandModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'commands');
    });
  }

  QueryBuilder<OfficialMenuModel, OfficialMenuModel, QAfterFilterCondition>
      container(FilterQuery<OfficialMenuContainerModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'container');
    });
  }
}
