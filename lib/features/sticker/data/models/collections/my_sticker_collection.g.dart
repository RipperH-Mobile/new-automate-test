// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_sticker_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMyStickerCollectionCollection on Isar {
  IsarCollection<MyStickerCollection> get myStickers => this.collection();
}

const MyStickerCollectionSchema = CollectionSchema(
  name: r'MyStickers',
  id: -6240879018675623177,
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
    r'expireAt': PropertySchema(
      id: 4,
      name: r'expireAt',
      type: IsarType.dateTime,
    ),
    r'favouriteAt': PropertySchema(
      id: 5,
      name: r'favouriteAt',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.string,
    ),
    r'isDefault': PropertySchema(
      id: 7,
      name: r'isDefault',
      type: IsarType.bool,
    ),
    r'isDownloaded': PropertySchema(
      id: 8,
      name: r'isDownloaded',
      type: IsarType.bool,
    ),
    r'isExpire': PropertySchema(
      id: 9,
      name: r'isExpire',
      type: IsarType.bool,
    ),
    r'isFavorite': PropertySchema(
      id: 10,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'isOwner': PropertySchema(
      id: 11,
      name: r'isOwner',
      type: IsarType.bool,
    ),
    r'isPublish': PropertySchema(
      id: 12,
      name: r'isPublish',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 13,
      name: r'name',
      type: IsarType.string,
    ),
    r'orderNo': PropertySchema(
      id: 14,
      name: r'orderNo',
      type: IsarType.long,
    ),
    r'popular': PropertySchema(
      id: 15,
      name: r'popular',
      type: IsarType.long,
    ),
    r'price': PropertySchema(
      id: 16,
      name: r'price',
      type: IsarType.double,
    ),
    r'publisher': PropertySchema(
      id: 17,
      name: r'publisher',
      type: IsarType.string,
    ),
    r'receivedAt': PropertySchema(
      id: 18,
      name: r'receivedAt',
      type: IsarType.dateTime,
    ),
    r'recommend': PropertySchema(
      id: 19,
      name: r'recommend',
      type: IsarType.bool,
    ),
    r'seq': PropertySchema(
      id: 20,
      name: r'seq',
      type: IsarType.long,
    ),
    r'tags': PropertySchema(
      id: 21,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'updatedAt': PropertySchema(
      id: 22,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _myStickerCollectionEstimateSize,
  serialize: _myStickerCollectionSerialize,
  deserialize: _myStickerCollectionDeserialize,
  deserializeProp: _myStickerCollectionDeserializeProp,
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
    r'seq': IndexSchema(
      id: -6951239953445392806,
      name: r'seq',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'seq',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'expireAt': IndexSchema(
      id: -3816823435115541070,
      name: r'expireAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'expireAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'favouriteAt': IndexSchema(
      id: 3386889060392108717,
      name: r'favouriteAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'favouriteAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'orderNo': IndexSchema(
      id: -8490363104718318756,
      name: r'orderNo',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'orderNo',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isExpire': IndexSchema(
      id: 317662286963004677,
      name: r'isExpire',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isExpire',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'stickerItems': LinkSchema(
      id: 2491192136898089144,
      name: r'stickerItems',
      target: r'Sticker',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _myStickerCollectionGetId,
  getLinks: _myStickerCollectionGetLinks,
  attach: _myStickerCollectionAttach,
  version: '3.3.0-dev.3',
);

int _myStickerCollectionEstimateSize(
  MyStickerCollection object,
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

void _myStickerCollectionSerialize(
  MyStickerCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.coverId);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeBool(offsets[2], object.deleted);
  writer.writeString(offsets[3], object.description);
  writer.writeDateTime(offsets[4], object.expireAt);
  writer.writeDateTime(offsets[5], object.favouriteAt);
  writer.writeString(offsets[6], object.id);
  writer.writeBool(offsets[7], object.isDefault);
  writer.writeBool(offsets[8], object.isDownloaded);
  writer.writeBool(offsets[9], object.isExpire);
  writer.writeBool(offsets[10], object.isFavorite);
  writer.writeBool(offsets[11], object.isOwner);
  writer.writeBool(offsets[12], object.isPublish);
  writer.writeString(offsets[13], object.name);
  writer.writeLong(offsets[14], object.orderNo);
  writer.writeLong(offsets[15], object.popular);
  writer.writeDouble(offsets[16], object.price);
  writer.writeString(offsets[17], object.publisher);
  writer.writeDateTime(offsets[18], object.receivedAt);
  writer.writeBool(offsets[19], object.recommend);
  writer.writeLong(offsets[20], object.seq);
  writer.writeStringList(offsets[21], object.tags);
  writer.writeDateTime(offsets[22], object.updatedAt);
}

MyStickerCollection _myStickerCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MyStickerCollection(
    coverId: reader.readStringOrNull(offsets[0]),
    createdAt: reader.readDateTimeOrNull(offsets[1]),
    deleted: reader.readBoolOrNull(offsets[2]),
    description: reader.readStringOrNull(offsets[3]),
    expireAt: reader.readDateTimeOrNull(offsets[4]),
    favouriteAt: reader.readDateTimeOrNull(offsets[5]),
    id: reader.readString(offsets[6]),
    isDefault: reader.readBoolOrNull(offsets[7]),
    isDownloaded: reader.readBoolOrNull(offsets[8]),
    isFavorite: reader.readBoolOrNull(offsets[10]),
    isOwner: reader.readBoolOrNull(offsets[11]),
    isPublish: reader.readBoolOrNull(offsets[12]),
    name: reader.readStringOrNull(offsets[13]),
    popular: reader.readLongOrNull(offsets[15]),
    price: reader.readDoubleOrNull(offsets[16]),
    publisher: reader.readStringOrNull(offsets[17]),
    receivedAt: reader.readDateTimeOrNull(offsets[18]),
    recommend: reader.readBoolOrNull(offsets[19]),
    seq: reader.readLongOrNull(offsets[20]),
    tags: reader.readStringList(offsets[21]),
    updatedAt: reader.readDateTimeOrNull(offsets[22]),
  );
  return object;
}

P _myStickerCollectionDeserializeProp<P>(
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readBoolOrNull(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 19:
      return (reader.readBoolOrNull(offset)) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (reader.readStringList(offset)) as P;
    case 22:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _myStickerCollectionGetId(MyStickerCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _myStickerCollectionGetLinks(
    MyStickerCollection object) {
  return [object.stickerItems];
}

void _myStickerCollectionAttach(
    IsarCollection<dynamic> col, Id id, MyStickerCollection object) {
  object.stickerItems.attach(
      col, col.isar.collection<StickerCollection>(), r'stickerItems', id);
}

extension MyStickerCollectionByIndex on IsarCollection<MyStickerCollection> {
  Future<MyStickerCollection?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  MyStickerCollection? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<MyStickerCollection?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<MyStickerCollection?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(MyStickerCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(MyStickerCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<MyStickerCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<MyStickerCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension MyStickerCollectionQueryWhereSort
    on QueryBuilder<MyStickerCollection, MyStickerCollection, QWhere> {
  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyTagsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'tags'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDefault'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDownloaded'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isPublish'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'price'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyRecommend() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'recommend'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isFavorite'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere> anySeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'seq'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'expireAt'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyFavouriteAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'favouriteAt'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyOrderNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'orderNo'),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhere>
      anyIsExpire() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isExpire'),
      );
    });
  }
}

extension MyStickerCollectionQueryWhere
    on QueryBuilder<MyStickerCollection, MyStickerCollection, QWhereClause> {
  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      nameEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      tagsElementEqualTo(String tagsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tags',
        value: [tagsElement],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      tagsElementNotEqualTo(String tagsElement) {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      tagsElementGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      tagsElementLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      tagsElementBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      tagsElementStartsWith(String TagsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tags',
        lower: [TagsElementPrefix],
        upper: ['$TagsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tags',
        value: [''],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      tagsElementIsNotEmpty() {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      createdAtEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      updatedAtEqualTo(DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isDefaultIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDefault',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isDefaultIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isDefault',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isDefaultEqualTo(bool? isDefault) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDefault',
        value: [isDefault],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isDefaultNotEqualTo(bool? isDefault) {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isDownloadedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDownloaded',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isDownloadedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isDownloaded',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isDownloadedEqualTo(bool? isDownloaded) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDownloaded',
        value: [isDownloaded],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isDownloadedNotEqualTo(bool? isDownloaded) {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isPublishIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPublish',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isPublishIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isPublish',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isPublishEqualTo(bool? isPublish) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPublish',
        value: [isPublish],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isPublishNotEqualTo(bool? isPublish) {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'price',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'price',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      priceEqualTo(double? price) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'price',
        value: [price],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      priceNotEqualTo(double? price) {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      priceGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      priceLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      priceBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      recommendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'recommend',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      recommendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recommend',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      recommendEqualTo(bool? recommend) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'recommend',
        value: [recommend],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      recommendNotEqualTo(bool? recommend) {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isFavoriteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isFavorite',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isFavoriteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isFavorite',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isFavoriteEqualTo(bool? isFavorite) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isFavorite',
        value: [isFavorite],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isFavoriteNotEqualTo(bool? isFavorite) {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      publisherIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'publisher',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      publisherIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'publisher',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      publisherEqualTo(String? publisher) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'publisher',
        value: [publisher],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      publisherNotEqualTo(String? publisher) {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      seqIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'seq',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      seqIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'seq',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      seqEqualTo(int? seq) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'seq',
        value: [seq],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      seqNotEqualTo(int? seq) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seq',
              lower: [],
              upper: [seq],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seq',
              lower: [seq],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seq',
              lower: [seq],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seq',
              lower: [],
              upper: [seq],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      seqGreaterThan(
    int? seq, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'seq',
        lower: [seq],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      seqLessThan(
    int? seq, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'seq',
        lower: [],
        upper: [seq],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      seqBetween(
    int? lowerSeq,
    int? upperSeq, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'seq',
        lower: [lowerSeq],
        includeLower: includeLower,
        upper: [upperSeq],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      expireAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'expireAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      expireAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expireAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      expireAtEqualTo(DateTime? expireAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'expireAt',
        value: [expireAt],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      expireAtNotEqualTo(DateTime? expireAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expireAt',
              lower: [],
              upper: [expireAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expireAt',
              lower: [expireAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expireAt',
              lower: [expireAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expireAt',
              lower: [],
              upper: [expireAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      expireAtGreaterThan(
    DateTime? expireAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expireAt',
        lower: [expireAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      expireAtLessThan(
    DateTime? expireAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expireAt',
        lower: [],
        upper: [expireAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      expireAtBetween(
    DateTime? lowerExpireAt,
    DateTime? upperExpireAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expireAt',
        lower: [lowerExpireAt],
        includeLower: includeLower,
        upper: [upperExpireAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      favouriteAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'favouriteAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      favouriteAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'favouriteAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      favouriteAtEqualTo(DateTime? favouriteAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'favouriteAt',
        value: [favouriteAt],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      favouriteAtNotEqualTo(DateTime? favouriteAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favouriteAt',
              lower: [],
              upper: [favouriteAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favouriteAt',
              lower: [favouriteAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favouriteAt',
              lower: [favouriteAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favouriteAt',
              lower: [],
              upper: [favouriteAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      favouriteAtGreaterThan(
    DateTime? favouriteAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'favouriteAt',
        lower: [favouriteAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      favouriteAtLessThan(
    DateTime? favouriteAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'favouriteAt',
        lower: [],
        upper: [favouriteAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      favouriteAtBetween(
    DateTime? lowerFavouriteAt,
    DateTime? upperFavouriteAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'favouriteAt',
        lower: [lowerFavouriteAt],
        includeLower: includeLower,
        upper: [upperFavouriteAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      orderNoEqualTo(int orderNo) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orderNo',
        value: [orderNo],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      orderNoNotEqualTo(int orderNo) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderNo',
              lower: [],
              upper: [orderNo],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderNo',
              lower: [orderNo],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderNo',
              lower: [orderNo],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderNo',
              lower: [],
              upper: [orderNo],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      orderNoGreaterThan(
    int orderNo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderNo',
        lower: [orderNo],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      orderNoLessThan(
    int orderNo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderNo',
        lower: [],
        upper: [orderNo],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      orderNoBetween(
    int lowerOrderNo,
    int upperOrderNo, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderNo',
        lower: [lowerOrderNo],
        includeLower: includeLower,
        upper: [upperOrderNo],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isExpireEqualTo(bool isExpire) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isExpire',
        value: [isExpire],
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterWhereClause>
      isExpireNotEqualTo(bool isExpire) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isExpire',
              lower: [],
              upper: [isExpire],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isExpire',
              lower: [isExpire],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isExpire',
              lower: [isExpire],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isExpire',
              lower: [],
              upper: [isExpire],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MyStickerCollectionQueryFilter on QueryBuilder<MyStickerCollection,
    MyStickerCollection, QFilterCondition> {
  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coverId',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coverId',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdEqualTo(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdStartsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdEndsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverId',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      coverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverId',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      createdAtGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      createdAtLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      createdAtBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      deletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      deletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deleted',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      deletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleted',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionEqualTo(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionStartsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionEndsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      expireAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      expireAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      expireAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      expireAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      expireAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      expireAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expireAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      favouriteAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'favouriteAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      favouriteAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'favouriteAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      favouriteAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favouriteAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      favouriteAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'favouriteAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      favouriteAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'favouriteAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      favouriteAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'favouriteAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idEqualTo(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idEndsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isDefaultIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDefault',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isDefaultIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDefault',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isDefaultEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDefault',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isDownloadedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDownloaded',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isDownloadedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDownloaded',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isDownloadedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDownloaded',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isExpireEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpire',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isFavoriteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isFavorite',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isFavoriteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isFavorite',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isFavoriteEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isOwnerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isOwner',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isOwnerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isOwner',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isOwnerEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOwner',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isPublishIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPublish',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isPublishIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPublish',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isPublishEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPublish',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isarIdGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isarIdLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      isarIdBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      orderNoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderNo',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      orderNoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderNo',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      orderNoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderNo',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      orderNoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      popularIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'popular',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      popularIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'popular',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      popularEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'popular',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      popularGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      popularLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      popularBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      priceEqualTo(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      priceGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      priceLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      priceBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'publisher',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'publisher',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherEqualTo(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherStartsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherEndsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'publisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'publisher',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publisher',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      publisherIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'publisher',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      receivedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'receivedAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      receivedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'receivedAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      receivedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receivedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      receivedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receivedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      receivedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receivedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      receivedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receivedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      recommendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recommend',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      recommendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recommend',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      recommendEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recommend',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      seqIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'seq',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      seqIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'seq',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      seqEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seq',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      seqGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      seqLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      seqBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementEqualTo(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementStartsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementEndsWith(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsIsEmpty() {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsIsNotEmpty() {
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsLengthLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsLengthGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      tagsLengthBetween(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      updatedAtGreaterThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      updatedAtLessThan(
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

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      updatedAtBetween(
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

extension MyStickerCollectionQueryObject on QueryBuilder<MyStickerCollection,
    MyStickerCollection, QFilterCondition> {}

extension MyStickerCollectionQueryLinks on QueryBuilder<MyStickerCollection,
    MyStickerCollection, QFilterCondition> {
  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      stickerItems(FilterQuery<StickerCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stickerItems');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      stickerItemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickerItems', length, true, length, true);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      stickerItemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickerItems', 0, true, 0, true);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      stickerItemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickerItems', 0, false, 999999, true);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      stickerItemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickerItems', 0, true, length, include);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      stickerItemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickerItems', length, include, 999999, true);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>
      stickerItemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'stickerItems', lower, includeLower, upper, includeUpper);
    });
  }
}

extension MyStickerCollectionQuerySortBy
    on QueryBuilder<MyStickerCollection, MyStickerCollection, QSortBy> {
  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByCoverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverId', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByCoverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverId', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByExpireAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByFavouriteAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favouriteAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByFavouriteAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favouriteAt', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsDownloadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsExpire() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpire', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsExpireDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpire', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByIsPublishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByOrderNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNo', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByOrderNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNo', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByPopularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByPublisher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByPublisherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByReceivedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByReceivedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByRecommend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommend', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByRecommendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommend', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortBySeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seq', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortBySeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seq', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension MyStickerCollectionQuerySortThenBy
    on QueryBuilder<MyStickerCollection, MyStickerCollection, QSortThenBy> {
  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByCoverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverId', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByCoverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverId', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByExpireAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByFavouriteAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favouriteAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByFavouriteAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favouriteAt', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsDownloadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsExpire() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpire', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsExpireDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpire', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsPublishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublish', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByOrderNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNo', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByOrderNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNo', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByPopularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByPublisher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByPublisherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByReceivedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByReceivedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByRecommend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommend', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByRecommendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommend', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenBySeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seq', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenBySeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seq', Sort.desc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension MyStickerCollectionQueryWhereDistinct
    on QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct> {
  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByCoverId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deleted');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expireAt');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByFavouriteAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'favouriteAt');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDefault');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDownloaded');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByIsExpire() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpire');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOwner');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByIsPublish() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPublish');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByOrderNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderNo');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'popular');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByPublisher({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'publisher', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByReceivedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receivedAt');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByRecommend() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recommend');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctBySeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seq');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<MyStickerCollection, MyStickerCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension MyStickerCollectionQueryProperty
    on QueryBuilder<MyStickerCollection, MyStickerCollection, QQueryProperty> {
  QueryBuilder<MyStickerCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<MyStickerCollection, String?, QQueryOperations>
      coverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverId');
    });
  }

  QueryBuilder<MyStickerCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MyStickerCollection, bool?, QQueryOperations> deletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deleted');
    });
  }

  QueryBuilder<MyStickerCollection, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<MyStickerCollection, DateTime?, QQueryOperations>
      expireAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expireAt');
    });
  }

  QueryBuilder<MyStickerCollection, DateTime?, QQueryOperations>
      favouriteAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'favouriteAt');
    });
  }

  QueryBuilder<MyStickerCollection, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MyStickerCollection, bool?, QQueryOperations>
      isDefaultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDefault');
    });
  }

  QueryBuilder<MyStickerCollection, bool?, QQueryOperations>
      isDownloadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDownloaded');
    });
  }

  QueryBuilder<MyStickerCollection, bool, QQueryOperations> isExpireProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpire');
    });
  }

  QueryBuilder<MyStickerCollection, bool?, QQueryOperations>
      isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<MyStickerCollection, bool?, QQueryOperations> isOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOwner');
    });
  }

  QueryBuilder<MyStickerCollection, bool?, QQueryOperations>
      isPublishProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPublish');
    });
  }

  QueryBuilder<MyStickerCollection, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MyStickerCollection, int, QQueryOperations> orderNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderNo');
    });
  }

  QueryBuilder<MyStickerCollection, int?, QQueryOperations> popularProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'popular');
    });
  }

  QueryBuilder<MyStickerCollection, double?, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<MyStickerCollection, String?, QQueryOperations>
      publisherProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'publisher');
    });
  }

  QueryBuilder<MyStickerCollection, DateTime?, QQueryOperations>
      receivedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receivedAt');
    });
  }

  QueryBuilder<MyStickerCollection, bool?, QQueryOperations>
      recommendProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recommend');
    });
  }

  QueryBuilder<MyStickerCollection, int?, QQueryOperations> seqProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seq');
    });
  }

  QueryBuilder<MyStickerCollection, List<String>?, QQueryOperations>
      tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<MyStickerCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
