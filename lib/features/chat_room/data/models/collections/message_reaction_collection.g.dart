// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_reaction_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMessageReactionCollectionCollection on Isar {
  IsarCollection<MessageReactionCollection> get messageReaction =>
      this.collection();
}

const MessageReactionCollectionSchema = CollectionSchema(
  name: r'MessageReaction',
  id: -7622035269640019440,
  properties: {
    r'accountId': PropertySchema(
      id: 0,
      name: r'accountId',
      type: IsarType.string,
    ),
    r'avatarPath': PropertySchema(
      id: 1,
      name: r'avatarPath',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'displayName': PropertySchema(
      id: 3,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'emojiId': PropertySchema(
      id: 4,
      name: r'emojiId',
      type: IsarType.string,
    ),
    r'fileId': PropertySchema(
      id: 5,
      name: r'fileId',
      type: IsarType.string,
    ),
    r'localDbId': PropertySchema(
      id: 6,
      name: r'localDbId',
      type: IsarType.string,
    ),
    r'msgId': PropertySchema(
      id: 7,
      name: r'msgId',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 8,
      name: r'roomId',
      type: IsarType.string,
    )
  },
  estimateSize: _messageReactionCollectionEstimateSize,
  serialize: _messageReactionCollectionSerialize,
  deserialize: _messageReactionCollectionDeserialize,
  deserializeProp: _messageReactionCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'msgId': IndexSchema(
      id: 8574845111581175867,
      name: r'msgId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'msgId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'roomId': IndexSchema(
      id: -3609232324653216207,
      name: r'roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'roomId_msgId': IndexSchema(
      id: -613102785840739907,
      name: r'roomId_msgId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'msgId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'emojiId': IndexSchema(
      id: -208669683108713598,
      name: r'emojiId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'emojiId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'emojiId_msgId': IndexSchema(
      id: 4964479139785167931,
      name: r'emojiId_msgId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'emojiId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'msgId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'fileId': IndexSchema(
      id: -2092632783237962250,
      name: r'fileId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fileId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'accountId': IndexSchema(
      id: -1591555361937770434,
      name: r'accountId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'accountId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'accountId_msgId': IndexSchema(
      id: -7597677271097326490,
      name: r'accountId_msgId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'accountId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'msgId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'displayName': IndexSchema(
      id: -825365117524145674,
      name: r'displayName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'displayName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'avatarPath': IndexSchema(
      id: 7747319477212850577,
      name: r'avatarPath',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'avatarPath',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'localDbId': IndexSchema(
      id: 8389096383111614337,
      name: r'localDbId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'localDbId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _messageReactionCollectionGetId,
  getLinks: _messageReactionCollectionGetLinks,
  attach: _messageReactionCollectionAttach,
  version: '3.3.0-dev.3',
);

int _messageReactionCollectionEstimateSize(
  MessageReactionCollection object,
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
    final value = object.avatarPath;
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
    final value = object.localDbId;
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

void _messageReactionCollectionSerialize(
  MessageReactionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountId);
  writer.writeString(offsets[1], object.avatarPath);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.displayName);
  writer.writeString(offsets[4], object.emojiId);
  writer.writeString(offsets[5], object.fileId);
  writer.writeString(offsets[6], object.localDbId);
  writer.writeString(offsets[7], object.msgId);
  writer.writeString(offsets[8], object.roomId);
}

MessageReactionCollection _messageReactionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageReactionCollection(
    accountId: reader.readStringOrNull(offsets[0]),
    avatarPath: reader.readStringOrNull(offsets[1]),
    createdAt: reader.readDateTimeOrNull(offsets[2]),
    displayName: reader.readStringOrNull(offsets[3]),
    emojiId: reader.readStringOrNull(offsets[4]),
    fileId: reader.readStringOrNull(offsets[5]),
    msgId: reader.readStringOrNull(offsets[7]),
    roomId: reader.readStringOrNull(offsets[8]),
  );
  return object;
}

P _messageReactionCollectionDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _messageReactionCollectionGetId(MessageReactionCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _messageReactionCollectionGetLinks(
    MessageReactionCollection object) {
  return [];
}

void _messageReactionCollectionAttach(
    IsarCollection<dynamic> col, Id id, MessageReactionCollection object) {}

extension MessageReactionCollectionByIndex
    on IsarCollection<MessageReactionCollection> {
  Future<MessageReactionCollection?> getByLocalDbId(String? localDbId) {
    return getByIndex(r'localDbId', [localDbId]);
  }

  MessageReactionCollection? getByLocalDbIdSync(String? localDbId) {
    return getByIndexSync(r'localDbId', [localDbId]);
  }

  Future<bool> deleteByLocalDbId(String? localDbId) {
    return deleteByIndex(r'localDbId', [localDbId]);
  }

  bool deleteByLocalDbIdSync(String? localDbId) {
    return deleteByIndexSync(r'localDbId', [localDbId]);
  }

  Future<List<MessageReactionCollection?>> getAllByLocalDbId(
      List<String?> localDbIdValues) {
    final values = localDbIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'localDbId', values);
  }

  List<MessageReactionCollection?> getAllByLocalDbIdSync(
      List<String?> localDbIdValues) {
    final values = localDbIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'localDbId', values);
  }

  Future<int> deleteAllByLocalDbId(List<String?> localDbIdValues) {
    final values = localDbIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'localDbId', values);
  }

  int deleteAllByLocalDbIdSync(List<String?> localDbIdValues) {
    final values = localDbIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'localDbId', values);
  }

  Future<Id> putByLocalDbId(MessageReactionCollection object) {
    return putByIndex(r'localDbId', object);
  }

  Id putByLocalDbIdSync(MessageReactionCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'localDbId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocalDbId(List<MessageReactionCollection> objects) {
    return putAllByIndex(r'localDbId', objects);
  }

  List<Id> putAllByLocalDbIdSync(List<MessageReactionCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'localDbId', objects, saveLinks: saveLinks);
  }
}

extension MessageReactionCollectionQueryWhereSort on QueryBuilder<
    MessageReactionCollection, MessageReactionCollection, QWhere> {
  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension MessageReactionCollectionQueryWhere on QueryBuilder<
    MessageReactionCollection, MessageReactionCollection, QWhereClause> {
  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> msgIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'msgId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> msgIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'msgId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> msgIdEqualTo(String? msgId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'msgId',
        value: [msgId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> msgIdNotEqualTo(String? msgId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'msgId',
              lower: [],
              upper: [msgId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'msgId',
              lower: [msgId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'msgId',
              lower: [msgId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'msgId',
              lower: [],
              upper: [msgId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdNotEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdIsNullAnyMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId_msgId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdIsNotNullAnyMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId_msgId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdEqualToAnyMsgId(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId_msgId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdNotEqualToAnyMsgId(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_msgId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_msgId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_msgId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_msgId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdEqualToMsgIdIsNull(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId_msgId',
        value: [roomId, null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdEqualToMsgIdIsNotNull(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId_msgId',
        lower: [roomId, null],
        includeLower: false,
        upper: [
          roomId,
        ],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> roomIdMsgIdEqualTo(String? roomId, String? msgId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId_msgId',
        value: [roomId, msgId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
          QAfterWhereClause>
      roomIdEqualToMsgIdNotEqualTo(String? roomId, String? msgId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_msgId',
              lower: [roomId],
              upper: [roomId, msgId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_msgId',
              lower: [roomId, msgId],
              includeLower: false,
              upper: [roomId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_msgId',
              lower: [roomId, msgId],
              includeLower: false,
              upper: [roomId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId_msgId',
              lower: [roomId],
              upper: [roomId, msgId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'emojiId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'emojiId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdEqualTo(String? emojiId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'emojiId',
        value: [emojiId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdNotEqualTo(String? emojiId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId',
              lower: [],
              upper: [emojiId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId',
              lower: [emojiId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId',
              lower: [emojiId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId',
              lower: [],
              upper: [emojiId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdIsNullAnyMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'emojiId_msgId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdIsNotNullAnyMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'emojiId_msgId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdEqualToAnyMsgId(String? emojiId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'emojiId_msgId',
        value: [emojiId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdNotEqualToAnyMsgId(String? emojiId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId_msgId',
              lower: [],
              upper: [emojiId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId_msgId',
              lower: [emojiId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId_msgId',
              lower: [emojiId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId_msgId',
              lower: [],
              upper: [emojiId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdEqualToMsgIdIsNull(String? emojiId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'emojiId_msgId',
        value: [emojiId, null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdEqualToMsgIdIsNotNull(String? emojiId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'emojiId_msgId',
        lower: [emojiId, null],
        includeLower: false,
        upper: [
          emojiId,
        ],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> emojiIdMsgIdEqualTo(String? emojiId, String? msgId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'emojiId_msgId',
        value: [emojiId, msgId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
          QAfterWhereClause>
      emojiIdEqualToMsgIdNotEqualTo(String? emojiId, String? msgId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId_msgId',
              lower: [emojiId],
              upper: [emojiId, msgId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId_msgId',
              lower: [emojiId, msgId],
              includeLower: false,
              upper: [emojiId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId_msgId',
              lower: [emojiId, msgId],
              includeLower: false,
              upper: [emojiId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiId_msgId',
              lower: [emojiId],
              upper: [emojiId, msgId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> fileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fileId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> fileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fileId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> fileIdEqualTo(String? fileId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fileId',
        value: [fileId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> fileIdNotEqualTo(String? fileId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileId',
              lower: [],
              upper: [fileId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileId',
              lower: [fileId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileId',
              lower: [fileId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileId',
              lower: [],
              upper: [fileId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdEqualTo(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [accountId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdNotEqualTo(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId',
              lower: [],
              upper: [accountId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId',
              lower: [accountId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId',
              lower: [accountId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId',
              lower: [],
              upper: [accountId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdIsNullAnyMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId_msgId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdIsNotNullAnyMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId_msgId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdEqualToAnyMsgId(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId_msgId',
        value: [accountId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdNotEqualToAnyMsgId(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId_msgId',
              lower: [],
              upper: [accountId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId_msgId',
              lower: [accountId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId_msgId',
              lower: [accountId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId_msgId',
              lower: [],
              upper: [accountId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdEqualToMsgIdIsNull(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId_msgId',
        value: [accountId, null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> accountIdEqualToMsgIdIsNotNull(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId_msgId',
        lower: [accountId, null],
        includeLower: false,
        upper: [
          accountId,
        ],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
          QAfterWhereClause>
      accountIdMsgIdEqualTo(String? accountId, String? msgId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId_msgId',
        value: [accountId, msgId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
          QAfterWhereClause>
      accountIdEqualToMsgIdNotEqualTo(String? accountId, String? msgId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId_msgId',
              lower: [accountId],
              upper: [accountId, msgId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId_msgId',
              lower: [accountId, msgId],
              includeLower: false,
              upper: [accountId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId_msgId',
              lower: [accountId, msgId],
              includeLower: false,
              upper: [accountId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountId_msgId',
              lower: [accountId],
              upper: [accountId, msgId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'displayName',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'displayName',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> displayNameEqualTo(String? displayName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'displayName',
        value: [displayName],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> displayNameNotEqualTo(String? displayName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [],
              upper: [displayName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [displayName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [displayName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [],
              upper: [displayName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> avatarPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'avatarPath',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> avatarPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'avatarPath',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> avatarPathEqualTo(String? avatarPath) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'avatarPath',
        value: [avatarPath],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> avatarPathNotEqualTo(String? avatarPath) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarPath',
              lower: [],
              upper: [avatarPath],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarPath',
              lower: [avatarPath],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarPath',
              lower: [avatarPath],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarPath',
              lower: [],
              upper: [avatarPath],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> createdAtEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> createdAtNotEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> createdAtGreaterThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> createdAtLessThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> createdAtBetween(
    DateTime? lowerCreatedAt,
    DateTime? upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> localDbIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localDbId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> localDbIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'localDbId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> localDbIdEqualTo(String? localDbId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localDbId',
        value: [localDbId],
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterWhereClause> localDbIdNotEqualTo(String? localDbId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDbId',
              lower: [],
              upper: [localDbId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDbId',
              lower: [localDbId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDbId',
              lower: [localDbId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDbId',
              lower: [],
              upper: [localDbId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MessageReactionCollectionQueryFilter on QueryBuilder<
    MessageReactionCollection, MessageReactionCollection, QFilterCondition> {
  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarPath',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarPath',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
          QAfterFilterCondition>
      avatarPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
          QAfterFilterCondition>
      avatarPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarPath',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> avatarPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarPath',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> emojiIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> emojiIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> emojiIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> emojiIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emojiId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> fileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> fileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> fileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> fileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localDbId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localDbId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localDbId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
          QAfterFilterCondition>
      localDbIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localDbId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
          QAfterFilterCondition>
      localDbIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localDbId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDbId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> localDbIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localDbId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> msgIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'msgId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> msgIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'msgId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> msgIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'msgId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> msgIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'msgId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
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

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterFilterCondition> roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }
}

extension MessageReactionCollectionQueryObject on QueryBuilder<
    MessageReactionCollection, MessageReactionCollection, QFilterCondition> {}

extension MessageReactionCollectionQueryLinks on QueryBuilder<
    MessageReactionCollection, MessageReactionCollection, QFilterCondition> {}

extension MessageReactionCollectionQuerySortBy on QueryBuilder<
    MessageReactionCollection, MessageReactionCollection, QSortBy> {
  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByAvatarPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPath', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByAvatarPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPath', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByEmojiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByEmojiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByFileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByFileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByLocalDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByLocalDbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByMsgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }
}

extension MessageReactionCollectionQuerySortThenBy on QueryBuilder<
    MessageReactionCollection, MessageReactionCollection, QSortThenBy> {
  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByAvatarPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPath', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByAvatarPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPath', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByEmojiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByEmojiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByFileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByFileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByLocalDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByLocalDbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByMsgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgId', Sort.desc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection,
      QAfterSortBy> thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }
}

extension MessageReactionCollectionQueryWhereDistinct on QueryBuilder<
    MessageReactionCollection, MessageReactionCollection, QDistinct> {
  QueryBuilder<MessageReactionCollection, MessageReactionCollection, QDistinct>
      distinctByAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection, QDistinct>
      distinctByAvatarPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection, QDistinct>
      distinctByDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection, QDistinct>
      distinctByEmojiId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emojiId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection, QDistinct>
      distinctByFileId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection, QDistinct>
      distinctByLocalDbId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localDbId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection, QDistinct>
      distinctByMsgId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'msgId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageReactionCollection, MessageReactionCollection, QDistinct>
      distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }
}

extension MessageReactionCollectionQueryProperty on QueryBuilder<
    MessageReactionCollection, MessageReactionCollection, QQueryProperty> {
  QueryBuilder<MessageReactionCollection, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<MessageReactionCollection, String?, QQueryOperations>
      accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<MessageReactionCollection, String?, QQueryOperations>
      avatarPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarPath');
    });
  }

  QueryBuilder<MessageReactionCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MessageReactionCollection, String?, QQueryOperations>
      displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<MessageReactionCollection, String?, QQueryOperations>
      emojiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emojiId');
    });
  }

  QueryBuilder<MessageReactionCollection, String?, QQueryOperations>
      fileIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileId');
    });
  }

  QueryBuilder<MessageReactionCollection, String?, QQueryOperations>
      localDbIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localDbId');
    });
  }

  QueryBuilder<MessageReactionCollection, String?, QQueryOperations>
      msgIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'msgId');
    });
  }

  QueryBuilder<MessageReactionCollection, String?, QQueryOperations>
      roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }
}
