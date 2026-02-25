// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_categories_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ReactionCategoriesModelSchema = Schema(
  name: r'ReactionCategoriesModel',
  id: -57020138448417893,
  properties: {
    r'accountList': PropertySchema(
      id: 0,
      name: r'accountList',
      type: IsarType.objectList,
      target: r'AccountEmojiReactionModel',
    ),
    r'amount': PropertySchema(
      id: 1,
      name: r'amount',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'emojiId': PropertySchema(
      id: 3,
      name: r'emojiId',
      type: IsarType.string,
    ),
    r'fileId': PropertySchema(
      id: 4,
      name: r'fileId',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 5,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'msgId': PropertySchema(
      id: 6,
      name: r'msgId',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 7,
      name: r'roomId',
      type: IsarType.string,
    )
  },
  estimateSize: _reactionCategoriesModelEstimateSize,
  serialize: _reactionCategoriesModelSerialize,
  deserialize: _reactionCategoriesModelDeserialize,
  deserializeProp: _reactionCategoriesModelDeserializeProp,
);

int _reactionCategoriesModelEstimateSize(
  ReactionCategoriesModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.accountList;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[AccountEmojiReactionModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += AccountEmojiReactionModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.emojiId;
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
  {
    final value = object.msgId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roomId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _reactionCategoriesModelSerialize(
  ReactionCategoriesModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<AccountEmojiReactionModel>(
    offsets[0],
    allOffsets,
    AccountEmojiReactionModelSchema.serialize,
    object.accountList,
  );
  writer.writeLong(offsets[1], object.amount);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.emojiId);
  writer.writeString(offsets[4], object.fileId);
  writer.writeLong(offsets[5], object.hashCode);
  writer.writeString(offsets[6], object.msgId);
  writer.writeString(offsets[7], object.roomId);
}

ReactionCategoriesModel _reactionCategoriesModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReactionCategoriesModel(
    accountList: reader.readObjectList<AccountEmojiReactionModel>(
      offsets[0],
      AccountEmojiReactionModelSchema.deserialize,
      allOffsets,
      AccountEmojiReactionModel(),
    ),
    amount: reader.readLongOrNull(offsets[1]),
    createdAt: reader.readDateTimeOrNull(offsets[2]),
    emojiId: reader.readStringOrNull(offsets[3]),
    fileId: reader.readStringOrNull(offsets[4]),
    msgId: reader.readStringOrNull(offsets[6]),
    roomId: reader.readStringOrNull(offsets[7]),
  );
  return object;
}

P _reactionCategoriesModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<AccountEmojiReactionModel>(
        offset,
        AccountEmojiReactionModelSchema.deserialize,
        allOffsets,
        AccountEmojiReactionModel(),
      )) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ReactionCategoriesModelQueryFilter on QueryBuilder<
    ReactionCategoriesModel, ReactionCategoriesModel, QFilterCondition> {
  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> accountListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountList',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> accountListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountList',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> accountListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> accountListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> accountListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> accountListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> accountListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> accountListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> amountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> amountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> amountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> amountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> amountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> amountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiId',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiId',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emojiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emojiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emojiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emojiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emojiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
          QAfterFilterCondition>
      emojiIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emojiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
          QAfterFilterCondition>
      emojiIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emojiId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> emojiIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emojiId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> fileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> fileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
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

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
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

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
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

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
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

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
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

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
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

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
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

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
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

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> fileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> fileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'msgId',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'msgId',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'msgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'msgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'msgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'msgId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'msgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'msgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
          QAfterFilterCondition>
      msgIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'msgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
          QAfterFilterCondition>
      msgIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'msgId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'msgId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> msgIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'msgId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
          QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
          QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
      QAfterFilterCondition> roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }
}

extension ReactionCategoriesModelQueryObject on QueryBuilder<
    ReactionCategoriesModel, ReactionCategoriesModel, QFilterCondition> {
  QueryBuilder<ReactionCategoriesModel, ReactionCategoriesModel,
          QAfterFilterCondition>
      accountListElement(FilterQuery<AccountEmojiReactionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'accountList');
    });
  }
}
