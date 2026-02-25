// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_call_payload_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MessageCallPayloadModelSchema = Schema(
  name: r'MessageCallPayloadModel',
  id: -3720937739990832827,
  properties: {
    r'accountId': PropertySchema(
      id: 0,
      name: r'accountId',
      type: IsarType.string,
    ),
    r'callEndDuration': PropertySchema(
      id: 1,
      name: r'callEndDuration',
      type: IsarType.string,
    ),
    r'displayName': PropertySchema(
      id: 2,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'durationString': PropertySchema(
      id: 3,
      name: r'durationString',
      type: IsarType.string,
    ),
    r'isJoined': PropertySchema(
      id: 4,
      name: r'isJoined',
      type: IsarType.bool,
    ),
    r'joinedUsers': PropertySchema(
      id: 5,
      name: r'joinedUsers',
      type: IsarType.stringList,
    ),
    r'roomCallType': PropertySchema(
      id: 6,
      name: r'roomCallType',
      type: IsarType.string,
      enumMap: _MessageCallPayloadModelroomCallTypeEnumValueMap,
    )
  },
  estimateSize: _messageCallPayloadModelEstimateSize,
  serialize: _messageCallPayloadModelSerialize,
  deserialize: _messageCallPayloadModelDeserialize,
  deserializeProp: _messageCallPayloadModelDeserializeProp,
);

int _messageCallPayloadModelEstimateSize(
  MessageCallPayloadModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.accountId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.callEndDuration;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.displayName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.durationString.length * 3;
  {
    final list = object.joinedUsers;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.roomCallType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _messageCallPayloadModelSerialize(
  MessageCallPayloadModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountId);
  writer.writeString(offsets[1], object.callEndDuration);
  writer.writeString(offsets[2], object.displayName);
  writer.writeString(offsets[3], object.durationString);
  writer.writeBool(offsets[4], object.isJoined);
  writer.writeStringList(offsets[5], object.joinedUsers);
  writer.writeString(offsets[6], object.roomCallType?.name);
}

MessageCallPayloadModel _messageCallPayloadModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageCallPayloadModel(
    accountId: reader.readStringOrNull(offsets[0]),
    callEndDuration: reader.readStringOrNull(offsets[1]),
    displayName: reader.readStringOrNull(offsets[2]),
    isJoined: reader.readBoolOrNull(offsets[4]),
    joinedUsers: reader.readStringList(offsets[5]),
    roomCallType: _MessageCallPayloadModelroomCallTypeValueEnumMap[
        reader.readStringOrNull(offsets[6])],
  );
  return object;
}

P _messageCallPayloadModelDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readStringList(offset)) as P;
    case 6:
      return (_MessageCallPayloadModelroomCallTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MessageCallPayloadModelroomCallTypeEnumValueMap = {
  r'voice': r'voice',
  r'video': r'video',
  r'unknown': r'unknown',
};
const _MessageCallPayloadModelroomCallTypeValueEnumMap = {
  r'voice': MessageRoomCallType.voice,
  r'video': MessageRoomCallType.video,
  r'unknown': MessageRoomCallType.unknown,
};

extension MessageCallPayloadModelQueryFilter on QueryBuilder<
    MessageCallPayloadModel, MessageCallPayloadModel, QFilterCondition> {
  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      accountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      accountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callEndDuration',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callEndDuration',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callEndDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'callEndDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'callEndDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'callEndDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'callEndDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'callEndDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      callEndDurationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callEndDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      callEndDurationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callEndDuration',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callEndDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> callEndDurationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callEndDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> durationStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> durationStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> durationStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> durationStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> durationStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'durationString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> durationStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'durationString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      durationStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'durationString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      durationStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'durationString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> durationStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationString',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> durationStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'durationString',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> isJoinedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isJoined',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> isJoinedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isJoined',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> isJoinedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isJoined',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'joinedUsers',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'joinedUsers',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'joinedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'joinedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'joinedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'joinedUsers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'joinedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'joinedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      joinedUsersElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'joinedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      joinedUsersElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'joinedUsers',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'joinedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'joinedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'joinedUsers',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'joinedUsers',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'joinedUsers',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'joinedUsers',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'joinedUsers',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> joinedUsersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'joinedUsers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomCallType',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomCallType',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeEqualTo(
    MessageRoomCallType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomCallType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeGreaterThan(
    MessageRoomCallType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomCallType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeLessThan(
    MessageRoomCallType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomCallType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeBetween(
    MessageRoomCallType? lower,
    MessageRoomCallType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomCallType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomCallType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomCallType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      roomCallTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomCallType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
          QAfterFilterCondition>
      roomCallTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomCallType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomCallType',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallPayloadModel, MessageCallPayloadModel,
      QAfterFilterCondition> roomCallTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomCallType',
        value: '',
      ));
    });
  }
}

extension MessageCallPayloadModelQueryObject on QueryBuilder<
    MessageCallPayloadModel, MessageCallPayloadModel, QFilterCondition> {}
