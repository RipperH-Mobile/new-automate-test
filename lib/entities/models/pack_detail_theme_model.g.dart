// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack_detail_theme_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PackDetailThemeModelSchema = Schema(
  name: r'PackDetailThemeModel',
  id: 4451264854320421377,
  properties: {
    r'bgColor': PropertySchema(
      id: 0,
      name: r'bgColor',
      type: IsarType.stringList,
    ),
    r'bgHeaderColor': PropertySchema(
      id: 1,
      name: r'bgHeaderColor',
      type: IsarType.stringList,
    ),
    r'bgRectMonthly': PropertySchema(
      id: 2,
      name: r'bgRectMonthly',
      type: IsarType.stringList,
    ),
    r'bgRectYearly': PropertySchema(
      id: 3,
      name: r'bgRectYearly',
      type: IsarType.stringList,
    ),
    r'bgSubscribeBtn': PropertySchema(
      id: 4,
      name: r'bgSubscribeBtn',
      type: IsarType.string,
    ),
    r'bgWhatIsInclude': PropertySchema(
      id: 5,
      name: r'bgWhatIsInclude',
      type: IsarType.string,
    ),
    r'bgWhatIsIncludeItem': PropertySchema(
      id: 6,
      name: r'bgWhatIsIncludeItem',
      type: IsarType.string,
    ),
    r'decorationItemColorMonthly': PropertySchema(
      id: 7,
      name: r'decorationItemColorMonthly',
      type: IsarType.string,
    ),
    r'decorationItemColorYearly': PropertySchema(
      id: 8,
      name: r'decorationItemColorYearly',
      type: IsarType.string,
    ),
    r'shadowRectMonthly': PropertySchema(
      id: 9,
      name: r'shadowRectMonthly',
      type: IsarType.string,
    ),
    r'shadowSubscribeBtn': PropertySchema(
      id: 10,
      name: r'shadowSubscribeBtn',
      type: IsarType.string,
    ),
    r'subscribeDescriptionTextColor': PropertySchema(
      id: 11,
      name: r'subscribeDescriptionTextColor',
      type: IsarType.string,
    )
  },
  estimateSize: _packDetailThemeModelEstimateSize,
  serialize: _packDetailThemeModelSerialize,
  deserialize: _packDetailThemeModelDeserialize,
  deserializeProp: _packDetailThemeModelDeserializeProp,
);

int _packDetailThemeModelEstimateSize(
  PackDetailThemeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.bgColor;
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
    final list = object.bgHeaderColor;
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
    final list = object.bgRectMonthly;
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
    final list = object.bgRectYearly;
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
    final value = object.bgSubscribeBtn;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.bgWhatIsInclude;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.bgWhatIsIncludeItem;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.decorationItemColorMonthly;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.decorationItemColorYearly;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.shadowRectMonthly;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.shadowSubscribeBtn;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.subscribeDescriptionTextColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _packDetailThemeModelSerialize(
  PackDetailThemeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.bgColor);
  writer.writeStringList(offsets[1], object.bgHeaderColor);
  writer.writeStringList(offsets[2], object.bgRectMonthly);
  writer.writeStringList(offsets[3], object.bgRectYearly);
  writer.writeString(offsets[4], object.bgSubscribeBtn);
  writer.writeString(offsets[5], object.bgWhatIsInclude);
  writer.writeString(offsets[6], object.bgWhatIsIncludeItem);
  writer.writeString(offsets[7], object.decorationItemColorMonthly);
  writer.writeString(offsets[8], object.decorationItemColorYearly);
  writer.writeString(offsets[9], object.shadowRectMonthly);
  writer.writeString(offsets[10], object.shadowSubscribeBtn);
  writer.writeString(offsets[11], object.subscribeDescriptionTextColor);
}

PackDetailThemeModel _packDetailThemeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PackDetailThemeModel(
    bgColor: reader.readStringList(offsets[0]),
    bgHeaderColor: reader.readStringList(offsets[1]),
    bgRectMonthly: reader.readStringList(offsets[2]),
    bgRectYearly: reader.readStringList(offsets[3]),
    bgSubscribeBtn: reader.readStringOrNull(offsets[4]),
    bgWhatIsInclude: reader.readStringOrNull(offsets[5]),
    bgWhatIsIncludeItem: reader.readStringOrNull(offsets[6]),
    decorationItemColorMonthly: reader.readStringOrNull(offsets[7]),
    decorationItemColorYearly: reader.readStringOrNull(offsets[8]),
    shadowRectMonthly: reader.readStringOrNull(offsets[9]),
    shadowSubscribeBtn: reader.readStringOrNull(offsets[10]),
    subscribeDescriptionTextColor: reader.readStringOrNull(offsets[11]),
  );
  return object;
}

