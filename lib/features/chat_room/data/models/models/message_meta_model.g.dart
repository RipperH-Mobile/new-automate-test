// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_meta_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MessageMetaModelSchema = Schema(
  name: r'MessageMetaModel',
  id: 3442376442839140237,
  properties: {
    r'albumId': PropertySchema(
      id: 0,
      name: r'albumId',
      type: IsarType.string,
    ),
    r'albumIsCreateOnly': PropertySchema(
      id: 1,
      name: r'albumIsCreateOnly',
      type: IsarType.bool,
    ),
    r'albumName': PropertySchema(
      id: 2,
      name: r'albumName',
      type: IsarType.string,
    ),
    r'albumTasks': PropertySchema(
      id: 3,
      name: r'albumTasks',
      type: IsarType.object,
      target: r'AlbumTaskModel',
    ),
    r'deletedAt': PropertySchema(
      id: 4,
      name: r'deletedAt',
      type: IsarType.dateTime,
    ),
    r'deletedBy': PropertySchema(
      id: 5,
      name: r'deletedBy',
      type: IsarType.object,
      target: r'DeletedByAccountModel',
    ),
    r'gifHeight': PropertySchema(
      id: 6,
      name: r'gifHeight',
      type: IsarType.double,
    ),
    r'gifMp4Url': PropertySchema(
      id: 7,
      name: r'gifMp4Url',
      type: IsarType.string,
    ),
    r'gifUrl': PropertySchema(
      id: 8,
      name: r'gifUrl',
      type: IsarType.string,
    ),
    r'gifWebpUrl': PropertySchema(
      id: 9,
      name: r'gifWebpUrl',
      type: IsarType.string,
    ),
    r'gifWidth': PropertySchema(
      id: 10,
      name: r'gifWidth',
      type: IsarType.double,
    ),
    r'giphyId': PropertySchema(
      id: 11,
      name: r'giphyId',
      type: IsarType.string,
    ),
    r'isCreatedAlbum': PropertySchema(
      id: 12,
      name: r'isCreatedAlbum',
      type: IsarType.bool,
    ),
    r'isEmoji': PropertySchema(
      id: 13,
      name: r'isEmoji',
      type: IsarType.bool,
    ),
    r'isRegEx': PropertySchema(
      id: 14,
      name: r'isRegEx',
      type: IsarType.bool,
    ),
    r'locationFormattedAddress': PropertySchema(
      id: 15,
      name: r'locationFormattedAddress',
      type: IsarType.string,
    ),
    r'locationImgBlurhash': PropertySchema(
      id: 16,
      name: r'locationImgBlurhash',
      type: IsarType.string,
    ),
    r'locationImgId': PropertySchema(
      id: 17,
      name: r'locationImgId',
      type: IsarType.string,
    ),
    r'locationLat': PropertySchema(
      id: 18,
      name: r'locationLat',
      type: IsarType.double,
    ),
    r'locationLng': PropertySchema(
      id: 19,
      name: r'locationLng',
      type: IsarType.double,
    ),
    r'locationName': PropertySchema(
      id: 20,
      name: r'locationName',
      type: IsarType.string,
    ),
    r'locationPlacesId': PropertySchema(
      id: 21,
      name: r'locationPlacesId',
      type: IsarType.string,
    ),
    r'locationVicinity': PropertySchema(
      id: 22,
      name: r'locationVicinity',
      type: IsarType.string,
    ),
    r'lockMessageData': PropertySchema(
      id: 23,
      name: r'lockMessageData',
      type: IsarType.string,
    ),
    r'lockMessageIv': PropertySchema(
      id: 24,
      name: r'lockMessageIv',
      type: IsarType.string,
    ),
    r'lockMessageSalt': PropertySchema(
      id: 25,
      name: r'lockMessageSalt',
      type: IsarType.string,
    ),
    r'stickerCoverId': PropertySchema(
      id: 26,
      name: r'stickerCoverId',
      type: IsarType.string,
    ),
    r'stickerDescription': PropertySchema(
      id: 27,
      name: r'stickerDescription',
      type: IsarType.string,
    ),
    r'stickerEmoji': PropertySchema(
      id: 28,
      name: r'stickerEmoji',
      type: IsarType.string,
    ),
    r'stickerName': PropertySchema(
      id: 29,
      name: r'stickerName',
      type: IsarType.string,
    ),
    r'stickerPack': PropertySchema(
      id: 30,
      name: r'stickerPack',
      type: IsarType.string,
    ),
    r'stickerPrice': PropertySchema(
      id: 31,
      name: r'stickerPrice',
      type: IsarType.double,
    ),
    r'stickerPublisher': PropertySchema(
      id: 32,
      name: r'stickerPublisher',
      type: IsarType.string,
    ),
    r'stickerValue': PropertySchema(
      id: 33,
      name: r'stickerValue',
      type: IsarType.string,
    )
  },
  estimateSize: _messageMetaModelEstimateSize,
  serialize: _messageMetaModelSerialize,
  deserialize: _messageMetaModelDeserialize,
  deserializeProp: _messageMetaModelDeserializeProp,
);

