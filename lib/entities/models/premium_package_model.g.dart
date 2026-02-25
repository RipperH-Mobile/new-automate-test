// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_package_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PremiumPackageModelSchema = Schema(
  name: r'PremiumPackageModel',
  id: 5846813299987044178,
  properties: {
    r'appleOrderId': PropertySchema(
      id: 0,
      name: r'appleOrderId',
      type: IsarType.string,
    ),
    r'appleProductId': PropertySchema(
      id: 1,
      name: r'appleProductId',
      type: IsarType.string,
    ),
    r'expireAt': PropertySchema(
      id: 2,
      name: r'expireAt',
      type: IsarType.dateTime,
    ),
    r'googleOrderId': PropertySchema(
      id: 3,
      name: r'googleOrderId',
      type: IsarType.string,
    ),
    r'googleProductId': PropertySchema(
      id: 4,
      name: r'googleProductId',
      type: IsarType.string,
    ),
    r'isAutoRenew': PropertySchema(
      id: 5,
      name: r'isAutoRenew',
      type: IsarType.bool,
    ),
    r'nextRefundReasonAt': PropertySchema(
      id: 6,
      name: r'nextRefundReasonAt',
      type: IsarType.dateTime,
    ),
    r'nextReviewAt': PropertySchema(
      id: 7,
      name: r'nextReviewAt',
      type: IsarType.dateTime,
    ),
    r'payStore': PropertySchema(
      id: 8,
      name: r'payStore',
      type: IsarType.string,
      enumMap: _PremiumPackageModelpayStoreEnumValueMap,
    ),
    r'periodType': PropertySchema(
      id: 9,
      name: r'periodType',
      type: IsarType.string,
      enumMap: _PremiumPackageModelperiodTypeEnumValueMap,
    ),
    r'premiumPackageId': PropertySchema(
      id: 10,
      name: r'premiumPackageId',
      type: IsarType.string,
    ),
    r'premiumPackageName': PropertySchema(
      id: 11,
      name: r'premiumPackageName',
      type: IsarType.string,
    ),
    r'reviewAt': PropertySchema(
      id: 12,
      name: r'reviewAt',
      type: IsarType.dateTime,
    ),
    r'subscribeAt': PropertySchema(
      id: 13,
      name: r'subscribeAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _premiumPackageModelEstimateSize,
  serialize: _premiumPackageModelSerialize,
  deserialize: _premiumPackageModelDeserialize,
  deserializeProp: _premiumPackageModelDeserializeProp,
);

int _premiumPackageModelEstimateSize(
  PremiumPackageModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.appleOrderId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.appleProductId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.googleOrderId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.googleProductId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.payStore;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.periodType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.premiumPackageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.premiumPackageName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _premiumPackageModelSerialize(
  PremiumPackageModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appleOrderId);
  writer.writeString(offsets[1], object.appleProductId);
  writer.writeDateTime(offsets[2], object.expireAt);
  writer.writeString(offsets[3], object.googleOrderId);
  writer.writeString(offsets[4], object.googleProductId);
  writer.writeBool(offsets[5], object.isAutoRenew);
  writer.writeDateTime(offsets[6], object.nextRefundReasonAt);
  writer.writeDateTime(offsets[7], object.nextReviewAt);
  writer.writeString(offsets[8], object.payStore?.name);
  writer.writeString(offsets[9], object.periodType?.name);
  writer.writeString(offsets[10], object.premiumPackageId);
  writer.writeString(offsets[11], object.premiumPackageName);
  writer.writeDateTime(offsets[12], object.reviewAt);
  writer.writeDateTime(offsets[13], object.subscribeAt);
}

PremiumPackageModel _premiumPackageModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PremiumPackageModel(
    appleOrderId: reader.readStringOrNull(offsets[0]),
    appleProductId: reader.readStringOrNull(offsets[1]),
    expireAt: reader.readDateTimeOrNull(offsets[2]),
    googleOrderId: reader.readStringOrNull(offsets[3]),
    googleProductId: reader.readStringOrNull(offsets[4]),
    isAutoRenew: reader.readBoolOrNull(offsets[5]) ?? true,
    nextRefundReasonAt: reader.readDateTimeOrNull(offsets[6]),
    nextReviewAt: reader.readDateTimeOrNull(offsets[7]),
    payStore: _PremiumPackageModelpayStoreValueEnumMap[
        reader.readStringOrNull(offsets[8])],
    periodType: _PremiumPackageModelperiodTypeValueEnumMap[
        reader.readStringOrNull(offsets[9])],
    premiumPackageId: reader.readStringOrNull(offsets[10]),
    premiumPackageName: reader.readStringOrNull(offsets[11]),
    reviewAt: reader.readDateTimeOrNull(offsets[12]),
    subscribeAt: reader.readDateTimeOrNull(offsets[13]),
  );
  return object;
}

