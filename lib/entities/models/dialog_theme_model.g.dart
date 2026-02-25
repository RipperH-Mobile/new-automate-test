// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_theme_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DialogThemeModelSchema = Schema(
  name: r'DialogThemeModel',
  id: 2820870934895079637,
  properties: {
    r'buttonColor': PropertySchema(
      id: 0,
      name: r'buttonColor',
      type: IsarType.stringList,
    ),
    r'descriptionColor': PropertySchema(
      id: 1,
      name: r'descriptionColor',
      type: IsarType.string,
    ),
    r'linkUrl': PropertySchema(
      id: 2,
      name: r'linkUrl',
      type: IsarType.string,
    ),
    r'subTitleTextColor': PropertySchema(
      id: 3,
      name: r'subTitleTextColor',
      type: IsarType.string,
    ),
    r'textRightButtonColor': PropertySchema(
      id: 4,
      name: r'textRightButtonColor',
      type: IsarType.string,
    ),
    r'titleTextColor': PropertySchema(
      id: 5,
      name: r'titleTextColor',
      type: IsarType.string,
    )
  },
  estimateSize: _dialogThemeModelEstimateSize,
  serialize: _dialogThemeModelSerialize,
  deserialize: _dialogThemeModelDeserialize,
  deserializeProp: _dialogThemeModelDeserializeProp,
);

int _dialogThemeModelEstimateSize(
  DialogThemeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.buttonColor;
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
    final value = object.descriptionColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.linkUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.subTitleTextColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textRightButtonColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.titleTextColor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dialogThemeModelSerialize(
  DialogThemeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.buttonColor);
  writer.writeString(offsets[1], object.descriptionColor);
  writer.writeString(offsets[2], object.linkUrl);
  writer.writeString(offsets[3], object.subTitleTextColor);
  writer.writeString(offsets[4], object.textRightButtonColor);
  writer.writeString(offsets[5], object.titleTextColor);
}

DialogThemeModel _dialogThemeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DialogThemeModel(
    buttonColor: reader.readStringList(offsets[0]),
    descriptionColor: reader.readStringOrNull(offsets[1]),
    linkUrl: reader.readStringOrNull(offsets[2]),
    subTitleTextColor: reader.readStringOrNull(offsets[3]),
    textRightButtonColor: reader.readStringOrNull(offsets[4]),
    titleTextColor: reader.readStringOrNull(offsets[5]),
  );
  return object;
}

P _dialogThemeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DialogThemeModelQueryFilter
    on QueryBuilder<DialogThemeModel, DialogThemeModel, QFilterCondition> {
  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'buttonColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'buttonColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buttonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'buttonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'buttonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'buttonColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'buttonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'buttonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'buttonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'buttonColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buttonColor',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'buttonColor',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttonColor',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttonColor',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttonColor',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttonColor',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttonColor',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      buttonColorLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'buttonColor',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descriptionColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descriptionColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descriptionColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descriptionColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descriptionColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descriptionColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descriptionColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descriptionColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descriptionColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionColor',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      descriptionColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descriptionColor',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkUrl',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkUrl',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'linkUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      linkUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'linkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subTitleTextColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subTitleTextColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subTitleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subTitleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subTitleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subTitleTextColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subTitleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subTitleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subTitleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subTitleTextColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subTitleTextColor',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      subTitleTextColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subTitleTextColor',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textRightButtonColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textRightButtonColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textRightButtonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textRightButtonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textRightButtonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textRightButtonColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textRightButtonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textRightButtonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textRightButtonColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textRightButtonColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textRightButtonColor',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      textRightButtonColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textRightButtonColor',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'titleTextColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'titleTextColor',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titleTextColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titleTextColor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titleTextColor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleTextColor',
        value: '',
      ));
    });
  }

  QueryBuilder<DialogThemeModel, DialogThemeModel, QAfterFilterCondition>
      titleTextColorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titleTextColor',
        value: '',
      ));
    });
  }
}

extension DialogThemeModelQueryObject
    on QueryBuilder<DialogThemeModel, DialogThemeModel, QFilterCondition> {}