int _messageMetaModelEstimateSize(
  MessageMetaModel object,
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
    final value = object.albumName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.albumTasks;
    if (value != null) {
      bytesCount += 3 +
          AlbumTaskModelSchema.estimateSize(
              value, allOffsets[AlbumTaskModel]!, allOffsets);
    }
  }
  {
    final value = object.deletedBy;
    if (value != null) {
      bytesCount += 3 +
          DeletedByAccountModelSchema.estimateSize(
              value, allOffsets[DeletedByAccountModel]!, allOffsets);
    }
  }
  {
    final value = object.gifMp4Url;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.gifUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.gifWebpUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.giphyId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.locationFormattedAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.locationImgBlurhash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.locationImgId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.locationName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.locationPlacesId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.locationVicinity;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lockMessageData;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lockMessageIv;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lockMessageSalt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stickerCoverId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stickerDescription;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stickerEmoji;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stickerName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stickerPack;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stickerPublisher;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stickerValue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _messageMetaModelSerialize(
  MessageMetaModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.albumId);
  writer.writeBool(offsets[1], object.albumIsCreateOnly);
  writer.writeString(offsets[2], object.albumName);
  writer.writeObject<AlbumTaskModel>(
    offsets[3],
    allOffsets,
    AlbumTaskModelSchema.serialize,
    object.albumTasks,
  );
  writer.writeDateTime(offsets[4], object.deletedAt);
  writer.writeObject<DeletedByAccountModel>(
    offsets[5],
    allOffsets,
    DeletedByAccountModelSchema.serialize,
    object.deletedBy,
  );
  writer.writeDouble(offsets[6], object.gifHeight);
  writer.writeString(offsets[7], object.gifMp4Url);
  writer.writeString(offsets[8], object.gifUrl);
  writer.writeString(offsets[9], object.gifWebpUrl);
  writer.writeDouble(offsets[10], object.gifWidth);
  writer.writeString(offsets[11], object.giphyId);
  writer.writeBool(offsets[12], object.isCreatedAlbum);
  writer.writeBool(offsets[13], object.isEmoji);
  writer.writeBool(offsets[14], object.isRegEx);
  writer.writeString(offsets[15], object.locationFormattedAddress);
  writer.writeString(offsets[16], object.locationImgBlurhash);
  writer.writeString(offsets[17], object.locationImgId);
  writer.writeDouble(offsets[18], object.locationLat);
  writer.writeDouble(offsets[19], object.locationLng);
  writer.writeString(offsets[20], object.locationName);
  writer.writeString(offsets[21], object.locationPlacesId);
  writer.writeString(offsets[22], object.locationVicinity);
  writer.writeString(offsets[23], object.lockMessageData);
  writer.writeString(offsets[24], object.lockMessageIv);
  writer.writeString(offsets[25], object.lockMessageSalt);
  writer.writeString(offsets[26], object.stickerCoverId);
  writer.writeString(offsets[27], object.stickerDescription);
  writer.writeString(offsets[28], object.stickerEmoji);
  writer.writeString(offsets[29], object.stickerName);
  writer.writeString(offsets[30], object.stickerPack);
  writer.writeDouble(offsets[31], object.stickerPrice);
  writer.writeString(offsets[32], object.stickerPublisher);
  writer.writeString(offsets[33], object.stickerValue);
}

