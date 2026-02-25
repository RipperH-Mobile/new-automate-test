// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlbumCollectionCollection on Isar {
  IsarCollection<AlbumCollection> get albums => this.collection();
}

const AlbumCollectionSchema = CollectionSchema(
  name: r'Album',
  id: -1355968412107120937,
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
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'createdBy': PropertySchema(
      id: 3,
      name: r'createdBy',
      type: IsarType.object,
      target: r'ContactModel',
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'isSuccess': PropertySchema(
      id: 5,
      name: r'isSuccess',
      type: IsarType.bool,
    ),
    r'lastTenImageInAlbum': PropertySchema(
      id: 6,
      name: r'lastTenImageInAlbum',
      type: IsarType.objectList,
      target: r'AlbumImageModel',
    ),
    r'roomId': PropertySchema(
      id: 7,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'totalImagesV2': PropertySchema(
      id: 8,
      name: r'totalImagesV2',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _albumCollectionEstimateSize,
  serialize: _albumCollectionSerialize,
  deserialize: _albumCollectionDeserialize,
  deserializeProp: _albumCollectionDeserializeProp,
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
          type: IndexType.value,
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
          type: IndexType.value,
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
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'ContactModel': ContactModelSchema,
    r'OfficialMenuModel': OfficialMenuModelSchema,
    r'OfficialMenuContainerModel': OfficialMenuContainerModelSchema,
    r'OfficialMenuCommandModel': OfficialMenuCommandModelSchema,
    r'OfficialMenuCommandArgModel': OfficialMenuCommandArgModelSchema,
    r'RichMenuModel': RichMenuModelSchema,
    r'RichMenuPublishModel': RichMenuPublishModelSchema,
    r'RichMenuContainerModel': RichMenuContainerModelSchema,
    r'RichMenuFunctionModel': RichMenuFunctionModelSchema,
    r'RichMenuBoundsModel': RichMenuBoundsModelSchema,
    r'RichMenuCommandArgModel': RichMenuCommandArgModelSchema,
    r'AccountSettingsModel': AccountSettingsModelSchema,
    r'CallSettingsModel': CallSettingsModelSchema,
    r'ChatSettingsModel': ChatSettingsModelSchema,
    r'FriendSettingsModel': FriendSettingsModelSchema,
    r'AllowFriendAddModel': AllowFriendAddModelSchema,
    r'NotificationSettingsModel': NotificationSettingsModelSchema,
    r'ProfileSettingsModel': ProfileSettingsModelSchema,
    r'SecuritySettingsModel': SecuritySettingsModelSchema,
    r'AlbumImageModel': AlbumImageModelSchema
  },
  getId: _albumCollectionGetId,
  getLinks: _albumCollectionGetLinks,
  attach: _albumCollectionAttach,
  version: '3.3.0-dev.3',
);

int _albumCollectionEstimateSize(
  AlbumCollection object,
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
    final value = object.createdBy;
    if (value != null) {
      bytesCount += 3 +
          ContactModelSchema.estimateSize(
              value, allOffsets[ContactModel]!, allOffsets);
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.lastTenImageInAlbum;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[AlbumImageModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              AlbumImageModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
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

void _albumCollectionSerialize(
  AlbumCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountId);
  writer.writeString(offsets[1], object.albumName);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeObject<ContactModel>(
    offsets[3],
    allOffsets,
    ContactModelSchema.serialize,
    object.createdBy,
  );
  writer.writeString(offsets[4], object.id);
  writer.writeBool(offsets[5], object.isSuccess);
  writer.writeObjectList<AlbumImageModel>(
    offsets[6],
    allOffsets,
    AlbumImageModelSchema.serialize,
    object.lastTenImageInAlbum,
  );
  writer.writeString(offsets[7], object.roomId);
  writer.writeLong(offsets[8], object.totalImagesV2);
  writer.writeDateTime(offsets[9], object.updatedAt);
}

AlbumCollection _albumCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AlbumCollection(
    accountId: reader.readStringOrNull(offsets[0]),
    albumName: reader.readStringOrNull(offsets[1]),
    createdAt: reader.readDateTimeOrNull(offsets[2]),
    createdBy: reader.readObjectOrNull<ContactModel>(
      offsets[3],
      ContactModelSchema.deserialize,
      allOffsets,
    ),
    id: reader.readStringOrNull(offsets[4]),
    isSuccess: reader.readBoolOrNull(offsets[5]),
    lastTenImageInAlbum: reader.readObjectList<AlbumImageModel>(
      offsets[6],
      AlbumImageModelSchema.deserialize,
      allOffsets,
      AlbumImageModel(),
    ),
    roomId: reader.readStringOrNull(offsets[7]),
    totalImagesV2: reader.readLongOrNull(offsets[8]),
    updatedAt: reader.readDateTimeOrNull(offsets[9]),
  );
  return object;
}

P _albumCollectionDeserializeProp<P>(
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
      return (reader.readObjectOrNull<ContactModel>(
        offset,
        ContactModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readObjectList<AlbumImageModel>(
        offset,
        AlbumImageModelSchema.deserialize,
        allOffsets,
        AlbumImageModel(),
      )) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _albumCollectionGetId(AlbumCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _albumCollectionGetLinks(AlbumCollection object) {
  return [];
}

void _albumCollectionAttach(
    IsarCollection<dynamic> col, Id id, AlbumCollection object) {}

extension AlbumCollectionQueryWhereSort
    on QueryBuilder<AlbumCollection, AlbumCollection, QWhere> {
  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'id'),
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhere> anyAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'accountId'),
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhere> anyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'roomId'),
      );
    });
  }
}

