// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContactCollectionCollection on Isar {
  IsarCollection<ContactCollection> get contacts => this.collection();
}

const ContactCollectionSchema = CollectionSchema(
  name: r'Contact',
  id: 342568039478732666,
  properties: {
    r'avatarId': PropertySchema(
      id: 0,
      name: r'avatarId',
      type: IsarType.string,
    ),
    r'avatarPublic': PropertySchema(
      id: 1,
      name: r'avatarPublic',
      type: IsarType.string,
    ),
    r'avatarUrl': PropertySchema(
      id: 2,
      name: r'avatarUrl',
      type: IsarType.string,
    ),
    r'backgroundBlurhash': PropertySchema(
      id: 3,
      name: r'backgroundBlurhash',
      type: IsarType.string,
    ),
    r'backgroundId': PropertySchema(
      id: 4,
      name: r'backgroundId',
      type: IsarType.string,
    ),
    r'backgroundUrl': PropertySchema(
      id: 5,
      name: r'backgroundUrl',
      type: IsarType.string,
    ),
    r'birthDate': PropertySchema(
      id: 6,
      name: r'birthDate',
      type: IsarType.string,
    ),
    r'blocked': PropertySchema(
      id: 7,
      name: r'blocked',
      type: IsarType.bool,
    ),
    r'blockedAt': PropertySchema(
      id: 8,
      name: r'blockedAt',
      type: IsarType.dateTime,
    ),
    r'canChatWith': PropertySchema(
      id: 9,
      name: r'canChatWith',
      type: IsarType.bool,
    ),
    r'canShowInFriendList': PropertySchema(
      id: 10,
      name: r'canShowInFriendList',
      type: IsarType.bool,
    ),
    r'canShowInFriendSearch': PropertySchema(
      id: 11,
      name: r'canShowInFriendSearch',
      type: IsarType.bool,
    ),
    r'canShowInOfficialAccountList': PropertySchema(
      id: 12,
      name: r'canShowInOfficialAccountList',
      type: IsarType.bool,
    ),
    r'canShowInOfficialAccountSearch': PropertySchema(
      id: 13,
      name: r'canShowInOfficialAccountSearch',
      type: IsarType.bool,
    ),
    r'canShowInShareContact': PropertySchema(
      id: 14,
      name: r'canShowInShareContact',
      type: IsarType.bool,
    ),
    r'createdAt': PropertySchema(
      id: 15,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'displayName': PropertySchema(
      id: 16,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'email': PropertySchema(
      id: 17,
      name: r'email',
      type: IsarType.string,
    ),
    r'exist': PropertySchema(
      id: 18,
      name: r'exist',
      type: IsarType.bool,
    ),
    r'friendCanSeeMyLastSeen': PropertySchema(
      id: 19,
      name: r'friendCanSeeMyLastSeen',
      type: IsarType.bool,
    ),
    r'googleAccount': PropertySchema(
      id: 20,
      name: r'googleAccount',
      type: IsarType.string,
    ),
    r'hasAvatar': PropertySchema(
      id: 21,
      name: r'hasAvatar',
      type: IsarType.bool,
    ),
    r'hasOfficialMenu': PropertySchema(
      id: 22,
      name: r'hasOfficialMenu',
      type: IsarType.bool,
    ),
    r'hasPassword': PropertySchema(
      id: 23,
      name: r'hasPassword',
      type: IsarType.bool,
    ),
    r'hasShowName': PropertySchema(
      id: 24,
      name: r'hasShowName',
      type: IsarType.bool,
    ),
    r'hidden': PropertySchema(
      id: 25,
      name: r'hidden',
      type: IsarType.bool,
    ),
    r'hiddenAt': PropertySchema(
      id: 26,
      name: r'hiddenAt',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(
      id: 27,
      name: r'id',
      type: IsarType.string,
    ),
    r'isBlocked': PropertySchema(
      id: 28,
      name: r'isBlocked',
      type: IsarType.bool,
    ),
    r'isDeleted': PropertySchema(
      id: 29,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'isFriend': PropertySchema(
      id: 30,
      name: r'isFriend',
      type: IsarType.bool,
    ),
    r'isHidden': PropertySchema(
      id: 31,
      name: r'isHidden',
      type: IsarType.bool,
    ),
    r'isMe': PropertySchema(
      id: 32,
      name: r'isMe',
      type: IsarType.bool,
    ),
    r'isOfficial': PropertySchema(
      id: 33,
      name: r'isOfficial',
      type: IsarType.bool,
    ),
    r'isTyping': PropertySchema(
      id: 34,
      name: r'isTyping',
      type: IsarType.bool,
    ),
    r'joinInMessage': PropertySchema(
      id: 35,
      name: r'joinInMessage',
      type: IsarType.string,
    ),
    r'lastSeenAt': PropertySchema(
      id: 36,
      name: r'lastSeenAt',
      type: IsarType.dateTime,
    ),
    r'lastTypedAt': PropertySchema(
      id: 37,
      name: r'lastTypedAt',
      type: IsarType.dateTime,
    ),
    r'menu': PropertySchema(
      id: 38,
      name: r'menu',
      type: IsarType.object,
      target: r'OfficialMenuModel',
    ),
    r'name': PropertySchema(
      id: 39,
      name: r'name',
      type: IsarType.string,
    ),
    r'nameLowercase': PropertySchema(
      id: 40,
      name: r'nameLowercase',
      type: IsarType.string,
    ),
    r'nickname': PropertySchema(
      id: 41,
      name: r'nickname',
      type: IsarType.string,
    ),
    r'onlineStatus': PropertySchema(
      id: 42,
      name: r'onlineStatus',
      type: IsarType.string,
      enumMap: _ContactCollectiononlineStatusEnumValueMap,
    ),
    r'originalIsDeleted': PropertySchema(
      id: 43,
      name: r'originalIsDeleted',
      type: IsarType.bool,
    ),
    r'originalIsFriend': PropertySchema(
      id: 44,
      name: r'originalIsFriend',
      type: IsarType.bool,
    ),
    r'originalStatusMessage': PropertySchema(
      id: 45,
      name: r'originalStatusMessage',
      type: IsarType.string,
    ),
    r'phoneNumber': PropertySchema(
      id: 46,
      name: r'phoneNumber',
      type: IsarType.string,
    ),
    r'richMenu': PropertySchema(
      id: 47,
      name: r'richMenu',
      type: IsarType.object,
      target: r'RichMenuModel',
    ),
    r'settings': PropertySchema(
      id: 48,
      name: r'settings',
      type: IsarType.object,
      target: r'AccountSettingsModel',
    ),
    r'shortDisplayName': PropertySchema(
      id: 49,
      name: r'shortDisplayName',
      type: IsarType.string,
    ),
    r'shortName': PropertySchema(
      id: 50,
      name: r'shortName',
      type: IsarType.string,
    ),
    r'shortNickname': PropertySchema(
      id: 51,
      name: r'shortNickname',
      type: IsarType.string,
    ),
    r'showName': PropertySchema(
      id: 52,
      name: r'showName',
      type: IsarType.string,
    ),
    r'statusMessage': PropertySchema(
      id: 53,
      name: r'statusMessage',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 54,
      name: r'type',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 55,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'username': PropertySchema(
      id: 56,
      name: r'username',
      type: IsarType.string,
    ),
    r'vibraniumShield': PropertySchema(
      id: 57,
      name: r'vibraniumShield',
      type: IsarType.bool,
    )
  },
  estimateSize: _contactCollectionEstimateSize,
  serialize: _contactCollectionSerialize,
  deserialize: _contactCollectionDeserialize,
  deserializeProp: _contactCollectionDeserializeProp,
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
    r'displayName': IndexSchema(
      id: -825365117524145674,
      name: r'displayName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'displayName',
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
    r'blocked': IndexSchema(
      id: 7101949552681291628,
      name: r'blocked',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'blocked',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'originalIsFriend': IndexSchema(
      id: 787645891655518374,
      name: r'originalIsFriend',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'originalIsFriend',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'nickname': IndexSchema(
      id: 4062737668634095984,
      name: r'nickname',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nickname',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'originalIsDeleted': IndexSchema(
      id: 9211679543595925797,
      name: r'originalIsDeleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'originalIsDeleted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'phoneNumber': IndexSchema(
      id: 5414128966131364535,
      name: r'phoneNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'phoneNumber',
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
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'hiddenAt': IndexSchema(
      id: 348734768726160760,
      name: r'hiddenAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'hiddenAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'blockedAt': IndexSchema(
      id: 5255835730422607383,
      name: r'blockedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'blockedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isOfficial': IndexSchema(
      id: 3000831953193917913,
      name: r'isOfficial',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isOfficial',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isBlocked': IndexSchema(
      id: 4270553749242334751,
      name: r'isBlocked',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isBlocked',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isHidden': IndexSchema(
      id: 1012074769999104596,
      name: r'isHidden',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isHidden',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isFriend': IndexSchema(
      id: 8095241923133819929,
      name: r'isFriend',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isFriend',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isDeleted': IndexSchema(
      id: -786475870904832312,
      name: r'isDeleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isDeleted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInFriendSearch': IndexSchema(
      id: 2260319754450392176,
      name: r'canShowInFriendSearch',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInFriendSearch',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInOfficialAccountSearch': IndexSchema(
      id: -1340493451214168060,
      name: r'canShowInOfficialAccountSearch',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInOfficialAccountSearch',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInFriendList': IndexSchema(
      id: -5032221631537385497,
      name: r'canShowInFriendList',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInFriendList',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInOfficialAccountList': IndexSchema(
      id: -6956444901588039784,
      name: r'canShowInOfficialAccountList',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInOfficialAccountList',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canShowInShareContact': IndexSchema(
      id: -7368526604916718047,
      name: r'canShowInShareContact',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canShowInShareContact',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'canChatWith': IndexSchema(
      id: 2426136979684270535,
      name: r'canChatWith',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'canChatWith',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'nameLowercase': IndexSchema(
      id: 2300966750611771008,
      name: r'nameLowercase',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nameLowercase',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
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
    r'SecuritySettingsModel': SecuritySettingsModelSchema
  },
  getId: _contactCollectionGetId,
  getLinks: _contactCollectionGetLinks,
  attach: _contactCollectionAttach,
  version: '3.3.0-dev.3',
);

int _contactCollectionEstimateSize(
  ContactCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
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
    final value = object.googleAccount;
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
    final value = object.joinInMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.menu;
    if (value != null) {
      bytesCount += 3 +
          OfficialMenuModelSchema.estimateSize(
              value, allOffsets[OfficialMenuModel]!, allOffsets);
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nameLowercase;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nickname;
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
    final value = object.phoneNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.richMenu;
    if (value != null) {
      bytesCount += 3 +
          RichMenuModelSchema.estimateSize(
              value, allOffsets[RichMenuModel]!, allOffsets);
    }
  }
  {
    final value = object.settings;
    if (value != null) {
      bytesCount += 3 +
          AccountSettingsModelSchema.estimateSize(
              value, allOffsets[AccountSettingsModel]!, allOffsets);
    }
  }
  bytesCount += 3 + object.shortDisplayName.length * 3;
  {
    final value = object.shortName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.shortNickname.length * 3;
  bytesCount += 3 + object.showName.length * 3;
  bytesCount += 3 + object.statusMessage.length * 3;
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
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

void _contactCollectionSerialize(
  ContactCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avatarId);
  writer.writeString(offsets[1], object.avatarPublic);
  writer.writeString(offsets[2], object.avatarUrl);
  writer.writeString(offsets[3], object.backgroundBlurhash);
  writer.writeString(offsets[4], object.backgroundId);
  writer.writeString(offsets[5], object.backgroundUrl);
  writer.writeString(offsets[6], object.birthDate);
  writer.writeBool(offsets[7], object.blocked);
  writer.writeDateTime(offsets[8], object.blockedAt);
  writer.writeBool(offsets[9], object.canChatWith);
  writer.writeBool(offsets[10], object.canShowInFriendList);
  writer.writeBool(offsets[11], object.canShowInFriendSearch);
  writer.writeBool(offsets[12], object.canShowInOfficialAccountList);
  writer.writeBool(offsets[13], object.canShowInOfficialAccountSearch);
  writer.writeBool(offsets[14], object.canShowInShareContact);
  writer.writeDateTime(offsets[15], object.createdAt);
  writer.writeString(offsets[16], object.displayName);
  writer.writeString(offsets[17], object.email);
  writer.writeBool(offsets[18], object.exist);
  writer.writeBool(offsets[19], object.friendCanSeeMyLastSeen);
  writer.writeString(offsets[20], object.googleAccount);
  writer.writeBool(offsets[21], object.hasAvatar);
  writer.writeBool(offsets[22], object.hasOfficialMenu);
  writer.writeBool(offsets[23], object.hasPassword);
  writer.writeBool(offsets[24], object.hasShowName);
  writer.writeBool(offsets[25], object.hidden);
  writer.writeDateTime(offsets[26], object.hiddenAt);
  writer.writeString(offsets[27], object.id);
  writer.writeBool(offsets[28], object.isBlocked);
  writer.writeBool(offsets[29], object.isDeleted);
  writer.writeBool(offsets[30], object.isFriend);
  writer.writeBool(offsets[31], object.isHidden);
  writer.writeBool(offsets[32], object.isMe);
  writer.writeBool(offsets[33], object.isOfficial);
  writer.writeBool(offsets[34], object.isTyping);
  writer.writeString(offsets[35], object.joinInMessage);
  writer.writeDateTime(offsets[36], object.lastSeenAt);
  writer.writeDateTime(offsets[37], object.lastTypedAt);
  writer.writeObject<OfficialMenuModel>(
    offsets[38],
    allOffsets,
    OfficialMenuModelSchema.serialize,
    object.menu,
  );
  writer.writeString(offsets[39], object.name);
  writer.writeString(offsets[40], object.nameLowercase);
  writer.writeString(offsets[41], object.nickname);
  writer.writeString(offsets[42], object.onlineStatus?.name);
  writer.writeBool(offsets[43], object.originalIsDeleted);
  writer.writeBool(offsets[44], object.originalIsFriend);
  writer.writeString(offsets[45], object.originalStatusMessage);
  writer.writeString(offsets[46], object.phoneNumber);
  writer.writeObject<RichMenuModel>(
    offsets[47],
    allOffsets,
    RichMenuModelSchema.serialize,
    object.richMenu,
  );
  writer.writeObject<AccountSettingsModel>(
    offsets[48],
    allOffsets,
    AccountSettingsModelSchema.serialize,
    object.settings,
  );
  writer.writeString(offsets[49], object.shortDisplayName);
  writer.writeString(offsets[50], object.shortName);
  writer.writeString(offsets[51], object.shortNickname);
  writer.writeString(offsets[52], object.showName);
  writer.writeString(offsets[53], object.statusMessage);
  writer.writeString(offsets[54], object.type);
  writer.writeDateTime(offsets[55], object.updatedAt);
  writer.writeString(offsets[56], object.username);
  writer.writeBool(offsets[57], object.vibraniumShield);
}

ContactCollection _contactCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ContactCollection(
    avatarId: reader.readStringOrNull(offsets[0]),
    backgroundBlurhash: reader.readStringOrNull(offsets[3]),
    backgroundId: reader.readStringOrNull(offsets[4]),
    birthDate: reader.readStringOrNull(offsets[6]),
    blocked: reader.readBoolOrNull(offsets[7]),
    blockedAt: reader.readDateTimeOrNull(offsets[8]),
    createdAt: reader.readDateTimeOrNull(offsets[15]),
    displayName: reader.readStringOrNull(offsets[16]),
    email: reader.readStringOrNull(offsets[17]),
    friendCanSeeMyLastSeen: reader.readBoolOrNull(offsets[19]),
    googleAccount: reader.readStringOrNull(offsets[20]),
    hasPassword: reader.readBoolOrNull(offsets[23]),
    hidden: reader.readBoolOrNull(offsets[25]),
    hiddenAt: reader.readDateTimeOrNull(offsets[26]),
    id: reader.readStringOrNull(offsets[27]),
    isTyping: reader.readBoolOrNull(offsets[34]),
    lastSeenAt: reader.readDateTimeOrNull(offsets[36]),
    lastTypedAt: reader.readDateTimeOrNull(offsets[37]),
    menu: reader.readObjectOrNull<OfficialMenuModel>(
      offsets[38],
      OfficialMenuModelSchema.deserialize,
      allOffsets,
    ),
    nickname: reader.readStringOrNull(offsets[41]),
    onlineStatus: _ContactCollectiononlineStatusValueEnumMap[
        reader.readStringOrNull(offsets[42])],
    originalIsDeleted: reader.readBoolOrNull(offsets[43]),
    originalIsFriend: reader.readBoolOrNull(offsets[44]),
    originalStatusMessage: reader.readStringOrNull(offsets[45]),
    phoneNumber: reader.readStringOrNull(offsets[46]),
    richMenu: reader.readObjectOrNull<RichMenuModel>(
      offsets[47],
      RichMenuModelSchema.deserialize,
      allOffsets,
    ),
    settings: reader.readObjectOrNull<AccountSettingsModel>(
      offsets[48],
      AccountSettingsModelSchema.deserialize,
      allOffsets,
    ),
    type: reader.readStringOrNull(offsets[54]),
    updatedAt: reader.readDateTimeOrNull(offsets[55]),
    username: reader.readStringOrNull(offsets[56]),
    vibraniumShield: reader.readBoolOrNull(offsets[57]),
  );
  object.statusMessage = reader.readString(offsets[53]);
  return object;
}

P _contactCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readBoolOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readBool(offset)) as P;
    case 22:
      return (reader.readBool(offset)) as P;
    case 23:
      return (reader.readBoolOrNull(offset)) as P;
    case 24:
      return (reader.readBool(offset)) as P;
    case 25:
      return (reader.readBoolOrNull(offset)) as P;
    case 26:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readBool(offset)) as P;
    case 29:
      return (reader.readBool(offset)) as P;
    case 30:
      return (reader.readBool(offset)) as P;
    case 31:
      return (reader.readBool(offset)) as P;
    case 32:
      return (reader.readBool(offset)) as P;
    case 33:
      return (reader.readBool(offset)) as P;
    case 34:
      return (reader.readBoolOrNull(offset)) as P;
    case 35:
      return (reader.readStringOrNull(offset)) as P;
    case 36:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 37:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 38:
      return (reader.readObjectOrNull<OfficialMenuModel>(
        offset,
        OfficialMenuModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 39:
      return (reader.readStringOrNull(offset)) as P;
    case 40:
      return (reader.readStringOrNull(offset)) as P;
    case 41:
      return (reader.readStringOrNull(offset)) as P;
    case 42:
      return (_ContactCollectiononlineStatusValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 43:
      return (reader.readBoolOrNull(offset)) as P;
    case 44:
      return (reader.readBoolOrNull(offset)) as P;
    case 45:
      return (reader.readStringOrNull(offset)) as P;
    case 46:
      return (reader.readStringOrNull(offset)) as P;
    case 47:
      return (reader.readObjectOrNull<RichMenuModel>(
        offset,
        RichMenuModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 48:
      return (reader.readObjectOrNull<AccountSettingsModel>(
        offset,
        AccountSettingsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 49:
      return (reader.readString(offset)) as P;
    case 50:
      return (reader.readStringOrNull(offset)) as P;
    case 51:
      return (reader.readString(offset)) as P;
    case 52:
      return (reader.readString(offset)) as P;
    case 53:
      return (reader.readString(offset)) as P;
    case 54:
      return (reader.readStringOrNull(offset)) as P;
    case 55:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 56:
      return (reader.readStringOrNull(offset)) as P;
    case 57:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ContactCollectiononlineStatusEnumValueMap = {
  r'online': r'online',
  r'busy': r'busy',
  r'doNotDisturb': r'doNotDisturb',
  r'offline': r'offline',
};
const _ContactCollectiononlineStatusValueEnumMap = {
  r'online': OnlineStatus.online,
  r'busy': OnlineStatus.busy,
  r'doNotDisturb': OnlineStatus.doNotDisturb,
  r'offline': OnlineStatus.offline,
};

Id _contactCollectionGetId(ContactCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _contactCollectionGetLinks(
    ContactCollection object) {
  return [];
}

void _contactCollectionAttach(
    IsarCollection<dynamic> col, Id id, ContactCollection object) {}

extension ContactCollectionByIndex on IsarCollection<ContactCollection> {
  Future<ContactCollection?> getById(String? id) {
    return getByIndex(r'id', [id]);
  }

  ContactCollection? getByIdSync(String? id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String? id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String? id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<ContactCollection?>> getAllById(List<String?> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<ContactCollection?> getAllByIdSync(List<String?> idValues) {
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

  Future<Id> putById(ContactCollection object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(ContactCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<ContactCollection> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<ContactCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }

  Future<ContactCollection?> getByUsername(String? username) {
    return getByIndex(r'username', [username]);
  }

  ContactCollection? getByUsernameSync(String? username) {
    return getByIndexSync(r'username', [username]);
  }

  Future<bool> deleteByUsername(String? username) {
    return deleteByIndex(r'username', [username]);
  }

  bool deleteByUsernameSync(String? username) {
    return deleteByIndexSync(r'username', [username]);
  }

  Future<List<ContactCollection?>> getAllByUsername(
      List<String?> usernameValues) {
    final values = usernameValues.map((e) => [e]).toList();
    return getAllByIndex(r'username', values);
  }

  List<ContactCollection?> getAllByUsernameSync(List<String?> usernameValues) {
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

  Future<Id> putByUsername(ContactCollection object) {
    return putByIndex(r'username', object);
  }

  Id putByUsernameSync(ContactCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'username', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUsername(List<ContactCollection> objects) {
    return putAllByIndex(r'username', objects);
  }

  List<Id> putAllByUsernameSync(List<ContactCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'username', objects, saveLinks: saveLinks);
  }
}

extension ContactCollectionQueryWhereSort
    on QueryBuilder<ContactCollection, ContactCollection, QWhere> {
  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere> anyBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'blocked'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyOriginalIsFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'originalIsFriend'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyOriginalIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'originalIsDeleted'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyHiddenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'hiddenAt'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyBlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'blockedAt'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyIsOfficial() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isOfficial'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isBlocked'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isHidden'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyIsFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isFriend'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDeleted'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyCanShowInFriendSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInFriendSearch'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyCanShowInOfficialAccountSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(
            indexName: r'canShowInOfficialAccountSearch'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyCanShowInFriendList() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInFriendList'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyCanShowInOfficialAccountList() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInOfficialAccountList'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyCanShowInShareContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canShowInShareContact'),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhere>
      anyCanChatWith() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'canChatWith'),
      );
    });
  }
}

extension ContactCollectionQueryWhere
    on QueryBuilder<ContactCollection, ContactCollection, QWhereClause> {
  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      idEqualTo(String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'displayName',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'displayName',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      displayNameEqualTo(String? displayName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'displayName',
        value: [displayName],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      displayNameNotEqualTo(String? displayName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [],
              upper: [displayName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [displayName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [displayName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [],
              upper: [displayName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'username',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      usernameEqualTo(String? username) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'username',
        value: [username],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'blocked',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'blocked',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedEqualTo(bool? blocked) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'blocked',
        value: [blocked],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedNotEqualTo(bool? blocked) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blocked',
              lower: [],
              upper: [blocked],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blocked',
              lower: [blocked],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blocked',
              lower: [blocked],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blocked',
              lower: [],
              upper: [blocked],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      originalIsFriendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'originalIsFriend',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      originalIsFriendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'originalIsFriend',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      originalIsFriendEqualTo(bool? originalIsFriend) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'originalIsFriend',
        value: [originalIsFriend],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      originalIsFriendNotEqualTo(bool? originalIsFriend) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalIsFriend',
              lower: [],
              upper: [originalIsFriend],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalIsFriend',
              lower: [originalIsFriend],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalIsFriend',
              lower: [originalIsFriend],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalIsFriend',
              lower: [],
              upper: [originalIsFriend],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      nicknameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nickname',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      nicknameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nickname',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      nicknameEqualTo(String? nickname) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nickname',
        value: [nickname],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      nicknameNotEqualTo(String? nickname) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nickname',
              lower: [],
              upper: [nickname],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nickname',
              lower: [nickname],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nickname',
              lower: [nickname],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nickname',
              lower: [],
              upper: [nickname],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      originalIsDeletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'originalIsDeleted',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      originalIsDeletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'originalIsDeleted',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      originalIsDeletedEqualTo(bool? originalIsDeleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'originalIsDeleted',
        value: [originalIsDeleted],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      originalIsDeletedNotEqualTo(bool? originalIsDeleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalIsDeleted',
              lower: [],
              upper: [originalIsDeleted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalIsDeleted',
              lower: [originalIsDeleted],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalIsDeleted',
              lower: [originalIsDeleted],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'originalIsDeleted',
              lower: [],
              upper: [originalIsDeleted],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      phoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'phoneNumber',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      phoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'phoneNumber',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      phoneNumberEqualTo(String? phoneNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'phoneNumber',
        value: [phoneNumber],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      phoneNumberNotEqualTo(String? phoneNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phoneNumber',
              lower: [],
              upper: [phoneNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phoneNumber',
              lower: [phoneNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phoneNumber',
              lower: [phoneNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phoneNumber',
              lower: [],
              upper: [phoneNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      typeEqualTo(String? type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type',
        value: [type],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      typeNotEqualTo(String? type) {
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      updatedAtEqualTo(DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      updatedAtNotEqualTo(DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      updatedAtGreaterThan(
    DateTime? updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [updatedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      updatedAtLessThan(
    DateTime? updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [],
        upper: [updatedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      updatedAtBetween(
    DateTime? lowerUpdatedAt,
    DateTime? upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [lowerUpdatedAt],
        includeLower: includeLower,
        upper: [upperUpdatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      hiddenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hiddenAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      hiddenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hiddenAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      hiddenAtEqualTo(DateTime? hiddenAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'hiddenAt',
        value: [hiddenAt],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      hiddenAtNotEqualTo(DateTime? hiddenAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hiddenAt',
              lower: [],
              upper: [hiddenAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hiddenAt',
              lower: [hiddenAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hiddenAt',
              lower: [hiddenAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'hiddenAt',
              lower: [],
              upper: [hiddenAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      hiddenAtGreaterThan(
    DateTime? hiddenAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hiddenAt',
        lower: [hiddenAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      hiddenAtLessThan(
    DateTime? hiddenAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hiddenAt',
        lower: [],
        upper: [hiddenAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      hiddenAtBetween(
    DateTime? lowerHiddenAt,
    DateTime? upperHiddenAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'hiddenAt',
        lower: [lowerHiddenAt],
        includeLower: includeLower,
        upper: [upperHiddenAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'blockedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'blockedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedAtEqualTo(DateTime? blockedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'blockedAt',
        value: [blockedAt],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedAtNotEqualTo(DateTime? blockedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blockedAt',
              lower: [],
              upper: [blockedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blockedAt',
              lower: [blockedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blockedAt',
              lower: [blockedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'blockedAt',
              lower: [],
              upper: [blockedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedAtGreaterThan(
    DateTime? blockedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'blockedAt',
        lower: [blockedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedAtLessThan(
    DateTime? blockedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'blockedAt',
        lower: [],
        upper: [blockedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      blockedAtBetween(
    DateTime? lowerBlockedAt,
    DateTime? upperBlockedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'blockedAt',
        lower: [lowerBlockedAt],
        includeLower: includeLower,
        upper: [upperBlockedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isOfficialEqualTo(bool isOfficial) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isOfficial',
        value: [isOfficial],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isOfficialNotEqualTo(bool isOfficial) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isOfficial',
              lower: [],
              upper: [isOfficial],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isOfficial',
              lower: [isOfficial],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isOfficial',
              lower: [isOfficial],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isOfficial',
              lower: [],
              upper: [isOfficial],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isBlockedEqualTo(bool isBlocked) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isBlocked',
        value: [isBlocked],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isBlockedNotEqualTo(bool isBlocked) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isBlocked',
              lower: [],
              upper: [isBlocked],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isBlocked',
              lower: [isBlocked],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isBlocked',
              lower: [isBlocked],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isBlocked',
              lower: [],
              upper: [isBlocked],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isHiddenEqualTo(bool isHidden) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isHidden',
        value: [isHidden],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isHiddenNotEqualTo(bool isHidden) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [],
              upper: [isHidden],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [isHidden],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [isHidden],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isHidden',
              lower: [],
              upper: [isHidden],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isFriendEqualTo(bool isFriend) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isFriend',
        value: [isFriend],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isFriendNotEqualTo(bool isFriend) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFriend',
              lower: [],
              upper: [isFriend],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFriend',
              lower: [isFriend],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFriend',
              lower: [isFriend],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFriend',
              lower: [],
              upper: [isFriend],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isDeletedEqualTo(bool isDeleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDeleted',
        value: [isDeleted],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      isDeletedNotEqualTo(bool isDeleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [],
              upper: [isDeleted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [isDeleted],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [isDeleted],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [],
              upper: [isDeleted],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInFriendSearchEqualTo(bool canShowInFriendSearch) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInFriendSearch',
        value: [canShowInFriendSearch],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInFriendSearchNotEqualTo(bool canShowInFriendSearch) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInFriendSearch',
              lower: [],
              upper: [canShowInFriendSearch],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInFriendSearch',
              lower: [canShowInFriendSearch],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInFriendSearch',
              lower: [canShowInFriendSearch],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInFriendSearch',
              lower: [],
              upper: [canShowInFriendSearch],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInOfficialAccountSearchEqualTo(
          bool canShowInOfficialAccountSearch) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInOfficialAccountSearch',
        value: [canShowInOfficialAccountSearch],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInOfficialAccountSearchNotEqualTo(
          bool canShowInOfficialAccountSearch) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInOfficialAccountSearch',
              lower: [],
              upper: [canShowInOfficialAccountSearch],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInOfficialAccountSearch',
              lower: [canShowInOfficialAccountSearch],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInOfficialAccountSearch',
              lower: [canShowInOfficialAccountSearch],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInOfficialAccountSearch',
              lower: [],
              upper: [canShowInOfficialAccountSearch],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInFriendListEqualTo(bool canShowInFriendList) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInFriendList',
        value: [canShowInFriendList],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInFriendListNotEqualTo(bool canShowInFriendList) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInFriendList',
              lower: [],
              upper: [canShowInFriendList],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInFriendList',
              lower: [canShowInFriendList],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInFriendList',
              lower: [canShowInFriendList],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInFriendList',
              lower: [],
              upper: [canShowInFriendList],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInOfficialAccountListEqualTo(bool canShowInOfficialAccountList) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInOfficialAccountList',
        value: [canShowInOfficialAccountList],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInOfficialAccountListNotEqualTo(
          bool canShowInOfficialAccountList) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInOfficialAccountList',
              lower: [],
              upper: [canShowInOfficialAccountList],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInOfficialAccountList',
              lower: [canShowInOfficialAccountList],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInOfficialAccountList',
              lower: [canShowInOfficialAccountList],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInOfficialAccountList',
              lower: [],
              upper: [canShowInOfficialAccountList],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInShareContactEqualTo(bool canShowInShareContact) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canShowInShareContact',
        value: [canShowInShareContact],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canShowInShareContactNotEqualTo(bool canShowInShareContact) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInShareContact',
              lower: [],
              upper: [canShowInShareContact],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInShareContact',
              lower: [canShowInShareContact],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInShareContact',
              lower: [canShowInShareContact],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canShowInShareContact',
              lower: [],
              upper: [canShowInShareContact],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canChatWithEqualTo(bool canChatWith) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'canChatWith',
        value: [canChatWith],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      canChatWithNotEqualTo(bool canChatWith) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canChatWith',
              lower: [],
              upper: [canChatWith],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canChatWith',
              lower: [canChatWith],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canChatWith',
              lower: [canChatWith],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'canChatWith',
              lower: [],
              upper: [canChatWith],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      nameLowercaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameLowercase',
        value: [null],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      nameLowercaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nameLowercase',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      nameLowercaseEqualTo(String? nameLowercase) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameLowercase',
        value: [nameLowercase],
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterWhereClause>
      nameLowercaseNotEqualTo(String? nameLowercase) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLowercase',
              lower: [],
              upper: [nameLowercase],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLowercase',
              lower: [nameLowercase],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLowercase',
              lower: [nameLowercase],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLowercase',
              lower: [],
              upper: [nameLowercase],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ContactCollectionQueryFilter
    on QueryBuilder<ContactCollection, ContactCollection, QFilterCondition> {
  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarId',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarId',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarId',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarId',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarPublicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarPublic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarPublicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarPublic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarPublicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarPublic',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarPublicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarPublic',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      avatarUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundBlurhashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'backgroundBlurhash',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundBlurhashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'backgroundBlurhash',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundBlurhashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'backgroundBlurhash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundBlurhashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'backgroundBlurhash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundBlurhashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundBlurhashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'backgroundBlurhash',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'backgroundId',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'backgroundId',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'backgroundId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'backgroundId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundId',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'backgroundId',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'backgroundUrl',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'backgroundUrl',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'backgroundUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'backgroundUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backgroundUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      backgroundUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'backgroundUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      birthDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'birthDate',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      birthDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'birthDate',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      birthDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'birthDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      birthDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'birthDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      birthDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'birthDate',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      birthDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'birthDate',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      blockedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'blocked',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      blockedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'blocked',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      blockedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blocked',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      blockedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'blockedAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      blockedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'blockedAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      blockedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      blockedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      blockedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      blockedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      canChatWithEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canChatWith',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      canShowInFriendListEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInFriendList',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      canShowInFriendSearchEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInFriendSearch',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      canShowInOfficialAccountListEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInOfficialAccountList',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      canShowInOfficialAccountSearchEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInOfficialAccountSearch',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      canShowInShareContactEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canShowInShareContact',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      existEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exist',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      friendCanSeeMyLastSeenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'friendCanSeeMyLastSeen',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      friendCanSeeMyLastSeenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'friendCanSeeMyLastSeen',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      friendCanSeeMyLastSeenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendCanSeeMyLastSeen',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'googleAccount',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'googleAccount',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'googleAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'googleAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'googleAccount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'googleAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'googleAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'googleAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'googleAccount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      googleAccountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'googleAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hasAvatarEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasAvatar',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hasOfficialMenuEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasOfficialMenu',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hasPasswordIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasPassword',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hasPasswordIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasPassword',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hasPasswordEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasPassword',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hasShowNameEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasShowName',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hiddenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hidden',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hiddenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hidden',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hiddenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hidden',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hiddenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hiddenAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hiddenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hiddenAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hiddenAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hiddenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hiddenAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hiddenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hiddenAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hiddenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      hiddenAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hiddenAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isBlockedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBlocked',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isFriendEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFriend',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isHiddenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isMeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMe',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isOfficialEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOfficial',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isTypingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isTyping',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isTypingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isTyping',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isTypingEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTyping',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'joinInMessage',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'joinInMessage',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'joinInMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'joinInMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'joinInMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'joinInMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'joinInMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'joinInMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'joinInMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'joinInMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'joinInMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      joinInMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'joinInMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastSeenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSeenAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastSeenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSeenAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastSeenAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSeenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastSeenAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSeenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastSeenAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSeenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastSeenAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSeenAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastTypedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTypedAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastTypedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTypedAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastTypedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTypedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastTypedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTypedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastTypedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTypedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      lastTypedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTypedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      menuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'menu',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      menuIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'menu',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nameLowercase',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nameLowercase',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameLowercase',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameLowercase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameLowercase',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameLowercase',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nameLowercaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameLowercase',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nickname',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nickname',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nickname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nickname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      nicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      onlineStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'onlineStatus',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      onlineStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'onlineStatus',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      onlineStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'onlineStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      onlineStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'onlineStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      onlineStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onlineStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      onlineStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'onlineStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalIsDeletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalIsDeleted',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalIsDeletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalIsDeleted',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalIsDeletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalIsDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalIsFriendIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalIsFriend',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalIsFriendIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalIsFriend',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalIsFriendEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalIsFriend',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalStatusMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'originalStatusMessage',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalStatusMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'originalStatusMessage',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalStatusMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalStatusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalStatusMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalStatusMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      originalStatusMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalStatusMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      phoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phoneNumber',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      phoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phoneNumber',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      phoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      richMenuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'richMenu',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      richMenuIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'richMenu',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      settingsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'settings',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      settingsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'settings',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortDisplayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortDisplayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortDisplayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortDisplayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortDisplayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shortName',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shortName',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortNickname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shortNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shortNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortNickname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      shortNicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      showNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'showName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      showNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'showName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      showNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      showNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'showName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      statusMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statusMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      statusMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statusMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      statusMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      statusMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statusMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeEqualTo(
    String? value, {
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeGreaterThan(
    String? value, {
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeLessThan(
    String? value, {
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
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

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      usernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      usernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      vibraniumShieldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vibraniumShield',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      vibraniumShieldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vibraniumShield',
      ));
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      vibraniumShieldEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vibraniumShield',
        value: value,
      ));
    });
  }
}

extension ContactCollectionQueryObject
    on QueryBuilder<ContactCollection, ContactCollection, QFilterCondition> {
  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      menu(FilterQuery<OfficialMenuModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'menu');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      richMenu(FilterQuery<RichMenuModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'richMenu');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>
      settings(FilterQuery<AccountSettingsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'settings');
    });
  }
}

extension ContactCollectionQueryLinks
    on QueryBuilder<ContactCollection, ContactCollection, QFilterCondition> {}

extension ContactCollectionQuerySortBy
    on QueryBuilder<ContactCollection, ContactCollection, QSortBy> {
  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByAvatarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByAvatarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByAvatarPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPublic', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByAvatarPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPublic', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBackgroundBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundBlurhash', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBackgroundBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundBlurhash', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBackgroundId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundId', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBackgroundIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundId', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBackgroundUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundUrl', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBackgroundUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundUrl', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBirthDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthDate', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBirthDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthDate', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blocked', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blocked', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByBlockedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanChatWith() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canChatWith', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanChatWithDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canChatWith', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInFriendList() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInFriendList', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInFriendListDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInFriendList', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInFriendSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInFriendSearch', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInFriendSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInFriendSearch', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInOfficialAccountList() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInOfficialAccountList', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInOfficialAccountListDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInOfficialAccountList', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInOfficialAccountSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInOfficialAccountSearch', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInOfficialAccountSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInOfficialAccountSearch', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInShareContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInShareContact', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCanShowInShareContactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInShareContact', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByExist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exist', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByExistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exist', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByFriendCanSeeMyLastSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendCanSeeMyLastSeen', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByFriendCanSeeMyLastSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendCanSeeMyLastSeen', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByGoogleAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleAccount', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByGoogleAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleAccount', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHasAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHasAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHasOfficialMenu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasOfficialMenu', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHasOfficialMenuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasOfficialMenu', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHasPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPassword', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHasPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPassword', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHasShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasShowName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHasShowNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasShowName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hidden', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hidden', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHiddenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByHiddenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFriend', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsFriendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFriend', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsOfficial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOfficial', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsOfficialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOfficial', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsTyping() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTyping', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByIsTypingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTyping', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByJoinInMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinInMessage', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByJoinInMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinInMessage', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByLastSeenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByLastSeenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByLastTypedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTypedAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByLastTypedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTypedAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByNameLowercase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByNameLowercaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByOnlineStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineStatus', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByOnlineStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineStatus', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByOriginalIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsDeleted', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByOriginalIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsDeleted', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByOriginalIsFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsFriend', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByOriginalIsFriendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsFriend', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByOriginalStatusMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalStatusMessage', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByOriginalStatusMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalStatusMessage', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByShortDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortDisplayName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByShortDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortDisplayName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByShortName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByShortNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByShortNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortNickname', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByShortNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortNickname', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByShowNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByStatusMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusMessage', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByStatusMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusMessage', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByVibraniumShield() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibraniumShield', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      sortByVibraniumShieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibraniumShield', Sort.desc);
    });
  }
}

extension ContactCollectionQuerySortThenBy
    on QueryBuilder<ContactCollection, ContactCollection, QSortThenBy> {
  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByAvatarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByAvatarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByAvatarPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPublic', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByAvatarPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPublic', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBackgroundBlurhash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundBlurhash', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBackgroundBlurhashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundBlurhash', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBackgroundId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundId', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBackgroundIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundId', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBackgroundUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundUrl', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBackgroundUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundUrl', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBirthDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthDate', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBirthDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthDate', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blocked', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blocked', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByBlockedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockedAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanChatWith() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canChatWith', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanChatWithDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canChatWith', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInFriendList() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInFriendList', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInFriendListDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInFriendList', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInFriendSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInFriendSearch', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInFriendSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInFriendSearch', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInOfficialAccountList() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInOfficialAccountList', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInOfficialAccountListDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInOfficialAccountList', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInOfficialAccountSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInOfficialAccountSearch', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInOfficialAccountSearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInOfficialAccountSearch', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInShareContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInShareContact', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCanShowInShareContactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canShowInShareContact', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByExist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exist', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByExistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exist', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByFriendCanSeeMyLastSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendCanSeeMyLastSeen', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByFriendCanSeeMyLastSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendCanSeeMyLastSeen', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByGoogleAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleAccount', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByGoogleAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleAccount', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHasAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHasAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHasOfficialMenu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasOfficialMenu', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHasOfficialMenuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasOfficialMenu', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHasPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPassword', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHasPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasPassword', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHasShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasShowName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHasShowNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasShowName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hidden', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hidden', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHiddenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByHiddenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFriend', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsFriendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFriend', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsOfficial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOfficial', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsOfficialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOfficial', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsTyping() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTyping', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsTypingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTyping', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByJoinInMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinInMessage', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByJoinInMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinInMessage', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByLastSeenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByLastSeenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByLastTypedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTypedAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByLastTypedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTypedAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByNameLowercase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByNameLowercaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLowercase', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByOnlineStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineStatus', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByOnlineStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onlineStatus', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByOriginalIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsDeleted', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByOriginalIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsDeleted', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByOriginalIsFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsFriend', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByOriginalIsFriendDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalIsFriend', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByOriginalStatusMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalStatusMessage', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByOriginalStatusMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalStatusMessage', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByShortDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortDisplayName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByShortDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortDisplayName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByShortName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByShortNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByShortNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortNickname', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByShortNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortNickname', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showName', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByShowNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showName', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByStatusMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusMessage', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByStatusMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusMessage', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByVibraniumShield() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibraniumShield', Sort.asc);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QAfterSortBy>
      thenByVibraniumShieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibraniumShield', Sort.desc);
    });
  }
}

extension ContactCollectionQueryWhereDistinct
    on QueryBuilder<ContactCollection, ContactCollection, QDistinct> {
  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByAvatarId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByAvatarPublic({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarPublic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByAvatarUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByBackgroundBlurhash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backgroundBlurhash',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByBackgroundId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backgroundId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByBackgroundUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backgroundUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByBirthDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'birthDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blocked');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByBlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedAt');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByCanChatWith() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canChatWith');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByCanShowInFriendList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInFriendList');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByCanShowInFriendSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInFriendSearch');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByCanShowInOfficialAccountList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInOfficialAccountList');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByCanShowInOfficialAccountSearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInOfficialAccountSearch');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByCanShowInShareContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canShowInShareContact');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByExist() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exist');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByFriendCanSeeMyLastSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendCanSeeMyLastSeen');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByGoogleAccount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'googleAccount',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByHasAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasAvatar');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByHasOfficialMenu() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasOfficialMenu');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByHasPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasPassword');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByHasShowName() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasShowName');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hidden');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByHiddenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hiddenAt');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBlocked');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByIsFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFriend');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHidden');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMe');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByIsOfficial() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOfficial');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByIsTyping() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTyping');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByJoinInMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'joinInMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByLastSeenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSeenAt');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByLastTypedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTypedAt');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByNameLowercase({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameLowercase',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByNickname({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nickname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByOnlineStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onlineStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByOriginalIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalIsDeleted');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByOriginalIsFriend() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalIsFriend');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByOriginalStatusMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalStatusMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phoneNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByShortDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortDisplayName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByShortName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByShortNickname({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortNickname',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByShowName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByStatusMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByUsername({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContactCollection, ContactCollection, QDistinct>
      distinctByVibraniumShield() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vibraniumShield');
    });
  }
}

extension ContactCollectionQueryProperty
    on QueryBuilder<ContactCollection, ContactCollection, QQueryProperty> {
  QueryBuilder<ContactCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      avatarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarId');
    });
  }

  QueryBuilder<ContactCollection, String, QQueryOperations>
      avatarPublicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarPublic');
    });
  }

  QueryBuilder<ContactCollection, String, QQueryOperations>
      avatarUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarUrl');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      backgroundBlurhashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backgroundBlurhash');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      backgroundIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backgroundId');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      backgroundUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backgroundUrl');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      birthDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'birthDate');
    });
  }

  QueryBuilder<ContactCollection, bool?, QQueryOperations> blockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blocked');
    });
  }

  QueryBuilder<ContactCollection, DateTime?, QQueryOperations>
      blockedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedAt');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations>
      canChatWithProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canChatWith');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations>
      canShowInFriendListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInFriendList');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations>
      canShowInFriendSearchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInFriendSearch');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations>
      canShowInOfficialAccountListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInOfficialAccountList');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations>
      canShowInOfficialAccountSearchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInOfficialAccountSearch');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations>
      canShowInShareContactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canShowInShareContact');
    });
  }

  QueryBuilder<ContactCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations> existProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exist');
    });
  }

  QueryBuilder<ContactCollection, bool?, QQueryOperations>
      friendCanSeeMyLastSeenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendCanSeeMyLastSeen');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      googleAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'googleAccount');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations> hasAvatarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasAvatar');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations>
      hasOfficialMenuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasOfficialMenu');
    });
  }

  QueryBuilder<ContactCollection, bool?, QQueryOperations>
      hasPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasPassword');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations>
      hasShowNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasShowName');
    });
  }

  QueryBuilder<ContactCollection, bool?, QQueryOperations> hiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hidden');
    });
  }

  QueryBuilder<ContactCollection, DateTime?, QQueryOperations>
      hiddenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hiddenAt');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations> isBlockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBlocked');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations> isFriendProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFriend');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations> isHiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHidden');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations> isMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMe');
    });
  }

  QueryBuilder<ContactCollection, bool, QQueryOperations> isOfficialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOfficial');
    });
  }

  QueryBuilder<ContactCollection, bool?, QQueryOperations> isTypingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTyping');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      joinInMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'joinInMessage');
    });
  }

  QueryBuilder<ContactCollection, DateTime?, QQueryOperations>
      lastSeenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSeenAt');
    });
  }

  QueryBuilder<ContactCollection, DateTime?, QQueryOperations>
      lastTypedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTypedAt');
    });
  }

  QueryBuilder<ContactCollection, OfficialMenuModel?, QQueryOperations>
      menuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'menu');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      nameLowercaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameLowercase');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      nicknameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nickname');
    });
  }

  QueryBuilder<ContactCollection, OnlineStatus?, QQueryOperations>
      onlineStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onlineStatus');
    });
  }

  QueryBuilder<ContactCollection, bool?, QQueryOperations>
      originalIsDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalIsDeleted');
    });
  }

  QueryBuilder<ContactCollection, bool?, QQueryOperations>
      originalIsFriendProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalIsFriend');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      originalStatusMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalStatusMessage');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phoneNumber');
    });
  }

  QueryBuilder<ContactCollection, RichMenuModel?, QQueryOperations>
      richMenuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'richMenu');
    });
  }

  QueryBuilder<ContactCollection, AccountSettingsModel?, QQueryOperations>
      settingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'settings');
    });
  }

  QueryBuilder<ContactCollection, String, QQueryOperations>
      shortDisplayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortDisplayName');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      shortNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortName');
    });
  }

  QueryBuilder<ContactCollection, String, QQueryOperations>
      shortNicknameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortNickname');
    });
  }

  QueryBuilder<ContactCollection, String, QQueryOperations> showNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showName');
    });
  }

  QueryBuilder<ContactCollection, String, QQueryOperations>
      statusMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusMessage');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<ContactCollection, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<ContactCollection, String?, QQueryOperations>
      usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }

  QueryBuilder<ContactCollection, bool?, QQueryOperations>
      vibraniumShieldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vibraniumShield');
    });
  }
}
