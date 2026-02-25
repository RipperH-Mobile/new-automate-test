// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_message_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPinMessageCollectionCollection on Isar {
  IsarCollection<PinMessageCollection> get pinMessage => this.collection();
}

const PinMessageCollectionSchema = CollectionSchema(
  name: r'PinMessage',
  id: -3999818433119580700,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
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
    r'message': PropertySchema(
      id: 3,
      name: r'message',
      type: IsarType.object,
      target: r'MessageModel',
    ),
    r'parentId': PropertySchema(
      id: 4,
      name: r'parentId',
      type: IsarType.string,
    ),
    r'pinnedBy': PropertySchema(
      id: 5,
      name: r'pinnedBy',
      type: IsarType.string,
    ),
    r'ref': PropertySchema(
      id: 6,
      name: r'ref',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 7,
      name: r'roomId',
      type: IsarType.string,
    )
  },
  estimateSize: _pinMessageCollectionEstimateSize,
  serialize: _pinMessageCollectionSerialize,
  deserialize: _pinMessageCollectionDeserialize,
  deserializeProp: _pinMessageCollectionDeserializeProp,
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
    r'ref': IndexSchema(
      id: -6066889550123943304,
      name: r'ref',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ref',
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
    )
  },
  links: {},
  embeddedSchemas: {
    r'MessageModel': MessageModelSchema,
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
    r'MessageFileModel': MessageFileModelSchema,
    r'MessageLinkModel': MessageLinkModelSchema,
    r'MessageLinkVideoModel': MessageLinkVideoModelSchema,
    r'MessageMetaModel': MessageMetaModelSchema,
    r'DeletedByAccountModel': DeletedByAccountModelSchema,
    r'AlbumTaskModel': AlbumTaskModelSchema,
    r'MessageSystemModel': MessageSystemModelSchema,
    r'MessageSystemPayloadModel': MessageSystemPayloadModelSchema,
    r'MessageSystemPayloadMemberModel': MessageSystemPayloadMemberModelSchema,
    r'MessageCallModel': MessageCallModelSchema,
    r'MessageCallPayloadModel': MessageCallPayloadModelSchema,
    r'MobileContactModel': MobileContactModelSchema,
    r'LastEmojiModel': LastEmojiModelSchema,
    r'MentionModel': MentionModelSchema,
    r'BookmarkTagModel': BookmarkTagModelSchema
  },
  getId: _pinMessageCollectionGetId,
  getLinks: _pinMessageCollectionGetLinks,
  attach: _pinMessageCollectionAttach,
  version: '3.3.0-dev.3',
);

int _pinMessageCollectionEstimateSize(
  PinMessageCollection object,
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
    final value = object.message;
    if (value != null) {
      bytesCount += 3 +
          MessageModelSchema.estimateSize(
              value, allOffsets[MessageModel]!, allOffsets);
    }
  }
  {
    final value = object.parentId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pinnedBy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ref;
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
  return bytesCount;
}

void _pinMessageCollectionSerialize(
  PinMessageCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeString(offsets[2], object.id);
  writer.writeObject<MessageModel>(
    offsets[3],
    allOffsets,
    MessageModelSchema.serialize,
    object.message,
  );
  writer.writeString(offsets[4], object.parentId);
  writer.writeString(offsets[5], object.pinnedBy);
  writer.writeString(offsets[6], object.ref);
  writer.writeString(offsets[7], object.roomId);
}

PinMessageCollection _pinMessageCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PinMessageCollection();
  object.createdAt = reader.readDateTimeOrNull(offsets[0]);
  object.id = reader.readStringOrNull(offsets[2]);
  object.message = reader.readObjectOrNull<MessageModel>(
    offsets[3],
    MessageModelSchema.deserialize,
    allOffsets,
  );
  object.parentId = reader.readStringOrNull(offsets[4]);
  object.pinnedBy = reader.readStringOrNull(offsets[5]);
  object.ref = reader.readStringOrNull(offsets[6]);
  object.roomId = reader.readStringOrNull(offsets[7]);
  return object;
}