extension AlbumCollectionQueryWhere
    on QueryBuilder<AlbumCollection, AlbumCollection, QWhereClause> {
  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause> idEqualTo(
      String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      idGreaterThan(
    String? id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [id],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause> idLessThan(
    String? id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [],
        upper: [id],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause> idBetween(
    String? lowerId,
    String? upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [lowerId],
        includeLower: includeLower,
        upper: [upperId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      idStartsWith(String IdPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [IdPrefix],
        upper: ['$IdPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [''],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'id',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'id',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'id',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'id',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [null],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdEqualTo(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [accountId],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdNotEqualTo(String? accountId) {
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdGreaterThan(
    String? accountId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId',
        lower: [accountId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdLessThan(
    String? accountId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId',
        lower: [],
        upper: [accountId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdBetween(
    String? lowerAccountId,
    String? upperAccountId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId',
        lower: [lowerAccountId],
        includeLower: includeLower,
        upper: [upperAccountId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdStartsWith(String AccountIdPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'accountId',
        lower: [AccountIdPrefix],
        upper: ['$AccountIdPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [''],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'accountId',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'accountId',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'accountId',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'accountId',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdNotEqualTo(String? roomId) {
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdGreaterThan(
    String? roomId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [roomId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdLessThan(
    String? roomId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [],
        upper: [roomId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdBetween(
    String? lowerRoomId,
    String? upperRoomId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [lowerRoomId],
        includeLower: includeLower,
        upper: [upperRoomId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdStartsWith(String RoomIdPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [RoomIdPrefix],
        upper: ['$RoomIdPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [''],
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterWhereClause>
      roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'roomId',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'roomId',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'roomId',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'roomId',
              upper: [''],
            ));
      }
    });
  }
}

extension AlbumCollectionQueryFilter
    on QueryBuilder<AlbumCollection, AlbumCollection, QFilterCondition> {
  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdEqualTo(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdGreaterThan(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdLessThan(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdBetween(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdStartsWith(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdEndsWith(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumName',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumName',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameEqualTo(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameGreaterThan(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameLessThan(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameBetween(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameStartsWith(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameEndsWith(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumName',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      albumNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumName',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      createdByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdBy',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      createdByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdBy',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idEqualTo(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      isSuccessIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isSuccess',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      isSuccessIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isSuccess',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      isSuccessEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSuccess',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      lastTenImageInAlbumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTenImageInAlbum',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      lastTenImageInAlbumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTenImageInAlbum',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      lastTenImageInAlbumLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastTenImageInAlbum',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      lastTenImageInAlbumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastTenImageInAlbum',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      lastTenImageInAlbumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastTenImageInAlbum',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      lastTenImageInAlbumLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastTenImageInAlbum',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      lastTenImageInAlbumLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastTenImageInAlbum',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      lastTenImageInAlbumLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lastTenImageInAlbum',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdEqualTo(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdGreaterThan(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdLessThan(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdBetween(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdStartsWith(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdEndsWith(
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      totalImagesV2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalImagesV2',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      totalImagesV2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalImagesV2',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      totalImagesV2EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalImagesV2',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      totalImagesV2GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalImagesV2',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      totalImagesV2LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalImagesV2',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      totalImagesV2Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalImagesV2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
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

extension AlbumCollectionQueryObject
    on QueryBuilder<AlbumCollection, AlbumCollection, QFilterCondition> {
  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      createdBy(FilterQuery<ContactModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'createdBy');
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterFilterCondition>
      lastTenImageInAlbumElement(FilterQuery<AlbumImageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lastTenImageInAlbum');
    });
  }
}

extension AlbumCollectionQueryLinks
    on QueryBuilder<AlbumCollection, AlbumCollection, QFilterCondition> {}

extension AlbumCollectionQuerySortBy
    on QueryBuilder<AlbumCollection, AlbumCollection, QSortBy> {
  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByAlbumName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumName', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByAlbumNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumName', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByIsSuccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSuccess', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByIsSuccessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSuccess', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy> sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByTotalImagesV2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalImagesV2', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByTotalImagesV2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalImagesV2', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AlbumCollectionQuerySortThenBy
    on QueryBuilder<AlbumCollection, AlbumCollection, QSortThenBy> {
  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByAlbumName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumName', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByAlbumNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumName', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByIsSuccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSuccess', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByIsSuccessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSuccess', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy> thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByTotalImagesV2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalImagesV2', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByTotalImagesV2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalImagesV2', Sort.desc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AlbumCollectionQueryWhereDistinct
    on QueryBuilder<AlbumCollection, AlbumCollection, QDistinct> {
  QueryBuilder<AlbumCollection, AlbumCollection, QDistinct> distinctByAccountId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QDistinct> distinctByAlbumName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QDistinct>
      distinctByIsSuccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSuccess');
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QDistinct> distinctByRoomId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QDistinct>
      distinctByTotalImagesV2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalImagesV2');
    });
  }

  QueryBuilder<AlbumCollection, AlbumCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension AlbumCollectionQueryProperty
    on QueryBuilder<AlbumCollection, AlbumCollection, QQueryProperty> {
  QueryBuilder<AlbumCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<AlbumCollection, String?, QQueryOperations> accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<AlbumCollection, String?, QQueryOperations> albumNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumName');
    });
  }

  QueryBuilder<AlbumCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AlbumCollection, ContactModel?, QQueryOperations>
      createdByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdBy');
    });
  }

  QueryBuilder<AlbumCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AlbumCollection, bool?, QQueryOperations> isSuccessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSuccess');
    });
  }

  QueryBuilder<AlbumCollection, List<AlbumImageModel>?, QQueryOperations>
      lastTenImageInAlbumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTenImageInAlbum');
    });
  }

  QueryBuilder<AlbumCollection, String?, QQueryOperations> roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<AlbumCollection, int?, QQueryOperations>
      totalImagesV2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalImagesV2');
    });
  }

  QueryBuilder<AlbumCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
