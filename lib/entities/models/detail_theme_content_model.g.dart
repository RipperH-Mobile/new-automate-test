// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_theme_content_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DetailThemeContentModelSchema = Schema(
  name: r'DetailThemeContentModel',
  id: 6776973275717279566,
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
  estimateSize: _detailThemeContentModelEstimateSize,
  serialize: _detailThemeContentModelSerialize,
  deserialize: _detailThemeContentModelDeserialize,
  deserializeProp: _detailThemeContentModelDeserializeProp,
);

int _detailThemeContentModelEstimateSize(
  DetailThemeContentModel object,
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

void _detailThemeContentModelSerialize(
  DetailThemeContentModel object,
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

DetailThemeContentModel _detailThemeContentModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DetailThemeContentModel(
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

P _detailThemeContentModelDeserializeProp<P>(
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

extension DetailThemeContentModelQueryFilter on QueryBuilder<
    DetailThemeContentModel, DetailThemeContentModel, QFilterCondition> {
  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> linkUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkUrl',
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> linkUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkUrl',
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> linkUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> linkUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'linkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> orderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> orderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> orderEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
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

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }
}

extension DetailThemeContentModelQueryObject on QueryBuilder<
    DetailThemeContentModel, DetailThemeContentModel, QFilterCondition> {
  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
          QAfterFilterCondition>
      description(FilterQuery<PremiumPackageLanguageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'description');
    });
  }

  QueryBuilder<DetailThemeContentModel, DetailThemeContentModel,
      QAfterFilterCondition> title(FilterQuery<PremiumPackageLanguageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'title');
    });
  }
}