P _pinMessageCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<MessageModel>(
        offset,
        MessageModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pinMessageCollectionGetId(PinMessageCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _pinMessageCollectionGetLinks(
    PinMessageCollection object) {
  return [];
}

void _pinMessageCollectionAttach(
    IsarCollection<dynamic> col, Id id, PinMessageCollection object) {}

extension PinMessageCollectionQueryWhereSort
    on QueryBuilder<PinMessageCollection, PinMessageCollection, QWhere> {
  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PinMessageCollectionQueryWhere
    on QueryBuilder<PinMessageCollection, PinMessageCollection, QWhereClause> {
  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
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

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
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

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
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

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
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

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      refIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ref',
        value: [null],
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      refIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ref',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      refEqualTo(String? ref) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ref',
        value: [ref],
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      refNotEqualTo(String? ref) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ref',
              lower: [],
              upper: [ref],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ref',
              lower: [ref],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ref',
              lower: [ref],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ref',
              lower: [],
              upper: [ref],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [null],
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
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

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
      roomIdEqualTo(String? roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterWhereClause>
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
}

extension PinMessageCollectionQueryFilter on QueryBuilder<PinMessageCollection,
    PinMessageCollection, QFilterCondition> {
  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentId',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentId',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
          QAfterFilterCondition>
      parentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
          QAfterFilterCondition>
      parentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentId',
        value: '',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> parentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentId',
        value: '',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pinnedBy',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pinnedBy',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pinnedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pinnedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pinnedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pinnedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pinnedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pinnedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
          QAfterFilterCondition>
      pinnedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pinnedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
          QAfterFilterCondition>
      pinnedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pinnedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pinnedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> pinnedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pinnedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ref',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ref',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ref',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
          QAfterFilterCondition>
      refContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ref',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
          QAfterFilterCondition>
      refMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ref',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ref',
        value: '',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> refIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ref',
        value: '',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomId',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdEqualTo(
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdGreaterThan(
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdLessThan(
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdBetween(
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdStartsWith(
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdEndsWith(
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

  QueryBuilder<PinMessageCollection, PinMessageCollection,
          QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
          QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }
}

extension PinMessageCollectionQueryObject on QueryBuilder<PinMessageCollection,
    PinMessageCollection, QFilterCondition> {
  QueryBuilder<PinMessageCollection, PinMessageCollection,
      QAfterFilterCondition> message(FilterQuery<MessageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'message');
    });
  }
}

extension PinMessageCollectionQueryLinks on QueryBuilder<PinMessageCollection,
    PinMessageCollection, QFilterCondition> {}

extension PinMessageCollectionQuerySortBy
    on QueryBuilder<PinMessageCollection, PinMessageCollection, QSortBy> {
  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByParentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByParentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByPinnedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pinnedBy', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByPinnedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pinnedBy', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ref', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ref', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }
}

extension PinMessageCollectionQuerySortThenBy
    on QueryBuilder<PinMessageCollection, PinMessageCollection, QSortThenBy> {
  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByParentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByParentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByPinnedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pinnedBy', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByPinnedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pinnedBy', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ref', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ref', Sort.desc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }
}

extension PinMessageCollectionQueryWhereDistinct
    on QueryBuilder<PinMessageCollection, PinMessageCollection, QDistinct> {
  QueryBuilder<PinMessageCollection, PinMessageCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QDistinct>
      distinctByParentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QDistinct>
      distinctByPinnedBy({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pinnedBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QDistinct>
      distinctByRef({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ref', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PinMessageCollection, PinMessageCollection, QDistinct>
      distinctByRoomId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }
}

extension PinMessageCollectionQueryProperty on QueryBuilder<
    PinMessageCollection, PinMessageCollection, QQueryProperty> {
  QueryBuilder<PinMessageCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<PinMessageCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PinMessageCollection, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<PinMessageCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PinMessageCollection, MessageModel?, QQueryOperations>
      messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<PinMessageCollection, String?, QQueryOperations>
      parentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentId');
    });
  }

  QueryBuilder<PinMessageCollection, String?, QQueryOperations>
      pinnedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pinnedBy');
    });
  }

  QueryBuilder<PinMessageCollection, String?, QQueryOperations> refProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ref');
    });
  }

  QueryBuilder<PinMessageCollection, String?, QQueryOperations>
      roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }
}
