// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_file_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRoomFileCollectionCollection on Isar {
  IsarCollection<RoomFileCollection> get roomFiles => this.collection();
}

const RoomFileCollectionSchema = CollectionSchema(
  name: r'RoomFile',
  id: 7678768901006242054,
  properties: {
    r'accountId': PropertySchema(
      id: 0,
      name: r'accountId',
      type: IsarType.string,
    ),
    r'createAt': PropertySchema(
      id: 1,
      name: r'createAt',
      type: IsarType.dateTime,
    ),
    r'file': PropertySchema(
      id: 2,
      name: r'file',
      type: IsarType.object,
      target: r'MessageFileModel',
    ),
    r'hashCode': PropertySchema(
      id: 3,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'isDownload': PropertySchema(
      id: 5,
      name: r'isDownload',
      type: IsarType.bool,
    ),
    r'isHidden': PropertySchema(
      id: 6,
      name: r'isHidden',
      type: IsarType.bool,
    ),
    r'isPhotosOrVideos': PropertySchema(
      id: 7,
      name: r'isPhotosOrVideos',
      type: IsarType.bool,
    ),
    r'messageId': PropertySchema(
      id: 8,
      name: r'messageId',
      type: IsarType.string,
    ),
    r'messageRef': PropertySchema(
      id: 9,
      name: r'messageRef',
      type: IsarType.string,
    ),
    r'messageSeq': PropertySchema(
      id: 10,
      name: r'messageSeq',
      type: IsarType.long,
    ),
    r'roomFileId': PropertySchema(
      id: 11,
      name: r'roomFileId',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 12,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 13,
      name: r'type',
      type: IsarType.string,
      enumMap: _RoomFileCollectiontypeEnumValueMap,
    )
  },
  estimateSize: _roomFileCollectionEstimateSize,
  serialize: _roomFileCollectionSerialize,
  deserialize: _roomFileCollectionDeserialize,
  deserializeProp: _roomFileCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
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
    r'type': IndexSchema(
      id: 5117122708147080838,
      name: r'type',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'type',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'type_roomId': IndexSchema(
      id: 584784721307119383,
      name: r'type_roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'type',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'type_accountId': IndexSchema(
      id: -2563615941048659819,
      name: r'type_accountId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'type',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'accountId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'messageId': IndexSchema(
      id: -635287409172016016,
      name: r'messageId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'messageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'messageSeq': IndexSchema(
      id: 5886150379064425645,
      name: r'messageSeq',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'messageSeq',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'roomFileId': IndexSchema(
      id: -5320001466161801466,
      name: r'roomFileId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'roomFileId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
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
    r'createAt': IndexSchema(
      id: -3149045466074267323,
      name: r'createAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isPhotosOrVideos': IndexSchema(
      id: -1540862096755136282,
      name: r'isPhotosOrVideos',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPhotosOrVideos',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isPhotosOrVideos_roomId': IndexSchema(
      id: -130583881483248569,
      name: r'isPhotosOrVideos_roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPhotosOrVideos',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isPhotosOrVideos_accountId': IndexSchema(
      id: 6322052449302690644,
      name: r'isPhotosOrVideos_accountId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPhotosOrVideos',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'accountId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'MessageFileModel': MessageFileModelSchema},
  getId: _roomFileCollectionGetId,
  getLinks: _roomFileCollectionGetLinks,
  attach: _roomFileCollectionAttach,
  version: '3.3.0-dev.3',
);

int _roomFileCollectionEstimateSize(
  RoomFileCollection object,
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
    final value = object.file;
    if (value != null) {
      bytesCount += 3 +
          MessageFileModelSchema.estimateSize(
              value, allOffsets[MessageFileModel]!, allOffsets);
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.messageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.messageRef;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roomFileId;
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
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _roomFileCollectionSerialize(
  RoomFileCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountId);
  writer.writeDateTime(offsets[1], object.createAt);
  writer.writeObject<MessageFileModel>(
    offsets[2],
    allOffsets,
    MessageFileModelSchema.serialize,
    object.file,
  );
  writer.writeLong(offsets[3], object.hashCode);
  writer.writeString(offsets[4], object.id);
  writer.writeBool(offsets[5], object.isDownload);
  writer.writeBool(offsets[6], object.isHidden);
  writer.writeBool(offsets[7], object.isPhotosOrVideos);
  writer.writeString(offsets[8], object.messageId);
  writer.writeString(offsets[9], object.messageRef);
  writer.writeLong(offsets[10], object.messageSeq);
  writer.writeString(offsets[11], object.roomFileId);
  writer.writeString(offsets[12], object.roomId);
  writer.writeString(offsets[13], object.type?.name);
}

RoomFileCollection _roomFileCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomFileCollection(
    file: reader.readObjectOrNull<MessageFileModel>(
      offsets[2],
      MessageFileModelSchema.deserialize,
      allOffsets,
    ),
    isDownload: reader.readBoolOrNull(offsets[5]),
    isHidden: reader.readBoolOrNull(offsets[6]),
    messageId: reader.readStringOrNull(offsets[8]),
    messageRef: reader.readStringOrNull(offsets[9]),
    messageSeq: reader.readLongOrNull(offsets[10]),
    roomFileId: reader.readStringOrNull(offsets[11]),
    roomId: reader.readStringOrNull(offsets[12]),
    type: _RoomFileCollectiontypeValueEnumMap[
        reader.readStringOrNull(offsets[13])],
  );
  return object;
}

P _roomFileCollectionDeserializeProp<P>(
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
      return (reader.readObjectOrNull<MessageFileModel>(
        offset,
        MessageFileModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (_RoomFileCollectiontypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RoomFileCollectiontypeEnumValueMap = {
  r'image': r'image',
  r'video': r'video',
  r'file': r'file',
};
const _RoomFileCollectiontypeValueEnumMap = {
  r'image': RoomFileType.image,
  r'video': RoomFileType.video,
  r'file': RoomFileType.file,
};

Id _roomFileCollectionGetId(RoomFileCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _roomFileCollectionGetLinks(
    RoomFileCollection object) {
  return [];
}

void _roomFileCollectionAttach(
    IsarCollection<dynamic> col, Id id, RoomFileCollection object) {}

extension RoomFileCollectionByIndex on IsarCollection<RoomFileCollection> {
  Future<RoomFileCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  RoomFileCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<RoomFileCollection?>> getAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<RoomFileCollection?> getAllByIdSync(List<String?> idValues) {
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

  Future<Id> putById(RoomFileCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(RoomFileCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<RoomFileCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<RoomFileCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension RoomFileCollectionQueryWhereSort
    on QueryBuilder<RoomFileCollection, RoomFileCollection, QWhere> {
  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhere>
      anyMessageSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'messageSeq'),
      );
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhere>
      anyCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createAt'),
      );
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhere>
      anyIsPhotosOrVideos() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isPhotosOrVideos'),
      );
    });
  }
}

extension RoomFileCollectionQueryWhere
    on QueryBuilder<RoomFileCollection, RoomFileCollection, QWhereClause> {
  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'type',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeEqualTo(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type',
        value: [type],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeNotEqualTo(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [],
              upper: [type],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [type],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [type],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [],
              upper: [type],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeIsNullAnyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type_roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeIsNotNullAnyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'type_roomId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeEqualToAnyRoomId(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type_roomId',
        value: [type],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeNotEqualToAnyRoomId(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_roomId',
              lower: [],
              upper: [type],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_roomId',
              lower: [type],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_roomId',
              lower: [type],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_roomId',
              lower: [],
              upper: [type],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeEqualToRoomIdIsNull(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type_roomId',
        value: [type, null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeEqualToRoomIdIsNotNull(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'type_roomId',
        lower: [type, null],
        includeLower: false,
        upper: [
          type,
        ],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeRoomIdEqualTo(RoomFileType? type, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type_roomId',
        value: [type, roomId],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeEqualToRoomIdNotEqualTo(RoomFileType? type, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_roomId',
              lower: [type],
              upper: [type, roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_roomId',
              lower: [type, roomId],
              includeLower: false,
              upper: [type],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_roomId',
              lower: [type, roomId],
              includeLower: false,
              upper: [type],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_roomId',
              lower: [type],
              upper: [type, roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeIsNullAnyAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type_accountId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeIsNotNullAnyAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'type_accountId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeEqualToAnyAccountId(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type_accountId',
        value: [type],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeNotEqualToAnyAccountId(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_accountId',
              lower: [],
              upper: [type],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_accountId',
              lower: [type],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_accountId',
              lower: [type],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_accountId',
              lower: [],
              upper: [type],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeEqualToAccountIdIsNull(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type_accountId',
        value: [type, null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeEqualToAccountIdIsNotNull(RoomFileType? type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'type_accountId',
        lower: [type, null],
        includeLower: false,
        upper: [
          type,
        ],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeAccountIdEqualTo(RoomFileType? type, String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type_accountId',
        value: [type, accountId],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      typeEqualToAccountIdNotEqualTo(RoomFileType? type, String? accountId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_accountId',
              lower: [type],
              upper: [type, accountId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_accountId',
              lower: [type, accountId],
              includeLower: false,
              upper: [type],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_accountId',
              lower: [type, accountId],
              includeLower: false,
              upper: [type],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type_accountId',
              lower: [type],
              upper: [type, accountId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'messageId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageIdEqualTo(String? messageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageId',
        value: [messageId],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageIdNotEqualTo(String? messageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [],
              upper: [messageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [messageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [messageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [],
              upper: [messageId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageSeqIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageSeq',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageSeqIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'messageSeq',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageSeqEqualTo(int? messageSeq) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageSeq',
        value: [messageSeq],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageSeqNotEqualTo(int? messageSeq) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageSeq',
              lower: [],
              upper: [messageSeq],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageSeq',
              lower: [messageSeq],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageSeq',
              lower: [messageSeq],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageSeq',
              lower: [],
              upper: [messageSeq],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageSeqGreaterThan(
    int? messageSeq, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'messageSeq',
        lower: [messageSeq],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageSeqLessThan(
    int? messageSeq, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'messageSeq',
        lower: [],
        upper: [messageSeq],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      messageSeqBetween(
    int? lowerMessageSeq,
    int? upperMessageSeq, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'messageSeq',
        lower: [lowerMessageSeq],
        includeLower: includeLower,
        upper: [upperMessageSeq],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      roomFileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomFileId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      roomFileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomFileId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      roomFileIdEqualTo(String? roomFileId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomFileId',
        value: [roomFileId],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      roomFileIdNotEqualTo(String? roomFileId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomFileId',
              lower: [],
              upper: [roomFileId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomFileId',
              lower: [roomFileId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomFileId',
              lower: [roomFileId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomFileId',
              lower: [],
              upper: [roomFileId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      accountIdEqualTo(String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountId',
        value: [accountId],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      createAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      createAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      createAtEqualTo(DateTime? createAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createAt',
        value: [createAt],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      createAtNotEqualTo(DateTime? createAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createAt',
              lower: [],
              upper: [createAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createAt',
              lower: [createAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createAt',
              lower: [createAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createAt',
              lower: [],
              upper: [createAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      createAtGreaterThan(
    DateTime? createAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createAt',
        lower: [createAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      createAtLessThan(
    DateTime? createAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createAt',
        lower: [],
        upper: [createAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      createAtBetween(
    DateTime? lowerCreateAt,
    DateTime? upperCreateAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createAt',
        lower: [lowerCreateAt],
        includeLower: includeLower,
        upper: [upperCreateAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosEqualTo(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPhotosOrVideos',
        value: [isPhotosOrVideos],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosNotEqualTo(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos',
              lower: [],
              upper: [isPhotosOrVideos],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos',
              lower: [isPhotosOrVideos],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos',
              lower: [isPhotosOrVideos],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos',
              lower: [],
              upper: [isPhotosOrVideos],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosEqualToAnyRoomId(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPhotosOrVideos_roomId',
        value: [isPhotosOrVideos],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosNotEqualToAnyRoomId(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_roomId',
              lower: [],
              upper: [isPhotosOrVideos],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_roomId',
              lower: [isPhotosOrVideos],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_roomId',
              lower: [isPhotosOrVideos],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_roomId',
              lower: [],
              upper: [isPhotosOrVideos],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosEqualToRoomIdIsNull(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPhotosOrVideos_roomId',
        value: [isPhotosOrVideos, null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosEqualToRoomIdIsNotNull(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isPhotosOrVideos_roomId',
        lower: [isPhotosOrVideos, null],
        includeLower: false,
        upper: [
          isPhotosOrVideos,
        ],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosRoomIdEqualTo(bool isPhotosOrVideos, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPhotosOrVideos_roomId',
        value: [isPhotosOrVideos, roomId],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosEqualToRoomIdNotEqualTo(
          bool isPhotosOrVideos, String? roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_roomId',
              lower: [isPhotosOrVideos],
              upper: [isPhotosOrVideos, roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_roomId',
              lower: [isPhotosOrVideos, roomId],
              includeLower: false,
              upper: [isPhotosOrVideos],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_roomId',
              lower: [isPhotosOrVideos, roomId],
              includeLower: false,
              upper: [isPhotosOrVideos],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_roomId',
              lower: [isPhotosOrVideos],
              upper: [isPhotosOrVideos, roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosEqualToAnyAccountId(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPhotosOrVideos_accountId',
        value: [isPhotosOrVideos],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosNotEqualToAnyAccountId(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_accountId',
              lower: [],
              upper: [isPhotosOrVideos],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_accountId',
              lower: [isPhotosOrVideos],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_accountId',
              lower: [isPhotosOrVideos],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_accountId',
              lower: [],
              upper: [isPhotosOrVideos],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosEqualToAccountIdIsNull(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPhotosOrVideos_accountId',
        value: [isPhotosOrVideos, null],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosEqualToAccountIdIsNotNull(bool isPhotosOrVideos) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isPhotosOrVideos_accountId',
        lower: [isPhotosOrVideos, null],
        includeLower: false,
        upper: [
          isPhotosOrVideos,
        ],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosAccountIdEqualTo(
          bool isPhotosOrVideos, String? accountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPhotosOrVideos_accountId',
        value: [isPhotosOrVideos, accountId],
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterWhereClause>
      isPhotosOrVideosEqualToAccountIdNotEqualTo(
          bool isPhotosOrVideos, String? accountId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_accountId',
              lower: [isPhotosOrVideos],
              upper: [isPhotosOrVideos, accountId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_accountId',
              lower: [isPhotosOrVideos, accountId],
              includeLower: false,
              upper: [isPhotosOrVideos],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_accountId',
              lower: [isPhotosOrVideos, accountId],
              includeLower: false,
              upper: [isPhotosOrVideos],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPhotosOrVideos_accountId',
              lower: [isPhotosOrVideos],
              upper: [isPhotosOrVideos, accountId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RoomFileCollectionQueryFilter
    on QueryBuilder<RoomFileCollection, RoomFileCollection, QFilterCondition> {
  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      accountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      accountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      accountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      accountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      createAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createAt',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      createAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createAt',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      createAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      createAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      createAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      createAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      fileIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'file',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      fileIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'file',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      hashCodeGreaterThan(
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      hashCodeLessThan(
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      hashCodeBetween(
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      isDownloadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDownload',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      isDownloadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDownload',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      isDownloadEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDownload',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      isHiddenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isHidden',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      isHiddenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isHidden',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      isHiddenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      isPhotosOrVideosEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPhotosOrVideos',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageId',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageId',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageRef',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageRef',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageRef',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageRef',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageRef',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageRefIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageRef',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageSeqIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageSeq',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageSeqIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageSeq',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageSeqEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageSeqGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageSeqLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      messageSeqBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageSeq',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomFileId',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomFileId',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomFileId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomFileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomFileId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomFileId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomFileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomFileId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeEqualTo(
    RoomFileType? value, {
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeGreaterThan(
    RoomFileType? value, {
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeLessThan(
    RoomFileType? value, {
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeBetween(
    RoomFileType? lower,
    RoomFileType? upper, {
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension RoomFileCollectionQueryObject
    on QueryBuilder<RoomFileCollection, RoomFileCollection, QFilterCondition> {
  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterFilterCondition>
      file(FilterQuery<MessageFileModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'file');
    });
  }
}

extension RoomFileCollectionQueryLinks
    on QueryBuilder<RoomFileCollection, RoomFileCollection, QFilterCondition> {}

extension RoomFileCollectionQuerySortBy
    on QueryBuilder<RoomFileCollection, RoomFileCollection, QSortBy> {
  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByIsDownload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByIsDownloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByIsPhotosOrVideos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPhotosOrVideos', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByIsPhotosOrVideosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPhotosOrVideos', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByMessageRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageRef', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByMessageRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageRef', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByMessageSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSeq', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByMessageSeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSeq', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByRoomFileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomFileId', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByRoomFileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomFileId', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension RoomFileCollectionQuerySortThenBy
    on QueryBuilder<RoomFileCollection, RoomFileCollection, QSortThenBy> {
  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByIsDownload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByIsDownloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownload', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByIsPhotosOrVideos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPhotosOrVideos', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByIsPhotosOrVideosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPhotosOrVideos', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByMessageRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageRef', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByMessageRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageRef', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByMessageSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSeq', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByMessageSeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSeq', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByRoomFileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomFileId', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByRoomFileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomFileId', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension RoomFileCollectionQueryWhereDistinct
    on QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct> {
  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByIsDownload() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDownload');
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHidden');
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByIsPhotosOrVideos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPhotosOrVideos');
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByMessageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByMessageRef({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageRef', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByMessageSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageSeq');
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByRoomFileId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomFileId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileCollection, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension RoomFileCollectionQueryProperty
    on QueryBuilder<RoomFileCollection, RoomFileCollection, QQueryProperty> {
  QueryBuilder<RoomFileCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<RoomFileCollection, String?, QQueryOperations>
      accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<RoomFileCollection, DateTime?, QQueryOperations>
      createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<RoomFileCollection, MessageFileModel?, QQueryOperations>
      fileProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'file');
    });
  }

  QueryBuilder<RoomFileCollection, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<RoomFileCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RoomFileCollection, bool?, QQueryOperations>
      isDownloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDownload');
    });
  }

  QueryBuilder<RoomFileCollection, bool?, QQueryOperations> isHiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHidden');
    });
  }

  QueryBuilder<RoomFileCollection, bool, QQueryOperations>
      isPhotosOrVideosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPhotosOrVideos');
    });
  }

  QueryBuilder<RoomFileCollection, String?, QQueryOperations>
      messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<RoomFileCollection, String?, QQueryOperations>
      messageRefProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageRef');
    });
  }

  QueryBuilder<RoomFileCollection, int?, QQueryOperations>
      messageSeqProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageSeq');
    });
  }

  QueryBuilder<RoomFileCollection, String?, QQueryOperations>
      roomFileIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomFileId');
    });
  }

  QueryBuilder<RoomFileCollection, String?, QQueryOperations> roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<RoomFileCollection, RoomFileType?, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
