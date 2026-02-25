// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FeatureModelSchema = Schema(
  name: r'FeatureModel',
  id: 5894419655063267141,
  properties: {
    r'animatedProfileFeature': PropertySchema(
      id: 0,
      name: r'animatedProfileFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'changeAppIconFeature': PropertySchema(
      id: 1,
      name: r'changeAppIconFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'changeFriendProfileFeature': PropertySchema(
      id: 2,
      name: r'changeFriendProfileFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'chatFolderFeature': PropertySchema(
      id: 3,
      name: r'chatFolderFeature',
      type: IsarType.object,
      target: r'ChatFolderFeatureFlagModel',
    ),
    r'coCalendarFeature': PropertySchema(
      id: 4,
      name: r'coCalendarFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'contents': PropertySchema(
      id: 5,
      name: r'contents',
      type: IsarType.objectList,
      target: r'FeatureFlagBase',
    ),
    r'emojiBookmarkFeature': PropertySchema(
      id: 6,
      name: r'emojiBookmarkFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'emojiFeature': PropertySchema(
      id: 7,
      name: r'emojiFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'hideAccountFeature': PropertySchema(
      id: 8,
      name: r'hideAccountFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'holdChatFeature': PropertySchema(
      id: 9,
      name: r'holdChatFeature',
      type: IsarType.object,
      target: r'HoldChatFeatureFlagModel',
    ),
    r'lastSeenTimeFeature': PropertySchema(
      id: 10,
      name: r'lastSeenTimeFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'liveLocationFeature': PropertySchema(
      id: 11,
      name: r'liveLocationFeature',
      type: IsarType.object,
      target: r'FeatureAbilityLiveLocationModel',
    ),
    r'lockMessageFeature': PropertySchema(
      id: 12,
      name: r'lockMessageFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'multipleAccountFeature': PropertySchema(
      id: 13,
      name: r'multipleAccountFeature',
      type: IsarType.object,
      target: r'MultipleAccountFeatureFlagModel',
    ),
    r'pinFeature': PropertySchema(
      id: 14,
      name: r'pinFeature',
      type: IsarType.object,
      target: r'FeatureAbilityPinModel',
    ),
    r'pinToAccessFeature': PropertySchema(
      id: 15,
      name: r'pinToAccessFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'privacyAccountFeature': PropertySchema(
      id: 16,
      name: r'privacyAccountFeature',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'secretRoomFeature': PropertySchema(
      id: 17,
      name: r'secretRoomFeature',
      type: IsarType.object,
      target: r'FeatureAbilitySecretRoomModel',
    )
  },
  estimateSize: _featureModelEstimateSize,
  serialize: _featureModelSerialize,
  deserialize: _featureModelDeserialize,
  deserializeProp: _featureModelDeserializeProp,
);

