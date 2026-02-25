// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_call_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MessageCallModelSchema = Schema(
  name: r'MessageCallModel',
  id: 6427344995179137983,
  properties: {
    r'isEndCall': PropertySchema(
      id: 0,
      name: r'isEndCall',
      type: IsarType.bool,
    ),
    r'isVideo': PropertySchema(
      id: 1,
      name: r'isVideo',
      type: IsarType.bool,
    ),
    r'isVoice': PropertySchema(
      id: 2,
      name: r'isVoice',
      type: IsarType.bool,
    ),
    r'payload': PropertySchema(
      id: 3,
      name: r'payload',
      type: IsarType.object,
      target: r'MessageCallPayloadModel',
    ),
    r'type': PropertySchema(
      id: 4,
      name: r'type',
      type: IsarType.string,
      enumMap: _MessageCallModeltypeEnumValueMap,
    )
  },
  estimateSize: _messageCallModelEstimateSize,
  serialize: _messageCallModelSerialize,
  deserialize: _messageCallModelDeserialize,
  deserializeProp: _messageCallModelDeserializeProp,
);

int _messageCallModelEstimateSize(
  MessageCallModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.payload;
    if (value != null) {
      bytesCount += 3 +
          MessageCallPayloadModelSchema.estimateSize(
              value, allOffsets[MessageCallPayloadModel]!, allOffsets);
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _messageCallModelSerialize(
  MessageCallModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isEndCall);
  writer.writeBool(offsets[1], object.isVideo);
  writer.writeBool(offsets[2], object.isVoice);
  writer.writeObject<MessageCallPayloadModel>(
    offsets[3],
    allOffsets,
    MessageCallPayloadModelSchema.serialize,
    object.payload,
  );
  writer.writeString(offsets[4], object.type?.name);
}

MessageCallModel _messageCallModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageCallModel(
    payload: reader.readObjectOrNull<MessageCallPayloadModel>(
      offsets[3],
      MessageCallPayloadModelSchema.deserialize,
      allOffsets,
    ),
    type:
        _MessageCallModeltypeValueEnumMap[reader.readStringOrNull(offsets[4])],
  );
  return object;
}

P _messageCallModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<MessageCallPayloadModel>(
        offset,
        MessageCallPayloadModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (_MessageCallModeltypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MessageCallModeltypeEnumValueMap = {
  r'decline': r'decline',
  r'timeout': r'timeout',
  r'unreachable': r'unreachable',
  r'end': r'end',
  r'join': r'join',
  r'start': r'start',
  r'leave': r'leave',
  r'unknown': r'unknown',
};
const _MessageCallModeltypeValueEnumMap = {
  r'decline': MessageCallType.decline,
  r'timeout': MessageCallType.timeout,
  r'unreachable': MessageCallType.unreachable,
  r'end': MessageCallType.end,
  r'join': MessageCallType.join,
  r'start': MessageCallType.start,
  r'leave': MessageCallType.leave,
  r'unknown': MessageCallType.unknown,
};

extension MessageCallModelQueryFilter
    on QueryBuilder<MessageCallModel, MessageCallModel, QFilterCondition> {
  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      isEndCallEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEndCall',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      isVideoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVideo',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      isVoiceEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVoice',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      payloadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'payload',
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      payloadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'payload',
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeEqualTo(
    MessageCallType? value, {
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

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeGreaterThan(
    MessageCallType? value, {
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

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeLessThan(
    MessageCallType? value, {
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

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeBetween(
    MessageCallType? lower,
    MessageCallType? upper, {
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

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeStartsWith(
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

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeEndsWith(
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

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension MessageCallModelQueryObject
    on QueryBuilder<MessageCallModel, MessageCallModel, QFilterCondition> {
  QueryBuilder<MessageCallModel, MessageCallModel, QAfterFilterCondition>
      payload(FilterQuery<MessageCallPayloadModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'payload');
    });
  }
}
