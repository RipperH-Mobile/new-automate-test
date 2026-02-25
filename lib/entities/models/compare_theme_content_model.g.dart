// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_theme_content_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CompareThemeContentModelSchema = Schema(
  name: r'CompareThemeContentModel',
  id: -7562184118871360516,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.object,
      target: r'PremiumPackageLanguageModel',
    ),
    r'linkUrl': PropertySchema(
      id: 1,
      name: r'linkUrl',
      type: IsarType.string,
    ),
    r'order': PropertySchema(
      id: 2,
      name: r'order',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 3,
      name: r'title',
      type: IsarType.object,
      target: r'PremiumPackageLanguageModel',
    )
  },
  estimateSize: _compareThemeContentModelEstimateSize,
  serialize: _compareThemeContentModelSerialize,
  deserialize: _compareThemeContentModelDeserialize,
  deserializeProp: _compareThemeContentModelDeserializeProp,
);

int _compareThemeContentModelEstimateSize(
  CompareThemeContentModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 +
          PremiumPackageLanguageModelSchema.estimateSize(
              value, allOffsets[PremiumPackageLanguageModel]!, allOffsets);
    }
  }
  {
    final value = object.linkUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 +
          PremiumPackageLanguageModelSchema.estimateSize(
              value, allOffsets[PremiumPackageLanguageModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _compareThemeContentModelSerialize(
  CompareThemeContentModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<PremiumPackageLanguageModel>(
    offsets[0],
    allOffsets,
    PremiumPackageLanguageModelSchema.serialize,
    object.description,
  );
  writer.writeString(offsets[1], object.linkUrl);
  writer.writeLong(offsets[2], object.order);
  writer.writeObject<PremiumPackageLanguageModel>(
    offsets[3],
    allOffsets,
    PremiumPackageLanguageModelSchema.serialize,
    object.title,
  );
}

CompareThemeContentModel _compareThemeContentModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompareThemeContentModel(
    description: reader.readObjectOrNull<PremiumPackageLanguageModel>(
      offsets[0],
      PremiumPackageLanguageModelSchema.deserialize,
      allOffsets,
    ),
    linkUrl: reader.readStringOrNull(offsets[1]),
    order: reader.readLongOrNull(offsets[2]),
    title: reader.readObjectOrNull<PremiumPackageLanguageModel>(
      offsets[3],
      PremiumPackageLanguageModelSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _compareThemeContentModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<PremiumPackageLanguageModel>(
        offset,
        PremiumPackageLanguageModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<PremiumPackageLanguageModel>(
        offset,
        PremiumPackageLanguageModelSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CompareThemeContentModelQueryFilter on QueryBuilder<
    CompareThemeContentModel, CompareThemeContentModel, QFilterCondition> {
  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkUrl',
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkUrl',
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlEqualTo(
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

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlGreaterThan(
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

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlLessThan(
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

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlBetween(
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

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlStartsWith(
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

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlEndsWith(
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

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
          QAfterFilterCondition>
      linkUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'linkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
          QAfterFilterCondition>
      linkUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'linkUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> linkUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'linkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> orderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> orderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> orderEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> orderGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> orderLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> orderBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }
}

extension CompareThemeContentModelQueryObject on QueryBuilder<
    CompareThemeContentModel, CompareThemeContentModel, QFilterCondition> {
  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
          QAfterFilterCondition>
      description(FilterQuery<PremiumPackageLanguageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'description');
    });
  }

  QueryBuilder<CompareThemeContentModel, CompareThemeContentModel,
      QAfterFilterCondition> title(FilterQuery<PremiumPackageLanguageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'title');
    });
  }
}