P _premiumPackageModelDeserializeProp<P>(
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (_PremiumPackageModelpayStoreValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 9:
      return (_PremiumPackageModelperiodTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PremiumPackageModelpayStoreEnumValueMap = {
  r'apple': r'apple',
  r'google': r'google',
};
const _PremiumPackageModelpayStoreValueEnumMap = {
  r'apple': PayStoreType.apple,
  r'google': PayStoreType.google,
};
const _PremiumPackageModelperiodTypeEnumValueMap = {
  r'none': r'none',
  r'month': r'month',
  r'year': r'year',
};
const _PremiumPackageModelperiodTypeValueEnumMap = {
  r'none': SubscriptionPeriodType.none,
  r'month': SubscriptionPeriodType.month,
  r'year': SubscriptionPeriodType.year,
};

extension PremiumPackageModelQueryFilter on QueryBuilder<PremiumPackageModel,
    PremiumPackageModel, QFilterCondition> {
  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'appleOrderId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'appleOrderId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appleOrderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appleOrderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleOrderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appleOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'appleProductId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'appleProductId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appleProductId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appleProductId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleProductId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      appleProductIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appleProductId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      expireAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      expireAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      expireAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      expireAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      expireAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      expireAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expireAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'googleOrderId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'googleOrderId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'googleOrderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'googleOrderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleOrderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'googleOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'googleProductId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'googleProductId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'googleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'googleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'googleProductId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'googleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'googleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'googleProductId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'googleProductId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleProductId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      googleProductIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'googleProductId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      isAutoRenewEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAutoRenew',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextRefundReasonAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextRefundReasonAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextRefundReasonAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextRefundReasonAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextRefundReasonAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextRefundReasonAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextRefundReasonAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextRefundReasonAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextRefundReasonAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextRefundReasonAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextRefundReasonAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextRefundReasonAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextReviewAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextReviewAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextReviewAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextReviewAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextReviewAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextReviewAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextReviewAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextReviewAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextReviewAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextReviewAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      nextReviewAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextReviewAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'payStore',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'payStore',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreEqualTo(
    PayStoreType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreGreaterThan(
    PayStoreType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreLessThan(
    PayStoreType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreBetween(
    PayStoreType? lower,
    PayStoreType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payStore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payStore',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payStore',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      payStoreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payStore',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'periodType',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'periodType',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeEqualTo(
    SubscriptionPeriodType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'periodType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeGreaterThan(
    SubscriptionPeriodType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'periodType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeLessThan(
    SubscriptionPeriodType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'periodType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeBetween(
    SubscriptionPeriodType? lower,
    SubscriptionPeriodType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'periodType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'periodType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'periodType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'periodType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'periodType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'periodType',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      periodTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'periodType',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'premiumPackageId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'premiumPackageId',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'premiumPackageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'premiumPackageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumPackageId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'premiumPackageId',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'premiumPackageName',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'premiumPackageName',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumPackageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'premiumPackageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'premiumPackageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'premiumPackageName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'premiumPackageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'premiumPackageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'premiumPackageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'premiumPackageName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumPackageName',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      premiumPackageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'premiumPackageName',
        value: '',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      reviewAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reviewAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      reviewAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reviewAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      reviewAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      reviewAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reviewAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      reviewAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reviewAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      reviewAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reviewAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      subscribeAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subscribeAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      subscribeAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subscribeAt',
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      subscribeAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subscribeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      subscribeAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subscribeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      subscribeAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subscribeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PremiumPackageModel, PremiumPackageModel, QAfterFilterCondition>
      subscribeAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subscribeAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PremiumPackageModelQueryObject on QueryBuilder<PremiumPackageModel,
    PremiumPackageModel, QFilterCondition> {}
