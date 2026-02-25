// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_image_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlbumImageCollectionCollection on Isar {
  IsarCollection<AlbumImageCollection> get albumImages => this.collection();
}

const AlbumImageCollectionSchema = CollectionSchema(
  name: r'AlbumImage',
  id: 6118964688056151708,
  properties: {
    r'albumId': PropertySchema(
      id: 0,
      name: r'albumId',
      type: IsarType.string,
    ),
    r'blurHash': PropertySchema(
      id: 1,
      name: r'blurHash',
      type: IsarType.string,
    ),
    r'createAt': PropertySchema(
      id: 2,
      name: r'createAt',
      type: IsarType.dateTime,
    ),
    r'hashCode': PropertySchema(
      id: 3,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'height': PropertySchema(
      id: 4,
      name: r'height',
      type: IsarType.long,
    ),
    r'imageId': PropertySchema(
      id: 5,
      name: r'imageId',
      type: IsarType.string,
    ),
    r'imageName': PropertySchema(
      id: 6,
      name: r'imageName',
      type: IsarType.string,
    ),
    r'imageSize': PropertySchema(
      id: 7,
      name: r'imageSize',
      type: IsarType.long,
    ),
    r'imageType': PropertySchema(
      id: 8,
      name: r'imageType',
      type: IsarType.string,
    ),
    r'mimeType': PropertySchema(
      id: 9,
      name: r'mimeType',
      type: IsarType.string,
    ),
    r'ownerId': PropertySchema(
      id: 10,
      name: r'ownerId',
      type: IsarType.string,
    ),
    r'taskId': PropertySchema(
      id: 11,
      name: r'taskId',
      type: IsarType.string,
    ),
    r'width': PropertySchema(
      id: 12,
      name: r'width',
      type: IsarType.long,
    )
  },
  estimateSize: _albumImageCollectionEstimateSize,
  serialize: _albumImageCollectionSerialize,
  deserialize: _albumImageCollectionDeserialize,
  deserializeProp: _albumImageCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'imageId': IndexSchema(
      id: -2353151822101600380,
      name: r'imageId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'imageId',
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
  getId: _albumImageCollectionGetId,
  getLinks: _albumImageCollectionGetLinks,
  attach: _albumImageCollectionAttach,
  version: '3.3.0-dev.3',
);

int _albumImageCollectionEstimateSize(
  AlbumImageCollection object,
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
    final value = object.blurHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imageName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imageType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mimeType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ownerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.taskId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _albumImageCollectionSerialize(
  AlbumImageCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.albumId);
  writer.writeString(offsets[1], object.blurHash);
  writer.writeDateTime(offsets[2], object.createAt);
  writer.writeLong(offsets[3], object.hashCode);
  writer.writeLong(offsets[4], object.height);
  writer.writeString(offsets[5], object.imageId);
  writer.writeString(offsets[6], object.imageName);
  writer.writeLong(offsets[7], object.imageSize);
  writer.writeString(offsets[8], object.imageType);
  writer.writeString(offsets[9], object.mimeType);
  writer.writeString(offsets[10], object.ownerId);
  writer.writeString(offsets[11], object.taskId);
  writer.writeLong(offsets[12], object.width);
}

AlbumImageCollection _albumImageCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AlbumImageCollection(
    albumId: reader.readStringOrNull(offsets[0]),
    blurHash: reader.readStringOrNull(offsets[1]),
    createAt: reader.readDateTimeOrNull(offsets[2]),
    height: reader.readLongOrNull(offsets[4]),
    imageId: reader.readStringOrNull(offsets[5]),
    imageName: reader.readStringOrNull(offsets[6]),
    imageType: reader.readStringOrNull(offsets[8]),
    mimeType: reader.readStringOrNull(offsets[9]),
    ownerId: reader.readStringOrNull(offsets[10]),
    taskId: reader.readStringOrNull(offsets[11]),
    width: reader.readLongOrNull(offsets[12]),
  );
  object.imageSize = reader.readLongOrNull(offsets[7]);
  return object;
}

P _albumImageCollectionDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _albumImageCollectionGetId(AlbumImageCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _albumImageCollectionGetLinks(
    AlbumImageCollection object) {
  return [];
}

void _albumImageCollectionAttach(
    IsarCollection<dynamic> col, Id id, AlbumImageCollection object) {}

extension AlbumImageCollectionQueryWhereSort
    on QueryBuilder<AlbumImageCollection, AlbumImageCollection, QWhere> {
  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AlbumImageCollectionQueryWhere
    on QueryBuilder<AlbumImageCollection, AlbumImageCollection, QWhereClause> {
  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
      imageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'imageId',
        value: [null],
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
      imageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'imageId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
      imageIdEqualTo(String? imageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'imageId',
        value: [imageId],
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
      imageIdNotEqualTo(String? imageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'imageId',
              lower: [],
              upper: [imageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'imageId',
              lower: [imageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'imageId',
              lower: [imageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'imageId',
              lower: [],
              upper: [imageId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
      albumIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'albumId',
        value: [null],
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
      albumIdEqualTo(String? albumId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'albumId',
        value: [albumId],
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterWhereClause>
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

extension AlbumImageCollectionQueryFilter on QueryBuilder<AlbumImageCollection,
    AlbumImageCollection, QFilterCondition> {
  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdEqualTo(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdGreaterThan(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdLessThan(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdBetween(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdStartsWith(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdEndsWith(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      albumIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      albumIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> albumIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'blurHash',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'blurHash',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blurHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blurHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blurHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blurHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blurHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blurHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      blurHashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blurHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      blurHashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blurHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blurHash',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> blurHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blurHash',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> createAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createAt',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> createAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createAt',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> createAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> createAtGreaterThan(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> createAtLessThan(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> createAtBetween(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> heightEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> heightGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> heightLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> heightBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageId',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageId',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      imageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      imageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageName',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageName',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      imageNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      imageNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageName',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageName',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageSizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageSize',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageSizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageSize',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageSizeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageSize',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageSizeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageSize',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageSizeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageSize',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageSizeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageType',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageType',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      imageTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      imageTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageType',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> imageTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageType',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mimeType',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mimeType',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mimeType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      mimeTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      mimeTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mimeType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mimeType',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> mimeTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mimeType',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ownerId',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ownerId',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ownerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      ownerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      ownerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> ownerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'taskId',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'taskId',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdEqualTo(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdGreaterThan(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdLessThan(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdBetween(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdStartsWith(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdEndsWith(
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

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      taskIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
          QAfterFilterCondition>
      taskIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'taskId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> taskIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'taskId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> widthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> widthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> widthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> widthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'width',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> widthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'width',
        value: value,
      ));
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection,
      QAfterFilterCondition> widthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AlbumImageCollectionQueryObject on QueryBuilder<AlbumImageCollection,
    AlbumImageCollection, QFilterCondition> {}

extension AlbumImageCollectionQueryLinks on QueryBuilder<AlbumImageCollection,
    AlbumImageCollection, QFilterCondition> {}

extension AlbumImageCollectionQuerySortBy
    on QueryBuilder<AlbumImageCollection, AlbumImageCollection, QSortBy> {
  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByBlurHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurHash', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByBlurHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurHash', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByImageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageId', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByImageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageId', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByImageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageName', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByImageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageName', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByImageSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageSize', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByImageSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageSize', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByImageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageType', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByImageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageType', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByMimeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mimeType', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByMimeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mimeType', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      sortByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension AlbumImageCollectionQuerySortThenBy
    on QueryBuilder<AlbumImageCollection, AlbumImageCollection, QSortThenBy> {
  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByBlurHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurHash', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByBlurHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blurHash', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createAt', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByImageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageId', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByImageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageId', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByImageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageName', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByImageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageName', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByImageSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageSize', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByImageSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageSize', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByImageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageType', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByImageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageType', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByMimeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mimeType', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByMimeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mimeType', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QAfterSortBy>
      thenByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension AlbumImageCollectionQueryWhereDistinct
    on QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct> {
  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByAlbumId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByBlurHash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blurHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createAt');
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByImageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByImageName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByImageSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageSize');
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByImageType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByMimeType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mimeType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByOwnerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByTaskId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlbumImageCollection, AlbumImageCollection, QDistinct>
      distinctByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'width');
    });
  }
}

extension AlbumImageCollectionQueryProperty on QueryBuilder<
    AlbumImageCollection, AlbumImageCollection, QQueryProperty> {
  QueryBuilder<AlbumImageCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<AlbumImageCollection, String?, QQueryOperations>
      albumIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumId');
    });
  }

  QueryBuilder<AlbumImageCollection, String?, QQueryOperations>
      blurHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blurHash');
    });
  }

  QueryBuilder<AlbumImageCollection, DateTime?, QQueryOperations>
      createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createAt');
    });
  }

  QueryBuilder<AlbumImageCollection, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<AlbumImageCollection, int?, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<AlbumImageCollection, String?, QQueryOperations>
      imageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageId');
    });
  }

  QueryBuilder<AlbumImageCollection, String?, QQueryOperations>
      imageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageName');
    });
  }

  QueryBuilder<AlbumImageCollection, int?, QQueryOperations>
      imageSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageSize');
    });
  }

  QueryBuilder<AlbumImageCollection, String?, QQueryOperations>
      imageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageType');
    });
  }

  QueryBuilder<AlbumImageCollection, String?, QQueryOperations>
      mimeTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mimeType');
    });
  }

  QueryBuilder<AlbumImageCollection, String?, QQueryOperations>
      ownerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownerId');
    });
  }

  QueryBuilder<AlbumImageCollection, String?, QQueryOperations>
      taskIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskId');
    });
  }

  QueryBuilder<AlbumImageCollection, int?, QQueryOperations> widthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'width');
    });
  }
}
