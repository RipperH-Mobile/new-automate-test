// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_account_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const GoogleAccountModelSchema = Schema(
  name: r'GoogleAccountModel',
  id: 2148085397562778382,
  properties: {
    r'email': PropertySchema(
      id: 0,
      name: r'email',
      type: IsarType.string,
    ),
    r'lastEditAt': PropertySchema(
      id: 1,
      name: r'lastEditAt',
      type: IsarType.dateTime,
    ),
    r'sub': PropertySchema(
      id: 2,
      name: r'sub',
      type: IsarType.string,
    )
  },
  estimateSize: _googleAccountModelEstimateSize,
  serialize: _googleAccountModelSerialize,
  deserialize: _googleAccountModelDeserialize,
  deserializeProp: _googleAccountModelDeserializeProp,
);

int _googleAccountModelEstimateSize(
  GoogleAccountModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sub;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _googleAccountModelSerialize(
  GoogleAccountModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.email);
  writer.writeDateTime(offsets[1], object.lastEditAt);
  writer.writeString(offsets[2], object.sub);
}

GoogleAccountModel _googleAccountModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GoogleAccountModel(
    email: reader.readStringOrNull(offsets[0]),
    lastEditAt: reader.readDateTimeOrNull(offsets[1]),
    sub: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _googleAccountModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension GoogleAccountModelQueryFilter
    on QueryBuilder<GoogleAccountModel, GoogleAccountModel, QFilterCondition> {
  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      lastEditAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastEditAt',
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      lastEditAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastEditAt',
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      lastEditAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastEditAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      lastEditAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastEditAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      lastEditAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastEditAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      lastEditAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastEditAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sub',
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sub',
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sub',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sub',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sub',
        value: '',
      ));
    });
  }

  QueryBuilder<GoogleAccountModel, GoogleAccountModel, QAfterFilterCondition>
      subIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sub',
        value: '',
      ));
    });
  }
}

extension GoogleAccountModelQueryObject
    on QueryBuilder<GoogleAccountModel, GoogleAccountModel, QFilterCondition> {}
