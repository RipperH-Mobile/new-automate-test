// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_category_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChatCategoryCollectionCollection on Isar {
  IsarCollection<ChatCategoryCollection> get chatCategorys => this.collection();
}

const ChatCategoryCollectionSchema = CollectionSchema(
  name: r'ChatCategory',
  id: 5858918591416741929,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.string,
    ),
    r'isUnread': PropertySchema(
      id: 1,
      name: r'isUnread',
      type: IsarType.bool,
    ),
    r'type': PropertySchema(
      id: 2,
      name: r'type',
      type: IsarType.string,
      enumMap: _ChatCategoryCollectiontypeEnumValueMap,
    )
  },
  estimateSize: _chatCategoryCollectionEstimateSize,
  serialize: _chatCategoryCollectionSerialize,
  deserialize: _chatCategoryCollectionDeserialize,
  deserializeProp: _chatCategoryCollectionDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _chatCategoryCollectionGetId,
  getLinks: _chatCategoryCollectionGetLinks,
  attach: _chatCategoryCollectionAttach,
  version: '3.3.0-dev.3',
);

int _chatCategoryCollectionEstimateSize(
  ChatCategoryCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
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

void _chatCategoryCollectionSerialize(
  ChatCategoryCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.id);
  writer.writeBool(offsets[1], object.isUnread);
  writer.writeString(offsets[2], object.type?.name);
}

ChatCategoryCollection _chatCategoryCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatCategoryCollection(
    id: reader.readStringOrNull(offsets[0]),
    isUnread: reader.readBoolOrNull(offsets[1]) ?? false,
    type: _ChatCategoryCollectiontypeValueEnumMap[
        reader.readStringOrNull(offsets[2])],
  );
  return object;
}

P _chatCategoryCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (_ChatCategoryCollectiontypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ChatCategoryCollectiontypeEnumValueMap = {
  r'all': r'all',
  r'friend': r'friend',
  r'group': r'group',
  r'oa': r'oa',
};
const _ChatCategoryCollectiontypeValueEnumMap = {
  r'all': ChatCategoryType.all,
  r'friend': ChatCategoryType.friend,
  r'group': ChatCategoryType.group,
  r'oa': ChatCategoryType.oa,
};

Id _chatCategoryCollectionGetId(ChatCategoryCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _chatCategoryCollectionGetLinks(
    ChatCategoryCollection object) {
  return [];
}

void _chatCategoryCollectionAttach(
    IsarCollection<dynamic> col, Id id, ChatCategoryCollection object) {}

extension ChatCategoryCollectionByIndex
    on IsarCollection<ChatCategoryCollection> {
  Future<ChatCategoryCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  ChatCategoryCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<ChatCategoryCollection?>> getAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<ChatCategoryCollection?> getAllByIdSync(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(ChatCategoryCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(ChatCategoryCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<ChatCategoryCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<ChatCategoryCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension ChatCategoryCollectionQueryWhereSort
    on QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QWhere> {
  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterWhere>
      anyIsUnread() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isUnread'),
      );
    });
  }
}

extension ChatCategoryCollectionQueryWhere on QueryBuilder<
    ChatCategoryCollection, ChatCategoryCollection, QWhereClause> {
  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterWhereClause> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterWhereClause> idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterWhereClause> idNotEqualTo(String? id) {
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterWhereClause> isUnreadEqualTo(bool isUnread) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isUnread',
        value: [isUnread],
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterWhereClause> isUnreadNotEqualTo(bool isUnread) {
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
}

extension ChatCategoryCollectionQueryFilter on QueryBuilder<
    ChatCategoryCollection, ChatCategoryCollection, QFilterCondition> {
  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> idEqualTo(
    String? value, {
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> idGreaterThan(
    String? value, {
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> idLessThan(
    String? value, {
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> idBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> isUnreadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUnread',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> typeEqualTo(
    ChatCategoryType? value, {
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> typeGreaterThan(
    ChatCategoryType? value, {
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> typeLessThan(
    ChatCategoryType? value, {
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> typeBetween(
    ChatCategoryType? lower,
    ChatCategoryType? upper, {
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
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

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection,
      QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension ChatCategoryCollectionQueryObject on QueryBuilder<
    ChatCategoryCollection, ChatCategoryCollection, QFilterCondition> {}

extension ChatCategoryCollectionQueryLinks on QueryBuilder<
    ChatCategoryCollection, ChatCategoryCollection, QFilterCondition> {}

extension ChatCategoryCollectionQuerySortBy
    on QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QSortBy> {
  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      sortByIsUnread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnread', Sort.asc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      sortByIsUnreadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnread', Sort.desc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChatCategoryCollectionQuerySortThenBy on QueryBuilder<
    ChatCategoryCollection, ChatCategoryCollection, QSortThenBy> {
  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      thenByIsUnread() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnread', Sort.asc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      thenByIsUnreadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnread', Sort.desc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChatCategoryCollectionQueryWhereDistinct
    on QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QDistinct> {
  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QDistinct>
      distinctByIsUnread() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUnread');
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryCollection, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension ChatCategoryCollectionQueryProperty on QueryBuilder<
    ChatCategoryCollection, ChatCategoryCollection, QQueryProperty> {
  QueryBuilder<ChatCategoryCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<ChatCategoryCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChatCategoryCollection, bool, QQueryOperations>
      isUnreadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUnread');
    });
  }

  QueryBuilder<ChatCategoryCollection, ChatCategoryType?, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
