// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iap_transaction_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIapTransactionCollectionCollection on Isar {
  IsarCollection<IapTransactionCollection> get iapTransactions =>
      this.collection();
}

const IapTransactionCollectionSchema = CollectionSchema(
  name: r'IapTransaction',
  id: -3247012347324780994,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.string,
    ),
    r'localVerificationData': PropertySchema(
      id: 1,
      name: r'localVerificationData',
      type: IsarType.string,
    ),
    r'productId': PropertySchema(
      id: 2,
      name: r'productId',
      type: IsarType.string,
    ),
    r'serverVerificationData': PropertySchema(
      id: 3,
      name: r'serverVerificationData',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 4,
      name: r'status',
      type: IsarType.string,
    )
  },
  estimateSize: _iapTransactionCollectionEstimateSize,
  serialize: _iapTransactionCollectionSerialize,
  deserialize: _iapTransactionCollectionDeserialize,
  deserializeProp: _iapTransactionCollectionDeserializeProp,
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
    r'productId': IndexSchema(
      id: 5580769080710688203,
      name: r'productId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'productId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _iapTransactionCollectionGetId,
  getLinks: _iapTransactionCollectionGetLinks,
  attach: _iapTransactionCollectionAttach,
  version: '3.3.0-dev.3',
);

int _iapTransactionCollectionEstimateSize(
  IapTransactionCollection object,
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
    final value = object.localVerificationData;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.productId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.serverVerificationData;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _iapTransactionCollectionSerialize(
  IapTransactionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.id);
  writer.writeString(offsets[1], object.localVerificationData);
  writer.writeString(offsets[2], object.productId);
  writer.writeString(offsets[3], object.serverVerificationData);
  writer.writeString(offsets[4], object.status);
}

IapTransactionCollection _iapTransactionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IapTransactionCollection(
    id: reader.readStringOrNull(offsets[0]),
    localVerificationData: reader.readStringOrNull(offsets[1]),
    productId: reader.readStringOrNull(offsets[2]),
    serverVerificationData: reader.readStringOrNull(offsets[3]),
    status: reader.readStringOrNull(offsets[4]),
  );
  return object;
}

P _iapTransactionCollectionDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _iapTransactionCollectionGetId(IapTransactionCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _iapTransactionCollectionGetLinks(
    IapTransactionCollection object) {
  return [];
}

void _iapTransactionCollectionAttach(
    IsarCollection<dynamic> col, Id id, IapTransactionCollection object) {}

extension IapTransactionCollectionByIndex
    on IsarCollection<IapTransactionCollection> {
  Future<IapTransactionCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  IapTransactionCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<IapTransactionCollection?>> getAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<IapTransactionCollection?> getAllByIdSync(List<String?> idValues) {
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

  Future<Id> putById(IapTransactionCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(IapTransactionCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<IapTransactionCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<IapTransactionCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension IapTransactionCollectionQueryWhereSort on QueryBuilder<
    IapTransactionCollection, IapTransactionCollection, QWhere> {
  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IapTransactionCollectionQueryWhere on QueryBuilder<
    IapTransactionCollection, IapTransactionCollection, QWhereClause> {
  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterWhereClause> idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterWhereClause> productIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'productId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterWhereClause> productIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'productId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterWhereClause> productIdEqualTo(String? productId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'productId',
        value: [productId],
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterWhereClause> productIdNotEqualTo(String? productId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productId',
              lower: [],
              upper: [productId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productId',
              lower: [productId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productId',
              lower: [productId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'productId',
              lower: [],
              upper: [productId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IapTransactionCollectionQueryFilter on QueryBuilder<
    IapTransactionCollection, IapTransactionCollection, QFilterCondition> {
  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localVerificationData',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localVerificationData',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localVerificationData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
          QAfterFilterCondition>
      localVerificationDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
          QAfterFilterCondition>
      localVerificationDataMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localVerificationData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localVerificationData',
        value: '',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> localVerificationDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localVerificationData',
        value: '',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productId',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productId',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
          QAfterFilterCondition>
      productIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
          QAfterFilterCondition>
      productIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> productIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverVerificationData',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverVerificationData',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverVerificationData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
          QAfterFilterCondition>
      serverVerificationDataContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverVerificationData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
          QAfterFilterCondition>
      serverVerificationDataMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverVerificationData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverVerificationData',
        value: '',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> serverVerificationDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverVerificationData',
        value: '',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusEqualTo(
    String? value, {
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusGreaterThan(
    String? value, {
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusLessThan(
    String? value, {
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusStartsWith(
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusEndsWith(
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

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
          QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
          QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection,
      QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }
}

extension IapTransactionCollectionQueryObject on QueryBuilder<
    IapTransactionCollection, IapTransactionCollection, QFilterCondition> {}

extension IapTransactionCollectionQueryLinks on QueryBuilder<
    IapTransactionCollection, IapTransactionCollection, QFilterCondition> {}

extension IapTransactionCollectionQuerySortBy on QueryBuilder<
    IapTransactionCollection, IapTransactionCollection, QSortBy> {
  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortByLocalVerificationData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVerificationData', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortByLocalVerificationDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVerificationData', Sort.desc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortByServerVerificationData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverVerificationData', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortByServerVerificationDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverVerificationData', Sort.desc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension IapTransactionCollectionQuerySortThenBy on QueryBuilder<
    IapTransactionCollection, IapTransactionCollection, QSortThenBy> {
  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByLocalVerificationData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVerificationData', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByLocalVerificationDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localVerificationData', Sort.desc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByServerVerificationData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverVerificationData', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByServerVerificationDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverVerificationData', Sort.desc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension IapTransactionCollectionQueryWhereDistinct on QueryBuilder<
    IapTransactionCollection, IapTransactionCollection, QDistinct> {
  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QDistinct>
      distinctByLocalVerificationData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localVerificationData',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QDistinct>
      distinctByProductId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QDistinct>
      distinctByServerVerificationData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverVerificationData',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IapTransactionCollection, IapTransactionCollection, QDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension IapTransactionCollectionQueryProperty on QueryBuilder<
    IapTransactionCollection, IapTransactionCollection, QQueryProperty> {
  QueryBuilder<IapTransactionCollection, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<IapTransactionCollection, String?, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IapTransactionCollection, String?, QQueryOperations>
      localVerificationDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localVerificationData');
    });
  }

  QueryBuilder<IapTransactionCollection, String?, QQueryOperations>
      productIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productId');
    });
  }

  QueryBuilder<IapTransactionCollection, String?, QQueryOperations>
      serverVerificationDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverVerificationData');
    });
  }

  QueryBuilder<IapTransactionCollection, String?, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
