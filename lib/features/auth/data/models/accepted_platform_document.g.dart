// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accepted_platform_document.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AcceptedPlatformDocumentSchema = Schema(
  name: r'AcceptedPlatformDocument',
  id: 7275792734958093197,
  properties: {
    r'acceptedAt': PropertySchema(
      id: 0,
      name: r'acceptedAt',
      type: IsarType.dateTime,
    ),
    r'major': PropertySchema(
      id: 1,
      name: r'major',
      type: IsarType.long,
    ),
    r'minor': PropertySchema(
      id: 2,
      name: r'minor',
      type: IsarType.long,
    ),
    r'patch': PropertySchema(
      id: 3,
      name: r'patch',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 4,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _acceptedPlatformDocumentEstimateSize,
  serialize: _acceptedPlatformDocumentSerialize,
  deserialize: _acceptedPlatformDocumentDeserialize,
  deserializeProp: _acceptedPlatformDocumentDeserializeProp,
);

int _acceptedPlatformDocumentEstimateSize(
  AcceptedPlatformDocument object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _acceptedPlatformDocumentSerialize(
  AcceptedPlatformDocument object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.acceptedAt);
  writer.writeLong(offsets[1], object.major);
  writer.writeLong(offsets[2], object.minor);
  writer.writeLong(offsets[3], object.patch);
  writer.writeString(offsets[4], object.type);
}

AcceptedPlatformDocument _acceptedPlatformDocumentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AcceptedPlatformDocument(
    acceptedAt: reader.readDateTimeOrNull(offsets[0]),
    major: reader.readLongOrNull(offsets[1]),
    minor: reader.readLongOrNull(offsets[2]),
    patch: reader.readLongOrNull(offsets[3]),
    type: reader.readStringOrNull(offsets[4]),
  );
  return object;
}

P _acceptedPlatformDocumentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AcceptedPlatformDocumentQueryFilter on QueryBuilder<
    AcceptedPlatformDocument, AcceptedPlatformDocument, QFilterCondition> {
  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> acceptedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'acceptedAt',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> acceptedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'acceptedAt',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> acceptedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acceptedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> acceptedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'acceptedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> acceptedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'acceptedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> acceptedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'acceptedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> majorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'major',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> majorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'major',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> majorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'major',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> majorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'major',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> majorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'major',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> majorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'major',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> minorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minor',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> minorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minor',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> minorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minor',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> minorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minor',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> minorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minor',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> minorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> patchIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'patch',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> patchIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'patch',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> patchEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patch',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> patchGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'patch',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> patchLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'patch',
        value: value,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> patchBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'patch',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
          QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
          QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<AcceptedPlatformDocument, AcceptedPlatformDocument,
      QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension AcceptedPlatformDocumentQueryObject on QueryBuilder<
    AcceptedPlatformDocument, AcceptedPlatformDocument, QFilterCondition> {}