MessageMetaModel _messageMetaModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageMetaModel(
    albumId: reader.readStringOrNull(offsets[0]),
    albumIsCreateOnly: reader.readBoolOrNull(offsets[1]),
    albumName: reader.readStringOrNull(offsets[2]),
    albumTasks: reader.readObjectOrNull<AlbumTaskModel>(
      offsets[3],
      AlbumTaskModelSchema.deserialize,
      allOffsets,
    ),
    deletedAt: reader.readDateTimeOrNull(offsets[4]),
    deletedBy: reader.readObjectOrNull<DeletedByAccountModel>(
      offsets[5],
      DeletedByAccountModelSchema.deserialize,
      allOffsets,
    ),
    gifHeight: reader.readDoubleOrNull(offsets[6]),
    gifMp4Url: reader.readStringOrNull(offsets[7]),
    gifUrl: reader.readStringOrNull(offsets[8]),
    gifWebpUrl: reader.readStringOrNull(offsets[9]),
    gifWidth: reader.readDoubleOrNull(offsets[10]),
    giphyId: reader.readStringOrNull(offsets[11]),
    isCreatedAlbum: reader.readBoolOrNull(offsets[12]),
    isEmoji: reader.readBoolOrNull(offsets[13]),
    isRegEx: reader.readBoolOrNull(offsets[14]),
    locationFormattedAddress: reader.readStringOrNull(offsets[15]),
    locationImgBlurhash: reader.readStringOrNull(offsets[16]),
    locationImgId: reader.readStringOrNull(offsets[17]),
    locationLat: reader.readDoubleOrNull(offsets[18]),
    locationLng: reader.readDoubleOrNull(offsets[19]),
    locationName: reader.readStringOrNull(offsets[20]),
    locationPlacesId: reader.readStringOrNull(offsets[21]),
    locationVicinity: reader.readStringOrNull(offsets[22]),
    lockMessageData: reader.readStringOrNull(offsets[23]),
    lockMessageIv: reader.readStringOrNull(offsets[24]),
    lockMessageSalt: reader.readStringOrNull(offsets[25]),
    stickerCoverId: reader.readStringOrNull(offsets[26]),
    stickerDescription: reader.readStringOrNull(offsets[27]),
    stickerEmoji: reader.readStringOrNull(offsets[28]),
    stickerName: reader.readStringOrNull(offsets[29]),
    stickerPack: reader.readStringOrNull(offsets[30]),
    stickerPrice: reader.readDoubleOrNull(offsets[31]) ?? 0,
    stickerPublisher: reader.readStringOrNull(offsets[32]),
    stickerValue: reader.readStringOrNull(offsets[33]),
  );
  return object;
}

