// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_system_payload_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MessageSystemPayloadModelSchema = Schema(
  name: r'MessageSystemPayloadModel',
  id: 8114074124884675906,
  properties: {
    r'accountId': PropertySchema(
      id: 0,
      name: r'accountId',
      type: IsarType.string,
    ),
    r'albumName': PropertySchema(
      id: 1,
      name: r'albumName',
      type: IsarType.string,
    ),
    r'callEndDuration': PropertySchema(
      id: 2,
      name: r'callEndDuration',
      type: IsarType.string,
    ),
    r'createBy': PropertySchema(
      id: 3,
      name: r'createBy',
      type: IsarType.string,
    ),
    r'createByName': PropertySchema(
      id: 4,
      name: r'createByName',
      type: IsarType.string,
    ),
    r'displayName': PropertySchema(
      id: 5,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'invitedBy': PropertySchema(
      id: 6,
      name: r'invitedBy',
      type: IsarType.string,
    ),
    r'invitedByName': PropertySchema(
      id: 7,
      name: r'invitedByName',
      type: IsarType.string,
    ),
    r'isViaLink': PropertySchema(
      id: 8,
      name: r'isViaLink',
      type: IsarType.bool,
    ),
    r'newAlbumName': PropertySchema(
      id: 9,
      name: r'newAlbumName',
      type: IsarType.string,
    ),
    r'newMemberList': PropertySchema(
      id: 10,
      name: r'newMemberList',
      type: IsarType.objectList,
      target: r'MessageSystemPayloadMemberModel',
    ),
    r'newRoomName': PropertySchema(
      id: 11,
      name: r'newRoomName',
      type: IsarType.string,
    ),
    r'oldAlbumName': PropertySchema(
      id: 12,
      name: r'oldAlbumName',
      type: IsarType.string,
    ),
    r'photoId': PropertySchema(
      id: 13,
      name: r'photoId',
      type: IsarType.string,
    ),
    r'removeMemberList': PropertySchema(
      id: 14,
      name: r'removeMemberList',
      type: IsarType.objectList,
      target: r'MessageSystemPayloadMemberModel',
    ),
    r'removedBy': PropertySchema(
      id: 15,
      name: r'removedBy',
      type: IsarType.string,
    ),
    r'removedByName': PropertySchema(
      id: 16,
      name: r'removedByName',
      type: IsarType.string,
    ),
    r'roomName': PropertySchema(
      id: 17,
      name: r'roomName',
      type: IsarType.string,
    )
  },
  estimateSize: _messageSystemPayloadModelEstimateSize,
  serialize: _messageSystemPayloadModelSerialize,
  deserialize: _messageSystemPayloadModelDeserialize,
  deserializeProp: _messageSystemPayloadModelDeserializeProp,
);

