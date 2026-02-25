import 'package:uchat/api/payloads/account/user_response.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/entities/models/default_bookmark_tag_item_model.dart';
import 'package:uchat/entities/models/default_emoji_item_model.dart';
import 'package:uchat/entities/models/enabled_features_model.dart';
import 'package:uchat/entities/models/link_accounts_model.dart';
import 'package:uchat/entities/models/premium_package_model.dart';
import 'package:uchat/features/auth/domain/entities/auth_login_entity.dart';
import 'package:uchat/utils/datetime.dart';

// TODO: change to immutable class
class AuthLoginResponse with ToUserModel implements UserResponse {
  bool? success;
  @override
  String? id;
  @override
  String? displayName;
  @override
  String? birthDate;
  @override
  String? email;
  @override
  bool? hasPassword;
  @override
  String? statusMessage;
  @override
  String? username;
  @override
  String? phoneNumber;
  String? token;
  @override
  String? avatarId;
  @override
  String? avatarBlurhash;
  @override
  String? background;
  @override
  String? backgroundId;
  @override
  String? backgroundBlurhash;
  @override
  DateTime? lastEditUsernameAt;
  @override
  int? limitFriend;
  @override
  int? friendRequestCount;
  @override
  EnabledFeaturesModel? enabledFeatures;
  @override
  String? currentSessionKeyId;
  @override
  OnlineStatus? onlineStatus;
  @override
  int? limitMultipleAccount;

  @override
  int? maxChatFolder;
  @override
  int? maxRoomInChatFolder;

  @override
  AccountSettingsModel? accountSettings;
  @override
  String? purchaseRefId;
  @override
  PremiumPackageModel? premiumPackage;

  @override
  List<DefaultEmojiItemModel>? uchatDefaultEmojiItems;

  @override
  List<DefaultEmojiItemModel>? accountDefaultEmojiItems;

  @override
  List<DefaultBookmarkTagItemModel>? uchatDefaultBookmarkEmojiTags;

  @override
  List<DefaultBookmarkTagItemModel>? accountDefaultBookmarkEmojiTags;

  @override
  LinkAccountsModel? linkAccounts;

  @override
  bool? isDeleted;

  String? firebaseToken;

