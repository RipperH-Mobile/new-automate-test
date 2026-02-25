// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_theme_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CompareThemeModelSchema = Schema(
  name: r'CompareThemeModel',
  id: 8957050938477826887,
  properties: {
    r'borderColor': PropertySchema(
      id: 0,
      name: r'borderColor',
      type: IsarType.string,
    ),
    r'descriptionFeatureColor': PropertySchema(
      id: 1,
      name: r'descriptionFeatureColor',
      type: IsarType.string,
    ),
    r'featureBgEven': PropertySchema(
      id: 2,
      name: r'featureBgEven',
      type: IsarType.string,
    ),
    r'featureBgOdd': PropertySchema(
      id: 3,
      name: r'featureBgOdd',
      type: IsarType.string,
    ),
    r'titleFeatureColor': PropertySchema(
      id: 4,
      name: r'titleFeatureColor',
      type: IsarType.string,
    ),
    r'viewingBgBtnColor': PropertySchema(
      id: 5,
      name: r'viewingBgBtnColor',
      type: IsarType.stringList,
    ),
    r'viewingBtnDropShadowColor': PropertySchema(
      id: 6,
      name: r'viewingBtnDropShadowColor',
      type: IsarType.string,
    ),
    r'viewingBtnDropShadowOpacity': PropertySchema(
      id: 7,
      name: r'viewingBtnDropShadowOpacity',
      type: IsarType.string,
    ),
    r'viewingBtnInnerShadowColor': PropertySchema(
      id: 8,
      name: r'viewingBtnInnerShadowColor',
      type: IsarType.string,
    ),
    r'viewingBtnInnerShadowOpacity': PropertySchema(
      id: 9,
      name: r'viewingBtnInnerShadowOpacity',
      type: IsarType.string,
    )
  },
  estimateSize: _compareThemeModelEstimateSize,
  serialize: _compareThemeModelSerialize,
  deserialize: _compareThemeModelDeserialize,
  deserializeProp: _compareThemeModelDeserializeProp,
);

int _compareThemeModelEstimateSize(
  CompareThemeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.borderColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.descriptionFeatureColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.featureBgEven;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.featureBgOdd;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.titleFeatureColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.viewingBgBtnColor;
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
    final value = object.viewingBtnDropShadowColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.viewingBtnDropShadowOpacity;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.viewingBtnInnerShadowColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.viewingBtnInnerShadowOpacity;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _compareThemeModelSerialize(
  CompareThemeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.borderColor);
  writer.writeString(offsets[1], object.descriptionFeatureColor);
  writer.writeString(offsets[2], object.featureBgEven);
  writer.writeString(offsets[3], object.featureBgOdd);
  writer.writeString(offsets[4], object.titleFeatureColor);
  writer.writeStringList(offsets[5], object.viewingBgBtnColor);
  writer.writeString(offsets[6], object.viewingBtnDropShadowColor);
  writer.writeString(offsets[7], object.viewingBtnDropShadowOpacity);
  writer.writeString(offsets[8], object.viewingBtnInnerShadowColor);
  writer.writeString(offsets[9], object.viewingBtnInnerShadowOpacity);
}

CompareThemeModel _compareThemeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompareThemeModel(
    borderColor: reader.readStringOrNull(offsets[0]),
    descriptionFeatureColor: reader.readStringOrNull(offsets[1]),
    featureBgEven: reader.readStringOrNull(offsets[2]),
    featureBgOdd: reader.readStringOrNull(offsets[3]),
    titleFeatureColor: reader.readStringOrNull(offsets[4]),
    viewingBgBtnColor: reader.readStringList(offsets[5]),
    viewingBtnDropShadowColor: reader.readStringOrNull(offsets[6]),
    viewingBtnDropShadowOpacity: reader.readStringOrNull(offsets[7]),
    viewingBtnInnerShadowColor: reader.readStringOrNull(offsets[8]),
    viewingBtnInnerShadowOpacity: reader.readStringOrNull(offsets[9]),
  );
  return object;
}

