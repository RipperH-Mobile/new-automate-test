// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_task_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlbumTaskCollectionCollection on Isar {
  IsarCollection<AlbumTaskCollection> get albumTasks => this.collection();
}

const AlbumTaskCollectionSchema = CollectionSchema(
  name: r'AlbumTask',
  id: 2757072307617638169,
  properties: {
    r'albumId': PropertySchema(
      id: 0,
      name: r'albumId',
      type: IsarType.string,
    ),
    r'allImagesPath': PropertySchema(
      id: 1,
      name: r'allImagesPath',
      type: IsarType.stringList,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currentProgress': PropertySchema(
      id: 3,
      name: r'currentProgress',
      type: IsarType.long,
    ),
    r'downloadFileName': PropertySchema(
      id: 4,
      name: r'downloadFileName',
      type: IsarType.stringList,
    ),
    r'inQueueImagesPath': PropertySchema(
      id: 5,
      name: r'inQueueImagesPath',
      type: IsarType.stringList,
    ),
    r'remainingUploadRetryAttempt': PropertySchema(
      id: 6,
      name: r'remainingUploadRetryAttempt',
      type: IsarType.long,
    ),
    r'roomId': PropertySchema(
      id: 7,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 8,
      name: r'status',
      type: IsarType.string,
      enumMap: _AlbumTaskCollectionstatusEnumValueMap,
    ),
    r'taskId': PropertySchema(
      id: 9,
      name: r'taskId',
      type: IsarType.string,
    ),
    r'totalImages': PropertySchema(
      id: 10,
      name: r'totalImages',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 11,
      name: r'type',
      type: IsarType.string,
      enumMap: _AlbumTaskCollectiontypeEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 12,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _albumTaskCollectionEstimateSize,
  serialize: _albumTaskCollectionSerialize,
  deserialize: _albumTaskCollectionDeserialize,
  deserializeProp: _albumTaskCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'taskId': IndexSchema(
      id: -6391211041487498726,
      name: r'taskId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'taskId',
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
    r'albumId': IndexSchema(
      id: -3314078833704812111,
      name: r'albumId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'albumId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _albumTaskCollectionGetId,
  getLinks: _albumTaskCollectionGetLinks,
  attach: _albumTaskCollectionAttach,
  version: '3.3.0-dev.3',
);

int _albumTaskCollectionEstimateSize(
  AlbumTaskCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.albumId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.allImagesPath;
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
  {
    final list = object.downloadFileName;
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
  {
    final list = object.inQueueImagesPath;
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
  {
    final value = object.roomId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.taskId;
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

void _albumTaskCollectionSerialize(
  AlbumTaskCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.albumId);
  writer.writeStringList(offsets[1], object.allImagesPath);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeLong(offsets[3], object.currentProgress);
  writer.writeStringList(offsets[4], object.downloadFileName);
  writer.writeStringList(offsets[5], object.inQueueImagesPath);
  writer.writeLong(offsets[6], object.remainingUploadRetryAttempt);
  writer.writeString(offsets[7], object.roomId);
  writer.writeString(offsets[8], object.status?.name);
  writer.writeString(offsets[9], object.taskId);
  writer.writeLong(offsets[10], object.totalImages);
  writer.writeString(offsets[11], object.type?.name);
  writer.writeDateTime(offsets[12], object.updatedAt);
}

AlbumTaskCollection _albumTaskCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AlbumTaskCollection(
    albumId: reader.readStringOrNull(offsets[0]),
    allImagesPath: reader.readStringList(offsets[1]),
    createdAt: reader.readDateTimeOrNull(offsets[2]),
    currentProgress: reader.readLongOrNull(offsets[3]),
    downloadFileName: reader.readStringList(offsets[4]),
    inQueueImagesPath: reader.readStringList(offsets[5]),
    remainingUploadRetryAttempt: reader.readLongOrNull(offsets[6]) ?? 1,
    roomId: reader.readStringOrNull(offsets[7]),
    status: _AlbumTaskCollectionstatusValueEnumMap[
        reader.readStringOrNull(offsets[8])],
    taskId: reader.readStringOrNull(offsets[9]),
    totalImages: reader.readLongOrNull(offsets[10]),
    type: _AlbumTaskCollectiontypeValueEnumMap[
        reader.readStringOrNull(offsets[11])],
    updatedAt: reader.readDateTimeOrNull(offsets[12]),
  );
  return object;
}

P _albumTaskCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringList(offset)) as P;
    case 5:
      return (reader.readStringList(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (_AlbumTaskCollectionstatusValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (_AlbumTaskCollectiontypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AlbumTaskCollectionstatusEnumValueMap = {
  r'inProgress': r'inProgress',
  r'completed': r'completed',
  r'canceled': r'canceled',
  r'failed': r'failed',
};
const _AlbumTaskCollectionstatusValueEnumMap = {
  r'inProgress': AlbumTaskStatus.inProgress,
  r'completed': AlbumTaskStatus.completed,
  r'canceled': AlbumTaskStatus.canceled,
  r'failed': AlbumTaskStatus.failed,
};
const _AlbumTaskCollectiontypeEnumValueMap = {
  r'upload': r'upload',
  r'download': r'download',
  r'downloadAll': r'downloadAll',
};
const _AlbumTaskCollectiontypeValueEnumMap = {
  r'upload': AlbumTaskType.upload,
  r'download': AlbumTaskType.download,
  r'downloadAll': AlbumTaskType.downloadAll,
};

Id _albumTaskCollectionGetId(AlbumTaskCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _albumTaskCollectionGetLinks(
    AlbumTaskCollection object) {
  return [];
}

void _albumTaskCollectionAttach(
    IsarCollection<dynamic> col, Id id, AlbumTaskCollection object) {}

extension AlbumTaskCollectionByIndex on IsarCollection<AlbumTaskCollection> {
  Future<AlbumTaskCollection?> getByTaskId(String? taskId) {
    return getByIndex(r'taskId', [taskId]);
  }

  AlbumTaskCollection? getByTaskIdSync(String? taskId) {
    return getByIndexSync(r'taskId', [taskId]);
  }

  Future<bool> deleteByTaskId(String? taskId) {
    return deleteByIndex(r'taskId', [taskId]);
  }

  bool deleteByTaskIdSync(String? taskId) {
    return deleteByIndexSync(r'taskId', [taskId]);
  }

  Future<List<AlbumTaskCollection?>> getAllByTaskId(
      List<String?> taskIdValues) {
    final values = taskIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'taskId', values);
  }

  List<AlbumTaskCollection?> getAllByTaskIdSync(List<String?> taskIdValues) {
    final values = taskIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'taskId', values);
  }

  Future<int> deleteAllByTaskId(List<String?> taskIdValues) {
    final values = taskIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'taskId', values);
  }

  int deleteAllByTaskIdSync(List<String?> taskIdValues) {
    final values = taskIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'taskId', values);
  }

  Future<Id> putByTaskId(AlbumTaskCollection object) {
    return putByIndex(r'taskId', object);
  }

  Id putByTaskIdSync(AlbumTaskCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'taskId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTaskId(List<AlbumTaskCollection> objects) {
    return putAllByIndex(r'taskId', objects);
  }

  List<Id> putAllByTaskIdSync(List<AlbumTaskCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'taskId', objects, saveLinks: saveLinks);
  }
}

extension AlbumTaskCollectionQueryWhereSort
    on QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QWhere> {
  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AlbumTaskCollectionQueryWhere
    on QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QWhereClause> {
  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      taskIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'taskId',
        value: [null],
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      taskIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      taskIdEqualTo(String? taskId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'taskId',
        value: [taskId],
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      taskIdNotEqualTo(String? taskId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [],
              upper: [taskId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [taskId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [taskId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [],
              upper: [taskId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      albumIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'albumId',
        value: [null],
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      albumIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'albumId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      albumIdEqualTo(String? albumId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'albumId',
        value: [albumId],
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterWhereClause>
      albumIdNotEqualTo(String? albumId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumId',
              lower: [],
              upper: [albumId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumId',
              lower: [albumId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumId',
              lower: [albumId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumId',
              lower: [],
              upper: [albumId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AlbumTaskCollectionQueryFilter on QueryBuilder<AlbumTaskCollection,
    AlbumTaskCollection, QFilterCondition> {
  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      albumIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allImagesPath',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allImagesPath',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allImagesPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'allImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'allImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'allImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'allImagesPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allImagesPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'allImagesPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allImagesPath',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allImagesPath',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allImagesPath',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allImagesPath',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allImagesPath',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      allImagesPathLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allImagesPath',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      currentProgressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentProgress',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      currentProgressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentProgress',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      currentProgressEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentProgress',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      currentProgressGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentProgress',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      currentProgressLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentProgress',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      currentProgressBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentProgress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'downloadFileName',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'downloadFileName',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downloadFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'downloadFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'downloadFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'downloadFileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'downloadFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'downloadFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'downloadFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'downloadFileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downloadFileName',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'downloadFileName',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'downloadFileName',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'downloadFileName',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'downloadFileName',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'downloadFileName',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'downloadFileName',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      downloadFileNameLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'downloadFileName',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inQueueImagesPath',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inQueueImagesPath',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inQueueImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inQueueImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inQueueImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inQueueImagesPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inQueueImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inQueueImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inQueueImagesPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inQueueImagesPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inQueueImagesPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inQueueImagesPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inQueueImagesPath',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inQueueImagesPath',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inQueueImagesPath',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inQueueImagesPath',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inQueueImagesPath',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      inQueueImagesPathLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inQueueImagesPath',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      remainingUploadRetryAttemptEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remainingUploadRetryAttempt',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      remainingUploadRetryAttemptGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remainingUploadRetryAttempt',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      remainingUploadRetryAttemptLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remainingUploadRetryAttempt',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      remainingUploadRetryAttemptBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remainingUploadRetryAttempt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusEqualTo(
    AlbumTaskStatus? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusGreaterThan(
    AlbumTaskStatus? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusLessThan(
    AlbumTaskStatus? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusBetween(
    AlbumTaskStatus? lower,
    AlbumTaskStatus? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'taskId',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'taskId',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'taskId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      taskIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'taskId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      totalImagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalImages',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      totalImagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalImages',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      totalImagesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalImages',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      totalImagesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalImages',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      totalImagesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalImages',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      totalImagesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalImages',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeEqualTo(
    AlbumTaskType? value, {
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeGreaterThan(
    AlbumTaskType? value, {
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeLessThan(
    AlbumTaskType? value, {
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeBetween(
    AlbumTaskType? lower,
    AlbumTaskType? upper, {
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterFilterCondition>
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

extension AlbumTaskCollectionQueryObject on QueryBuilder<AlbumTaskCollection,
    AlbumTaskCollection, QFilterCondition> {}

extension AlbumTaskCollectionQueryLinks on QueryBuilder<AlbumTaskCollection,
    AlbumTaskCollection, QFilterCondition> {}

extension AlbumTaskCollectionQuerySortBy
    on QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QSortBy> {
  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByCurrentProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgress', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByCurrentProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgress', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByRemainingUploadRetryAttempt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingUploadRetryAttempt', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByRemainingUploadRetryAttemptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingUploadRetryAttempt', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByTotalImages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalImages', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByTotalImagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalImages', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AlbumTaskCollectionQuerySortThenBy
    on QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QSortThenBy> {
  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByCurrentProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgress', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByCurrentProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgress', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByRemainingUploadRetryAttempt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingUploadRetryAttempt', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByRemainingUploadRetryAttemptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingUploadRetryAttempt', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByTotalImages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalImages', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByTotalImagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalImages', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AlbumTaskCollectionQueryWhereDistinct
    on QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct> {
  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByAlbumId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByAllImagesPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allImagesPath');
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByCurrentProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentProgress');
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByDownloadFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downloadFileName');
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByInQueueImagesPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inQueueImagesPath');
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByRemainingUploadRetryAttempt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remainingUploadRetryAttempt');
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByTaskId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByTotalImages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalImages');
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension AlbumTaskCollectionQueryProperty
    on QueryBuilder<AlbumTaskCollection, AlbumTaskCollection, QQueryProperty> {
  QueryBuilder<AlbumTaskCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<AlbumTaskCollection, String?, QQueryOperations>
      albumIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumId');
    });
  }

  QueryBuilder<AlbumTaskCollection, List<String>?, QQueryOperations>
      allImagesPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allImagesPath');
    });
  }

  QueryBuilder<AlbumTaskCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AlbumTaskCollection, int?, QQueryOperations>
      currentProgressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentProgress');
    });
  }

  QueryBuilder<AlbumTaskCollection, List<String>?, QQueryOperations>
      downloadFileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downloadFileName');
    });
  }

  QueryBuilder<AlbumTaskCollection, List<String>?, QQueryOperations>
      inQueueImagesPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inQueueImagesPath');
    });
  }

  QueryBuilder<AlbumTaskCollection, int, QQueryOperations>
      remainingUploadRetryAttemptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remainingUploadRetryAttempt');
    });
  }

  QueryBuilder<AlbumTaskCollection, String?, QQueryOperations>
      roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskStatus?, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<AlbumTaskCollection, String?, QQueryOperations>
      taskIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskId');
    });
  }

  QueryBuilder<AlbumTaskCollection, int?, QQueryOperations>
      totalImagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalImages');
    });
  }

  QueryBuilder<AlbumTaskCollection, AlbumTaskType?, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<AlbumTaskCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
