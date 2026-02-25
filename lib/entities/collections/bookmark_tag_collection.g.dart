// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_tag_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookmarkTagCollectionCollection on Isar {
  IsarCollection<BookmarkTagCollection> get bookmarkTag => this.collection();
}

const BookmarkTagCollectionSchema = CollectionSchema(
  name: r'BookmarkTag',
  id: 6738793649206123814,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'defaultName': PropertySchema(
      id: 1,
      name: r'defaultName',
      type: IsarType.string,
    ),
    r'emojiTagId': PropertySchema(
      id: 2,
      name: r'emojiTagId',
      type: IsarType.string,
    ),
    r'fileId': PropertySchema(
      id: 3,
      name: r'fileId',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'localDbId': PropertySchema(
      id: 5,
      name: r'localDbId',
      type: IsarType.string,
    ),
    r'msgId': PropertySchema(
      id: 6,
      name: r'msgId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 8,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _bookmarkTagCollectionEstimateSize,
  serialize: _bookmarkTagCollectionSerialize,
  deserialize: _bookmarkTagCollectionDeserialize,
  deserializeProp: _bookmarkTagCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
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
    r'emojiTagId': IndexSchema(
      id: 8524261821211069880,
      name: r'emojiTagId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'emojiTagId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'defaultName': IndexSchema(
      id: 6738224552888789289,
      name: r'defaultName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'defaultName',
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
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
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
  getId: _bookmarkTagCollectionGetId,
  getLinks: _bookmarkTagCollectionGetLinks,
  attach: _bookmarkTagCollectionAttach,
  version: '3.3.0-dev.3',
);

int _bookmarkTagCollectionEstimateSize(
  BookmarkTagCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.defaultName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.emojiTagId;
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
    final value = object.id;
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
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _bookmarkTagCollectionSerialize(
  BookmarkTagCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.defaultName);
  writer.writeString(offsets[2], object.emojiTagId);
  writer.writeString(offsets[3], object.fileId);
  writer.writeString(offsets[4], object.id);
  writer.writeString(offsets[5], object.localDbId);
  writer.writeString(offsets[6], object.msgId);
  writer.writeString(offsets[7], object.name);
  writer.writeDateTime(offsets[8], object.updatedAt);
}

BookmarkTagCollection _bookmarkTagCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookmarkTagCollection(
    createdAt: reader.readDateTimeOrNull(offsets[0]),
    defaultName: reader.readStringOrNull(offsets[1]),
    emojiTagId: reader.readStringOrNull(offsets[2]),
    fileId: reader.readStringOrNull(offsets[3]),
    id: reader.readStringOrNull(offsets[4]),
    msgId: reader.readStringOrNull(offsets[6]),
    name: reader.readStringOrNull(offsets[7]),
    updatedAt: reader.readDateTimeOrNull(offsets[8]),
  );
  return object;
}

P _bookmarkTagCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
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
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bookmarkTagCollectionGetId(BookmarkTagCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _bookmarkTagCollectionGetLinks(
    BookmarkTagCollection object) {
  return [];
}

void _bookmarkTagCollectionAttach(
    IsarCollection<dynamic> col, Id id, BookmarkTagCollection object) {}

extension BookmarkTagCollectionByIndex
    on IsarCollection<BookmarkTagCollection> {
  Future<BookmarkTagCollection?> getByLocalDbId(String? localDbId) {
    return getByIndex(r'localDbId', [localDbId]);
  }

  BookmarkTagCollection? getByLocalDbIdSync(String? localDbId) {
    return getByIndexSync(r'localDbId', [localDbId]);
  }

  Future<bool> deleteByLocalDbId(String? localDbId) {
    return deleteByIndex(r'localDbId', [localDbId]);
  }

  bool deleteByLocalDbIdSync(String? localDbId) {
    return deleteByIndexSync(r'localDbId', [localDbId]);
  }

  Future<List<BookmarkTagCollection?>> getAllByLocalDbId(
      List<String?> localDbIdValues) {
    final values = localDbIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'localDbId', values);
  }

  List<BookmarkTagCollection?> getAllByLocalDbIdSync(
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

  Future<Id> putByLocalDbId(BookmarkTagCollection object) {
    return putByIndex(r'localDbId', object);
  }

  Id putByLocalDbIdSync(BookmarkTagCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'localDbId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocalDbId(List<BookmarkTagCollection> objects) {
    return putAllByIndex(r'localDbId', objects);
  }

  List<Id> putAllByLocalDbIdSync(List<BookmarkTagCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'localDbId', objects, saveLinks: saveLinks);
  }
}

extension BookmarkTagCollectionQueryWhereSort
    on QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QWhere> {
  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhere>
      anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }
}

extension BookmarkTagCollectionQueryWhere on QueryBuilder<BookmarkTagCollection,
    BookmarkTagCollection, QWhereClause> {
  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      idNotEqualTo(String? id) {
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      msgIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'msgId',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      msgIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'msgId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      msgIdEqualTo(String? msgId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'msgId',
        value: [msgId],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      msgIdNotEqualTo(String? msgId) {
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      emojiTagIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'emojiTagId',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      emojiTagIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'emojiTagId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      emojiTagIdEqualTo(String? emojiTagId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'emojiTagId',
        value: [emojiTagId],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      emojiTagIdNotEqualTo(String? emojiTagId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiTagId',
              lower: [],
              upper: [emojiTagId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiTagId',
              lower: [emojiTagId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiTagId',
              lower: [emojiTagId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'emojiTagId',
              lower: [],
              upper: [emojiTagId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      nameEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      nameNotEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      defaultNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'defaultName',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      defaultNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'defaultName',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      defaultNameEqualTo(String? defaultName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'defaultName',
        value: [defaultName],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      defaultNameNotEqualTo(String? defaultName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'defaultName',
              lower: [],
              upper: [defaultName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'defaultName',
              lower: [defaultName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'defaultName',
              lower: [defaultName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'defaultName',
              lower: [],
              upper: [defaultName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      fileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fileId',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      fileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fileId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      fileIdEqualTo(String? fileId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fileId',
        value: [fileId],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      fileIdNotEqualTo(String? fileId) {
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      createdAtEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      createdAtNotEqualTo(DateTime? createdAt) {
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      createdAtGreaterThan(
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      createdAtLessThan(
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      createdAtBetween(
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      updatedAtEqualTo(DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      updatedAtNotEqualTo(DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      updatedAtGreaterThan(
    DateTime? updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [updatedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      updatedAtLessThan(
    DateTime? updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [],
        upper: [updatedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      updatedAtBetween(
    DateTime? lowerUpdatedAt,
    DateTime? upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [lowerUpdatedAt],
        includeLower: includeLower,
        upper: [upperUpdatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      localDbIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localDbId',
        value: [null],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      localDbIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'localDbId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      localDbIdEqualTo(String? localDbId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localDbId',
        value: [localDbId],
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterWhereClause>
      localDbIdNotEqualTo(String? localDbId) {
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

extension BookmarkTagCollectionQueryFilter on QueryBuilder<
    BookmarkTagCollection, BookmarkTagCollection, QFilterCondition> {
  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defaultName',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defaultName',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
          QAfterFilterCondition>
      defaultNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
          QAfterFilterCondition>
      defaultNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultName',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> defaultNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultName',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiTagId',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiTagId',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emojiTagId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
          QAfterFilterCondition>
      emojiTagIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emojiTagId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
          QAfterFilterCondition>
      emojiTagIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emojiTagId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiTagId',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> emojiTagIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emojiTagId',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> fileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> fileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileId',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> fileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileId',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> fileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileId',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> localDbIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localDbId',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> localDbIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localDbId',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> localDbIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDbId',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> localDbIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localDbId',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> msgIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'msgId',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> msgIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'msgId',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> msgIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'msgId',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> msgIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'msgId',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
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

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection,
      QAfterFilterCondition> updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookmarkTagCollectionQueryObject on QueryBuilder<
    BookmarkTagCollection, BookmarkTagCollection, QFilterCondition> {}

extension BookmarkTagCollectionQueryLinks on QueryBuilder<BookmarkTagCollection,
    BookmarkTagCollection, QFilterCondition> {}

extension BookmarkTagCollectionQuerySortBy
    on QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QSortBy> {
  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByDefaultName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultName', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByDefaultNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultName', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByEmojiTagId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiTagId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByEmojiTagIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiTagId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByFileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByFileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByLocalDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByLocalDbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByMsgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension BookmarkTagCollectionQuerySortThenBy
    on QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QSortThenBy> {
  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByDefaultName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultName', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByDefaultNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultName', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByEmojiTagId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiTagId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByEmojiTagIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emojiTagId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByFileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByFileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByLocalDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByLocalDbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDbId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByMsgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgId', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByMsgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgId', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension BookmarkTagCollectionQueryWhereDistinct
    on QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct> {
  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct>
      distinctByDefaultName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct>
      distinctByEmojiTagId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emojiTagId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct>
      distinctByFileId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct>
      distinctByLocalDbId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localDbId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct>
      distinctByMsgId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'msgId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookmarkTagCollection, BookmarkTagCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension BookmarkTagCollectionQueryProperty on QueryBuilder<
    BookmarkTagCollection, BookmarkTagCollection, QQueryProperty> {
  QueryBuilder<BookmarkTagCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<BookmarkTagCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<BookmarkTagCollection, String?, QQueryOperations>
      defaultNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultName');
    });
  }

  QueryBuilder<BookmarkTagCollection, String?, QQueryOperations>
      emojiTagIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emojiTagId');
    });
  }

  QueryBuilder<BookmarkTagCollection, String?, QQueryOperations>
      fileIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileId');
    });
  }

  QueryBuilder<BookmarkTagCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BookmarkTagCollection, String?, QQueryOperations>
      localDbIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localDbId');
    });
  }

  QueryBuilder<BookmarkTagCollection, String?, QQueryOperations>
      msgIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'msgId');
    });
  }

  QueryBuilder<BookmarkTagCollection, String?, QQueryOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<BookmarkTagCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
