// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enabled_features_model.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const EnabledFeaturesModelSchema = Schema(
  name: r'EnabledFeaturesModel',
  id: 5193618106705705026,
  properties: {
    r'analytic': PropertySchema(
      id: 0,
      name: r'analytic',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'bookmark': PropertySchema(
      id: 1,
      name: r'bookmark',
      type: IsarType.object,
      target: r'BookmarkFeatureFlagModel',
    ),
    r'call': PropertySchema(
      id: 2,
      name: r'call',
      type: IsarType.object,
      target: r'CallFeatureFlagModel',
    ),
    r'chatFolder': PropertySchema(
      id: 3,
      name: r'chatFolder',
      type: IsarType.object,
      target: r'ChatFolderFeatureFlagModel',
    ),
    r'chatFolderV2': PropertySchema(
      id: 4,
      name: r'chatFolderV2',
      type: IsarType.object,
      target: r'ChatFolderFeatureFlagModel',
    ),
    r'coin': PropertySchema(
      id: 5,
      name: r'coin',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'debugAccount': PropertySchema(
      id: 6,
      name: r'debugAccount',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'groupPermission': PropertySchema(
      id: 7,
      name: r'groupPermission',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'helpCenter': PropertySchema(
      id: 8,
      name: r'helpCenter',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'holdChat': PropertySchema(
      id: 9,
      name: r'holdChat',
      type: IsarType.object,
      target: r'HoldChatFeatureFlagModel',
    ),
    r'lockMessage': PropertySchema(
      id: 10,
      name: r'lockMessage',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'multipleAccount': PropertySchema(
      id: 11,
      name: r'multipleAccount',
      type: IsarType.object,
      target: r'MultipleAccountFeatureFlagModel',
    ),
    r'newMessage': PropertySchema(
      id: 12,
      name: r'newMessage',
      type: IsarType.object,
      target: r'NewMessageEffectFeatureFlagModel',
    ),
    r'pin': PropertySchema(
      id: 13,
      name: r'pin',
      type: IsarType.object,
      target: r'FeatureAbilityPinModel',
    ),
    r'premiumStore': PropertySchema(
      id: 14,
      name: r'premiumStore',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'previewFont': PropertySchema(
      id: 15,
      name: r'previewFont',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'reactMessage': PropertySchema(
      id: 16,
      name: r'reactMessage',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'secretRoom': PropertySchema(
      id: 17,
      name: r'secretRoom',
      type: IsarType.object,
      target: r'FeatureAbilitySecretRoomModel',
    ),
    r'talker': PropertySchema(
      id: 18,
      name: r'talker',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'troubleshoot': PropertySchema(
      id: 19,
      name: r'troubleshoot',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'uploadPro': PropertySchema(
      id: 20,
      name: r'uploadPro',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'useFirebaseState': PropertySchema(
      id: 21,
      name: r'useFirebaseState',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'webhook': PropertySchema(
      id: 22,
      name: r'webhook',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    ),
    r'whoRead': PropertySchema(
      id: 23,
      name: r'whoRead',
      type: IsarType.object,
      target: r'FeatureFlagBase',
    )
  },
  estimateSize: _enabledFeaturesModelEstimateSize,
  serialize: _enabledFeaturesModelSerialize,
  deserialize: _enabledFeaturesModelDeserialize,
  deserializeProp: _enabledFeaturesModelDeserializeProp,
);

int _enabledFeaturesModelEstimateSize(
  EnabledFeaturesModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.analytic;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.bookmark;
    if (value != null) {
      bytesCount += 3 +
          BookmarkFeatureFlagModelSchema.estimateSize(
              value, allOffsets[BookmarkFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.call;
    if (value != null) {
      bytesCount += 3 +
          CallFeatureFlagModelSchema.estimateSize(
              value, allOffsets[CallFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.chatFolder;
    if (value != null) {
      bytesCount += 3 +
          ChatFolderFeatureFlagModelSchema.estimateSize(
              value, allOffsets[ChatFolderFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.chatFolderV2;
    if (value != null) {
      bytesCount += 3 +
          ChatFolderFeatureFlagModelSchema.estimateSize(
              value, allOffsets[ChatFolderFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.coin;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.debugAccount;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.groupPermission;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.helpCenter;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.holdChat;
    if (value != null) {
      bytesCount += 3 +
          HoldChatFeatureFlagModelSchema.estimateSize(
              value, allOffsets[HoldChatFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.lockMessage;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.multipleAccount;
    if (value != null) {
      bytesCount += 3 +
          MultipleAccountFeatureFlagModelSchema.estimateSize(
              value, allOffsets[MultipleAccountFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.newMessage;
    if (value != null) {
      bytesCount += 3 +
          NewMessageEffectFeatureFlagModelSchema.estimateSize(
              value, allOffsets[NewMessageEffectFeatureFlagModel]!, allOffsets);
    }
  }
  {
    final value = object.pin;
    if (value != null) {
      bytesCount += 3 +
          FeatureAbilityPinModelSchema.estimateSize(
              value, allOffsets[FeatureAbilityPinModel]!, allOffsets);
    }
  }
  {
    final value = object.premiumStore;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.previewFont;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.reactMessage;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.secretRoom;
    if (value != null) {
      bytesCount += 3 +
          FeatureAbilitySecretRoomModelSchema.estimateSize(
              value, allOffsets[FeatureAbilitySecretRoomModel]!, allOffsets);
    }
  }
  {
    final value = object.talker;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.troubleshoot;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.uploadPro;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.useFirebaseState;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.webhook;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  {
    final value = object.whoRead;
    if (value != null) {
      bytesCount += 3 +
          FeatureFlagBaseSchema.estimateSize(
              value, allOffsets[FeatureFlagBase]!, allOffsets);
    }
  }
  return bytesCount;
}

void _enabledFeaturesModelSerialize(
  EnabledFeaturesModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<FeatureFlagBase>(
    offsets[0],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.analytic,
  );
  writer.writeObject<BookmarkFeatureFlagModel>(
    offsets[1],
    allOffsets,
    BookmarkFeatureFlagModelSchema.serialize,
    object.bookmark,
  );
  writer.writeObject<CallFeatureFlagModel>(
    offsets[2],
    allOffsets,
    CallFeatureFlagModelSchema.serialize,
    object.call,
  );
  writer.writeObject<ChatFolderFeatureFlagModel>(
    offsets[3],
    allOffsets,
    ChatFolderFeatureFlagModelSchema.serialize,
    object.chatFolder,
  );
  writer.writeObject<ChatFolderFeatureFlagModel>(
    offsets[4],
    allOffsets,
    ChatFolderFeatureFlagModelSchema.serialize,
    object.chatFolderV2,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[5],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.coin,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[6],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.debugAccount,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[7],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.groupPermission,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[8],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.helpCenter,
  );
  writer.writeObject<HoldChatFeatureFlagModel>(
    offsets[9],
    allOffsets,
    HoldChatFeatureFlagModelSchema.serialize,
    object.holdChat,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[10],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.lockMessage,
  );
  writer.writeObject<MultipleAccountFeatureFlagModel>(
    offsets[11],
    allOffsets,
    MultipleAccountFeatureFlagModelSchema.serialize,
    object.multipleAccount,
  );
  writer.writeObject<NewMessageEffectFeatureFlagModel>(
    offsets[12],
    allOffsets,
    NewMessageEffectFeatureFlagModelSchema.serialize,
    object.newMessage,
  );
  writer.writeObject<FeatureAbilityPinModel>(
    offsets[13],
    allOffsets,
    FeatureAbilityPinModelSchema.serialize,
    object.pin,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[14],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.premiumStore,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[15],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.previewFont,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[16],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.reactMessage,
  );
  writer.writeObject<FeatureAbilitySecretRoomModel>(
    offsets[17],
    allOffsets,
    FeatureAbilitySecretRoomModelSchema.serialize,
    object.secretRoom,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[18],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.talker,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[19],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.troubleshoot,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[20],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.uploadPro,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[21],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.useFirebaseState,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[22],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.webhook,
  );
  writer.writeObject<FeatureFlagBase>(
    offsets[23],
    allOffsets,
    FeatureFlagBaseSchema.serialize,
    object.whoRead,
  );
}

EnabledFeaturesModel _enabledFeaturesModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EnabledFeaturesModel(
    analytic: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[0],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    bookmark: reader.readObjectOrNull<BookmarkFeatureFlagModel>(
      offsets[1],
      BookmarkFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    call: reader.readObjectOrNull<CallFeatureFlagModel>(
      offsets[2],
      CallFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    chatFolder: reader.readObjectOrNull<ChatFolderFeatureFlagModel>(
      offsets[3],
      ChatFolderFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    chatFolderV2: reader.readObjectOrNull<ChatFolderFeatureFlagModel>(
      offsets[4],
      ChatFolderFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    coin: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[5],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    debugAccount: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[6],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    groupPermission: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[7],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    helpCenter: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[8],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    holdChat: reader.readObjectOrNull<HoldChatFeatureFlagModel>(
      offsets[9],
      HoldChatFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    lockMessage: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[10],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    multipleAccount: reader.readObjectOrNull<MultipleAccountFeatureFlagModel>(
      offsets[11],
      MultipleAccountFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    newMessage: reader.readObjectOrNull<NewMessageEffectFeatureFlagModel>(
      offsets[12],
      NewMessageEffectFeatureFlagModelSchema.deserialize,
      allOffsets,
    ),
    pin: reader.readObjectOrNull<FeatureAbilityPinModel>(
      offsets[13],
      FeatureAbilityPinModelSchema.deserialize,
      allOffsets,
    ),
    premiumStore: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[14],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    previewFont: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[15],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    reactMessage: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[16],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    secretRoom: reader.readObjectOrNull<FeatureAbilitySecretRoomModel>(
      offsets[17],
      FeatureAbilitySecretRoomModelSchema.deserialize,
      allOffsets,
    ),
    talker: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[18],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    troubleshoot: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[19],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    uploadPro: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[20],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    useFirebaseState: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[21],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    webhook: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[22],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
    whoRead: reader.readObjectOrNull<FeatureFlagBase>(
      offsets[23],
      FeatureFlagBaseSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _enabledFeaturesModelDeserializeProp<P>(
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
      return (reader.readObjectOrNull<BookmarkFeatureFlagModel>(
        offset,
        BookmarkFeatureFlagModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readObjectOrNull<CallFeatureFlagModel>(
        offset,
        CallFeatureFlagModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readObjectOrNull<ChatFolderFeatureFlagModel>(
        offset,
        ChatFolderFeatureFlagModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readObjectOrNull<ChatFolderFeatureFlagModel>(
        offset,
        ChatFolderFeatureFlagModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 5:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
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
      return (reader.readObjectOrNull<MultipleAccountFeatureFlagModel>(
        offset,
        MultipleAccountFeatureFlagModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 12:
      return (reader.readObjectOrNull<NewMessageEffectFeatureFlagModel>(
        offset,
        NewMessageEffectFeatureFlagModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 13:
      return (reader.readObjectOrNull<FeatureAbilityPinModel>(
        offset,
        FeatureAbilityPinModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 14:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
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
    case 18:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 19:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 20:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 21:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 22:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    case 23:
      return (reader.readObjectOrNull<FeatureFlagBase>(
        offset,
        FeatureFlagBaseSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension EnabledFeaturesModelQueryFilter on QueryBuilder<EnabledFeaturesModel,
    EnabledFeaturesModel, QFilterCondition> {
  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> analyticIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'analytic',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> analyticIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'analytic',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> bookmarkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bookmark',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> bookmarkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bookmark',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> callIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'call',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> callIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'call',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> chatFolderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chatFolder',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> chatFolderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chatFolder',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> chatFolderV2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chatFolderV2',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> chatFolderV2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chatFolderV2',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> coinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coin',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> coinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coin',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> debugAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'debugAccount',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> debugAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'debugAccount',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> groupPermissionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupPermission',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> groupPermissionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupPermission',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> helpCenterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'helpCenter',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> helpCenterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'helpCenter',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> holdChatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'holdChat',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> holdChatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'holdChat',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> lockMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lockMessage',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> lockMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lockMessage',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> multipleAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'multipleAccount',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> multipleAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'multipleAccount',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> newMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newMessage',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> newMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newMessage',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> pinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pin',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> pinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pin',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> premiumStoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'premiumStore',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> premiumStoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'premiumStore',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> previewFontIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'previewFont',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> previewFontIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'previewFont',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> reactMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reactMessage',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> reactMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reactMessage',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> secretRoomIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secretRoom',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> secretRoomIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secretRoom',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> talkerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'talker',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> talkerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'talker',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> troubleshootIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'troubleshoot',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> troubleshootIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'troubleshoot',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> uploadProIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uploadPro',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> uploadProIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uploadPro',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> useFirebaseStateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'useFirebaseState',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> useFirebaseStateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'useFirebaseState',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> webhookIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'webhook',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> webhookIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'webhook',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> whoReadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'whoRead',
      ));
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> whoReadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'whoRead',
      ));
    });
  }
}

extension EnabledFeaturesModelQueryObject on QueryBuilder<EnabledFeaturesModel,
    EnabledFeaturesModel, QFilterCondition> {
  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> analytic(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'analytic');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> bookmark(FilterQuery<BookmarkFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'bookmark');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> call(FilterQuery<CallFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'call');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
          QAfterFilterCondition>
      chatFolder(FilterQuery<ChatFolderFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'chatFolder');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
          QAfterFilterCondition>
      chatFolderV2(FilterQuery<ChatFolderFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'chatFolderV2');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> coin(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'coin');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> debugAccount(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'debugAccount');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> groupPermission(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'groupPermission');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> helpCenter(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'helpCenter');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> holdChat(FilterQuery<HoldChatFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'holdChat');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> lockMessage(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lockMessage');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
          QAfterFilterCondition>
      multipleAccount(FilterQuery<MultipleAccountFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'multipleAccount');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
          QAfterFilterCondition>
      newMessage(FilterQuery<NewMessageEffectFeatureFlagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'newMessage');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> pin(FilterQuery<FeatureAbilityPinModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pin');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> premiumStore(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'premiumStore');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> previewFont(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'previewFont');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> reactMessage(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'reactMessage');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
          QAfterFilterCondition>
      secretRoom(FilterQuery<FeatureAbilitySecretRoomModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'secretRoom');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> talker(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'talker');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> troubleshoot(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'troubleshoot');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> uploadPro(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'uploadPro');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> useFirebaseState(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'useFirebaseState');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> webhook(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'webhook');
    });
  }

  QueryBuilder<EnabledFeaturesModel, EnabledFeaturesModel,
      QAfterFilterCondition> whoRead(FilterQuery<FeatureFlagBase> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'whoRead');
    });
  }
}
