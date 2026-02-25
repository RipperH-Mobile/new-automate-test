// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_package_language_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PremiumPackageLanguageModelSchema = Schema(
  name: r'PremiumPackageLanguageModel',
  id: -1221706133788202185,
  properties: {
    r'en': PropertySchema(
      id: 0,
      name: r'en',
      type: IsarType.string,
    ),
    r'th': PropertySchema(
      id: 1,
      name: r'th',
      type: IsarType.string,
    )
  },
  estimateSize: _premiumPackageLanguageModelEstimateSize,
  serialize: _premiumPackageLanguageModelSerialize,
  deserialize: _premiumPackageLanguageModelDeserialize,
  deserializeProp: _premiumPackageLanguageModelDeserializeProp,
);

int _premiumPackageLanguageModelEstimateSize(
  PremiumPackageLanguageModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.en;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.th;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _premiumPackageLanguageModelSerialize(
  PremiumPackageLanguageModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.en);
  writer.writeString(offsets[1], object.th);
}

PremiumPackageLanguageModel _premiumPackageLanguageModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PremiumPackageLanguageModel(
    en: reader.readStringOrNull(offsets[0]),
    th: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _premiumPackageLanguageModelDeserializeProp<P>(
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

extension PremiumPackageLanguageModelQueryFilter on QueryBuilder<
    PremiumPackageLanguageModel,
    PremiumPackageLanguageModel,
    QFilterCondition> {
  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'en',
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'en',
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'en',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'en',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'en',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'en',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'en',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'en',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
          QAfterFilterCondition>
      enContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'en',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
          QAfterFilterCondition>
      enMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'en',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'en',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> enIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'en',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'th',
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'th',
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'th',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'th',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'th',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'th',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'th',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'th',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
          QAfterFilterCondition>
      thContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'th',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
          QAfterFilterCondition>
      thMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'th',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'th',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageLanguageModel, PremiumPackageLanguageModel,
      QAfterFilterCondition> thIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'th',
        value: '',
      ));
    });
  }
}

extension PremiumPackageLanguageModelQueryObject on QueryBuilder<
    PremiumPackageLanguageModel,
    PremiumPackageLanguageModel,
    QFilterCondition> {}