int _featureModelEstimateSize(
  FeatureModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.animatedProfileFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.changeAppIconFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.changeFriendProfileFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.chatFolderFeature;
    if (value != null) {
      bytesCount += 3 +
          ChatFolderFeatureFlagModelSchema.estimateSize(
              value, allOffsets[ChatFolderFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.coCalendarFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final list = object.contents;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[FeatureFlagBase]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              FeatureFlagBaseSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.emojiBookmarkFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.emojiFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.hideAccountFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.holdChatFeature;
    if (value != null) {
      bytesCount += 3 +
          HoldChatFeatureFlagModelSchema.estimateSize(
              value, allOffsets[HoldChatFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.lastSeenTimeFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.liveLocationFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureAbilityLiveLocationModelSchema.estimateSize(
              value, allOffsets[FeatureAbilityLiveLocationModel]!, allOffsets);
    }
  }
  {
    final value = object.lockMessageFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.multipleAccountFeature;
    if (value != null) {
      bytesCount += 3 +
          MultipleAccountFeatureFlagModelSchema.estimateSize(
              value, allOffsets[MultipleAccountFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.pinFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureAbilityPinModelSchema.estimateSize(
              value, allOffsets[FeatureAbilityPinModel]!, allOffsets);
    }
  }
  {
    final value = object.pinToAccessFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.privacyAccountFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.secretRoomFeature;
    if (value != null) {
      bytesCount += 3 +
          FeatureAbilitySecretRoomModelSchema.estimateSize(
              value, allOffsets[FeatureAbilitySecretRoomModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _featureModelSerialize(
  FeatureModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<FeatureFlagBase>(
    offsets[0],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.animatedProfileFeature,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[1],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.changeAppIconFeature,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[2],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.changeFriendProfileFeature,
  );
  writer.writeObject<ChatFolderFeatureFlagModel>(
    offsets[3],
    allOffsets,
    ChatFolderFeatureFlagModelSchema.serialize,
    object.chatFolderFeature,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[4],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.coCalendarFeature,
  );
  writer.writeObjectList<FeatureFlagBase>(
    offsets[5],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.contents,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[6],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.emojiBookmarkFeature,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[7],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.emojiFeature,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[8],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.hideAccountFeature,
  );
  writer.writeObject<HoldChatFeatureFlagModel>(
    offsets[9],
    allOffsets,
    HoldChatFeatureFlagModelSchema.serialize,
    object.holdChatFeature,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[10],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.lastSeenTimeFeature,
  );
  writer.writeObject<FeatureAbilityLiveLocationModel>(
    offsets[11],
    allOffsets,
    FeatureAbilityLiveLocationModelSchema.serialize,
    object.liveLocationFeature,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[12],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.lockMessageFeature,
  );
  writer.writeObject<MultipleAccountFeatureFlagModel>(
    offsets[13],
    allOffsets,
    MultipleAccountFeatureFlagModelSchema.serialize,
    object.multipleAccountFeature,
  );
  writer.writeObject<FeatureAbilityPinModel>(
    offsets[14],
    allOffsets,
    FeatureAbilityPinModelSchema.serialize,
    object.pinFeature,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[15],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.pinToAccessFeature,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[16],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.privacyAccountFeature,
  );
  writer.writeObject<FeatureAbilitySecretRoomModel>(
    offsets[17],
    allOffsets,
    FeatureAbilitySecretRoomModelSchema.serialize,
    object.secretRoomFeature,
  );
}

FeatureModel _featureModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FeatureModel(
    animatedProfileFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[0],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    changeAppIconFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[1],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    changeFriendProfileFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[2],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    chatFolderFeature: reader.readObjectOrNull<ChatFolderFeatureFlagModel>(
      offsets[3],
      ChatFolderFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    coCalendarFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[4],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    contents: reader.readObjectList<FeatureFlagBase>(
      offsets[5],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
      FeatureFlagBase(),
    ),
    emojiBookmarkFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[6],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    emojiFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[7],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    hideAccountFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[8],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    holdChatFeature: reader.readObjectOrNull<HoldChatFeatureFlagModel>(
      offsets[9],
      HoldChatFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    lastSeenTimeFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[10],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    liveLocationFeature:
        reader.readObjectOrNull<FeatureAbilityLiveLocationModel>(
      offsets[11],
      FeatureAbilityLiveLocationModelSchema.deserialize,
      allOffsets,
    ),
    lockMessageFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[12],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    multipleAccountFeature:
        reader.readObjectOrNull<MultipleAccountFeatureFlagModel>(
      offsets[13],
      MultipleAccountFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    pinFeature: reader.readObjectOrNull<FeatureAbilityPinModel>(
      offsets[14],
      FeatureAbilityPinModelSchema.deserialize,
      allOffsets,
    ),
    pinToAccessFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[15],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    privacyAccountFeature: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[16],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    secretRoomFeature: reader.readObjectOrNull<FeatureAbilitySecretRoomModel>(
      offsets[17],
      FeatureAbilitySecretRoomModelSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _featureModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readObjectOrNull<ChatFolderFeatureFlagModel>(
        offset,
        ChatFolderFeatureFlagModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 5:
      return (reader.readObjectList<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
        FeatureFlagBase(),
      )) as P;
    case 6:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 7:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 8:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 9:
      return (reader.readObjectOrNull<HoldChatFeatureFlagModel>(
        offset,
        HoldChatFeatureFlagModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 10:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 11:
      return (reader.readObjectOrNull<FeatureAbilityLiveLocationModel>(
        offset,
        FeatureAbilityLiveLocationModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 12:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 13:
      return (reader.readObjectOrNull<MultipleAccountFeatureFlagModel>(
        offset,
        MultipleAccountFeatureFlagModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 14:
      return (reader.readObjectOrNull<FeatureAbilityPinModel>(
        offset,
        FeatureAbilityPinModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 15:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 16:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 17:
      return (reader.readObjectOrNull<FeatureAbilitySecretRoomModel>(
        offset,
        FeatureAbilitySecretRoomModelSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FeatureModelQueryFilter
    on QueryBuilder<FeatureModel, FeatureModel, QFilterCondition> {
  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      animatedProfileFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'animatedProfileFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      animatedProfileFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'animatedProfileFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      changeAppIconFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'changeAppIconFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      changeAppIconFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'changeAppIconFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      changeFriendProfileFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'changeFriendProfileFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      changeFriendProfileFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'changeFriendProfileFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      chatFolderFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chatFolderFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      chatFolderFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chatFolderFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      coCalendarFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coCalendarFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      coCalendarFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coCalendarFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      contentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contents',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      contentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contents',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      contentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contents',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      contentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contents',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      contentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contents',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      contentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contents',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      contentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contents',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      contentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contents',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      emojiBookmarkFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiBookmarkFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      emojiBookmarkFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiBookmarkFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      emojiFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emojiFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      emojiFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emojiFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      hideAccountFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hideAccountFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      hideAccountFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hideAccountFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      holdChatFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'holdChatFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      holdChatFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'holdChatFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      lastSeenTimeFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSeenTimeFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      lastSeenTimeFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSeenTimeFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      liveLocationFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'liveLocationFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      liveLocationFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'liveLocationFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      lockMessageFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lockMessageFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      lockMessageFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lockMessageFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      multipleAccountFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'multipleAccountFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      multipleAccountFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'multipleAccountFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      pinFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pinFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      pinFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pinFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      pinToAccessFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pinToAccessFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      pinToAccessFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pinToAccessFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      privacyAccountFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'privacyAccountFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      privacyAccountFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'privacyAccountFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      secretRoomFeatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secretRoomFeature',
      ));
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      secretRoomFeatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secretRoomFeature',
      ));
    });
  }
}

extension FeatureModelQueryObject
    on QueryBuilder<FeatureModel, FeatureModel, QFilterCondition> {
  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      animatedProfileFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'animatedProfileFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      changeAppIconFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'changeAppIconFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      changeFriendProfileFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'changeFriendProfileFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      chatFolderFeature(FilterQuery<ChatFolderFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'chatFolderFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      coCalendarFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'coCalendarFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      contentsElement(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'contents');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      emojiBookmarkFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'emojiBookmarkFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition> emojiFeature(
      FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'emojiFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      hideAccountFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'hideAccountFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      holdChatFeature(FilterQuery<HoldChatFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'holdChatFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      lastSeenTimeFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lastSeenTimeFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      liveLocationFeature(FilterQuery<FeatureAbilityLiveLocationModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'liveLocationFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      lockMessageFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lockMessageFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      multipleAccountFeature(FilterQuery<MultipleAccountFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'multipleAccountFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition> pinFeature(
      FilterQuery<FeatureAbilityPinModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pinFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      pinToAccessFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pinToAccessFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      privacyAccountFeature(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'privacyAccountFeature');
    });
  }

  QueryBuilder<FeatureModel, FeatureModel, QAfterFilterCondition>
      secretRoomFeature(FilterQuery<FeatureAbilitySecretRoomModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'secretRoomFeature');
    });
  }
}
