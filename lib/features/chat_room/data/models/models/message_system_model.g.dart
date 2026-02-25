// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_system_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MessageSystemModelSchema = Schema(
  name: r'MessageSystemModel',
  id: 9005726527254997115,
  properties: {
    r'isCallEnd': PropertySchema(
      id: 0,
      name: r'isCallEnd',
      type: IsarType.bool,
    ),
    r'payload': PropertySchema(
      id: 1,
      name: r'payload',
      type: IsarType.object,
      target: r'MessageSystemPayloadModel',
    ),
    r'type': PropertySchema(
      id: 2,
      name: r'type',
      type: IsarType.string,
      enumMap: _MessageSystemModeltypeEnumValueMap,
    )
  },
  estimateSize: _messageSystemModelEstimateSize,
  serialize: _messageSystemModelSerialize,
  deserialize: _messageSystemModelDeserialize,
  deserializeProp: _messageSystemModelDeserializeProp,
);

int _messageSystemModelEstimateSize(
  MessageSystemModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.payload;
    if (value != null) {
      bytesCount += 3 +
          MessageSystemPayloadModelSchema.estimateSize(
              value, allOffsets[MessageSystemPayloadModel]!, allOffsets);
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

void _messageSystemModelSerialize(
  MessageSystemModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isCallEnd);
  writer.writeObject<MessageSystemPayloadModel>(
    offsets[1],
    allOffsets,
    MessageSystemPayloadModelSchema.serialize,
    object.payload,
  );
  writer.writeString(offsets[2], object.type?.name);
}

MessageSystemModel _messageSystemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageSystemModel(
    payload: reader.readObjectOrNull<MessageSystemPayloadModel>(
      offsets[1],
      MessageSystemPayloadModelSchema.deserialize,
      allOffsets,
    ),
    type: _MessageSystemModeltypeValueEnumMap[
        reader.readStringOrNull(offsets[2])],
  );
  return object;
}

P _messageSystemModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<MessageSystemPayloadModel>(
        offset,
        MessageSystemPayloadModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (_MessageSystemModeltypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MessageSystemModeltypeEnumValueMap = {
  r'createGroup': r'createGroup',
  r'inviteToGroup': r'inviteToGroup',
  r'removeFromGroup': r'removeFromGroup',
  r'leaveGroup': r'leaveGroup',
  r'leaveDirectChat': r'leaveDirectChat',
  r'callStart': r'callStart',
  r'callEnd': r'callEnd',
  r'callDecline': r'callDecline',
  r'changeGroupName': r'changeGroupName',
  r'changeGroupPhoto': r'changeGroupPhoto',
  r'joinToGroup': r'joinToGroup',
  r'changeAlbumName': r'changeAlbumName',
  r'removeAlbum': r'removeAlbum',
  r'removeImageAlbum': r'removeImageAlbum',
  r'createdSecretRoom': r'createdSecretRoom',
  r'createdAlbum': r'createdAlbum',
  r'destroyedSecretRoom': r'destroyedSecretRoom',
  r'changedSecretRoomExp': r'changedSecretRoomExp',
  r'capturedScreen': r'capturedScreen',
  r'unknown': r'unknown',
  r'pinMessage': r'pinMessage',
  r'unPinMessage': r'unPinMessage',
  r'unPinAllMessage': r'unPinAllMessage',
  r'unSentMessage': r'unSentMessage',
  r'changeOwner': r'changeOwner',
};
const _MessageSystemModeltypeValueEnumMap = {
  r'createGroup': MessageSystemType.createGroup,
  r'inviteToGroup': MessageSystemType.inviteToGroup,
  r'removeFromGroup': MessageSystemType.removeFromGroup,
  r'leaveGroup': MessageSystemType.leaveGroup,
  r'leaveDirectChat': MessageSystemType.leaveDirectChat,
  r'callStart': MessageSystemType.callStart,
  r'callEnd': MessageSystemType.callEnd,
  r'callDecline': MessageSystemType.callDecline,
  r'changeGroupName': MessageSystemType.changeGroupName,
  r'changeGroupPhoto': MessageSystemType.changeGroupPhoto,
  r'joinToGroup': MessageSystemType.joinToGroup,
  r'changeAlbumName': MessageSystemType.changeAlbumName,
  r'removeAlbum': MessageSystemType.removeAlbum,
  r'removeImageAlbum': MessageSystemType.removeImageAlbum,
  r'createdSecretRoom': MessageSystemType.createdSecretRoom,
  r'createdAlbum': MessageSystemType.createdAlbum,
  r'destroyedSecretRoom': MessageSystemType.destroyedSecretRoom,
  r'changedSecretRoomExp': MessageSystemType.changedSecretRoomExp,
  r'capturedScreen': MessageSystemType.capturedScreen,
  r'unknown': MessageSystemType.unknown,
  r'pinMessage': MessageSystemType.pinMessage,
  r'unPinMessage': MessageSystemType.unPinMessage,
  r'unPinAllMessage': MessageSystemType.unPinAllMessage,
  r'unSentMessage': MessageSystemType.unSentMessage,
  r'changeOwner': MessageSystemType.changeOwner,
};

extension MessageSystemModelQueryFilter
    on QueryBuilder<MessageSystemModel, MessageSystemModel, QFilterCondition> {
  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      isCallEndEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCallEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      payloadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'payload',
      ));
    });
  }

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      payloadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'payload',
      ));
    });
  }

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeEqualTo(
    MessageSystemType? value, {
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

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeGreaterThan(
    MessageSystemType? value, {
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

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeLessThan(
    MessageSystemType? value, {
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

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeBetween(
    MessageSystemType? lower,
    MessageSystemType? upper, {
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

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
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

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
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

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension MessageSystemModelQueryObject
    on QueryBuilder<MessageSystemModel, MessageSystemModel, QFilterCondition> {
  QueryBuilder<MessageSystemModel, MessageSystemModel, QAfterFilterCondition>
      payload(FilterQuery<MessageSystemPayloadModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'payload');
    });
  }
}
