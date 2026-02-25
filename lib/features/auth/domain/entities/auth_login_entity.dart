import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/entities/models/default_bookmark_tag_item_model.dart';
import 'package:uchat/entities/models/default_emoji_item_model.dart';
import 'package:uchat/entities/models/enabled_features_model.dart';
import 'package:uchat/entities/models/link_accounts_model.dart';
import 'package:uchat/entities/models/premium_package_model.dart';

class AuthLoginEntity {
  final bool? success;
  final String? token;
  final String? id;
  final String? displayName;
  final String? birthDate;
  final String? email;
  final bool? hasPassword;
  final String? statusMessage;
  final String? username;
  final String? phoneNumber;
  final String? avatarId;
  final String? avatarBlurhash;
  final String? background;
  final String? backgroundId;
  final String? backgroundBlurhash;
  final DateTime? lastEditUsernameAt;
  final int? limitFriend;
  final int? friendRequestCount;

  // TODO: create entity
  final EnabledFeaturesModel? enabledFeatures;
  final String? currentSessionKeyId;

  // TODO: create entity
  final OnlineStatus? onlineStatus;
  final int? limitMultipleAccount;
  final int? maxChatFolder;
  final int? maxRoomInChatFolder;

  // TODO: create entity
  final AccountSettingsModel? accountSettings;
  final String? purchaseRefId;

  // TODO: create entity
  final PremiumPackageModel? premiumPackage;

  // TODO: create entity
  final List<DefaultEmojiItemModel>? uchatDefaultEmojiItems;
  final List<DefaultEmojiItemModel>? accountDefaultEmojiItems;

  // TODO: create entity
  final List<DefaultBookmarkTagItemModel>? uchatDefaultBookmarkEmojiTags;
  final List<DefaultBookmarkTagItemModel>? accountDefaultBookmarkEmojiTags;

  // TODO: create entity
  final LinkAccountsModel? linkAccounts;
  final bool? isDeleted;
  final String? firebaseToken;

  const AuthLoginEntity({
    this.success,
    this.token,
    this.id,
    this.displayName,
    this.birthDate,
    this.email,
    this.hasPassword,
    this.statusMessage,
    this.username,
    this.phoneNumber,
    this.avatarId,
    this.avatarBlurhash,
    this.background,
    this.backgroundId,
    this.backgroundBlurhash,
    this.lastEditUsernameAt,
    this.limitFriend,
    this.friendRequestCount,
    this.enabledFeatures,
    this.currentSessionKeyId,
    this.onlineStatus,
    this.limitMultipleAccount,
    this.maxChatFolder,
    this.maxRoomInChatFolder,
    this.accountSettings,
    this.purchaseRefId,
    this.premiumPackage,
    this.uchatDefaultEmojiItems,
    this.accountDefaultEmojiItems,
    this.uchatDefaultBookmarkEmojiTags,
    this.accountDefaultBookmarkEmojiTags,
    this.linkAccounts,
    this.isDeleted,
    this.firebaseToken,
  });

  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      token: token,
      username: username,
      displayName: displayName,
      birthDate: birthDate,
      email: email,
      hasPassword: hasPassword,
      originalStatusMessage: statusMessage,
      phoneNumber: phoneNumber,
      avatarBlurhash: avatarBlurhash,
      avatarId: avatarId,
      backgroundId: backgroundId,
      backgroundBlurhash: backgroundBlurhash,
      lastEditUsernameAt: lastEditUsernameAt,
      limitFriend: limitFriend,
      friendRequestCount: friendRequestCount,
      enabledFeatures: enabledFeatures,
      currentSessionKeyId: currentSessionKeyId,
      onlineStatus: onlineStatus,
      limitMultipleAccount: limitMultipleAccount,
      accountSettings: accountSettings,
      purchaseRefId: purchaseRefId,
      premiumPackage: premiumPackage,
      uchatDefaultEmojiItems: uchatDefaultEmojiItems,
      accountDefaultEmojiItems: accountDefaultEmojiItems,
      uchatDefaultBookmarkEmojiTags: uchatDefaultBookmarkEmojiTags,
      accountDefaultBookmarkEmojiTags: accountDefaultBookmarkEmojiTags,
      linkAccounts: linkAccounts,
      isDeleted: isDeleted,
      firebaseToken: firebaseToken,
    );
  }
}
