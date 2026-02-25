// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_recently_search_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStickerRecentlySearchCollectionCollection on Isar {
  IsarCollection<StickerRecentlySearchCollection> get stickerRecentlySearches =>
      this.collection();
}

const StickerRecentlySearchCollectionSchema = CollectionSchema(
  name: r'StickerRecentlySearch',
  id: 4709161966018015758,
  properties: {
    r'coverId': PropertySchema(
      id: 0,
      name: r'coverId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deleted': PropertySchema(
      id: 2,
      name: r'deleted',
      type: IsarType.bool,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 4,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'isDefault': PropertySchema(
      id: 6,
      name: r'isDefault',
      type: IsarType.bool,
    ),
    r'isDownloaded': PropertySchema(
      id: 7,
      name: r'isDownloaded',
      type: IsarType.bool,
    ),
    r'isFavorite': PropertySchema(
      id: 8,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'isOwner': PropertySchema(
      id: 9,
      name: r'isOwner',
      type: IsarType.bool,
    ),
    r'isPublish': PropertySchema(
      id: 10,
      name: r'isPublish',
      type: IsarType.bool,
    ),
    r'lastOpenedAt': PropertySchema(
      id: 11,
      name: r'lastOpenedAt',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 12,
      name: r'name',
      type: IsarType.string,
    ),
    r'popular': PropertySchema(
      id: 13,
      name: r'popular',
      type: IsarType.long,
    ),
    r'price': PropertySchema(
      id: 14,
      name: r'price',
      type: IsarType.double,
    ),
    r'publisher': PropertySchema(
      id: 15,
      name: r'publisher',
      type: IsarType.string,
    ),
    r'recommend': PropertySchema(
      id: 16,
      name: r'recommend',
      type: IsarType.bool,
    ),
    r'tags': PropertySchema(
      id: 17,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'updatedAt': PropertySchema(
      id: 18,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _stickerRecentlySearchCollectionEstimateSize,
  serialize: _stickerRecentlySearchCollectionSerialize,
  deserialize: _stickerRecentlySearchCollectionDeserialize,
  deserializeProp: _stickerRecentlySearchCollectionDeserializeProp,
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
    r'tags': IndexSchema(
      id: 4029205728550669204,
      name: r'tags',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tags',
          type: IndexType.value,
          caseSensitive: false,
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
    r'isDefault': IndexSchema(
      id: -6569979013669400724,
      name: r'isDefault',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isDefault',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isDownloaded': IndexSchema(
      id: -6442886867973844146,
      name: r'isDownloaded',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isDownloaded',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isPublish': IndexSchema(
      id: 1440005267719680533,
      name: r'isPublish',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPublish',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'price': IndexSchema(
      id: 1573330024715551856,
      name: r'price',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'price',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'recommend': IndexSchema(
      id: 122648571527372502,
      name: r'recommend',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'recommend',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isFavorite': IndexSchema(
      id: 5742774614603939776,
      name: r'isFavorite',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isFavorite',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'publisher': IndexSchema(
      id: -2921935681165768687,
      name: r'publisher',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'publisher',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'lastOpenedAt': IndexSchema(
      id: -3498580983902171062,
      name: r'lastOpenedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lastOpenedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _stickerRecentlySearchCollectionGetId,
  getLinks: _stickerRecentlySearchCollectionGetLinks,
  attach: _stickerRecentlySearchCollectionAttach,
  version: '3.3.0-dev.3',
);

int _stickerRecentlySearchCollectionEstimateSize(
  StickerRecentlySearchCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.coverId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.publisher;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.tags;
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
  return bytesCount;
}

void _stickerRecentlySearchCollectionSerialize(
  StickerRecentlySearchCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.coverId);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeBool(offsets[2], object.deleted);
  writer.writeString(offsets[3], object.description);
  writer.writeLong(offsets[4], object.hashCode);
  writer.writeString(offsets[5], object.id);
  writer.writeBool(offsets[6], object.isDefault);
  writer.writeBool(offsets[7], object.isDownloaded);
  writer.writeBool(offsets[8], object.isFavorite);
  writer.writeBool(offsets[9], object.isOwner);
  writer.writeBool(offsets[10], object.isPublish);
  writer.writeDateTime(offsets[11], object.lastOpenedAt);
  writer.writeString(offsets[12], object.name);
  writer.writeLong(offsets[13], object.popular);
  writer.writeDouble(offsets[14], object.price);
  writer.writeString(offsets[15], object.publisher);
  writer.writeBool(offsets[16], object.recommend);
  writer.writeStringList(offsets[17], object.tags);
  writer.writeDateTime(offsets[18], object.updatedAt);
}

StickerRecentlySearchCollection _stickerRecentlySearchCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StickerRecentlySearchCollection(
    coverId: reader.readStringOrNull(offsets[0]),
    createdAt: reader.readDateTimeOrNull(offsets[1]),
    deleted: reader.readBoolOrNull(offsets[2]),
    description: reader.readStringOrNull(offsets[3]),
    id: reader.readString(offsets[5]),
    isDefault: reader.readBoolOrNull(offsets[6]),
    isDownloaded: reader.readBoolOrNull(offsets[7]),
    isFavorite: reader.readBoolOrNull(offsets[8]),
    isOwner: reader.readBoolOrNull(offsets[9]),
    isPublish: reader.readBoolOrNull(offsets[10]),
    lastOpenedAt: reader.readDateTimeOrNull(offsets[11]),
    name: reader.readStringOrNull(offsets[12]),
    popular: reader.readLongOrNull(offsets[13]),
    price: reader.readDoubleOrNull(offsets[14]),
    publisher: reader.readStringOrNull(offsets[15]),
    recommend: reader.readBoolOrNull(offsets[16]),
    tags: reader.readStringList(offsets[17]),
    updatedAt: reader.readDateTimeOrNull(offsets[18]),
  );
  return object;
}

P _stickerRecentlySearchCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset)) as P;
    case 9:
      return (reader.readBoolOrNull(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readDoubleOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readBoolOrNull(offset)) as P;
    case 17:
      return (reader.readStringList(offset)) as P;
    case 18:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stickerRecentlySearchCollectionGetId(
    StickerRecentlySearchCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _stickerRecentlySearchCollectionGetLinks(
    StickerRecentlySearchCollection object) {
  return [];
}

void _stickerRecentlySearchCollectionAttach(IsarCollection<dynamic> col, Id id,
    StickerRecentlySearchCollection object) {}

extension StickerRecentlySearchCollectionByIndex
    on IsarCollection<StickerRecentlySearchCollection> {
  Future<StickerRecentlySearchCollection?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  StickerRecentlySearchCollection? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<StickerRecentlySearchCollection?>> getAllById(
      List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<StickerRecentlySearchCollection?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(StickerRecentlySearchCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(StickerRecentlySearchCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<StickerRecentlySearchCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<StickerRecentlySearchCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension StickerRecentlySearchCollectionQueryWhereSort on QueryBuilder<
    StickerRecentlySearchCollection, StickerRecentlySearchCollection, QWhere> {
  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyTagsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'tags'),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDefault'),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDownloaded'),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isPublish'),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'price'),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyRecommend() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'recommend'),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isFavorite'),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhere> anyLastOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lastOpenedAt'),
      );
    });
  }
}

extension StickerRecentlySearchCollectionQueryWhere on QueryBuilder<
    StickerRecentlySearchCollection,
    StickerRecentlySearchCollection,
    QWhereClause> {
  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> nameEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> nameNotEqualTo(String? name) {
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> tagsElementEqualTo(String tagsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tags',
        value: [tagsElement],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> tagsElementNotEqualTo(String tagsElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tags',
              lower: [],
              upper: [tagsElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tags',
              lower: [tagsElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tags',
              lower: [tagsElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tags',
              lower: [],
              upper: [tagsElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> tagsElementGreaterThan(
    String tagsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tags',
        lower: [tagsElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> tagsElementLessThan(
    String tagsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tags',
        lower: [],
        upper: [tagsElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> tagsElementBetween(
    String lowerTagsElement,
    String upperTagsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tags',
        lower: [lowerTagsElement],
        includeLower: includeLower,
        upper: [upperTagsElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> tagsElementStartsWith(String TagsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tags',
        lower: [TagsElementPrefix],
        upper: ['$TagsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tags',
        value: [''],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'tags',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'tags',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'tags',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'tags',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> createdAtEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> updatedAtEqualTo(DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> updatedAtNotEqualTo(DateTime? updatedAt) {
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> updatedAtGreaterThan(
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> updatedAtLessThan(
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> updatedAtBetween(
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isDefaultIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDefault',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isDefaultIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isDefault',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isDefaultEqualTo(bool? isDefault) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDefault',
        value: [isDefault],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isDefaultNotEqualTo(bool? isDefault) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDefault',
              lower: [],
              upper: [isDefault],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDefault',
              lower: [isDefault],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDefault',
              lower: [isDefault],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDefault',
              lower: [],
              upper: [isDefault],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isDownloadedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDownloaded',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isDownloadedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isDownloaded',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isDownloadedEqualTo(bool? isDownloaded) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDownloaded',
        value: [isDownloaded],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isDownloadedNotEqualTo(bool? isDownloaded) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDownloaded',
              lower: [],
              upper: [isDownloaded],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDownloaded',
              lower: [isDownloaded],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDownloaded',
              lower: [isDownloaded],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDownloaded',
              lower: [],
              upper: [isDownloaded],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isPublishIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPublish',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isPublishIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isPublish',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isPublishEqualTo(bool? isPublish) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPublish',
        value: [isPublish],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isPublishNotEqualTo(bool? isPublish) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPublish',
              lower: [],
              upper: [isPublish],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPublish',
              lower: [isPublish],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPublish',
              lower: [isPublish],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPublish',
              lower: [],
              upper: [isPublish],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'price',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'price',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> priceEqualTo(double? price) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'price',
        value: [price],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> priceNotEqualTo(double? price) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'price',
              lower: [],
              upper: [price],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'price',
              lower: [price],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'price',
              lower: [price],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'price',
              lower: [],
              upper: [price],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> priceGreaterThan(
    double? price, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'price',
        lower: [price],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> priceLessThan(
    double? price, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'price',
        lower: [],
        upper: [price],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> priceBetween(
    double? lowerPrice,
    double? upperPrice, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'price',
        lower: [lowerPrice],
        includeLower: includeLower,
        upper: [upperPrice],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> recommendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'recommend',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> recommendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recommend',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> recommendEqualTo(bool? recommend) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'recommend',
        value: [recommend],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> recommendNotEqualTo(bool? recommend) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recommend',
              lower: [],
              upper: [recommend],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recommend',
              lower: [recommend],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recommend',
              lower: [recommend],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recommend',
              lower: [],
              upper: [recommend],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isFavoriteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isFavorite',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isFavoriteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isFavorite',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isFavoriteEqualTo(bool? isFavorite) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isFavorite',
        value: [isFavorite],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> isFavoriteNotEqualTo(bool? isFavorite) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [],
              upper: [isFavorite],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [isFavorite],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [isFavorite],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [],
              upper: [isFavorite],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> publisherIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'publisher',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> publisherIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'publisher',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> publisherEqualTo(String? publisher) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'publisher',
        value: [publisher],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> publisherNotEqualTo(String? publisher) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'publisher',
              lower: [],
              upper: [publisher],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'publisher',
              lower: [publisher],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'publisher',
              lower: [publisher],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'publisher',
              lower: [],
              upper: [publisher],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> lastOpenedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lastOpenedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> lastOpenedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastOpenedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> lastOpenedAtEqualTo(DateTime? lastOpenedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lastOpenedAt',
        value: [lastOpenedAt],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> lastOpenedAtNotEqualTo(DateTime? lastOpenedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastOpenedAt',
              lower: [],
              upper: [lastOpenedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastOpenedAt',
              lower: [lastOpenedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastOpenedAt',
              lower: [lastOpenedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastOpenedAt',
              lower: [],
              upper: [lastOpenedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> lastOpenedAtGreaterThan(
    DateTime? lastOpenedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastOpenedAt',
        lower: [lastOpenedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> lastOpenedAtLessThan(
    DateTime? lastOpenedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastOpenedAt',
        lower: [],
        upper: [lastOpenedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterWhereClause> lastOpenedAtBetween(
    DateTime? lowerLastOpenedAt,
    DateTime? upperLastOpenedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastOpenedAt',
        lower: [lowerLastOpenedAt],
        includeLower: includeLower,
        upper: [upperLastOpenedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StickerRecentlySearchCollectionQueryFilter on QueryBuilder<
    StickerRecentlySearchCollection,
    StickerRecentlySearchCollection,
    QFilterCondition> {
  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coverId',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coverId',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
          QAfterFilterCondition>
      coverIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
          QAfterFilterCondition>
      coverIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverId',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> coverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverId',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> deletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> deletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> deletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleted',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
          QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
          QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isDefaultIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDefault',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isDefaultIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDefault',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isDefaultEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDefault',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isDownloadedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDownloaded',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isDownloadedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDownloaded',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isDownloadedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDownloaded',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isFavoriteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isFavorite',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isFavoriteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isFavorite',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isFavoriteEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isOwnerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isOwner',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isOwnerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isOwner',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isOwnerEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOwner',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isPublishIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPublish',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isPublishIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPublish',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isPublishEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPublish',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> lastOpenedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastOpenedAt',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> lastOpenedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastOpenedAt',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> lastOpenedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastOpenedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> lastOpenedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastOpenedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> lastOpenedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastOpenedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> lastOpenedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastOpenedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> popularIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'popular',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> popularIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'popular',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> popularEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'popular',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> popularGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'popular',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> popularLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'popular',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> popularBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'popular',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> priceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> priceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> priceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> priceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'publisher',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'publisher',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'publisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'publisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'publisher',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'publisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'publisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
          QAfterFilterCondition>
      publisherContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'publisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
          QAfterFilterCondition>
      publisherMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'publisher',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publisher',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> publisherIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'publisher',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> recommendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recommend',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> recommendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recommend',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> recommendEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recommend',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
          QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
          QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
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

extension StickerRecentlySearchCollectionQueryObject on QueryBuilder<
    StickerRecentlySearchCollection,
    StickerRecentlySearchCollection,
    QFilterCondition> {}

extension StickerRecentlySearchCollectionQueryLinks on QueryBuilder<
    StickerRecentlySearchCollection,
    StickerRecentlySearchCollection,
    QFilterCondition> {}

extension StickerRecentlySearchCollectionQuerySortBy on QueryBuilder<
    StickerRecentlySearchCollection, StickerRecentlySearchCollection, QSortBy> {
  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByCoverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverId', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByCoverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverId', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsDownloadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByIsPublishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByLastOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOpenedAt', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByLastOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOpenedAt', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByPopularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByPublisher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByPublisherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByRecommend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommend', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByRecommendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommend', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension StickerRecentlySearchCollectionQuerySortThenBy on QueryBuilder<
    StickerRecentlySearchCollection,
    StickerRecentlySearchCollection,
    QSortThenBy> {
  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByCoverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverId', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByCoverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverId', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsDownloadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsPublishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByLastOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOpenedAt', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByLastOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOpenedAt', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByPopularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByPublisher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByPublisherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByRecommend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommend', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByRecommendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommend', Sort.desc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension StickerRecentlySearchCollectionQueryWhereDistinct on QueryBuilder<
    StickerRecentlySearchCollection,
    StickerRecentlySearchCollection,
    QDistinct> {
  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByCoverId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deleted');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDefault');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDownloaded');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOwner');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPublish');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByLastOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastOpenedAt');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'popular');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByPublisher({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'publisher', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByRecommend() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recommend');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, StickerRecentlySearchCollection,
      QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension StickerRecentlySearchCollectionQueryProperty on QueryBuilder<
    StickerRecentlySearchCollection,
    StickerRecentlySearchCollection,
    QQueryProperty> {
  QueryBuilder<StickerRecentlySearchCollection, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, String?, QQueryOperations>
      coverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverId');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, bool?, QQueryOperations>
      deletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deleted');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, int, QQueryOperations>
      hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, String, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, bool?, QQueryOperations>
      isDefaultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDefault');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, bool?, QQueryOperations>
      isDownloadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDownloaded');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, bool?, QQueryOperations>
      isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, bool?, QQueryOperations>
      isOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOwner');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, bool?, QQueryOperations>
      isPublishProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPublish');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, DateTime?, QQueryOperations>
      lastOpenedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastOpenedAt');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, String?, QQueryOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, int?, QQueryOperations>
      popularProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'popular');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, double?, QQueryOperations>
      priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, String?, QQueryOperations>
      publisherProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'publisher');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, bool?, QQueryOperations>
      recommendProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recommend');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, List<String>?, QQueryOperations>
      tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<StickerRecentlySearchCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
