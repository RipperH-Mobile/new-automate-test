// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_theme_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const StoreThemeModelSchema = Schema(
  name: r'StoreThemeModel',
  id: -1255247315950119886,
  properties: {
    r'advertisementText': PropertySchema(
      id: 0,
      name: r'advertisementText',
      type: IsarType.string,
    ),
    r'bgChipHeaderColor': PropertySchema(
      id: 1,
      name: r'bgChipHeaderColor',
      type: IsarType.stringList,
    ),
    r'bgColor': PropertySchema(
      id: 2,
      name: r'bgColor',
      type: IsarType.string,
    ),
    r'bgItemColor1': PropertySchema(
      id: 3,
      name: r'bgItemColor1',
      type: IsarType.string,
    ),
    r'bgItemColor2': PropertySchema(
      id: 4,
      name: r'bgItemColor2',
      type: IsarType.string,
    ),
    r'borderColor': PropertySchema(
      id: 5,
      name: r'borderColor',
      type: IsarType.string,
    ),
    r'shadowChipHeaderColor': PropertySchema(
      id: 6,
      name: r'shadowChipHeaderColor',
      type: IsarType.string,
    ),
    r'shadowColor': PropertySchema(
      id: 7,
      name: r'shadowColor',
      type: IsarType.string,
    ),
    r'textChipHeaderColor': PropertySchema(
      id: 8,
      name: r'textChipHeaderColor',
      type: IsarType.string,
    ),
    r'textDesColor': PropertySchema(
      id: 9,
      name: r'textDesColor',
      type: IsarType.string,
    ),
    r'textParamColor': PropertySchema(
      id: 10,
      name: r'textParamColor',
      type: IsarType.string,
    ),
    r'textPrimaryColor': PropertySchema(
      id: 11,
      name: r'textPrimaryColor',
      type: IsarType.string,
    ),
    r'textSecondaryColor': PropertySchema(
      id: 12,
      name: r'textSecondaryColor',
      type: IsarType.string,
    )
  },
  estimateSize: _storeThemeModelEstimateSize,
  serialize: _storeThemeModelSerialize,
  deserialize: _storeThemeModelDeserialize,
  deserializeProp: _storeThemeModelDeserializeProp,
);

int _storeThemeModelEstimateSize(
  StoreThemeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.advertisementText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.bgChipHeaderColor;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.bgColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.bgItemColor1;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.bgItemColor2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.borderColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.shadowChipHeaderColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.shadowColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textChipHeaderColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textDesColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textParamColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textPrimaryColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textSecondaryColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _storeThemeModelSerialize(
  StoreThemeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.advertisementText);
  writer.writeStringList(offsets[1], object.bgChipHeaderColor);
  writer.writeString(offsets[2], object.bgColor);
  writer.writeString(offsets[3], object.bgItemColor1);
  writer.writeString(offsets[4], object.bgItemColor2);
  writer.writeString(offsets[5], object.borderColor);
  writer.writeString(offsets[6], object.shadowChipHeaderColor);
  writer.writeString(offsets[7], object.shadowColor);
  writer.writeString(offsets[8], object.textChipHeaderColor);
  writer.writeString(offsets[9], object.textDesColor);
  writer.writeString(offsets[10], object.textParamColor);
  writer.writeString(offsets[11], object.textPrimaryColor);
  writer.writeString(offsets[12], object.textSecondaryColor);
}

StoreThemeModel _storeThemeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StoreThemeModel(
    advertisementText: reader.readStringOrNull(offsets[0]),
    bgChipHeaderColor: reader.readStringList(offsets[1]),
    bgColor: reader.readStringOrNull(offsets[2]),
    bgItemColor1: reader.readStringOrNull(offsets[3]),
    bgItemColor2: reader.readStringOrNull(offsets[4]),
    borderColor: reader.readStringOrNull(offsets[5]),
    shadowChipHeaderColor: reader.readStringOrNull(offsets[6]),
    shadowColor: reader.readStringOrNull(offsets[7]),
    textChipHeaderColor: reader.readStringOrNull(offsets[8]),
    textDesColor: reader.readStringOrNull(offsets[9]),
    textParamColor: reader.readStringOrNull(offsets[10]),
    textPrimaryColor: reader.readStringOrNull(offsets[11]),
    textSecondaryColor: reader.readStringOrNull(offsets[12]),
  );
  return object;
}

P _storeThemeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension StoreThemeModelQueryFilter
    on QueryBuilder<StoreThemeModel, StoreThemeModel, QFilterCondition> {
  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'advertisementText',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'advertisementText',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'advertisementText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'advertisementText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'advertisementText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'advertisementText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'advertisementText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'advertisementText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'advertisementText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'advertisementText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'advertisementText',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      advertisementTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'advertisementText',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgChipHeaderColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgChipHeaderColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgChipHeaderColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgChipHeaderColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgChipHeaderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgChipHeaderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgChipHeaderColor',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgChipHeaderColor',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgChipHeaderColor',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgChipHeaderColor',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgChipHeaderColor',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgChipHeaderColorLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgChipHeaderColor',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgItemColor1',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgItemColor1',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgItemColor1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgItemColor1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgItemColor1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgItemColor1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgItemColor1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgItemColor1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgItemColor1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgItemColor1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgItemColor1',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgItemColor1',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgItemColor2',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgItemColor2',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgItemColor2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgItemColor2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgItemColor2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgItemColor2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgItemColor2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgItemColor2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgItemColor2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgItemColor2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgItemColor2',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      bgItemColor2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgItemColor2',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'borderColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'borderColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'borderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'borderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'borderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'borderColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'borderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'borderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'borderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'borderColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'borderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      borderColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'borderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shadowChipHeaderColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shadowChipHeaderColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shadowChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shadowChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shadowChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shadowChipHeaderColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shadowChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shadowChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shadowChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shadowChipHeaderColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shadowChipHeaderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowChipHeaderColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shadowChipHeaderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shadowColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shadowColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shadowColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shadowColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shadowColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      shadowColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shadowColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textChipHeaderColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textChipHeaderColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textChipHeaderColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textChipHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textChipHeaderColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textChipHeaderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textChipHeaderColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textChipHeaderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textDesColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textDesColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textDesColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textDesColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textDesColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textDesColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textDesColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textDesColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textDesColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textDesColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textDesColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textDesColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textDesColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textParamColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textParamColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textParamColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textParamColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textParamColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textParamColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textParamColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textParamColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textParamColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textParamColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textParamColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textParamColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textParamColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textPrimaryColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textPrimaryColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textPrimaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textPrimaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textPrimaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textPrimaryColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textPrimaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textPrimaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textPrimaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textPrimaryColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textPrimaryColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textPrimaryColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textPrimaryColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textSecondaryColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textSecondaryColor',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textSecondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textSecondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textSecondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textSecondaryColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textSecondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textSecondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textSecondaryColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textSecondaryColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textSecondaryColor',
        value: '',
      ));
    });
  }

  QueryBuilder<StoreThemeModel, StoreThemeModel, QAfterFilterCondition>
      textSecondaryColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textSecondaryColor',
        value: '',
      ));
    });
  }
}

extension StoreThemeModelQueryObject
    on QueryBuilder<StoreThemeModel, StoreThemeModel, QFilterCondition> {}