int _messageSystemPayloadModelEstimateSize(
  MessageSystemPayloadModel object,
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
    final value = object.albumName;
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
    final value = object.createBy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createByName;
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
  {
    final value = object.invitedBy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.invitedByName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.newAlbumName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.newMemberList;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[MessageSystemPayloadMemberModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += MessageSystemPayloadMemberModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.newRoomName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.oldAlbumName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.photoId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.removeMemberList;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[MessageSystemPayloadMemberModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += MessageSystemPayloadMemberModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.removedBy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.removedByName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roomName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _messageSystemPayloadModelSerialize(
  MessageSystemPayloadModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountId);
  writer.writeString(offsets[1], object.albumName);
  writer.writeString(offsets[2], object.callEndDuration);
  writer.writeString(offsets[3], object.createBy);
  writer.writeString(offsets[4], object.createByName);
  writer.writeString(offsets[5], object.displayName);
  writer.writeString(offsets[6], object.invitedBy);
  writer.writeString(offsets[7], object.invitedByName);
  writer.writeBool(offsets[8], object.isViaLink);
  writer.writeString(offsets[9], object.newAlbumName);
  writer.writeObjectList<MessageSystemPayloadMemberModel>(
    offsets[10],
    allOffsets,
    MessageSystemPayloadMemberModelSchema.serialize,
    object.newMemberList,
  );
  writer.writeString(offsets[11], object.newRoomName);
  writer.writeString(offsets[12], object.oldAlbumName);
  writer.writeString(offsets[13], object.photoId);
  writer.writeObjectList<MessageSystemPayloadMemberModel>(
    offsets[14],
    allOffsets,
    MessageSystemPayloadMemberModelSchema.serialize,
    object.removeMemberList,
  );
  writer.writeString(offsets[15], object.removedBy);
  writer.writeString(offsets[16], object.removedByName);
  writer.writeString(offsets[17], object.roomName);
}

MessageSystemPayloadModel _messageSystemPayloadModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageSystemPayloadModel(
    accountId: reader.readStringOrNull(offsets[0]),
    albumName: reader.readStringOrNull(offsets[1]),
    callEndDuration: reader.readStringOrNull(offsets[2]),
    createBy: reader.readStringOrNull(offsets[3]),
    createByName: reader.readStringOrNull(offsets[4]),
    displayName: reader.readStringOrNull(offsets[5]),
    invitedBy: reader.readStringOrNull(offsets[6]),
    invitedByName: reader.readStringOrNull(offsets[7]),
    isViaLink: reader.readBoolOrNull(offsets[8]),
    newAlbumName: reader.readStringOrNull(offsets[9]),
    newMemberList: reader.readObjectList<MessageSystemPayloadMemberModel>(
      offsets[10],
      MessageSystemPayloadMemberModelSchema.deserialize,
      allOffsets,
      MessageSystemPayloadMemberModel(),
    ),
    newRoomName: reader.readStringOrNull(offsets[11]),
    oldAlbumName: reader.readStringOrNull(offsets[12]),
    photoId: reader.readStringOrNull(offsets[13]),
    removeMemberList: reader.readObjectList<MessageSystemPayloadMemberModel>(
      offsets[14],
      MessageSystemPayloadMemberModelSchema.deserialize,
      allOffsets,
      MessageSystemPayloadMemberModel(),
    ),
    removedBy: reader.readStringOrNull(offsets[15]),
    removedByName: reader.readStringOrNull(offsets[16]),
    roomName: reader.readStringOrNull(offsets[17]),
  );
  return object;
}

P _messageSystemPayloadModelDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readObjectList<MessageSystemPayloadMemberModel>(
        offset,
        MessageSystemPayloadMemberModelSchema.deserialize,
        allOffsets,
        MessageSystemPayloadMemberModel(),
      )) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readObjectList<MessageSystemPayloadMemberModel>(
        offset,
        MessageSystemPayloadMemberModelSchema.deserialize,
        allOffsets,
        MessageSystemPayloadMemberModel(),
      )) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MessageSystemPayloadModelQueryFilter on QueryBuilder<
    MessageSystemPayloadModel, MessageSystemPayloadModel, QFilterCondition> {
  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'albumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'albumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      albumNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      albumNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> albumNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> callEndDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callEndDuration',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> callEndDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callEndDuration',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> callEndDurationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callEndDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> callEndDurationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callEndDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createBy',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createBy',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      createByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      createByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createBy',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createBy',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createByName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createByName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createByName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      createByNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      createByNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createByName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createByName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> createByNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createByName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
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

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'invitedBy',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'invitedBy',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invitedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invitedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invitedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invitedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'invitedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'invitedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      invitedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'invitedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      invitedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'invitedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invitedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'invitedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'invitedByName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'invitedByName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invitedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invitedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invitedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invitedByName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'invitedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'invitedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      invitedByNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'invitedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      invitedByNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'invitedByName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invitedByName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> invitedByNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'invitedByName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> isViaLinkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isViaLink',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> isViaLinkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isViaLink',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> isViaLinkEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isViaLink',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newAlbumName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newAlbumName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newAlbumName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'newAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'newAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      newAlbumNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'newAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      newAlbumNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'newAlbumName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newAlbumName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newAlbumNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'newAlbumName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newMemberListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newMemberList',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newMemberListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newMemberList',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newMemberListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'newMemberList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newMemberListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'newMemberList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newMemberListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'newMemberList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newMemberListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'newMemberList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newMemberListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'newMemberList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newMemberListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'newMemberList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newRoomName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newRoomName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newRoomName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'newRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'newRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      newRoomNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'newRoomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      newRoomNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'newRoomName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newRoomName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> newRoomNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'newRoomName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'oldAlbumName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'oldAlbumName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'oldAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'oldAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'oldAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'oldAlbumName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'oldAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'oldAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      oldAlbumNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'oldAlbumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      oldAlbumNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'oldAlbumName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'oldAlbumName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> oldAlbumNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'oldAlbumName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoId',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoId',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      photoIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      photoIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> photoIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removeMemberListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'removeMemberList',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removeMemberListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'removeMemberList',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removeMemberListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'removeMemberList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removeMemberListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'removeMemberList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removeMemberListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'removeMemberList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removeMemberListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'removeMemberList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removeMemberListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'removeMemberList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removeMemberListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'removeMemberList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'removedBy',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'removedBy',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'removedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'removedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'removedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'removedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'removedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'removedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      removedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'removedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      removedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'removedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'removedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'removedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'removedByName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'removedByName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'removedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'removedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'removedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'removedByName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'removedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'removedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      removedByNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'removedByName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      removedByNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'removedByName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'removedByName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> removedByNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'removedByName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomName',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      roomNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      roomNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
      QAfterFilterCondition> roomNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomName',
        value: '',
      ));
    });
  }
}

extension MessageSystemPayloadModelQueryObject on QueryBuilder<
    MessageSystemPayloadModel, MessageSystemPayloadModel, QFilterCondition> {
  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      newMemberListElement(FilterQuery<MessageSystemPayloadMemberModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'newMemberList');
    });
  }

  QueryBuilder<MessageSystemPayloadModel, MessageSystemPayloadModel,
          QAfterFilterCondition>
      removeMemberListElement(FilterQuery<MessageSystemPayloadMemberModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'removeMemberList');
    });
  }
}
