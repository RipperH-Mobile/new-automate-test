// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserCollectionCollection on Isar {
  IsarCollection<UserCollection> get users => this.collection();
}

const UserCollectionSchema = CollectionSchema(
  name: r'User',
  id: -7838171048429979076,
  properties: {
    r'acceptedPlatformDocument': PropertySchema(
      id: 0,
      name: r'acceptedPlatformDocument',
      type: IsarType.objectList,
      target: r'AcceptedPlatformDocument',
    ),
    r'accountDefaultBookmarkEmojiTags': PropertySchema(
      id: 1,
      name: r'accountDefaultBookmarkEmojiTags',
      type: IsarType.objectList,
      target: r'DefaultBookmarkTagItemModel',
    ),
    r'accountDefaultEmojiItems': PropertySchema(
      id: 2,
      name: r'accountDefaultEmojiItems',
      type: IsarType.objectList,
      target: r'DefaultEmojiItemModel',
    ),
    r'accountSettings': PropertySchema(
      id: 3,
      name: r'accountSettings',
      type: IsarType.object,
      target: r'AccountSettingsModel',
    ),
    r'allBookmarkEmojiTags': PropertySchema(
      id: 4,
      name: r'allBookmarkEmojiTags',
      type: IsarType.objectList,
      target: r'BookmarkTagModel',
    ),
    r'appleOrderId': PropertySchema(
      id: 5,
      name: r'appleOrderId',
      type: IsarType.string,
    ),
    r'appleUserId': PropertySchema(
      id: 6,
      name: r'appleUserId',
      type: IsarType.string,
    ),
    r'avatarBlurhash': PropertySchema(
      id: 7,
      name: r'avatarBlurhash',
      type: IsarType.string,
    ),
    r'avatarId': PropertySchema(
      id: 8,
      name: r'avatarId',
      type: IsarType.string,
    ),
    r'avatarPublic': PropertySchema(
      id: 9,
      name: r'avatarPublic',
      type: IsarType.string,
    ),
    r'avatarUrl': PropertySchema(
      id: 10,
      name: r'avatarUrl',
      type: IsarType.string,
    ),
    r'backgroundBlurhash': PropertySchema(
      id: 11,
      name: r'backgroundBlurhash',
      type: IsarType.string,
    ),
    r'backgroundId': PropertySchema(
      id: 12,
      name: r'backgroundId',
      type: IsarType.string,
    ),
    r'backgroundUrl': PropertySchema(
      id: 13,
      name: r'backgroundUrl',
      type: IsarType.string,
    ),
    r'birthDate': PropertySchema(
      id: 14,
      name: r'birthDate',
      type: IsarType.string,
    ),
    r'callOnSessionKeyId': PropertySchema(
      id: 15,
      name: r'callOnSessionKeyId',
      type: IsarType.string,
    ),
    r'callStatus': PropertySchema(
      id: 16,
      name: r'callStatus',
      type: IsarType.string,
      enumMap: _UserCollectioncallStatusEnumValueMap,
    ),
    r'currentSessionKeyId': PropertySchema(
      id: 17,
      name: r'currentSessionKeyId',
      type: IsarType.string,
    ),
    r'currentStateSeq': PropertySchema(
      id: 18,
      name: r'currentStateSeq',
      type: IsarType.long,
    ),
    r'dBirthdate': PropertySchema(
      id: 19,
      name: r'dBirthdate',
      type: IsarType.dateTime,
    ),
    r'displayName': PropertySchema(
      id: 20,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'email': PropertySchema(
      id: 21,
      name: r'email',
      type: IsarType.string,
    ),
    r'enabledFeatures': PropertySchema(
      id: 22,
      name: r'enabledFeatures',
      type: IsarType.object,
      target: r'EnabledFeaturesModel',
    ),
    r'expireAt': PropertySchema(
      id: 23,
      name: r'expireAt',
      type: IsarType.dateTime,
    ),
    r'firebaseToken': PropertySchema(
      id: 24,
      name: r'firebaseToken',
      type: IsarType.string,
    ),
    r'friendRequestCount': PropertySchema(
      id: 25,
      name: r'friendRequestCount',
      type: IsarType.long,
    ),
    r'googleOrderId': PropertySchema(
      id: 26,
      name: r'googleOrderId',
      type: IsarType.string,
    ),
    r'googleUserId': PropertySchema(
      id: 27,
      name: r'googleUserId',
      type: IsarType.string,
    ),
    r'hasAvatar': PropertySchema(
      id: 28,
      name: r'hasAvatar',
      type: IsarType.bool,
    ),
    r'hasPassword': PropertySchema(
      id: 29,
      name: r'hasPassword',
      type: IsarType.bool,
    ),
    r'hasShowName': PropertySchema(
      id: 30,
      name: r'hasShowName',
      type: IsarType.bool,
    ),
    r'id': PropertySchema(
      id: 31,
      name: r'id',
      type: IsarType.string,
    ),
    r'isCurrentUser': PropertySchema(
      id: 32,
      name: r'isCurrentUser',
      type: IsarType.bool,
    ),
    r'isDeleted': PropertySchema(
      id: 33,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'isMAHidden': PropertySchema(
      id: 34,
      name: r'isMAHidden',
      type: IsarType.bool,
    ),
    r'isNewMessageAnimatedEnable': PropertySchema(
      id: 35,
      name: r'isNewMessageAnimatedEnable',
      type: IsarType.bool,
    ),
    r'isNewMessageSoundEnable': PropertySchema(
      id: 36,
      name: r'isNewMessageSoundEnable',
      type: IsarType.bool,
    ),
    r'lastEditUsernameAt': PropertySchema(
      id: 37,
      name: r'lastEditUsernameAt',
      type: IsarType.dateTime,
    ),
    r'limitFriend': PropertySchema(
      id: 38,
      name: r'limitFriend',
      type: IsarType.long,
    ),
    r'limitMultipleAccount': PropertySchema(
      id: 39,
      name: r'limitMultipleAccount',
      type: IsarType.long,
    ),
    r'linkAccounts': PropertySchema(
      id: 40,
      name: r'linkAccounts',
      type: IsarType.object,
      target: r'LinkAccountsModel',
    ),
    r'loginAt': PropertySchema(
      id: 41,
      name: r'loginAt',
      type: IsarType.dateTime,
    ),
    r'newMessageAnimatedDuration': PropertySchema(
      id: 42,
      name: r'newMessageAnimatedDuration',
      type: IsarType.long,
    ),
    r'newMessageAnimatedType': PropertySchema(
      id: 43,
      name: r'newMessageAnimatedType',
      type: IsarType.long,
    ),
    r'newMessageSoundFriendSelected': PropertySchema(
      id: 44,
      name: r'newMessageSoundFriendSelected',
      type: IsarType.string,
    ),
    r'newMessageSoundMeSelected': PropertySchema(
      id: 45,
      name: r'newMessageSoundMeSelected',
      type: IsarType.string,
    ),
    r'nextReview': PropertySchema(
      id: 46,
      name: r'nextReview',
      type: IsarType.dateTime,
    ),
    r'onlineStatus': PropertySchema(
      id: 47,
      name: r'onlineStatus',
      type: IsarType.string,
      enumMap: _UserCollectiononlineStatusEnumValueMap,
    ),
    r'originalStatusMessage': PropertySchema(
      id: 48,
      name: r'originalStatusMessage',
      type: IsarType.string,
    ),
    r'payStore': PropertySchema(
      id: 49,
      name: r'payStore',
      type: IsarType.string,
      enumMap: _UserCollectionpayStoreEnumValueMap,
    ),
    r'phoneNumber': PropertySchema(
      id: 50,
      name: r'phoneNumber',
      type: IsarType.string,
    ),
    r'premiumPackage': PropertySchema(
      id: 51,
      name: r'premiumPackage',
      type: IsarType.object,
      target: r'PremiumPackageModel',
    ),
    r'premiumPackageId': PropertySchema(
      id: 52,
      name: r'premiumPackageId',
      type: IsarType.string,
    ),
    r'privateKey': PropertySchema(
      id: 53,
      name: r'privateKey',
      type: IsarType.string,
    ),
    r'publicKey': PropertySchema(
      id: 54,
      name: r'publicKey',
      type: IsarType.string,
    ),
    r'purchaseRefId': PropertySchema(
      id: 55,
      name: r'purchaseRefId',
      type: IsarType.string,
    ),
    r'roomInvitedIds': PropertySchema(
      id: 56,
      name: r'roomInvitedIds',
      type: IsarType.stringList,
    ),
    r'schemaVersion': PropertySchema(
      id: 57,
      name: r'schemaVersion',
      type: IsarType.long,
    ),
    r'shortDisplayName': PropertySchema(
      id: 58,
      name: r'shortDisplayName',
      type: IsarType.string,
    ),
    r'shortcutPasscode': PropertySchema(
      id: 59,
      name: r'shortcutPasscode',
      type: IsarType.string,
    ),
    r'showName': PropertySchema(
      id: 60,
      name: r'showName',
      type: IsarType.string,
    ),
    r'statusMessage': PropertySchema(
      id: 61,
      name: r'statusMessage',
      type: IsarType.string,
    ),
    r'subscribeAt': PropertySchema(
      id: 62,
      name: r'subscribeAt',
      type: IsarType.dateTime,
    ),
    r'token': PropertySchema(
      id: 63,
      name: r'token',
      type: IsarType.string,
    ),
    r'uchatDefaultBookmarkEmojiTags': PropertySchema(
      id: 64,
      name: r'uchatDefaultBookmarkEmojiTags',
      type: IsarType.objectList,
      target: r'DefaultBookmarkTagItemModel',
    ),
    r'uchatDefaultEmojiItems': PropertySchema(
      id: 65,
      name: r'uchatDefaultEmojiItems',
      type: IsarType.objectList,
      target: r'DefaultEmojiItemModel',
    ),
    r'username': PropertySchema(
      id: 66,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _userCollectionEstimateSize,
  serialize: _userCollectionSerialize,
  deserialize: _userCollectionDeserialize,
  deserializeProp: _userCollectionDeserializeProp,
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
    r'username': IndexSchema(
      id: -2899563114555695793,
      name: r'username',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'username',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isCurrentUser': IndexSchema(
      id: -174690003150482991,
      name: r'isCurrentUser',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isCurrentUser',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'shortcutPasscode': IndexSchema(
      id: -4832060262888924835,
      name: r'shortcutPasscode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'shortcutPasscode',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'LinkAccountsModel': LinkAccountsModelSchema,
    r'GoogleAccountModel': GoogleAccountModelSchema,
    r'AppleAccountModel': AppleAccountModelSchema,
    r'FacebookAccountModel': FacebookAccountModelSchema,
    r'EnabledFeaturesModel': EnabledFeaturesModelSchema,
    r'BookmarkFeatureFlagModel': BookmarkFeatureFlagModelSchema,
    r'CallFeatureFlagModel': CallFeatureFlagModelSchema,
    r'ChatFolderFeatureFlagModel': ChatFolderFeatureFlagModelSchema,
    r'CompareThemeContentModel': CompareThemeContentModelSchema,
    r'PremiumPackageLanguageModel': PremiumPackageLanguageModelSchema,
    r'DetailThemeContentModel': DetailThemeContentModelSchema,
    r'FeatureFlagBase': FeatureFlagBaseSchema,
    r'HoldChatFeatureFlagModel': HoldChatFeatureFlagModelSchema,
    r'MultipleAccountFeatureFlagModel': MultipleAccountFeatureFlagModelSchema,
    r'NewMessageEffectFeatureFlagModel': NewMessageEffectFeatureFlagModelSchema,
    r'FeatureAbilityPinModel': FeatureAbilityPinModelSchema,
    r'FeatureAbilitySecretRoomModel': FeatureAbilitySecretRoomModelSchema,
    r'AccountSettingsModel': AccountSettingsModelSchema,
    r'CallSettingsModel': CallSettingsModelSchema,
    r'ChatSettingsModel': ChatSettingsModelSchema,
    r'FriendSettingsModel': FriendSettingsModelSchema,
    r'AllowFriendAddModel': AllowFriendAddModelSchema,
    r'NotificationSettingsModel': NotificationSettingsModelSchema,
    r'ProfileSettingsModel': ProfileSettingsModelSchema,
    r'SecuritySettingsModel': SecuritySettingsModelSchema,
    r'DefaultEmojiItemModel': DefaultEmojiItemModelSchema,
    r'DefaultBookmarkTagItemModel': DefaultBookmarkTagItemModelSchema,
    r'BookmarkTagModel': BookmarkTagModelSchema,
    r'PremiumPackageModel': PremiumPackageModelSchema,
    r'AcceptedPlatformDocument': AcceptedPlatformDocumentSchema
  },
  getId: _userCollectionGetId,
  getLinks: _userCollectionGetLinks,
  attach: _userCollectionAttach,
  version: '3.3.0-dev.3',
);

int _userCollectionEstimateSize(
  UserCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.acceptedPlatformDocument;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[AcceptedPlatformDocument]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += AcceptedPlatformDocumentSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.accountDefaultBookmarkEmojiTags;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DefaultBookmarkTagItemModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += DefaultBookmarkTagItemModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.accountDefaultEmojiItems;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DefaultEmojiItemModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += DefaultEmojiItemModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.accountSettings;
    if (value != null) {
      bytesCount += 3 +
          AccountSettingsModelSchema.estimateSize(
              value, allOffsets[AccountSettingsModel]!, allOffsets);
    }
  }
  {
    final list = object.allBookmarkEmojiTags;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[BookmarkTagModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              BookmarkTagModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.appleOrderId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.appleUserId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.avatarBlurhash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.avatarId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.avatarPublic.length * 3;
  bytesCount += 3 + object.avatarUrl.length * 3;
  {
    final value = object.backgroundBlurhash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.backgroundId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.backgroundUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.birthDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.callOnSessionKeyId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.callStatus;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.currentSessionKeyId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.displayName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.enabledFeatures;
    if (value != null) {
      bytesCount += 3 +
          EnabledFeaturesModelSchema.estimateSize(
              value, allOffsets[EnabledFeaturesModel]!, allOffsets);
    }
  }
  {
    final value = object.firebaseToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.googleOrderId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.googleUserId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.linkAccounts;
    if (value != null) {
      bytesCount += 3 +
          LinkAccountsModelSchema.estimateSize(
              value, allOffsets[LinkAccountsModel]!, allOffsets);
    }
  }
  {
    final value = object.newMessageSoundFriendSelected;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.newMessageSoundMeSelected;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.onlineStatus;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.originalStatusMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.payStore;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.phoneNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.premiumPackage;
    if (value != null) {
      bytesCount += 3 +
          PremiumPackageModelSchema.estimateSize(
              value, allOffsets[PremiumPackageModel]!, allOffsets);
    }
  }
  {
    final value = object.premiumPackageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.privateKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.publicKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.purchaseRefId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.roomInvitedIds;
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
  bytesCount += 3 + object.shortDisplayName.length * 3;
  {
    final value = object.shortcutPasscode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.showName.length * 3;
  bytesCount += 3 + object.statusMessage.length * 3;
  {
    final value = object.token;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.uchatDefaultBookmarkEmojiTags;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DefaultBookmarkTagItemModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += DefaultBookmarkTagItemModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.uchatDefaultEmojiItems;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DefaultEmojiItemModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += DefaultEmojiItemModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.username;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userCollectionSerialize(
  UserCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<AcceptedPlatformDocument>(
    offsets[0],
    allOffsets,
    AcceptedPlatformDocumentSchema.serialize,
    object.acceptedPlatformDocument,
  );
  writer.writeObjectList<DefaultBookmarkTagItemModel>(
    offsets[1],
    allOffsets,
    DefaultBookmarkTagItemModelSchema.serialize,
    object.accountDefaultBookmarkEmojiTags,
  );
  writer.writeObjectList<DefaultEmojiItemModel>(
    offsets[2],
    allOffsets,
    DefaultEmojiItemModelSchema.serialize,
    object.accountDefaultEmojiItems,
  );
  writer.writeObject<AccountSettingsModel>(
    offsets[3],
    allOffsets,
    AccountSettingsModelSchema.serialize,
    object.accountSettings,
  );
  writer.writeObjectList<BookmarkTagModel>(
    offsets[4],
    allOffsets,
    BookmarkTagModelSchema.serialize,
    object.allBookmarkEmojiTags,
  );
  writer.writeString(offsets[5], object.appleOrderId);
  writer.writeString(offsets[6], object.appleUserId);
  writer.writeString(offsets[7], object.avatarBlurhash);
  writer.writeString(offsets[8], object.avatarId);
  writer.writeString(offsets[9], object.avatarPublic);
  writer.writeString(offsets[10], object.avatarUrl);
  writer.writeString(offsets[11], object.backgroundBlurhash);
  writer.writeString(offsets[12], object.backgroundId);
  writer.writeString(offsets[13], object.backgroundUrl);
  writer.writeString(offsets[14], object.birthDate);
  writer.writeString(offsets[15], object.callOnSessionKeyId);
  writer.writeString(offsets[16], object.callStatus?.name);
  writer.writeString(offsets[17], object.currentSessionKeyId);
  writer.writeLong(offsets[18], object.currentStateSeq);
  writer.writeDateTime(offsets[19], object.dBirthdate);
  writer.writeString(offsets[20], object.displayName);
  writer.writeString(offsets[21], object.email);
  writer.writeObject<EnabledFeaturesModel>(
    offsets[22],
    allOffsets,
    EnabledFeaturesModelSchema.serialize,
    object.enabledFeatures,
  );
  writer.writeDateTime(offsets[23], object.expireAt);
  writer.writeString(offsets[24], object.firebaseToken);
  writer.writeLong(offsets[25], object.friendRequestCount);
  writer.writeString(offsets[26], object.googleOrderId);
  writer.writeString(offsets[27], object.googleUserId);
  writer.writeBool(offsets[28], object.hasAvatar);
  writer.writeBool(offsets[29], object.hasPassword);
  writer.writeBool(offsets[30], object.hasShowName);
  writer.writeString(offsets[31], object.id);
  writer.writeBool(offsets[32], object.isCurrentUser);
  writer.writeBool(offsets[33], object.isDeleted);
  writer.writeBool(offsets[34], object.isMAHidden);
  writer.writeBool(offsets[35], object.isNewMessageAnimatedEnable);
  writer.writeBool(offsets[36], object.isNewMessageSoundEnable);
  writer.writeDateTime(offsets[37], object.lastEditUsernameAt);
  writer.writeLong(offsets[38], object.limitFriend);
  writer.writeLong(offsets[39], object.limitMultipleAccount);
  writer.writeObject<LinkAccountsModel>(
    offsets[40],
    allOffsets,
    LinkAccountsModelSchema.serialize,
    object.linkAccounts,
  );
  writer.writeDateTime(offsets[41], object.loginAt);
  writer.writeLong(offsets[42], object.newMessageAnimatedDuration);
  writer.writeLong(offsets[43], object.newMessageAnimatedType);
  writer.writeString(offsets[44], object.newMessageSoundFriendSelected);
  writer.writeString(offsets[45], object.newMessageSoundMeSelected);
  writer.writeDateTime(offsets[46], object.nextReview);
  writer.writeString(offsets[47], object.onlineStatus?.name);
  writer.writeString(offsets[48], object.originalStatusMessage);
  writer.writeString(offsets[49], object.payStore?.name);
  writer.writeString(offsets[50], object.phoneNumber);
  writer.writeObject<PremiumPackageModel>(
    offsets[51],
    allOffsets,
    PremiumPackageModelSchema.serialize,
    object.premiumPackage,
  );
  writer.writeString(offsets[52], object.premiumPackageId);
  writer.writeString(offsets[53], object.privateKey);
  writer.writeString(offsets[54], object.publicKey);
  writer.writeString(offsets[55], object.purchaseRefId);
  writer.writeStringList(offsets[56], object.roomInvitedIds);
  writer.writeLong(offsets[57], object.schemaVersion);
  writer.writeString(offsets[58], object.shortDisplayName);
  writer.writeString(offsets[59], object.shortcutPasscode);
  writer.writeString(offsets[60], object.showName);
  writer.writeString(offsets[61], object.statusMessage);
  writer.writeDateTime(offsets[62], object.subscribeAt);
  writer.writeString(offsets[63], object.token);
  writer.writeObjectList<DefaultBookmarkTagItemModel>(
    offsets[64],
    allOffsets,
    DefaultBookmarkTagItemModelSchema.serialize,
    object.uchatDefaultBookmarkEmojiTags,
  );
  writer.writeObjectList<DefaultEmojiItemModel>(
    offsets[65],
    allOffsets,
    DefaultEmojiItemModelSchema.serialize,
    object.uchatDefaultEmojiItems,
  );
  writer.writeString(offsets[66], object.username);
}

UserCollection _userCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserCollection(
    acceptedPlatformDocument: reader.readObjectList<AcceptedPlatformDocument>(
      offsets[0],
      AcceptedPlatformDocumentSchema.deserialize,
      allOffsets,
      AcceptedPlatformDocument(),
    ),
    accountDefaultBookmarkEmojiTags:
        reader.readObjectList<DefaultBookmarkTagItemModel>(
      offsets[1],
      DefaultBookmarkTagItemModelSchema.deserialize,
      allOffsets,
      DefaultBookmarkTagItemModel(),
    ),
    accountDefaultEmojiItems: reader.readObjectList<DefaultEmojiItemModel>(
      offsets[2],
      DefaultEmojiItemModelSchema.deserialize,
      allOffsets,
      DefaultEmojiItemModel(),
    ),
    accountSettings: reader.readObjectOrNull<AccountSettingsModel>(
      offsets[3],
      AccountSettingsModelSchema.deserialize,
      allOffsets,
    ),
    allBookmarkEmojiTags: reader.readObjectList<BookmarkTagModel>(
      offsets[4],
      BookmarkTagModelSchema.deserialize,
      allOffsets,
      BookmarkTagModel(),
    ),
    appleOrderId: reader.readStringOrNull(offsets[5]),
    appleUserId: reader.readStringOrNull(offsets[6]),
    avatarBlurhash: reader.readStringOrNull(offsets[7]),
    avatarId: reader.readStringOrNull(offsets[8]),
    backgroundBlurhash: reader.readStringOrNull(offsets[11]),
    backgroundId: reader.readStringOrNull(offsets[12]),
    birthDate: reader.readStringOrNull(offsets[14]),
    callOnSessionKeyId: reader.readStringOrNull(offsets[15]),
    callStatus: _UserCollectioncallStatusValueEnumMap[
        reader.readStringOrNull(offsets[16])],
    currentSessionKeyId: reader.readStringOrNull(offsets[17]),
    currentStateSeq: reader.readLongOrNull(offsets[18]),
    displayName: reader.readStringOrNull(offsets[20]),
    email: reader.readStringOrNull(offsets[21]),
    enabledFeatures: reader.readObjectOrNull<EnabledFeaturesModel>(
      offsets[22],
      EnabledFeaturesModelSchema.deserialize,
      allOffsets,
    ),
    expireAt: reader.readDateTimeOrNull(offsets[23]),
    firebaseToken: reader.readStringOrNull(offsets[24]),
    friendRequestCount: reader.readLongOrNull(offsets[25]),
    googleOrderId: reader.readStringOrNull(offsets[26]),
    googleUserId: reader.readStringOrNull(offsets[27]),
    hasPassword: reader.readBoolOrNull(offsets[29]),
    id: reader.readStringOrNull(offsets[31]),
    isCurrentUser: reader.readBoolOrNull(offsets[32]),
    isDeleted: reader.readBoolOrNull(offsets[33]),
    isMAHidden: reader.readBoolOrNull(offsets[34]),
    isNewMessageAnimatedEnable: reader.readBoolOrNull(offsets[35]),
    isNewMessageSoundEnable: reader.readBoolOrNull(offsets[36]),
    lastEditUsernameAt: reader.readDateTimeOrNull(offsets[37]),
    limitFriend: reader.readLongOrNull(offsets[38]),
    limitMultipleAccount: reader.readLongOrNull(offsets[39]),
    linkAccounts: reader.readObjectOrNull<LinkAccountsModel>(
      offsets[40],
      LinkAccountsModelSchema.deserialize,
      allOffsets,
    ),
    loginAt: reader.readDateTimeOrNull(offsets[41]),
    newMessageAnimatedDuration: reader.readLongOrNull(offsets[42]),
    newMessageAnimatedType: reader.readLongOrNull(offsets[43]),
    newMessageSoundFriendSelected: reader.readStringOrNull(offsets[44]),
    newMessageSoundMeSelected: reader.readStringOrNull(offsets[45]),
    nextReview: reader.readDateTimeOrNull(offsets[46]),
    onlineStatus: _UserCollectiononlineStatusValueEnumMap[
        reader.readStringOrNull(offsets[47])],
    originalStatusMessage: reader.readStringOrNull(offsets[48]),
    payStore: _UserCollectionpayStoreValueEnumMap[
        reader.readStringOrNull(offsets[49])],
    phoneNumber: reader.readStringOrNull(offsets[50]),
    premiumPackage: reader.readObjectOrNull<PremiumPackageModel>(
      offsets[51],
      PremiumPackageModelSchema.deserialize,
      allOffsets,
    ),
    premiumPackageId: reader.readStringOrNull(offsets[52]),
    privateKey: reader.readStringOrNull(offsets[53]),
    publicKey: reader.readStringOrNull(offsets[54]),
    purchaseRefId: reader.readStringOrNull(offsets[55]),
    roomInvitedIds: reader.readStringList(offsets[56]),
    schemaVersion: reader.readLongOrNull(offsets[57]),
    shortcutPasscode: reader.readStringOrNull(offsets[59]),
    subscribeAt: reader.readDateTimeOrNull(offsets[62]),
    token: reader.readStringOrNull(offsets[63]),
    uchatDefaultBookmarkEmojiTags:
        reader.readObjectList<DefaultBookmarkTagItemModel>(
      offsets[64],
      DefaultBookmarkTagItemModelSchema.deserialize,
      allOffsets,
      DefaultBookmarkTagItemModel(),
    ),
    uchatDefaultEmojiItems: reader.readObjectList<DefaultEmojiItemModel>(
      offsets[65],
      DefaultEmojiItemModelSchema.deserialize,
      allOffsets,
      DefaultEmojiItemModel(),
    ),
    username: reader.readStringOrNull(offsets[66]),
  );
  object.statusMessage = reader.readString(offsets[61]);
  return object;
}

P _userCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<AcceptedPlatformDocument>(
        offset,
        AcceptedPlatformDocumentSchema.deserialize,
        allOffsets,
        AcceptedPlatformDocument(),
      )) as P;
    case 1:
      return (reader.readObjectList<DefaultBookmarkTagItemModel>(
        offset,
        DefaultBookmarkTagItemModelSchema.deserialize,
        allOffsets,
        DefaultBookmarkTagItemModel(),
      )) as P;
    case 2:
      return (reader.readObjectList<DefaultEmojiItemModel>(
        offset,
        DefaultEmojiItemModelSchema.deserialize,
        allOffsets,
        DefaultEmojiItemModel(),
      )) as P;
    case 3:
      return (reader.readObjectOrNull<AccountSettingsModel>(
        offset,
        AccountSettingsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readObjectList<BookmarkTagModel>(
        offset,
        BookmarkTagModelSchema.deserialize,
        allOffsets,
        BookmarkTagModel(),
      )) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (_UserCollectioncallStatusValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readObjectOrNull<EnabledFeaturesModel>(
        offset,
        EnabledFeaturesModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 23:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readLongOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readBool(offset)) as P;
    case 29:
      return (reader.readBoolOrNull(offset)) as P;
    case 30:
      return (reader.readBool(offset)) as P;
    case 31:
      return (reader.readStringOrNull(offset)) as P;
    case 32:
      return (reader.readBoolOrNull(offset)) as P;
    case 33:
      return (reader.readBoolOrNull(offset)) as P;
    case 34:
      return (reader.readBoolOrNull(offset)) as P;
    case 35:
      return (reader.readBoolOrNull(offset)) as P;
    case 36:
      return (reader.readBoolOrNull(offset)) as P;
    case 37:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 38:
      return (reader.readLongOrNull(offset)) as P;
    case 39:
      return (reader.readLongOrNull(offset)) as P;
    case 40:
      return (reader.readObjectOrNull<LinkAccountsModel>(
        offset,
        LinkAccountsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 41:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 42:
      return (reader.readLongOrNull(offset)) as P;
    case 43:
      return (reader.readLongOrNull(offset)) as P;
    case 44:
      return (reader.readStringOrNull(offset)) as P;
    case 45:
      return (reader.readStringOrNull(offset)) as P;
    case 46:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 47:
      return (_UserCollectiononlineStatusValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 48:
      return (reader.readStringOrNull(offset)) as P;
    case 49:
      return (_UserCollectionpayStoreValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 50:
      return (reader.readStringOrNull(offset)) as P;
    case 51:
      return (reader.readObjectOrNull<PremiumPackageModel>(
        offset,
        PremiumPackageModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 52:
      return (reader.readStringOrNull(offset)) as P;
    case 53:
      return (reader.readStringOrNull(offset)) as P;
    case 54:
      return (reader.readStringOrNull(offset)) as P;
    case 55:
      return (reader.readStringOrNull(offset)) as P;
    case 56:
      return (reader.readStringList(offset)) as P;
    case 57:
      return (reader.readLongOrNull(offset)) as P;
    case 58:
      return (reader.readString(offset)) as P;
    case 59:
      return (reader.readStringOrNull(offset)) as P;
    case 60:
      return (reader.readString(offset)) as P;
    case 61:
      return (reader.readString(offset)) as P;
    case 62:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 63:
      return (reader.readStringOrNull(offset)) as P;
    case 64:
      return (reader.readObjectList<DefaultBookmarkTagItemModel>(
        offset,
        DefaultBookmarkTagItemModelSchema.deserialize,
        allOffsets,
        DefaultBookmarkTagItemModel(),
      )) as P;
    case 65:
      return (reader.readObjectList<DefaultEmojiItemModel>(
        offset,
        DefaultEmojiItemModelSchema.deserialize,
        allOffsets,
        DefaultEmojiItemModel(),
      )) as P;
    case 66:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserCollectioncallStatusEnumValueMap = {
  r'newCall': r'newCall',
  r'created': r'created',
  r'startCall': r'startCall',
  r'calling': r'calling',
  r'inProgress': r'inProgress',
  r'failed': r'failed',
  r'completed': r'completed',
};
const _UserCollectioncallStatusValueEnumMap = {
  r'newCall': CallStatusType.newCall,
  r'created': CallStatusType.created,
  r'startCall': CallStatusType.startCall,
  r'calling': CallStatusType.calling,
  r'inProgress': CallStatusType.inProgress,
  r'failed': CallStatusType.failed,
  r'completed': CallStatusType.completed,
};
const _UserCollectiononlineStatusEnumValueMap = {
  r'online': r'online',
  r'busy': r'busy',
  r'doNotDisturb': r'doNotDisturb',
  r'offline': r'offline',
};
const _UserCollectiononlineStatusValueEnumMap = {
  r'online': OnlineStatus.online,
  r'busy': OnlineStatus.busy,
  r'doNotDisturb': OnlineStatus.doNotDisturb,
  r'offline': OnlineStatus.offline,
};
const _UserCollectionpayStoreEnumValueMap = {
  r'apple': r'apple',
  r'google': r'google',
};
const _UserCollectionpayStoreValueEnumMap = {
  r'apple': PayStoreType.apple,
  r'google': PayStoreType.google,
};

Id _userCollectionGetId(UserCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _userCollectionGetLinks(UserCollection object) {
  return [];
}

void _userCollectionAttach(
    IsarCollection<dynamic> col, Id id, UserCollection object) {}

extension UserCollectionByIndex on IsarCollection<UserCollection> {
  Future<UserCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  UserCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<UserCollection?>> getAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<UserCollection?> getAllByIdSync(List<String?> idValues) {
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

  Future<Id> putById(UserCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(UserCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<UserCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<UserCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }

  Future<UserCollection?> getByUsername(String? username) {
    return getByIndex(r'username', [username]);
  }

  UserCollection? getByUsernameSync(String? username) {
    return getByIndexSync(r'username', [username]);
  }

  Future<bool> deleteByUsername(String? username) {
    return deleteByIndex(r'username', [username]);
  }

  bool deleteByUsernameSync(String? username) {
    return deleteByIndexSync(r'username', [username]);
  }

  Future<List<UserCollection?>> getAllByUsername(List<String?> usernameValues) {
    final values = usernameValues.map((e) => [e]).toList();
    return getAllByIndex(r'username', values);
  }

  List<UserCollection?> getAllByUsernameSync(List<String?> usernameValues) {
    final values = usernameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'username', values);
  }

  Future<int> deleteAllByUsername(List<String?> usernameValues) {
    final values = usernameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'username', values);
  }

  int deleteAllByUsernameSync(List<String?> usernameValues) {
    final values = usernameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'username', values);
  }

  Future<Id> putByUsername(UserCollection object) {
    return putByIndex(r'username', object);
  }

  Id putByUsernameSync(UserCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'username', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUsername(List<UserCollection> objects) {
    return putAllByIndex(r'username', objects);
  }

  List<Id> putAllByUsernameSync(List<UserCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'username', objects, saveLinks: saveLinks);
  }
}

extension UserCollectionQueryWhereSort
    on QueryBuilder<UserCollection, UserCollection, QWhere> {
  QueryBuilder<UserCollection, UserCollection, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhere> anyIsCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isCurrentUser'),
      );
    });
  }
}

extension UserCollectionQueryWhere
    on QueryBuilder<UserCollection, UserCollection, QWhereClause> {
  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
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

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
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

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> idEqualTo(
      String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> idNotEqualTo(
      String? id) {
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

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'username',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'username',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      usernameEqualTo(String? username) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'username',
        value: [username],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      usernameNotEqualTo(String? username) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'username',
              lower: [],
              upper: [username],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'username',
              lower: [username],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'username',
              lower: [username],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'username',
              lower: [],
              upper: [username],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      isCurrentUserIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isCurrentUser',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      isCurrentUserIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isCurrentUser',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      isCurrentUserEqualTo(bool? isCurrentUser) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isCurrentUser',
        value: [isCurrentUser],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      isCurrentUserNotEqualTo(bool? isCurrentUser) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCurrentUser',
              lower: [],
              upper: [isCurrentUser],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCurrentUser',
              lower: [isCurrentUser],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCurrentUser',
              lower: [isCurrentUser],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isCurrentUser',
              lower: [],
              upper: [isCurrentUser],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      shortcutPasscodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'shortcutPasscode',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      shortcutPasscodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'shortcutPasscode',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      shortcutPasscodeEqualTo(String? shortcutPasscode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'shortcutPasscode',
        value: [shortcutPasscode],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      shortcutPasscodeNotEqualTo(String? shortcutPasscode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'shortcutPasscode',
              lower: [],
              upper: [shortcutPasscode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'shortcutPasscode',
              lower: [shortcutPasscode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'shortcutPasscode',
              lower: [shortcutPasscode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'shortcutPasscode',
              lower: [],
              upper: [shortcutPasscode],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserCollectionQueryFilter
    on QueryBuilder<UserCollection, UserCollection, QFilterCondition> {
  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      acceptedPlatformDocumentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'acceptedPlatformDocument',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      acceptedPlatformDocumentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'acceptedPlatformDocument',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      acceptedPlatformDocumentLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'acceptedPlatformDocument',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      acceptedPlatformDocumentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'acceptedPlatformDocument',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      acceptedPlatformDocumentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'acceptedPlatformDocument',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      acceptedPlatformDocumentLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'acceptedPlatformDocument',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      acceptedPlatformDocumentLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'acceptedPlatformDocument',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      acceptedPlatformDocumentLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'acceptedPlatformDocument',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultBookmarkEmojiTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountDefaultBookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultBookmarkEmojiTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountDefaultBookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultBookmarkEmojiTagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultBookmarkEmojiTags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultBookmarkEmojiTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultBookmarkEmojiTags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultBookmarkEmojiTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultBookmarkEmojiTags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultBookmarkEmojiTagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultBookmarkEmojiTags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultBookmarkEmojiTagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultBookmarkEmojiTags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultBookmarkEmojiTagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultBookmarkEmojiTags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultEmojiItemsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountDefaultEmojiItems',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultEmojiItemsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountDefaultEmojiItems',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultEmojiItemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultEmojiItems',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultEmojiItemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultEmojiItems',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultEmojiItemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultEmojiItems',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultEmojiItemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultEmojiItems',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultEmojiItemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultEmojiItems',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultEmojiItemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'accountDefaultEmojiItems',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountSettingsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountSettings',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountSettingsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountSettings',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      allBookmarkEmojiTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allBookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      allBookmarkEmojiTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allBookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      allBookmarkEmojiTagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allBookmarkEmojiTags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      allBookmarkEmojiTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allBookmarkEmojiTags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      allBookmarkEmojiTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allBookmarkEmojiTags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      allBookmarkEmojiTagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allBookmarkEmojiTags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      allBookmarkEmojiTagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allBookmarkEmojiTags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      allBookmarkEmojiTagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allBookmarkEmojiTags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'appleOrderId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'appleOrderId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appleOrderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appleOrderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleOrderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appleOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'appleUserId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'appleUserId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appleUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appleUserId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appleUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      appleUserIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appleUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarBlurhash',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarBlurhash',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarBlurhash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarBlurhash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarBlurhashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarPublic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarPublic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarPublic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarPublic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarPublic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarPublic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarPublic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarPublic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarPublic',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarPublicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarPublic',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'backgroundBlurhash',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'backgroundBlurhash',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'backgroundBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'backgroundBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'backgroundBlurhash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'backgroundBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'backgroundBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'backgroundBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'backgroundBlurhash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundBlurhashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'backgroundBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'backgroundId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'backgroundId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'backgroundId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'backgroundId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'backgroundId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'backgroundId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'backgroundId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'backgroundId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'backgroundId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'backgroundId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'backgroundUrl',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'backgroundUrl',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'backgroundUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'backgroundUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'backgroundUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'backgroundUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'backgroundUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'backgroundUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'backgroundUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      backgroundUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'backgroundUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'birthDate',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'birthDate',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'birthDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'birthDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'birthDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'birthDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'birthDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'birthDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'birthDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'birthDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'birthDate',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      birthDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'birthDate',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callOnSessionKeyId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callOnSessionKeyId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callOnSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'callOnSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'callOnSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'callOnSessionKeyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'callOnSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'callOnSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callOnSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callOnSessionKeyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callOnSessionKeyId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callOnSessionKeyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callOnSessionKeyId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callStatus',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callStatus',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusEqualTo(
    CallStatusType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusGreaterThan(
    CallStatusType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusLessThan(
    CallStatusType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusBetween(
    CallStatusType? lower,
    CallStatusType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'callStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      callStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentSessionKeyId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentSessionKeyId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentSessionKeyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currentSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currentSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currentSessionKeyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currentSessionKeyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentSessionKeyId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentSessionKeyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currentSessionKeyId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentStateSeqIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentStateSeq',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentStateSeqIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentStateSeq',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentStateSeqEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStateSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentStateSeqGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStateSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentStateSeqLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStateSeq',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      currentStateSeqBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStateSeq',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dBirthdateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dBirthdate',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dBirthdateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dBirthdate',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dBirthdateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dBirthdate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dBirthdateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dBirthdate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dBirthdateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dBirthdate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dBirthdateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dBirthdate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      enabledFeaturesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enabledFeatures',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      enabledFeaturesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enabledFeatures',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      expireAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      expireAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expireAt',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      expireAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expireAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseToken',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseToken',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firebaseToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseToken',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      firebaseTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseToken',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      friendRequestCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'friendRequestCount',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      friendRequestCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'friendRequestCount',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      friendRequestCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendRequestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      friendRequestCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friendRequestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      friendRequestCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friendRequestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      friendRequestCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friendRequestCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'googleOrderId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'googleOrderId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'googleOrderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'googleOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'googleOrderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleOrderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'googleOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'googleUserId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'googleUserId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'googleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'googleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'googleUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'googleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'googleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'googleUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'googleUserId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      googleUserIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'googleUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      hasAvatarEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasAvatar',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      hasPasswordIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasPassword',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      hasPasswordIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasPassword',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      hasPasswordEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasPassword',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      hasShowNameEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasShowName',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isCurrentUserIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCurrentUser',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isCurrentUserIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCurrentUser',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isCurrentUserEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCurrentUser',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isDeletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isDeleted',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isDeletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isDeleted',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isDeletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isMAHiddenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isMAHidden',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isMAHiddenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isMAHidden',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isMAHiddenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMAHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isNewMessageAnimatedEnableIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isNewMessageAnimatedEnable',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isNewMessageAnimatedEnableIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isNewMessageAnimatedEnable',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isNewMessageAnimatedEnableEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isNewMessageAnimatedEnable',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isNewMessageSoundEnableIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isNewMessageSoundEnable',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isNewMessageSoundEnableIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isNewMessageSoundEnable',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isNewMessageSoundEnableEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isNewMessageSoundEnable',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      lastEditUsernameAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastEditUsernameAt',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      lastEditUsernameAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastEditUsernameAt',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      lastEditUsernameAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastEditUsernameAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      lastEditUsernameAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastEditUsernameAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      lastEditUsernameAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastEditUsernameAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      lastEditUsernameAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastEditUsernameAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitFriendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'limitFriend',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitFriendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'limitFriend',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitFriendEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'limitFriend',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitFriendGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'limitFriend',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitFriendLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'limitFriend',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitFriendBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'limitFriend',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitMultipleAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'limitMultipleAccount',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitMultipleAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'limitMultipleAccount',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitMultipleAccountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'limitMultipleAccount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitMultipleAccountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'limitMultipleAccount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitMultipleAccountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'limitMultipleAccount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      limitMultipleAccountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'limitMultipleAccount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      linkAccountsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkAccounts',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      linkAccountsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkAccounts',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      loginAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loginAt',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      loginAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loginAt',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      loginAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loginAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      loginAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loginAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      loginAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loginAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      loginAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loginAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newMessageAnimatedDuration',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newMessageAnimatedDuration',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedDurationEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newMessageAnimatedDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedDurationGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newMessageAnimatedDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedDurationLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newMessageAnimatedDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedDurationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newMessageAnimatedDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newMessageAnimatedType',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newMessageAnimatedType',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedTypeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newMessageAnimatedType',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedTypeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newMessageAnimatedType',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedTypeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newMessageAnimatedType',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageAnimatedTypeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newMessageAnimatedType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newMessageSoundFriendSelected',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newMessageSoundFriendSelected',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newMessageSoundFriendSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newMessageSoundFriendSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newMessageSoundFriendSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newMessageSoundFriendSelected',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'newMessageSoundFriendSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'newMessageSoundFriendSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'newMessageSoundFriendSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'newMessageSoundFriendSelected',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newMessageSoundFriendSelected',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundFriendSelectedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'newMessageSoundFriendSelected',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newMessageSoundMeSelected',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newMessageSoundMeSelected',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newMessageSoundMeSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newMessageSoundMeSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newMessageSoundMeSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newMessageSoundMeSelected',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'newMessageSoundMeSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'newMessageSoundMeSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'newMessageSoundMeSelected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'newMessageSoundMeSelected',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newMessageSoundMeSelected',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      newMessageSoundMeSelectedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'newMessageSoundMeSelected',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nextReviewIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextReview',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nextReviewIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextReview',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nextReviewEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextReview',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nextReviewGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextReview',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nextReviewLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextReview',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nextReviewBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextReview',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'onlineStatus',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'onlineStatus',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusEqualTo(
    OnlineStatus? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onlineStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusGreaterThan(
    OnlineStatus? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'onlineStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusLessThan(
    OnlineStatus? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'onlineStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusBetween(
    OnlineStatus? lower,
    OnlineStatus? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'onlineStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'onlineStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'onlineStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'onlineStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'onlineStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onlineStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onlineStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'onlineStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalStatusMessage',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalStatusMessage',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalStatusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originalStatusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originalStatusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originalStatusMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'originalStatusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'originalStatusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalStatusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalStatusMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalStatusMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      originalStatusMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalStatusMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'payStore',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'payStore',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreEqualTo(
    PayStoreType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreGreaterThan(
    PayStoreType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreLessThan(
    PayStoreType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreBetween(
    PayStoreType? lower,
    PayStoreType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payStore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payStore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payStore',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payStore',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      payStoreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payStore',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phoneNumber',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phoneNumber',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'premiumPackage',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'premiumPackage',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'premiumPackageId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'premiumPackageId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'premiumPackageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'premiumPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'premiumPackageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumPackageId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'premiumPackageId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'privateKey',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'privateKey',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'privateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'privateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'privateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'privateKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'privateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'privateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'privateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'privateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'privateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      privateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'privateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'publicKey',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'publicKey',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'publicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'publicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'publicKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'publicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'publicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'publicKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'publicKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      publicKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'publicKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'purchaseRefId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'purchaseRefId',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchaseRefId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purchaseRefId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purchaseRefId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purchaseRefId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'purchaseRefId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'purchaseRefId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'purchaseRefId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'purchaseRefId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchaseRefId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      purchaseRefIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'purchaseRefId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roomInvitedIds',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roomInvitedIds',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomInvitedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomInvitedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomInvitedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomInvitedIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomInvitedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomInvitedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomInvitedIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomInvitedIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomInvitedIds',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomInvitedIds',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roomInvitedIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roomInvitedIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roomInvitedIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roomInvitedIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roomInvitedIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      roomInvitedIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roomInvitedIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      schemaVersionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'schemaVersion',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      schemaVersionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'schemaVersion',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      schemaVersionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'schemaVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      schemaVersionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'schemaVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      schemaVersionLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'schemaVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      schemaVersionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'schemaVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortDisplayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shortDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shortDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortDisplayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortDisplayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shortcutPasscode',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shortcutPasscode',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortcutPasscode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortcutPasscode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortcutPasscode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortcutPasscode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shortcutPasscode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shortcutPasscode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortcutPasscode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortcutPasscode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortcutPasscode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      shortcutPasscodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortcutPasscode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'showName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'showName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'showName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'showName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'showName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'showName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'showName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      showNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'showName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statusMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statusMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      statusMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statusMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      subscribeAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subscribeAt',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      subscribeAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subscribeAt',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      subscribeAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subscribeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      subscribeAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subscribeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      subscribeAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subscribeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      subscribeAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subscribeAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'token',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'token',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'token',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'token',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      tokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'token',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultBookmarkEmojiTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uchatDefaultBookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultBookmarkEmojiTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uchatDefaultBookmarkEmojiTags',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultBookmarkEmojiTagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultBookmarkEmojiTags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultBookmarkEmojiTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultBookmarkEmojiTags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultBookmarkEmojiTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultBookmarkEmojiTags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultBookmarkEmojiTagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultBookmarkEmojiTags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultBookmarkEmojiTagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultBookmarkEmojiTags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultBookmarkEmojiTagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultBookmarkEmojiTags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultEmojiItemsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uchatDefaultEmojiItems',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultEmojiItemsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uchatDefaultEmojiItems',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultEmojiItemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultEmojiItems',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultEmojiItemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultEmojiItems',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultEmojiItemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultEmojiItems',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultEmojiItemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultEmojiItems',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultEmojiItemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultEmojiItems',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultEmojiItemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uchatDefaultEmojiItems',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'username',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension UserCollectionQueryObject
    on QueryBuilder<UserCollection, UserCollection, QFilterCondition> {
  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      acceptedPlatformDocumentElement(FilterQuery<AcceptedPlatformDocument> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'acceptedPlatformDocument');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultBookmarkEmojiTagsElement(
          FilterQuery<DefaultBookmarkTagItemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'accountDefaultBookmarkEmojiTags');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountDefaultEmojiItemsElement(FilterQuery<DefaultEmojiItemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'accountDefaultEmojiItems');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      accountSettings(FilterQuery<AccountSettingsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'accountSettings');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      allBookmarkEmojiTagsElement(FilterQuery<BookmarkTagModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'allBookmarkEmojiTags');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      enabledFeatures(FilterQuery<EnabledFeaturesModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'enabledFeatures');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      linkAccounts(FilterQuery<LinkAccountsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'linkAccounts');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      premiumPackage(FilterQuery<PremiumPackageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'premiumPackage');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultBookmarkEmojiTagsElement(
          FilterQuery<DefaultBookmarkTagItemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'uchatDefaultBookmarkEmojiTags');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      uchatDefaultEmojiItemsElement(FilterQuery<DefaultEmojiItemModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'uchatDefaultEmojiItems');
    });
  }
}

extension UserCollectionQueryLinks
    on QueryBuilder<UserCollection, UserCollection, QFilterCondition> {}

extension UserCollectionQuerySortBy
    on QueryBuilder<UserCollection, UserCollection, QSortBy> {
  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAppleOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleOrderId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAppleOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleOrderId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAppleUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleUserId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAppleUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleUserId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAvatarBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarBlurhash', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAvatarBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarBlurhash', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByAvatarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAvatarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAvatarPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPublic', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAvatarPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPublic', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByBackgroundBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundBlurhash', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByBackgroundBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundBlurhash', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByBackgroundId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByBackgroundIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByBackgroundUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundUrl', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByBackgroundUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundUrl', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByBirthDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthDate', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByBirthDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthDate', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByCallOnSessionKeyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callOnSessionKeyId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByCallOnSessionKeyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callOnSessionKeyId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByCallStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByCallStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByCurrentSessionKeyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSessionKeyId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByCurrentSessionKeyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSessionKeyId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByCurrentStateSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStateSeq', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByCurrentStateSeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStateSeq', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByDBirthdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dBirthdate', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByDBirthdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dBirthdate', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByExpireAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByFirebaseToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseToken', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByFirebaseTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseToken', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByFriendRequestCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestCount', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByFriendRequestCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestCount', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByGoogleOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleOrderId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByGoogleOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleOrderId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByGoogleUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleUserId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByGoogleUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleUserId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByHasAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByHasAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByHasPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPassword', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByHasPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPassword', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByHasShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasShowName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByHasShowNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasShowName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByIsCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrentUser', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByIsCurrentUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrentUser', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByIsMAHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMAHidden', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByIsMAHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMAHidden', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByIsNewMessageAnimatedEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNewMessageAnimatedEnable', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByIsNewMessageAnimatedEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNewMessageAnimatedEnable', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByIsNewMessageSoundEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNewMessageSoundEnable', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByIsNewMessageSoundEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNewMessageSoundEnable', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByLastEditUsernameAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditUsernameAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByLastEditUsernameAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditUsernameAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByLimitFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitFriend', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByLimitFriendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitFriend', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByLimitMultipleAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitMultipleAccount', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByLimitMultipleAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitMultipleAccount', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByLoginAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loginAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByLoginAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loginAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNewMessageAnimatedDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageAnimatedDuration', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNewMessageAnimatedDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageAnimatedDuration', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNewMessageAnimatedType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageAnimatedType', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNewMessageAnimatedTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageAnimatedType', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNewMessageSoundFriendSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageSoundFriendSelected', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNewMessageSoundFriendSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageSoundFriendSelected', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNewMessageSoundMeSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageSoundMeSelected', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNewMessageSoundMeSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageSoundMeSelected', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNextReview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReview', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNextReviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReview', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByOnlineStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineStatus', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByOnlineStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineStatus', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByOriginalStatusMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalStatusMessage', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByOriginalStatusMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalStatusMessage', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByPayStore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payStore', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPayStoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payStore', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPremiumPackageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumPackageId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPremiumPackageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumPackageId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPrivateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privateKey', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPrivateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privateKey', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByPublicKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicKey', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPublicKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicKey', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPurchaseRefId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseRefId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByPurchaseRefIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseRefId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortBySchemaVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schemaVersion', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortBySchemaVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schemaVersion', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByShortDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortDisplayName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByShortDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortDisplayName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByShortcutPasscode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortcutPasscode', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByShortcutPasscodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortcutPasscode', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByShowNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByStatusMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusMessage', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByStatusMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusMessage', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortBySubscribeAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscribeAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortBySubscribeAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscribeAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension UserCollectionQuerySortThenBy
    on QueryBuilder<UserCollection, UserCollection, QSortThenBy> {
  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAppleOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleOrderId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAppleOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleOrderId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAppleUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleUserId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAppleUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appleUserId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAvatarBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarBlurhash', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAvatarBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarBlurhash', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByAvatarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAvatarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAvatarPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPublic', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAvatarPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPublic', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByBackgroundBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundBlurhash', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByBackgroundBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundBlurhash', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByBackgroundId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByBackgroundIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByBackgroundUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundUrl', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByBackgroundUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundUrl', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByBirthDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthDate', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByBirthDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthDate', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByCallOnSessionKeyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callOnSessionKeyId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByCallOnSessionKeyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callOnSessionKeyId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByCallStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByCallStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByCurrentSessionKeyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSessionKeyId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByCurrentSessionKeyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSessionKeyId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByCurrentStateSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStateSeq', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByCurrentStateSeqDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStateSeq', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByDBirthdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dBirthdate', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByDBirthdateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dBirthdate', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByExpireAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expireAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByFirebaseToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseToken', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByFirebaseTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseToken', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByFriendRequestCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestCount', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByFriendRequestCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestCount', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByGoogleOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleOrderId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByGoogleOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleOrderId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByGoogleUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleUserId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByGoogleUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleUserId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByHasAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByHasAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByHasPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPassword', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByHasPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPassword', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByHasShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasShowName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByHasShowNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasShowName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrentUser', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsCurrentUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrentUser', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsMAHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMAHidden', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsMAHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMAHidden', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsNewMessageAnimatedEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNewMessageAnimatedEnable', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsNewMessageAnimatedEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNewMessageAnimatedEnable', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsNewMessageSoundEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNewMessageSoundEnable', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsNewMessageSoundEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNewMessageSoundEnable', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByLastEditUsernameAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditUsernameAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByLastEditUsernameAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditUsernameAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByLimitFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitFriend', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByLimitFriendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitFriend', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByLimitMultipleAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitMultipleAccount', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByLimitMultipleAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitMultipleAccount', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByLoginAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loginAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByLoginAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loginAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNewMessageAnimatedDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageAnimatedDuration', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNewMessageAnimatedDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageAnimatedDuration', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNewMessageAnimatedType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageAnimatedType', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNewMessageAnimatedTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageAnimatedType', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNewMessageSoundFriendSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageSoundFriendSelected', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNewMessageSoundFriendSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageSoundFriendSelected', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNewMessageSoundMeSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageSoundMeSelected', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNewMessageSoundMeSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newMessageSoundMeSelected', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNextReview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReview', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNextReviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReview', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByOnlineStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineStatus', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByOnlineStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineStatus', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByOriginalStatusMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalStatusMessage', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByOriginalStatusMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalStatusMessage', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByPayStore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payStore', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPayStoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payStore', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPremiumPackageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumPackageId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPremiumPackageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumPackageId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPrivateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privateKey', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPrivateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privateKey', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByPublicKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicKey', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPublicKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicKey', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPurchaseRefId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseRefId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByPurchaseRefIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseRefId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenBySchemaVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schemaVersion', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenBySchemaVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schemaVersion', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByShortDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortDisplayName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByShortDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortDisplayName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByShortcutPasscode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortcutPasscode', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByShortcutPasscodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortcutPasscode', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByShowNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByStatusMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusMessage', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByStatusMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusMessage', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenBySubscribeAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscribeAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenBySubscribeAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscribeAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension UserCollectionQueryWhereDistinct
    on QueryBuilder<UserCollection, UserCollection, QDistinct> {
  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByAppleOrderId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appleOrderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByAppleUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appleUserId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByAvatarBlurhash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarBlurhash',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByAvatarId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByAvatarPublic({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarPublic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByAvatarUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByBackgroundBlurhash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backgroundBlurhash',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByBackgroundId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backgroundId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByBackgroundUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backgroundUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByBirthDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'birthDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByCallOnSessionKeyId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callOnSessionKeyId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByCallStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByCurrentSessionKeyId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentSessionKeyId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByCurrentStateSeq() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStateSeq');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByDBirthdate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dBirthdate');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByExpireAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expireAt');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByFirebaseToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseToken',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByFriendRequestCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendRequestCount');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByGoogleOrderId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'googleOrderId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByGoogleUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'googleUserId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByHasAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasAvatar');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByHasPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasPassword');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByHasShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasShowName');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByIsCurrentUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCurrentUser');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByIsMAHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMAHidden');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByIsNewMessageAnimatedEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isNewMessageAnimatedEnable');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByIsNewMessageSoundEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isNewMessageSoundEnable');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByLastEditUsernameAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastEditUsernameAt');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByLimitFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'limitFriend');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByLimitMultipleAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'limitMultipleAccount');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByLoginAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loginAt');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByNewMessageAnimatedDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newMessageAnimatedDuration');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByNewMessageAnimatedType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newMessageAnimatedType');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByNewMessageSoundFriendSelected({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newMessageSoundFriendSelected',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByNewMessageSoundMeSelected({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newMessageSoundMeSelected',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByNextReview() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextReview');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByOnlineStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onlineStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByOriginalStatusMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalStatusMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByPayStore(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payStore', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByPhoneNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phoneNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByPremiumPackageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'premiumPackageId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByPrivateKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'privateKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByPublicKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'publicKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByPurchaseRefId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purchaseRefId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByRoomInvitedIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomInvitedIds');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctBySchemaVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'schemaVersion');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByShortDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortDisplayName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByShortcutPasscode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortcutPasscode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByShowName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByStatusMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctBySubscribeAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subscribeAt');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'token', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension UserCollectionQueryProperty
    on QueryBuilder<UserCollection, UserCollection, QQueryProperty> {
  QueryBuilder<UserCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<UserCollection, List<AcceptedPlatformDocument>?,
      QQueryOperations> acceptedPlatformDocumentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'acceptedPlatformDocument');
    });
  }

  QueryBuilder<UserCollection, List<DefaultBookmarkTagItemModel>?,
      QQueryOperations> accountDefaultBookmarkEmojiTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountDefaultBookmarkEmojiTags');
    });
  }

  QueryBuilder<UserCollection, List<DefaultEmojiItemModel>?, QQueryOperations>
      accountDefaultEmojiItemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountDefaultEmojiItems');
    });
  }

  QueryBuilder<UserCollection, AccountSettingsModel?, QQueryOperations>
      accountSettingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountSettings');
    });
  }

  QueryBuilder<UserCollection, List<BookmarkTagModel>?, QQueryOperations>
      allBookmarkEmojiTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allBookmarkEmojiTags');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      appleOrderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appleOrderId');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      appleUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appleUserId');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      avatarBlurhashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarBlurhash');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations> avatarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarId');
    });
  }

  QueryBuilder<UserCollection, String, QQueryOperations>
      avatarPublicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarPublic');
    });
  }

  QueryBuilder<UserCollection, String, QQueryOperations> avatarUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarUrl');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      backgroundBlurhashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backgroundBlurhash');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      backgroundIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backgroundId');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      backgroundUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backgroundUrl');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations> birthDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'birthDate');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      callOnSessionKeyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callOnSessionKeyId');
    });
  }

  QueryBuilder<UserCollection, CallStatusType?, QQueryOperations>
      callStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callStatus');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      currentSessionKeyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentSessionKeyId');
    });
  }

  QueryBuilder<UserCollection, int?, QQueryOperations>
      currentStateSeqProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStateSeq');
    });
  }

  QueryBuilder<UserCollection, DateTime?, QQueryOperations>
      dBirthdateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dBirthdate');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<UserCollection, EnabledFeaturesModel?, QQueryOperations>
      enabledFeaturesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enabledFeatures');
    });
  }

  QueryBuilder<UserCollection, DateTime?, QQueryOperations> expireAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expireAt');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      firebaseTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseToken');
    });
  }

  QueryBuilder<UserCollection, int?, QQueryOperations>
      friendRequestCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendRequestCount');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      googleOrderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'googleOrderId');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      googleUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'googleUserId');
    });
  }

  QueryBuilder<UserCollection, bool, QQueryOperations> hasAvatarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasAvatar');
    });
  }

  QueryBuilder<UserCollection, bool?, QQueryOperations> hasPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasPassword');
    });
  }

  QueryBuilder<UserCollection, bool, QQueryOperations> hasShowNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasShowName');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserCollection, bool?, QQueryOperations>
      isCurrentUserProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCurrentUser');
    });
  }

  QueryBuilder<UserCollection, bool?, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<UserCollection, bool?, QQueryOperations> isMAHiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMAHidden');
    });
  }

  QueryBuilder<UserCollection, bool?, QQueryOperations>
      isNewMessageAnimatedEnableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isNewMessageAnimatedEnable');
    });
  }

  QueryBuilder<UserCollection, bool?, QQueryOperations>
      isNewMessageSoundEnableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isNewMessageSoundEnable');
    });
  }

  QueryBuilder<UserCollection, DateTime?, QQueryOperations>
      lastEditUsernameAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastEditUsernameAt');
    });
  }

  QueryBuilder<UserCollection, int?, QQueryOperations> limitFriendProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'limitFriend');
    });
  }

  QueryBuilder<UserCollection, int?, QQueryOperations>
      limitMultipleAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'limitMultipleAccount');
    });
  }

  QueryBuilder<UserCollection, LinkAccountsModel?, QQueryOperations>
      linkAccountsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkAccounts');
    });
  }

  QueryBuilder<UserCollection, DateTime?, QQueryOperations> loginAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loginAt');
    });
  }

  QueryBuilder<UserCollection, int?, QQueryOperations>
      newMessageAnimatedDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newMessageAnimatedDuration');
    });
  }

  QueryBuilder<UserCollection, int?, QQueryOperations>
      newMessageAnimatedTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newMessageAnimatedType');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      newMessageSoundFriendSelectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newMessageSoundFriendSelected');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      newMessageSoundMeSelectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newMessageSoundMeSelected');
    });
  }

  QueryBuilder<UserCollection, DateTime?, QQueryOperations>
      nextReviewProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextReview');
    });
  }

  QueryBuilder<UserCollection, OnlineStatus?, QQueryOperations>
      onlineStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onlineStatus');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      originalStatusMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalStatusMessage');
    });
  }

  QueryBuilder<UserCollection, PayStoreType?, QQueryOperations>
      payStoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payStore');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phoneNumber');
    });
  }

  QueryBuilder<UserCollection, PremiumPackageModel?, QQueryOperations>
      premiumPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'premiumPackage');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      premiumPackageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'premiumPackageId');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations> privateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'privateKey');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations> publicKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'publicKey');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      purchaseRefIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purchaseRefId');
    });
  }

  QueryBuilder<UserCollection, List<String>?, QQueryOperations>
      roomInvitedIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomInvitedIds');
    });
  }

  QueryBuilder<UserCollection, int?, QQueryOperations> schemaVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'schemaVersion');
    });
  }

  QueryBuilder<UserCollection, String, QQueryOperations>
      shortDisplayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortDisplayName');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      shortcutPasscodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortcutPasscode');
    });
  }

  QueryBuilder<UserCollection, String, QQueryOperations> showNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showName');
    });
  }

  QueryBuilder<UserCollection, String, QQueryOperations>
      statusMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusMessage');
    });
  }

  QueryBuilder<UserCollection, DateTime?, QQueryOperations>
      subscribeAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subscribeAt');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations> tokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'token');
    });
  }

  QueryBuilder<UserCollection, List<DefaultBookmarkTagItemModel>?,
      QQueryOperations> uchatDefaultBookmarkEmojiTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uchatDefaultBookmarkEmojiTags');
    });
  }

  QueryBuilder<UserCollection, List<DefaultEmojiItemModel>?, QQueryOperations>
      uchatDefaultEmojiItemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uchatDefaultEmojiItems');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
