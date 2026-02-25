// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'official_menu_container_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const OfficialMenuContainerModelSchema = Schema(
  name: r'OfficialMenuContainerModel',
  id: -330950364295358251,
  properties: {
    r'aspectRatio': PropertySchema(
      id: 0,
      name: r'aspectRatio',
      type: IsarType.string,
    ),
    r'height': PropertySchema(
      id: 1,
      name: r'height',
      type: IsarType.double,
    ),
    r'heightRatio': PropertySchema(
      id: 2,
      name: r'heightRatio',
      type: IsarType.double,
    ),
    r'imageFileId': PropertySchema(
      id: 3,
      name: r'imageFileId',
      type: IsarType.string,
    ),
    r'width': PropertySchema(
      id: 4,
      name: r'width',
      type: IsarType.double,
    ),
    r'widthRatio': PropertySchema(
      id: 5,
      name: r'widthRatio',
      type: IsarType.double,
    )
  },
  estimateSize: _officialMenuContainerModelEstimateSize,
  serialize: _officialMenuContainerModelSerialize,
  deserialize: _officialMenuContainerModelDeserialize,
  deserializeProp: _officialMenuContainerModelDeserializeProp,
);

int _officialMenuContainerModelEstimateSize(
  OfficialMenuContainerModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.aspectRatio;
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

void _officialMenuContainerModelSerialize(
  OfficialMenuContainerModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aspectRatio);
  writer.writeDouble(offsets[1], object.height);
  writer.writeDouble(offsets[2], object.heightRatio);
  writer.writeString(offsets[3], object.imageFileId);
  writer.writeDouble(offsets[4], object.width);
  writer.writeDouble(offsets[5], object.widthRatio);
}

OfficialMenuContainerModel _officialMenuContainerModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OfficialMenuContainerModel(
    aspectRatio: reader.readStringOrNull(offsets[0]),
    height: reader.readDoubleOrNull(offsets[1]),
    imageFileId: reader.readStringOrNull(offsets[3]),
    width: reader.readDoubleOrNull(offsets[4]),
  );
  return object;
}

P _officialMenuContainerModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension OfficialMenuContainerModelQueryFilter on QueryBuilder<
    OfficialMenuContainerModel, OfficialMenuContainerModel, QFilterCondition> {
  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aspectRatio',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aspectRatio',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aspectRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aspectRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aspectRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aspectRatio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aspectRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aspectRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
          QAfterFilterCondition>
      aspectRatioContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aspectRatio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
          QAfterFilterCondition>
      aspectRatioMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aspectRatio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aspectRatio',
        value: '',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> aspectRatioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aspectRatio',
        value: '',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> heightRatioEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'heightRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> heightRatioGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'heightRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> heightRatioLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'heightRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> heightRatioBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'heightRatio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> imageFileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageFileId',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> imageFileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageFileId',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> imageFileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFileId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> imageFileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageFileId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> widthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> widthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
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

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> widthRatioEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widthRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> widthRatioGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'widthRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> widthRatioLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'widthRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfficialMenuContainerModel, OfficialMenuContainerModel,
      QAfterFilterCondition> widthRatioBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'widthRatio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension OfficialMenuContainerModelQueryObject on QueryBuilder<
    OfficialMenuContainerModel, OfficialMenuContainerModel, QFilterCondition> {}
