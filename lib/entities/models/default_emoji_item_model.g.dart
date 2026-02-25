// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_emoji_item_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DefaultEmojiItemModelSchema = Schema(
  name: r'DefaultEmojiItemModel',
  id: 4423818816142141110,
  properties: {
    r'emojiItemId': PropertySchema(
      id: 0,
      name: r'emojiItemId',
      type: IsarType.string,
    ),
    r'fileId': PropertySchema(
      id: 1,
      name: r'fileId',
      type: IsarType.string,
    )
  },
  estimateSize: _defaultEmojiItemModelEstimateSize,
  serialize: _defaultEmojiItemModelSerialize,
  deserialize: _defaultEmojiItemModelDeserialize,
  deserializeProp: _defaultEmojiItemModelDeserializeProp,
);

int _defaultEmojiItemModelEstimateSize(
  DefaultEmojiItemModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.emojiItemId;
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

void _defaultEmojiItemModelSerialize(
  DefaultEmojiItemModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.emojiItemId);
  writer.writeString(offsets[1], object.fileId);
}

DefaultEmojiItemModel _defaultEmojiItemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DefaultEmojiItemModel(
    emojiItemId: reader.readStringOrNull(offsets[0]),
    fileId: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _defaultEmojiItemModelDeserializeProp<P>(
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

extension DefaultEmojiItemModelQueryFilter on QueryBuilder<
    DefaultEmojiItemModel, DefaultEmojiItemModel, QFilterCondition> {
  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiItemId',
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiItemId',
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emojiItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emojiItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emojiItemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emojiItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emojiItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
          QAfterFilterCondition>
      emojiItemIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emojiItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
          QAfterFilterCondition>
      emojiItemIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emojiItemId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiItemId',
        value: '',
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> emojiItemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emojiItemId',
        value: '',
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> fileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> fileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
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

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
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

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
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

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
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

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
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

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
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

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
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

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
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

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> fileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileId',
        value: '',
      ));
    });
  }

  QueryBuilder<DefaultEmojiItemModel, DefaultEmojiItemModel,
      QAfterFilterCondition> fileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileId',
        value: '',
      ));
    });
  }
}

extension DefaultEmojiItemModelQueryObject on QueryBuilder<
    DefaultEmojiItemModel, DefaultEmojiItemModel, QFilterCondition> {}