  AuthLoginResponse({
    this.success,
    this.id,
    this.displayName,
    this.birthDate,
    this.email,
    this.hasPassword,
    this.statusMessage,
    this.username,
    this.phoneNumber,
    this.token,
    this.avatarBlurhash,
    this.avatarId,
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

  factory AuthLoginResponse.fromMap(Map<String, dynamic> json) {
    Map<String, dynamic> account = json['account'];

    return AuthLoginResponse(
      success: json['success'],
      id: account['_id'],
      displayName: account['displayName'],
      birthDate: account['birthDate'],
      email: account['email'],
      hasPassword: account['hasPassword'],
      statusMessage: account['statusMessage'],
      username: account['username'],
      phoneNumber: account['phoneNumber'],
      token: json['token'],
      avatarId: account['avatarId'] ?? '',
      avatarBlurhash: account['avatarBlurhash'] ?? '',
      background: account['background'],
      backgroundId: account['backgroundId'],
      backgroundBlurhash: account['backgroundBlurhash'],
      lastEditUsernameAt: json['lastEditUsernameAt'] != null ? strToDateTime(json['lastEditUsernameAt']) : null,
      limitFriend: account['limitFriend'] ?? 100,
      friendRequestCount: account['friendRequestCount'] ?? 0,
      currentSessionKeyId: account['currentSessionKeyId'],
      enabledFeatures: EnabledFeaturesModel.fromMap(account['features'] ?? {}),
      onlineStatus: OnlineStatus.from(account['onlineStatus']),
      limitMultipleAccount: account['limitMultipleAccount'],
      maxChatFolder: account['maxChatFolder'],
      maxRoomInChatFolder: account['maxRoomInChatFolder'],
      accountSettings: AccountSettingsModel.fromMap(account['settings'] ?? {}),
      purchaseRefId: account['purchaseRefId'],
      premiumPackage: account['premiumPackage'] != null ? PremiumPackageModel.fromMap(account['premiumPackage']) : null,
      uchatDefaultEmojiItems: account['uchatDefaultEmojiItems'] != null
          ? List<DefaultEmojiItemModel>.from(
        account['uchatDefaultEmojiItems'].map((x) => DefaultEmojiItemModel.fromMap(x)),
      )
          : null,
      accountDefaultEmojiItems: account['accountDefaultEmojiItems'] != null
          ? List<DefaultEmojiItemModel>.from(
        account['accountDefaultEmojiItems'].map((x) => DefaultEmojiItemModel.fromMap(x)),
      )
          : null,
      uchatDefaultBookmarkEmojiTags: account['uchatDefaultBookmarkEmojiTags'] != null
          ? List<DefaultBookmarkTagItemModel>.from(
        account['uchatDefaultBookmarkEmojiTags'].map((x) => DefaultBookmarkTagItemModel.fromMap(x)),
      )
          : null,
      accountDefaultBookmarkEmojiTags: account['accountDefaultBookmarkEmojiTags'] != null
          ? List<DefaultBookmarkTagItemModel>.from(
        account['accountDefaultBookmarkEmojiTags'].map((x) => DefaultBookmarkTagItemModel.fromMap(x)),
      )
          : null,
      linkAccounts: account['linkAccounts'] != null ? LinkAccountsModel.fromJson(account['linkAccounts']) : null,
      isDeleted: account['deleted'],
      firebaseToken: json['firebaseToken'],
    );
  }

  // from entity
  factory AuthLoginResponse.fromEntity(AuthLoginEntity entity) {
    return AuthLoginResponse(
      success: entity.success,
      id: entity.id,
      displayName: entity.displayName,
      birthDate: entity.birthDate,
      email: entity.email,
      hasPassword: entity.hasPassword,
      statusMessage: entity.statusMessage,
      username: entity.username,
      phoneNumber: entity.phoneNumber,
      token: entity.token,
      avatarId: entity.avatarId,
      avatarBlurhash: entity.avatarBlurhash,
      background: entity.background,
      backgroundId: entity.backgroundId,
      backgroundBlurhash: entity.backgroundBlurhash,
      lastEditUsernameAt: entity.lastEditUsernameAt,
      limitFriend: entity.limitFriend ?? 100,
      friendRequestCount: entity.friendRequestCount ?? 0,
      enabledFeatures: entity.enabledFeatures,
      currentSessionKeyId: entity.currentSessionKeyId,
      onlineStatus: entity.onlineStatus,
      limitMultipleAccount: entity.limitMultipleAccount,
      maxChatFolder: entity.maxChatFolder,
      maxRoomInChatFolder: entity.maxRoomInChatFolder,
      accountSettings: entity.accountSettings,
      purchaseRefId: entity.purchaseRefId,
      premiumPackage: entity.premiumPackage,
      uchatDefaultEmojiItems: entity.uchatDefaultEmojiItems,
      accountDefaultBookmarkEmojiTags: entity.accountDefaultBookmarkEmojiTags,
      uchatDefaultBookmarkEmojiTags: entity.uchatDefaultBookmarkEmojiTags,
      accountDefaultEmojiItems: entity.accountDefaultEmojiItems,
      isDeleted: entity.isDeleted,
      linkAccounts: entity.linkAccounts,
      firebaseToken: entity.firebaseToken,
    );
  }

  @override
  UserCollection toUserCollection() {
    final user = super.toUserCollection();
    user.token = token;
    user.firebaseToken = firebaseToken;
    return user;
  }

  AuthLoginEntity toEntity() {
    return AuthLoginEntity(
      success: success,
      token: token,
      id: id,
      displayName: displayName,
      birthDate: birthDate,
      email: email,
      hasPassword: hasPassword,
      statusMessage: statusMessage,
      username: username,
      phoneNumber: phoneNumber,
      avatarId: avatarId,
      avatarBlurhash: avatarBlurhash,
      background: background,
      backgroundId: backgroundId,
      backgroundBlurhash: backgroundBlurhash,
      lastEditUsernameAt: lastEditUsernameAt,
      limitFriend: limitFriend,
      friendRequestCount: friendRequestCount,
      enabledFeatures: enabledFeatures,
      currentSessionKeyId: currentSessionKeyId,
      onlineStatus: onlineStatus,
      limitMultipleAccount: limitMultipleAccount,
      maxChatFolder: maxChatFolder,
      maxRoomInChatFolder: maxRoomInChatFolder,
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
