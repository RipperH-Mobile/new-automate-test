// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_menu_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RoomMenuModelSchema = Schema(
  name: r'RoomMenuModel',
  id: 3026158236845360334,
  properties: {
    r'draftMenu': PropertySchema(
      id: 0,
      name: r'draftMenu',
      type: IsarType.objectList,
      target: r'RoomMenuActionModel',
    ),
    r'publishMenu': PropertySchema(
      id: 1,
      name: r'publishMenu',
      type: IsarType.objectList,
      target: r'RoomMenuActionModel',
    ),
    r'publishedAt': PropertySchema(
      id: 2,
      name: r'publishedAt',
      type: IsarType.dateTime,
    ),
    r'updatedAt': PropertySchema(
      id: 3,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _roomMenuModelEstimateSize,
  serialize: _roomMenuModelSerialize,
  deserialize: _roomMenuModelDeserialize,
  deserializeProp: _roomMenuModelDeserializeProp,
);

int _roomMenuModelEstimateSize(
  RoomMenuModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.draftMenu.length * 3;
  {
    final offsets = allOffsets[RoomMenuActionModel]!;
    for (var i = 0; i < object.draftMenu.length; i++) {
      final value = object.draftMenu[i];
      bytesCount +=
          RoomMenuActionModelSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.publishMenu.length * 3;
  {
    final offsets = allOffsets[RoomMenuActionModel]!;
    for (var i = 0; i < object.publishMenu.length; i++) {
      final value = object.publishMenu[i];
      bytesCount +=
          RoomMenuActionModelSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _roomMenuModelSerialize(
  RoomMenuModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<RoomMenuActionModel>(
    offsets[0],
    allOffsets,
    RoomMenuActionModelSchema.serialize,
    object.draftMenu,
  );
  writer.writeObjectList<RoomMenuActionModel>(
    offsets[1],
    allOffsets,
    RoomMenuActionModelSchema.serialize,
    object.publishMenu,
  );
  writer.writeDateTime(offsets[2], object.publishedAt);
  writer.writeDateTime(offsets[3], object.updatedAt);
}

RoomMenuModel _roomMenuModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomMenuModel(
    draftMenu: reader.readObjectList<RoomMenuActionModel>(
          offsets[0],
          RoomMenuActionModelSchema.deserialize,
          allOffsets,
          RoomMenuActionModel(),
        ) ??
        const [],
    publishMenu: reader.readObjectList<RoomMenuActionModel>(
          offsets[1],
          RoomMenuActionModelSchema.deserialize,
          allOffsets,
          RoomMenuActionModel(),
        ) ??
        const [],
    publishedAt: reader.readDateTimeOrNull(offsets[2]),
    updatedAt: reader.readDateTimeOrNull(offsets[3]),
  );
  return object;
}

P _roomMenuModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<RoomMenuActionModel>(
            offset,
            RoomMenuActionModelSchema.deserialize,
            allOffsets,
            RoomMenuActionModel(),
          ) ??
          const []) as P;
    case 1:
      return (reader.readObjectList<RoomMenuActionModel>(
            offset,
            RoomMenuActionModelSchema.deserialize,
            allOffsets,
            RoomMenuActionModel(),
          ) ??
          const []) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RoomMenuModelQueryFilter
    on QueryBuilder<RoomMenuModel, RoomMenuModel, QFilterCondition> {
  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      draftMenuLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftMenu',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      draftMenuIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftMenu',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      draftMenuIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftMenu',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      draftMenuLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftMenu',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      draftMenuLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftMenu',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      draftMenuLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftMenu',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishMenuLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'publishMenu',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishMenuIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'publishMenu',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishMenuIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'publishMenu',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishMenuLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'publishMenu',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishMenuLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'publishMenu',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishMenuLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'publishMenu',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'publishedAt',
      ));
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'publishedAt',
      ));
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
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

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
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

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
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

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
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

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
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

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
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

extension RoomMenuModelQueryObject
    on QueryBuilder<RoomMenuModel, RoomMenuModel, QFilterCondition> {
  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      draftMenuElement(FilterQuery<RoomMenuActionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'draftMenu');
    });
  }

  QueryBuilder<RoomMenuModel, RoomMenuModel, QAfterFilterCondition>
      publishMenuElement(FilterQuery<RoomMenuActionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'publishMenu');
    });
  }
}
