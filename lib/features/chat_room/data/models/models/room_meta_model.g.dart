// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_meta_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RoomMetaModelSchema = Schema(
  name: r'RoomMetaModel',
  id: -4097300954117537692,
  properties: {
    r'menu': PropertySchema(
      id: 0,
      name: r'menu',
      type: IsarType.object,
      target: r'RoomMenuModel',
    )
  },
  estimateSize: _roomMetaModelEstimateSize,
  serialize: _roomMetaModelSerialize,
  deserialize: _roomMetaModelDeserialize,
  deserializeProp: _roomMetaModelDeserializeProp,
);

int _roomMetaModelEstimateSize(
  RoomMetaModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.menu;
    if (value != null) {
      bytesCount += 3 +
          RoomMenuModelSchema.estimateSize(
              value, allOffsets[RoomMenuModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _roomMetaModelSerialize(
  RoomMetaModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<RoomMenuModel>(
    offsets[0],
    allOffsets,
    RoomMenuModelSchema.serialize,
    object.menu,
  );
}

RoomMetaModel _roomMetaModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomMetaModel(
    menu: reader.readObjectOrNull<RoomMenuModel>(
      offsets[0],
      RoomMenuModelSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _roomMetaModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<RoomMenuModel>(
        offset,
        RoomMenuModelSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RoomMetaModelQueryFilter
    on QueryBuilder<RoomMetaModel, RoomMetaModel, QFilterCondition> {
  QueryBuilder<RoomMetaModel, RoomMetaModel, QAfterFilterCondition>
      menuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'menu',
      ));
    });
  }

  QueryBuilder<RoomMetaModel, RoomMetaModel, QAfterFilterCondition>
      menuIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'menu',
      ));
    });
  }
}

extension RoomMetaModelQueryObject
    on QueryBuilder<RoomMetaModel, RoomMetaModel, QFilterCondition> {
  QueryBuilder<RoomMetaModel, RoomMetaModel, QAfterFilterCondition> menu(
      FilterQuery<RoomMenuModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'menu');
    });
  }
}