P _compareThemeModelDeserializeProp<P>(
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
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringList(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CompareThemeModelQueryFilter
    on QueryBuilder<CompareThemeModel, CompareThemeModel, QFilterCondition> {
  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      borderColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'borderColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      borderColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'borderColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
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

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
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

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
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

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
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

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
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

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
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

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      borderColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'borderColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      borderColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'borderColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      borderColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'borderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      borderColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'borderColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descriptionFeatureColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descriptionFeatureColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descriptionFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descriptionFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descriptionFeatureColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descriptionFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descriptionFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descriptionFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descriptionFeatureColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionFeatureColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      descriptionFeatureColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descriptionFeatureColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'featureBgEven',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'featureBgEven',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'featureBgEven',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'featureBgEven',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'featureBgEven',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'featureBgEven',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'featureBgEven',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'featureBgEven',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'featureBgEven',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'featureBgEven',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'featureBgEven',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgEvenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'featureBgEven',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'featureBgOdd',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'featureBgOdd',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'featureBgOdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'featureBgOdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'featureBgOdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'featureBgOdd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'featureBgOdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'featureBgOdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'featureBgOdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'featureBgOdd',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'featureBgOdd',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      featureBgOddIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'featureBgOdd',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'titleFeatureColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'titleFeatureColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titleFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titleFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titleFeatureColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titleFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titleFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titleFeatureColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titleFeatureColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleFeatureColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      titleFeatureColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titleFeatureColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'viewingBgBtnColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'viewingBgBtnColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBgBtnColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'viewingBgBtnColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'viewingBgBtnColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'viewingBgBtnColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'viewingBgBtnColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'viewingBgBtnColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'viewingBgBtnColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'viewingBgBtnColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBgBtnColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'viewingBgBtnColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viewingBgBtnColor',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viewingBgBtnColor',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viewingBgBtnColor',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viewingBgBtnColor',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viewingBgBtnColor',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBgBtnColorLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viewingBgBtnColor',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'viewingBtnDropShadowColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'viewingBtnDropShadowColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBtnDropShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'viewingBtnDropShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'viewingBtnDropShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'viewingBtnDropShadowColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'viewingBtnDropShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'viewingBtnDropShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'viewingBtnDropShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'viewingBtnDropShadowColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBtnDropShadowColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'viewingBtnDropShadowColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'viewingBtnDropShadowOpacity',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'viewingBtnDropShadowOpacity',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBtnDropShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'viewingBtnDropShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'viewingBtnDropShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'viewingBtnDropShadowOpacity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'viewingBtnDropShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'viewingBtnDropShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'viewingBtnDropShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'viewingBtnDropShadowOpacity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBtnDropShadowOpacity',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnDropShadowOpacityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'viewingBtnDropShadowOpacity',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'viewingBtnInnerShadowColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'viewingBtnInnerShadowColor',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBtnInnerShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'viewingBtnInnerShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'viewingBtnInnerShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'viewingBtnInnerShadowColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'viewingBtnInnerShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'viewingBtnInnerShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'viewingBtnInnerShadowColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'viewingBtnInnerShadowColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBtnInnerShadowColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'viewingBtnInnerShadowColor',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'viewingBtnInnerShadowOpacity',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'viewingBtnInnerShadowOpacity',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBtnInnerShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'viewingBtnInnerShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'viewingBtnInnerShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'viewingBtnInnerShadowOpacity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'viewingBtnInnerShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'viewingBtnInnerShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'viewingBtnInnerShadowOpacity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'viewingBtnInnerShadowOpacity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewingBtnInnerShadowOpacity',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeModel, CompareThemeModel, QAfterFilterCondition>
      viewingBtnInnerShadowOpacityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'viewingBtnInnerShadowOpacity',
        value: '',
      ));
    });
  }
}

extension CompareThemeModelQueryObject
    on QueryBuilder<CompareThemeModel, CompareThemeModel, QFilterCondition> {}
