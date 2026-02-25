// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_feature_flag_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BookmarkFeatureFlagModelSchema = Schema(
  name: r'BookmarkFeatureFlagModel',
  id: -1815188574390267836,
  properties: {
    r'emojiTag': PropertySchema(
      id: 0,
      name: r'emojiTag',
      type: IsarType.bool,
    ),
    r'enabled': PropertySchema(
      id: 1,
      name: r'enabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _bookmarkFeatureFlagModelEstimateSize,
  serialize: _bookmarkFeatureFlagModelSerialize,
  deserialize: _bookmarkFeatureFlagModelDeserialize,
  deserializeProp: _bookmarkFeatureFlagModelDeserializeProp,
);

int _bookmarkFeatureFlagModelEstimateSize(
  BookmarkFeatureFlagModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _bookmarkFeatureFlagModelSerialize(
  BookmarkFeatureFlagModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.emojiTag);
  writer.writeBool(offsets[1], object.enabled);
}

BookmarkFeatureFlagModel _bookmarkFeatureFlagModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookmarkFeatureFlagModel(
    emojiTag: reader.readBoolOrNull(offsets[0]),
    enabled: reader.readBoolOrNull(offsets[1]),
  );
  return object;
}

P _bookmarkFeatureFlagModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension BookmarkFeatureFlagModelQueryFilter on QueryBuilder<
    BookmarkFeatureFlagModel, BookmarkFeatureFlagModel, QFilterCondition> {
  QueryBuilder<BookmarkFeatureFlagModel, BookmarkFeatureFlagModel,
      QAfterFilterCondition> emojiTagIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiTag',
      ));
    });
  }

  QueryBuilder<BookmarkFeatureFlagModel, BookmarkFeatureFlagModel,
      QAfterFilterCondition> emojiTagIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiTag',
      ));
    });
  }

  QueryBuilder<BookmarkFeatureFlagModel, BookmarkFeatureFlagModel,
      QAfterFilterCondition> emojiTagEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiTag',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkFeatureFlagModel, BookmarkFeatureFlagModel,
      QAfterFilterCondition> enabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<BookmarkFeatureFlagModel, BookmarkFeatureFlagModel,
      QAfterFilterCondition> enabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabled',
      ));
    });
  }

  QueryBuilder<BookmarkFeatureFlagModel, BookmarkFeatureFlagModel,
      QAfterFilterCondition> enabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }
}

extension BookmarkFeatureFlagModelQueryObject on QueryBuilder<
    BookmarkFeatureFlagModel, BookmarkFeatureFlagModel, QFilterCondition> {}
