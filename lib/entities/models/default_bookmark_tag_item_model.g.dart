// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_bookmark_tag_item_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DefaultBookmarkTagItemModelSchema = Schema(
  name: r'DefaultBookmarkTagItemModel',
  id: 4406187609119210674,
  properties: {
    r'emojiTagId': PropertySchema(
      id: 0,
      name: r'emojiTagId',
      type: IsarType.string,
    ),
    r'fileId': PropertySchema(
      id: 1,
      name: r'fileId',
      type: IsarType.string,
    )
  },
  estimateSize: _defaultBookmarkTagItemModelEstimateSize,
  serialize: _defaultBookmarkTagItemModelSerialize,
  deserialize: _defaultBookmarkTagItemModelDeserialize,
  deserializeProp: _defaultBookmarkTagItemModelDeserializeProp,
);

int _defaultBookmarkTagItemModelEstimateSize(
  DefaultBookmarkTagItemModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.emojiTagId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fileId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _defaultBookmarkTagItemModelSerialize(
  DefaultBookmarkTagItemModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.emojiTagId);
  writer.writeString(offsets[1], object.fileId);
}

DefaultBookmarkTagItemModel _defaultBookmarkTagItemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DefaultBookmarkTagItemModel(
    emojiTagId: reader.readStringOrNull(offsets[0]),
    fileId: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _defaultBookmarkTagItemModelDeserializeProp<P>(
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

extension DefaultBookmarkTagItemModelQueryFilter on QueryBuilder<
    DefaultBookmarkTagItemModel,
    DefaultBookmarkTagItemModel,
    QFilterCondition> {
  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiTagId',
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiTagId',
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emojiTagId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
          QAfterFilterCondition>
      emojiTagIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
          QAfterFilterCondition>
      emojiTagIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emojiTagId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiTagId',
        value: '',
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> emojiTagIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emojiTagId',
        value: '',
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
          QAfterFilterCondition>
      fileIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
          QAfterFilterCondition>
      fileIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileId',
        value: '',
      ));
    });
  }

  QueryBuilder<DefaultBookmarkTagItemModel, DefaultBookmarkTagItemModel,
      QAfterFilterCondition> fileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileId',
        value: '',
      ));
    });
  }
}

extension DefaultBookmarkTagItemModelQueryObject on QueryBuilder<
    DefaultBookmarkTagItemModel,
    DefaultBookmarkTagItemModel,
    QFilterCondition> {}