P _packDetailThemeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    case 3:
      return (reader.readStringList(offset)) as P;
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PackDetailThemeModelQueryFilter on QueryBuilder<PackDetailThemeModel,
    PackDetailThemeModel, QFilterCondition> {
  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgColor',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgColor',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorElementEqualTo(
    String value, {
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

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorElementGreaterThan(
    String value, {
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

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorElementLessThan(
    String value, {
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

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorElementBetween(
    String lower,
    String upper, {
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

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorElementStartsWith(
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

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorElementEndsWith(
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

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgColorElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgColorElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgColor',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgColor',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgColor',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgColor',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgColor',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgColor',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgColor',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgColorLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgColor',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgHeaderColor',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgHeaderColor',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgHeaderColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgHeaderColorElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgHeaderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgHeaderColorElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgHeaderColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgHeaderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgHeaderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgHeaderColor',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgHeaderColor',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgHeaderColor',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgHeaderColor',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgHeaderColor',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgHeaderColorLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgHeaderColor',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgRectMonthly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgRectMonthly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgRectMonthly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgRectMonthlyElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgRectMonthlyElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgRectMonthly',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgRectMonthly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgRectMonthly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectMonthly',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectMonthly',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectMonthly',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectMonthly',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectMonthly',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectMonthlyLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectMonthly',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgRectYearly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgRectYearly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgRectYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgRectYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgRectYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgRectYearly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgRectYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgRectYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgRectYearlyElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgRectYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgRectYearlyElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgRectYearly',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgRectYearly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgRectYearly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectYearly',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectYearly',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectYearly',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectYearly',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectYearly',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgRectYearlyLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bgRectYearly',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgSubscribeBtn',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgSubscribeBtn',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgSubscribeBtn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgSubscribeBtnContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgSubscribeBtnMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgSubscribeBtn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgSubscribeBtn',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgSubscribeBtnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgSubscribeBtn',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgWhatIsInclude',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgWhatIsInclude',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgWhatIsInclude',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgWhatIsInclude',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgWhatIsInclude',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgWhatIsInclude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgWhatIsInclude',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgWhatIsInclude',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgWhatIsIncludeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgWhatIsInclude',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgWhatIsIncludeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgWhatIsInclude',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgWhatIsInclude',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgWhatIsInclude',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bgWhatIsIncludeItem',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bgWhatIsIncludeItem',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgWhatIsIncludeItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bgWhatIsIncludeItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bgWhatIsIncludeItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bgWhatIsIncludeItem',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bgWhatIsIncludeItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bgWhatIsIncludeItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgWhatIsIncludeItemContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bgWhatIsIncludeItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      bgWhatIsIncludeItemMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bgWhatIsIncludeItem',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bgWhatIsIncludeItem',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> bgWhatIsIncludeItemIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bgWhatIsIncludeItem',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'decorationItemColorMonthly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'decorationItemColorMonthly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'decorationItemColorMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'decorationItemColorMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'decorationItemColorMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'decorationItemColorMonthly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'decorationItemColorMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'decorationItemColorMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      decorationItemColorMonthlyContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'decorationItemColorMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      decorationItemColorMonthlyMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'decorationItemColorMonthly',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'decorationItemColorMonthly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorMonthlyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'decorationItemColorMonthly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'decorationItemColorYearly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'decorationItemColorYearly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'decorationItemColorYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'decorationItemColorYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'decorationItemColorYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'decorationItemColorYearly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'decorationItemColorYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'decorationItemColorYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      decorationItemColorYearlyContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'decorationItemColorYearly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      decorationItemColorYearlyMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'decorationItemColorYearly',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'decorationItemColorYearly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> decorationItemColorYearlyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'decorationItemColorYearly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shadowRectMonthly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shadowRectMonthly',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shadowRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shadowRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shadowRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shadowRectMonthly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shadowRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shadowRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      shadowRectMonthlyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shadowRectMonthly',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      shadowRectMonthlyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shadowRectMonthly',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shadowRectMonthly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowRectMonthlyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shadowRectMonthly',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shadowSubscribeBtn',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shadowSubscribeBtn',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shadowSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shadowSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shadowSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shadowSubscribeBtn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shadowSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shadowSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      shadowSubscribeBtnContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shadowSubscribeBtn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      shadowSubscribeBtnMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shadowSubscribeBtn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shadowSubscribeBtn',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> shadowSubscribeBtnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shadowSubscribeBtn',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subscribeDescriptionTextColor',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subscribeDescriptionTextColor',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subscribeDescriptionTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subscribeDescriptionTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subscribeDescriptionTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subscribeDescriptionTextColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subscribeDescriptionTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subscribeDescriptionTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      subscribeDescriptionTextColorContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subscribeDescriptionTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
          QAfterFilterCondition>
      subscribeDescriptionTextColorMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subscribeDescriptionTextColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subscribeDescriptionTextColor',
        value: '',
      ));
    });
  }

  QueryBuilder<PackDetailThemeModel, PackDetailThemeModel,
      QAfterFilterCondition> subscribeDescriptionTextColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subscribeDescriptionTextColor',
        value: '',
      ));
    });
  }
}

extension PackDetailThemeModelQueryObject on QueryBuilder<PackDetailThemeModel,
    PackDetailThemeModel, QFilterCondition> {}
