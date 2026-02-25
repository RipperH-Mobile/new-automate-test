// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_folder_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChatFolderCollectionCollection on Isar {
  IsarCollection<ChatFolderCollection> get chatFolders => this.collection();
}

const ChatFolderCollectionSchema = CollectionSchema(
  name: r'ChatFolder',
  id: 7209620492837378699,
  properties: {
    r'displayName': PropertySchema(
      id: 0,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    ),
    r'isHidden': PropertySchema(
      id: 3,
      name: r'isHidden',
      type: IsarType.bool,
    ),
    r'isRecommended': PropertySchema(
      id: 4,
      name: r'isRecommended',
      type: IsarType.bool,
    ),
    r'isUnread': PropertySchema(
      id: 5,
      name: r'isUnread',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'orderType': PropertySchema(
      id: 7,
      name: r'orderType',
      type: IsarType.string,
      enumMap: _ChatFolderCollectionorderTypeEnumValueMap,
    ),
    r'seq': PropertySchema(
      id: 8,
      name: r'seq',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.string,
      enumMap: _ChatFolderCollectiontypeEnumValueMap,
    )
  },
  estimateSize: _chatFolderCollectionEstimateSize,
  serialize: _chatFolderCollectionSerialize,
  deserialize: _chatFolderCollectionDeserialize,
  deserializeProp: _chatFolderCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isUnread': IndexSchema(
      id: -4458356783793844610,
      name: r'isUnread',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isUnread',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isHidden': IndexSchema(
      id: 1012074769999104596,
      name: r'isHidden',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isHidden',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _chatFolderCollectionGetId,
  getLinks: _chatFolderCollectionGetLinks,
  attach: _chatFolderCollectionAttach,
  version: '3.3.0-dev.3',
);

int _chatFolderCollectionEstimateSize(
  ChatFolderCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.displayName.length * 3;
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.orderType.name.length * 3;
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _chatFolderCollectionSerialize(
  ChatFolderCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.displayName);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeString(offsets[2], object.id);
  writer.writeBool(offsets[3], object.isHidden);
  writer.writeBool(offsets[4], object.isRecommended);
  writer.writeBool(offsets[5], object.isUnread);
  writer.writeString(offsets[6], object.name);
  writer.writeString(offsets[7], object.orderType.name);
  writer.writeLong(offsets[8], object.seq);
  writer.writeString(offsets[9], object.type?.name);
}

ChatFolderCollection _chatFolderCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatFolderCollection(
    id: reader.readString(offsets[2]),
    isHidden: reader.readBoolOrNull(offsets[3]) ?? false,
    isUnread: reader.readBoolOrNull(offsets[5]) ?? false,
    name: reader.readStringOrNull(offsets[6]),
    orderType: _ChatFolderCollectionorderTypeValueEnumMap[
            reader.readStringOrNull(offsets[7])] ??
        ChatOrderType.unread,
    seq: reader.readLongOrNull(offsets[8]),
    type: _ChatFolderCollectiontypeValueEnumMap[
        reader.readStringOrNull(offsets[9])],
  );
  return object;
}

P _chatFolderCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (_ChatFolderCollectionorderTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ChatOrderType.unread) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (_ChatFolderCollectiontypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ChatFolderCollectionorderTypeEnumValueMap = {
  r'unread': r'unread',
  r'az': r'az',
  r'za': r'za',
  r'latest': r'latest',
  r'oldest': r'oldest',
};
const _ChatFolderCollectionorderTypeValueEnumMap = {
  r'unread': ChatOrderType.unread,
  r'az': ChatOrderType.az,
  r'za': ChatOrderType.za,
  r'latest': ChatOrderType.latest,
  r'oldest': ChatOrderType.oldest,
};
const _ChatFolderCollectiontypeEnumValueMap = {
  r'all': r'all',
  r'normal': r'normal',
  r'unread': r'unread',
  r'direct': r'direct',
  r'secret': r'secret',
  r'group': r'group',
  r'oa': r'oa',
};
const _ChatFolderCollectiontypeValueEnumMap = {
  r'all': ChatFolderType.all,
  r'normal': ChatFolderType.normal,
  r'unread': ChatFolderType.unread,
  r'direct': ChatFolderType.direct,
  r'secret': ChatFolderType.secret,
  r'group': ChatFolderType.group,
  r'oa': ChatFolderType.oa,
};

Id _chatFolderCollectionGetId(ChatFolderCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _chatFolderCollectionGetLinks(
    ChatFolderCollection object) {
  return [];
}

void _chatFolderCollectionAttach(
    IsarCollection<dynamic> col, Id id, ChatFolderCollection object) {}

extension ChatFolderCollectionByIndex on IsarCollection<ChatFolderCollection> {
  Future<ChatFolderCollection?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  ChatFolderCollection? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<ChatFolderCollection?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<ChatFolderCollection?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(ChatFolderCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(ChatFolderCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<ChatFolderCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<ChatFolderCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension ChatFolderCollectionQueryWhereSort
    on QueryBuilder<ChatFolderCollection, ChatFolderCollection, QWhere> {
  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhere>
      anyIsUnread() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isUnread'),
      );
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhere>
      anyIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isHidden'),
      );
    });
  }
}

extension ChatFolderCollectionQueryWhere
    on QueryBuilder<ChatFolderCollection, ChatFolderCollection, QWhereClause> {
  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      isarIdBetween(
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      isUnreadEqualTo(bool isUnread) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isUnread',
        value: [isUnread],
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      isUnreadNotEqualTo(bool isUnread) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isUnread',
              lower: [],
              upper: [isUnread],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isUnread',
              lower: [isUnread],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isUnread',
              lower: [isUnread],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isUnread',
              lower: [],
              upper: [isUnread],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      isHiddenEqualTo(bool isHidden) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isHidden',
        value: [isHidden],
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterWhereClause>
      isHiddenNotEqualTo(bool isHidden) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [],
              upper: [isHidden],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [isHidden],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [isHidden],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [],
              upper: [isHidden],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ChatFolderCollectionQueryFilter on QueryBuilder<ChatFolderCollection,
    ChatFolderCollection, QFilterCondition> {
  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> displayNameEqualTo(
    String value, {
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> displayNameGreaterThan(
    String value, {
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> displayNameLessThan(
    String value, {
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> displayNameBetween(
    String lower,
    String upper, {
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
          QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
          QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> isHiddenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> isRecommendedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRecommended',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> isUnreadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUnread',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> orderTypeEqualTo(
    ChatOrderType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> orderTypeGreaterThan(
    ChatOrderType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> orderTypeLessThan(
    ChatOrderType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> orderTypeBetween(
    ChatOrderType lower,
    ChatOrderType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> orderTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> orderTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
          QAfterFilterCondition>
      orderTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
          QAfterFilterCondition>
      orderTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orderType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> orderTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderType',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> orderTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orderType',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> seqIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'seq',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> seqIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'seq',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> seqEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seq',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> seqGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seq',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> seqLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seq',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> seqBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seq',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> typeEqualTo(
    ChatFolderType? value, {
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> typeGreaterThan(
    ChatFolderType? value, {
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> typeLessThan(
    ChatFolderType? value, {
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> typeBetween(
    ChatFolderType? lower,
    ChatFolderType? upper, {
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
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

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection,
      QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension ChatFolderCollectionQueryObject on QueryBuilder<ChatFolderCollection,
    ChatFolderCollection, QFilterCondition> {}

extension ChatFolderCollectionQueryLinks on QueryBuilder<ChatFolderCollection,
    ChatFolderCollection, QFilterCondition> {}

extension ChatFolderCollectionQuerySortBy
    on QueryBuilder<ChatFolderCollection, ChatFolderCollection, QSortBy> {
  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByIsRecommended() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecommended', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByIsRecommendedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecommended', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByIsUnread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnread', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByIsUnreadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnread', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByOrderType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByOrderTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortBySeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seq', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortBySeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seq', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChatFolderCollectionQuerySortThenBy
    on QueryBuilder<ChatFolderCollection, ChatFolderCollection, QSortThenBy> {
  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByIsRecommended() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecommended', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByIsRecommendedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecommended', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByIsUnread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnread', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByIsUnreadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnread', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByOrderType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByOrderTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenBySeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seq', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenBySeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seq', Sort.desc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChatFolderCollectionQueryWhereDistinct
    on QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct> {
  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctByDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHidden');
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctByIsRecommended() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRecommended');
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctByIsUnread() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUnread');
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctByOrderType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctBySeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seq');
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderCollection, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension ChatFolderCollectionQueryProperty on QueryBuilder<
    ChatFolderCollection, ChatFolderCollection, QQueryProperty> {
  QueryBuilder<ChatFolderCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<ChatFolderCollection, String, QQueryOperations>
      displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<ChatFolderCollection, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<ChatFolderCollection, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChatFolderCollection, bool, QQueryOperations>
      isHiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHidden');
    });
  }

  QueryBuilder<ChatFolderCollection, bool, QQueryOperations>
      isRecommendedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRecommended');
    });
  }

  QueryBuilder<ChatFolderCollection, bool, QQueryOperations>
      isUnreadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUnread');
    });
  }

  QueryBuilder<ChatFolderCollection, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ChatFolderCollection, ChatOrderType, QQueryOperations>
      orderTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderType');
    });
  }

  QueryBuilder<ChatFolderCollection, int?, QQueryOperations> seqProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seq');
    });
  }

  QueryBuilder<ChatFolderCollection, ChatFolderType?, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