P _messageMetaModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<AlbumTaskModel>(
        offset,
        AlbumTaskModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readObjectOrNull<DeletedByAccountModel>(
        offset,
        DeletedByAccountModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset)) as P;
    case 13:
      return (reader.readBoolOrNull(offset)) as P;
    case 14:
      return (reader.readBoolOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    case 19:
      return (reader.readDoubleOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readStringOrNull(offset)) as P;
    case 29:
      return (reader.readStringOrNull(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 32:
      return (reader.readStringOrNull(offset)) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MessageMetaModelQueryFilter
    on QueryBuilder<MessageMetaModel, MessageMetaModel, QFilterCondition> {
  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumIsCreateOnlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumIsCreateOnly',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumIsCreateOnlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumIsCreateOnly',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumIsCreateOnlyEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumIsCreateOnly',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumName',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumName',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
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

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumTasksIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumTasks',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumTasksIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumTasks',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      deletedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      deletedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      deletedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      deletedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      deletedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      deletedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deletedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      deletedByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deletedBy',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      deletedByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deletedBy',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifHeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gifHeight',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifHeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gifHeight',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifHeightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gifHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifHeightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gifHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifHeightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gifHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifHeightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gifHeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gifMp4Url',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gifMp4Url',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gifMp4Url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gifMp4Url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gifMp4Url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gifMp4Url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gifMp4Url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gifMp4Url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gifMp4Url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gifMp4Url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gifMp4Url',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifMp4UrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gifMp4Url',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gifUrl',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gifUrl',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gifUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gifUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gifUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gifUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gifUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gifUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gifUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gifUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gifUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gifUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gifWebpUrl',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gifWebpUrl',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gifWebpUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gifWebpUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gifWebpUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gifWebpUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gifWebpUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gifWebpUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gifWebpUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gifWebpUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gifWebpUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWebpUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gifWebpUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWidthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gifWidth',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWidthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gifWidth',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWidthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gifWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWidthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gifWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWidthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gifWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      gifWidthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gifWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'giphyId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'giphyId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'giphyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'giphyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'giphyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'giphyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'giphyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'giphyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'giphyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'giphyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'giphyId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      giphyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'giphyId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      isCreatedAlbumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCreatedAlbum',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      isCreatedAlbumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCreatedAlbum',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      isCreatedAlbumEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCreatedAlbum',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      isEmojiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isEmoji',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      isEmojiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isEmoji',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      isEmojiEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEmoji',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      isRegExIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isRegEx',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      isRegExIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isRegEx',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      isRegExEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRegEx',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationFormattedAddress',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationFormattedAddress',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationFormattedAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationFormattedAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationFormattedAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationFormattedAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationFormattedAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationFormattedAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationFormattedAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationFormattedAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationFormattedAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationFormattedAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationFormattedAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationImgBlurhash',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationImgBlurhash',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationImgBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationImgBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationImgBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationImgBlurhash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationImgBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationImgBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationImgBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationImgBlurhash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationImgBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgBlurhashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationImgBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationImgId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationImgId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationImgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationImgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationImgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationImgId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationImgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationImgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationImgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationImgId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationImgId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationImgIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationImgId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationLat',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationLat',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLatEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLatGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLatLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLatBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationLat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLngIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationLng',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLngIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationLng',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLngEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLngGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLngLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationLngBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationLng',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationName',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationName',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationPlacesId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationPlacesId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationPlacesId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationPlacesId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationPlacesId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationPlacesId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationPlacesId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationPlacesId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationPlacesId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationPlacesId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationPlacesId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationPlacesIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationPlacesId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationVicinity',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationVicinity',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationVicinity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationVicinity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationVicinity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationVicinity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationVicinity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationVicinity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationVicinity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationVicinity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationVicinity',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      locationVicinityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationVicinity',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lockMessageData',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lockMessageData',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockMessageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lockMessageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lockMessageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lockMessageData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lockMessageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lockMessageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lockMessageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lockMessageData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockMessageData',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lockMessageData',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lockMessageIv',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lockMessageIv',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockMessageIv',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lockMessageIv',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lockMessageIv',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lockMessageIv',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lockMessageIv',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lockMessageIv',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lockMessageIv',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lockMessageIv',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockMessageIv',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageIvIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lockMessageIv',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lockMessageSalt',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lockMessageSalt',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockMessageSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lockMessageSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lockMessageSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lockMessageSalt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lockMessageSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lockMessageSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lockMessageSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lockMessageSalt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockMessageSalt',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      lockMessageSaltIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lockMessageSalt',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stickerCoverId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stickerCoverId',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerCoverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stickerCoverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stickerCoverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stickerCoverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stickerCoverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stickerCoverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stickerCoverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stickerCoverId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerCoverId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerCoverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stickerCoverId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stickerDescription',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stickerDescription',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stickerDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stickerDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stickerDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stickerDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stickerDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stickerDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stickerDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stickerDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stickerEmoji',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stickerEmoji',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stickerEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stickerEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stickerEmoji',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stickerEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stickerEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stickerEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stickerEmoji',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerEmoji',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerEmojiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stickerEmoji',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stickerName',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stickerName',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stickerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stickerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stickerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stickerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stickerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stickerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stickerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stickerName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stickerPack',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stickerPack',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerPack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stickerPack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stickerPack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stickerPack',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stickerPack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stickerPack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stickerPack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stickerPack',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerPack',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPackIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stickerPack',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stickerPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stickerPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stickerPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stickerPublisher',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stickerPublisher',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerPublisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stickerPublisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stickerPublisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stickerPublisher',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stickerPublisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stickerPublisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stickerPublisher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stickerPublisher',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerPublisher',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerPublisherIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stickerPublisher',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stickerValue',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stickerValue',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stickerValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stickerValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stickerValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stickerValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stickerValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stickerValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stickerValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stickerValue',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      stickerValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stickerValue',
        value: '',
      ));
    });
  }
}

extension MessageMetaModelQueryObject
    on QueryBuilder<MessageMetaModel, MessageMetaModel, QFilterCondition> {
  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      albumTasks(FilterQuery<AlbumTaskModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'albumTasks');
    });
  }

  QueryBuilder<MessageMetaModel, MessageMetaModel, QAfterFilterCondition>
      deletedBy(FilterQuery<DeletedByAccountModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'deletedBy');
    });
  }
}
