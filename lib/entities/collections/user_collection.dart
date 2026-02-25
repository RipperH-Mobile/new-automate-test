import 'dart:convert';

import 'package:isar_community/isar.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/enum/pay_store_type.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/mixins.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/apple_account_model.dart';
import 'package:uchat/entities/models/default_bookmark_tag_item_model.dart';
import 'package:uchat/entities/models/default_emoji_item_model.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';
import 'package:uchat/entities/models/facebook_account_model.dart';
import 'package:uchat/entities/models/google_account_model.dart';
import 'package:uchat/entities/models/link_accounts_model.dart';
import 'package:uchat/features/auth/data/models/accepted_platform_document.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'user_collection.g.dart';

@Collection(accessor: 'users')
@Name('User')
class UserCollection with UserMixin {
  @override
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id!);

  @override
  @Index(unique: true, replace: true)
  String? username;

  @override
  String? displayName;

  @override
  String? birthDate;

  @override
  String? email;

  @override
  bool? hasPassword;

  @override
  String? avatarId;

  @override
  String? originalStatusMessage;

  @override
  @Enumerated(EnumType.name)
  OnlineStatus? onlineStatus;

  @Index()
  bool? isCurrentUser;

  String? phoneNumber;

  @override
  String? backgroundId;

  String? backgroundBlurhash;
  String? token;
  String? avatarBlurhash;
  DateTime? lastEditUsernameAt;
  int? limitFriend;
  int? friendRequestCount;
  List<String>? roomInvitedIds;
  LinkAccountsModel? linkAccounts;

  /// Whether this user is hidden from multiple account screen
  bool? isMAHidden;

  // DateTime when user login, used to for sorting in accounts center.
  DateTime? loginAt;
  @Index()
  String? shortcutPasscode;
  EnabledFeaturesModel? enabledFeatures;

  int? currentStateSeq;
  int? schemaVersion;

  @Enumerated(EnumType.name)
  CallStatusType? callStatus;
  String? callOnSessionKeyId;

  String? currentSessionKeyId;

  // Encryption
  // TODO is publicKey unused ?
  String? publicKey;
  String? privateKey;

  bool? isNewMessageSoundEnable;
  bool? isNewMessageAnimatedEnable;
  String? newMessageSoundMeSelected;
  String? newMessageSoundFriendSelected;
  int? newMessageAnimatedType;
  int? newMessageAnimatedDuration;
  bool? isDeleted;
  int? limitMultipleAccount;

  AccountSettingsModel? accountSettings;
  List<DefaultEmojiItemModel>? uchatDefaultEmojiItems;
  List<DefaultEmojiItemModel>? accountDefaultEmojiItems;
  List<DefaultBookmarkTagItemModel>? uchatDefaultBookmarkEmojiTags;
  List<DefaultBookmarkTagItemModel>? accountDefaultBookmarkEmojiTags;

  List<BookmarkTagModel>? allBookmarkEmojiTags;

  String? appleUserId;
  String? googleUserId;
  String? premiumPackageId;
  DateTime? subscribeAt;
  DateTime? expireAt;

  @Enumerated(EnumType.name)
  PayStoreType? payStore;

  DateTime? nextReview;
  String? appleOrderId;
  String? googleOrderId;

  // Unique key to identify user for in app purchase (user id can't be use because format is not supported in app store / play store)
  String? purchaseRefId;
  PremiumPackageModel? premiumPackage;
  List<AcceptedPlatformDocument>? acceptedPlatformDocument;

  String? firebaseToken;

  UserCollection({
    this.id,
    this.username,
    this.displayName,
    this.birthDate,
    this.email,
    this.hasPassword,
    this.phoneNumber,
    this.originalStatusMessage,
    this.avatarId,
    this.token,
    this.avatarBlurhash,
    this.backgroundId,
    this.backgroundBlurhash,
    this.lastEditUsernameAt,
    this.limitFriend,
    this.friendRequestCount,
    this.roomInvitedIds,
    this.onlineStatus,
    this.isCurrentUser,
    this.isMAHidden = false,
    this.loginAt,
    this.shortcutPasscode,
    this.enabledFeatures,
    this.currentStateSeq,
    this.schemaVersion,
    this.callStatus,
    this.currentSessionKeyId,
    this.callOnSessionKeyId,
    this.publicKey,
    this.privateKey,
    this.isNewMessageSoundEnable,
    this.isNewMessageAnimatedEnable,
    this.newMessageSoundMeSelected,
    this.newMessageSoundFriendSelected,
    this.newMessageAnimatedType,
    this.newMessageAnimatedDuration,
    this.isDeleted,
    this.limitMultipleAccount,
    this.accountSettings,
    this.appleUserId,
    this.googleUserId,
    this.premiumPackageId,
    this.subscribeAt,
    this.expireAt,
    this.payStore,
    this.nextReview,
    this.appleOrderId,
    this.googleOrderId,
    this.purchaseRefId,
    this.premiumPackage,
    this.uchatDefaultEmojiItems,
    this.accountDefaultEmojiItems,
    this.uchatDefaultBookmarkEmojiTags,
    this.accountDefaultBookmarkEmojiTags,
    this.allBookmarkEmojiTags,
    this.acceptedPlatformDocument,
    this.linkAccounts,
    this.firebaseToken,
  });

  factory UserCollection.fromMap(Map<String, dynamic> data) {
    DateTime? lastEditUsernameAt;
    if (data['lastEditUsernameAt'] != null) {
      lastEditUsernameAt = strToDateTime(data['lastEditUsernameAt']);
    }

    final user = UserCollection(
      id: data['id'] ?? data['_id'],
      username: data['username'],
      displayName: data['displayName'],
      birthDate: data['birthDate'],
      email: data['email'],
      hasPassword: data['hasPassword'],
      originalStatusMessage: data['statusMessage'],
      phoneNumber: data['phoneNumber'],
      avatarBlurhash: data['avatarBlurhash'],
      avatarId: data['avatarId'],
      backgroundId: data['backgroundId'],
      backgroundBlurhash: data['backgroundBlurhash'],
      lastEditUsernameAt: lastEditUsernameAt,
      limitFriend: data['limitFriend'],
      friendRequestCount: data['friendRequestCount'],
      isDeleted: data['deleted'],
      limitMultipleAccount: data['limitMultipleAccount'],
      linkAccounts: data['linkAccounts'] != null ? LinkAccountsModel.fromJson(data['linkAccounts']) : null,
      firebaseToken: data['firebaseToken'],
    );

    if (data['purchaseRefId'] != null) {
      user.purchaseRefId = data['purchaseRefId'];
    }

    if (data['premiumPackage'] != null) {
      user.premiumPackage = PremiumPackageModel.fromMap(data['premiumPackage']);
    }

    if (data['acceptPlatformDocument'] != null) {
      user.acceptedPlatformDocument = List<AcceptedPlatformDocument>.from(
        data['acceptPlatformDocument'].map(
          (x) => AcceptedPlatformDocument.fromJson(x),
        ),
      );
    }
    // _log.i(data['roomInvitedIds']);
    if (data['roomInvitedIds'] != null && data['roomInvitedIds'] is List<String>?) {
      user.roomInvitedIds = data['roomInvitedIds'];
    }

    if (data['onlineStatus'] != null) {
      user.onlineStatus = OnlineStatus.from(data['onlineStatus']);
    }

    if (data['features'] != null) {
      user.enabledFeatures = EnabledFeaturesModel.fromMap(
        data['features'],
      );
    }

    if (data['callStatus'] != null) {
      user.callStatus = CallStatusType.from(data['callStatus']);
    }

    if (data['currentSessionKeyId'] != null) {
      user.currentSessionKeyId = data['currentSessionKeyId'];
    }

    if (data['callOnSessionKeyId'] != null) {
      user.callOnSessionKeyId = data['callOnSessionKeyId'];
    }

    if (data['publicKey'] != null) {
      if (data['publicKey'] is Map<String, dynamic>) {
        user.publicKey = json.encode(data['publicKey']);
      } else {
        user.publicKey = data['publicKey'].toString();
      }
    }

    if (data['privateKey'] != null) {
      if (data['privateKey'] is Map<String, dynamic>) {
        user.privateKey = json.encode(data['privateKey']);
      } else {
        user.privateKey = data['privateKey'].toString();
      }
    }

    if (data['settings'] != null) {
      user.accountSettings = AccountSettingsModel.fromMap(
        data['settings'],
      );
    }

    if (data['uchatDefaultEmojiItems'] != null) {
      user.uchatDefaultEmojiItems = List<DefaultEmojiItemModel>.from(
        data['uchatDefaultEmojiItems'].map(
          (x) => DefaultEmojiItemModel.fromMap(x),
        ),
      );
    }

    if (data['accountDefaultEmojiItems'] != null) {
      user.accountDefaultEmojiItems = List<DefaultEmojiItemModel>.from(
        data['accountDefaultEmojiItems'].map(
          (x) => DefaultEmojiItemModel.fromMap(x),
        ),
      );
    }

    if (data['uchatDefaultBookmarkEmojiTags'] != null) {
      user.uchatDefaultBookmarkEmojiTags = List<DefaultBookmarkTagItemModel>.from(
        data['uchatDefaultBookmarkEmojiTags'].map(
          (x) => DefaultBookmarkTagItemModel.fromMap(x),
        ),
      );
    }

    if (data['accountDefaultBookmarkEmojiTags'] != null) {
      user.accountDefaultBookmarkEmojiTags = List<DefaultBookmarkTagItemModel>.from(
        data['accountDefaultBookmarkEmojiTags'].map(
          (x) => DefaultBookmarkTagItemModel.fromMap(x),
        ),
      );
    }

    if (data['allBookmarkEmojiTags'] != null) {
      user.allBookmarkEmojiTags = List<BookmarkTagModel>.from(
        (data['allBookmarkEmojiTags'] as List).map(
          (x) => BookmarkTagModel.fromMap(x as Map<String, dynamic>),
        ),
      );
    }

    return user;
  }

  void update(UserCollection user, {bool forceUpdateStatus = false}) {
    if (user.id != null) id = user.id;
    if (user.username != null) username = user.username;
    if (user.displayName != null) displayName = user.displayName;
    if (user.birthDate != null) birthDate = user.birthDate;
    if (user.email != null) email = user.email;
    if (user.hasPassword != null) hasPassword = user.hasPassword;
    if (user.phoneNumber != null) phoneNumber = user.phoneNumber;
    if (user.avatarBlurhash != null) avatarBlurhash = user.avatarBlurhash;
    if (user.avatarId != null) avatarId = user.avatarId;
    if (user.backgroundId != null) backgroundId = user.backgroundId;
    if (user.backgroundBlurhash != null) backgroundBlurhash = user.backgroundBlurhash;
    if (user.lastEditUsernameAt != null) lastEditUsernameAt = user.lastEditUsernameAt;
    if (user.limitFriend != null) limitFriend = user.limitFriend;
    if (user.friendRequestCount != null) friendRequestCount = user.friendRequestCount;
    if (user.roomInvitedIds != null) roomInvitedIds = user.roomInvitedIds;
    if (user.onlineStatus != null) onlineStatus = user.onlineStatus;
    if (user.enabledFeatures != null) enabledFeatures = user.enabledFeatures;
    if (user.callStatus != null) callStatus = user.callStatus;
    if (user.currentSessionKeyId != null) currentSessionKeyId = user.currentSessionKeyId;
    if (user.callOnSessionKeyId != null) callOnSessionKeyId = user.callOnSessionKeyId;
    if (user.publicKey != null) publicKey = user.publicKey;
    if (user.privateKey != null) privateKey = user.privateKey;
    if (user.isNewMessageSoundEnable != null) isNewMessageSoundEnable = user.isNewMessageSoundEnable;
    if (user.isNewMessageAnimatedEnable != null) isNewMessageAnimatedEnable = user.isNewMessageAnimatedEnable;
    if (user.newMessageSoundMeSelected != null) newMessageSoundMeSelected = user.newMessageSoundMeSelected;
    if (user.newMessageSoundFriendSelected != null) newMessageSoundFriendSelected = user.newMessageSoundFriendSelected;
    if (user.newMessageAnimatedType != null) newMessageAnimatedType = user.newMessageAnimatedType;
    if (user.newMessageAnimatedDuration != null) newMessageAnimatedDuration = user.newMessageAnimatedDuration;
    if (user.isDeleted != null) isDeleted = user.isDeleted;
    if (user.limitMultipleAccount != null) limitMultipleAccount = user.limitMultipleAccount;
    if (user.accountSettings != null) accountSettings = user.accountSettings;
    if (user.purchaseRefId != null) purchaseRefId = user.purchaseRefId;
    if (user.premiumPackage != null) premiumPackage = user.premiumPackage;
    if (user.uchatDefaultEmojiItems != null) uchatDefaultEmojiItems = user.uchatDefaultEmojiItems;
    if (user.accountDefaultEmojiItems != null) accountDefaultEmojiItems = user.accountDefaultEmojiItems;
    if (user.uchatDefaultBookmarkEmojiTags != null) uchatDefaultBookmarkEmojiTags = user.uchatDefaultBookmarkEmojiTags;
    if (user.accountDefaultBookmarkEmojiTags != null) {
      accountDefaultBookmarkEmojiTags = user.accountDefaultBookmarkEmojiTags;
    }
    if (user.allBookmarkEmojiTags != null) allBookmarkEmojiTags = user.allBookmarkEmojiTags;
    if (user.acceptedPlatformDocument != null) acceptedPlatformDocument = user.acceptedPlatformDocument;
    if (user.linkAccounts != null) linkAccounts = user.linkAccounts;
    if (user.firebaseToken != null) firebaseToken = user.firebaseToken;

    // for status message, we need to allow empty string to overwrite
    originalStatusMessage = user.originalStatusMessage;
  }

  DateTime? get dBirthdate {
    if (birthDate != null) {
      return DateTime.tryParse(birthDate!);
    }
    return null;
  }

  ContactModel toContact() {
    final contact = ContactModel(
      id: id,
      displayName: displayName,
      birthDate: birthDate,
      email: email,
      username: username,
      avatarId: avatarId,
      backgroundId: backgroundId,
      backgroundBlurhash: backgroundBlurhash,
      isDeleted: isDeleted,
    );

    contact.statusMessage = statusMessage;

    return contact;
  }

  @override
  String toString() {
    return '[UserCollection]\n'
        'UserID: $id\n'
        'UserName: $username\n'
        'DisplayName: $displayName\n'
        'birthDate: $birthDate\n\n'
        'email: $email\n\n'
        'EnabledFeatures: $enabledFeatures';
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      displayName: displayName,
      birthDate: birthDate,
      email: email,
      hasPassword: hasPassword,
      avatarId: avatarId,
      originalStatusMessage: originalStatusMessage,
      onlineStatus: onlineStatus,
      isCurrentUser: isCurrentUser,
      phoneNumber: phoneNumber,
      backgroundId: backgroundId,
      backgroundBlurhash: backgroundBlurhash,
      lastEditUsernameAt: lastEditUsernameAt,
      limitFriend: limitFriend,
      friendRequestCount: friendRequestCount,
      roomInvitedIds: roomInvitedIds,
      isMAHidden: isMAHidden,
      loginAt: loginAt,
      shortcutPasscode: shortcutPasscode,
      enabledFeatures: enabledFeatures,
      currentStateSeq: currentStateSeq,
      schemaVersion: schemaVersion,
      callStatus: callStatus,
      callOnSessionKeyId: callOnSessionKeyId,
      currentSessionKeyId: currentSessionKeyId,
      publicKey: publicKey,
      privateKey: privateKey,
      isNewMessageSoundEnable: isNewMessageSoundEnable,
      isNewMessageAnimatedEnable: isNewMessageAnimatedEnable,
      newMessageSoundMeSelected: newMessageSoundMeSelected,
      newMessageSoundFriendSelected: newMessageSoundFriendSelected,
      newMessageAnimatedType: newMessageAnimatedType,
      newMessageAnimatedDuration: newMessageAnimatedDuration,
      isDeleted: isDeleted,
      limitMultipleAccount: limitMultipleAccount,
      accountSettings: accountSettings,
      uchatDefaultEmojiItems: uchatDefaultEmojiItems,
      accountDefaultEmojiItems: accountDefaultEmojiItems,
      uchatDefaultBookmarkEmojiTags: uchatDefaultBookmarkEmojiTags,
      accountDefaultBookmarkEmojiTags: accountDefaultBookmarkEmojiTags,
      allBookmarkEmojiTags: allBookmarkEmojiTags,
      appleUserId: appleUserId,
      googleUserId: googleUserId,
      premiumPackageId: premiumPackageId,
      subscribeAt: subscribeAt,
      expireAt: expireAt,
      payStore: payStore,
      nextReview: nextReview,
      appleOrderId: appleOrderId,
      googleOrderId: googleOrderId,
      purchaseRefId: purchaseRefId,
      premiumPackage: premiumPackage,
      token: token,
      acceptedPlatformDocument: acceptedPlatformDocument,
      linkAccounts: linkAccounts,
      firebaseToken: firebaseToken,
    );
  }

  static UserCollection fromEntity(UserEntity entity) {
    return UserCollection(
      id: entity.id,
      username: entity.username,
      displayName: entity.displayName,
      birthDate: entity.birthDate,
      email: entity.email,
      hasPassword: entity.hasPassword,
      avatarId: entity.avatarId,
      originalStatusMessage: entity.originalStatusMessage,
      onlineStatus: entity.onlineStatus,
      isCurrentUser: entity.isCurrentUser,
      phoneNumber: entity.phoneNumber,
      backgroundId: entity.backgroundId,
      backgroundBlurhash: entity.backgroundBlurhash,
      lastEditUsernameAt: entity.lastEditUsernameAt,
      limitFriend: entity.limitFriend,
      friendRequestCount: entity.friendRequestCount,
      roomInvitedIds: entity.roomInvitedIds,
      isMAHidden: entity.isMAHidden,
      loginAt: entity.loginAt,
      shortcutPasscode: entity.shortcutPasscode,
      enabledFeatures: entity.enabledFeatures,
      currentStateSeq: entity.currentStateSeq,
      schemaVersion: entity.schemaVersion,
      callStatus: entity.callStatus,
      callOnSessionKeyId: entity.callOnSessionKeyId,
      currentSessionKeyId: entity.currentSessionKeyId,
      publicKey: entity.publicKey,
      privateKey: entity.privateKey,
      isNewMessageSoundEnable: entity.isNewMessageSoundEnable,
      isNewMessageAnimatedEnable: entity.isNewMessageAnimatedEnable,
      newMessageSoundMeSelected: entity.newMessageSoundMeSelected,
      newMessageSoundFriendSelected: entity.newMessageSoundFriendSelected,
      newMessageAnimatedType: entity.newMessageAnimatedType,
      newMessageAnimatedDuration: entity.newMessageAnimatedDuration,
      isDeleted: entity.isDeleted,
      limitMultipleAccount: entity.limitMultipleAccount,
      accountSettings: entity.accountSettings,
      uchatDefaultEmojiItems: entity.uchatDefaultEmojiItems,
      accountDefaultEmojiItems: entity.accountDefaultEmojiItems,
      uchatDefaultBookmarkEmojiTags: entity.uchatDefaultBookmarkEmojiTags,
      accountDefaultBookmarkEmojiTags: entity.accountDefaultBookmarkEmojiTags,
      allBookmarkEmojiTags: entity.allBookmarkEmojiTags,
      appleUserId: entity.appleUserId,
      googleUserId: entity.googleUserId,
      premiumPackageId: entity.premiumPackageId,
      subscribeAt: entity.subscribeAt,
      expireAt: entity.expireAt,
      payStore: entity.payStore,
      nextReview: entity.nextReview,
      appleOrderId: entity.appleOrderId,
      googleOrderId: entity.googleOrderId,
      purchaseRefId: entity.purchaseRefId,
      premiumPackage: entity.premiumPackage,
      acceptedPlatformDocument: entity.acceptedPlatformDocument,
      linkAccounts: entity.linkAccounts,
      token: entity.token,
      firebaseToken: entity.firebaseToken,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;
}
