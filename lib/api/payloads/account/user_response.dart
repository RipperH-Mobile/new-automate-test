import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/entities/models/default_bookmark_tag_item_model.dart';
import 'package:uchat/entities/models/default_emoji_item_model.dart';
import 'package:uchat/entities/models/enabled_features_model.dart';
import 'package:uchat/entities/models/link_accounts_model.dart';
import 'package:uchat/entities/models/premium_package_model.dart';
import 'package:uchat/utils/datetime.dart';

class UserResponse with ToUserModel implements UserResponseAbstract {
  @override
  String? avatarBlurhash;

  @override
  String? avatarId;

  @override
  String? background;

  @override
  String? backgroundBlurhash;

  @override
  String? backgroundId;

  @override
  String? displayName;

  @override
  String? birthDate;

  @override
  String? email;

  @override
  bool? hasPassword;

  @override
  int? friendRequestCount;

  @override
  String? id;

  @override
  DateTime? lastEditUsernameAt;

  @override
  int? limitFriend;

  @override
  String? phoneNumber;

  @override
  String? statusMessage;

  @override
  String? username;

  @override
  EnabledFeaturesModel? enabledFeatures;

  @override
  String? currentSessionKeyId;

  @override
  OnlineStatus? onlineStatus;

  @override
  int? limitMultipleAccount;

  @override
  @Deprecated('use in `enabledFeatures -> chatFolderV2` instead')
  int? maxChatFolder;

  @override
  @Deprecated('use in `enabledFeatures -> chatFolderV2` instead')
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

  UserResponse({
    this.id,
    this.displayName,
    this.birthDate,
    this.email,
    this.hasPassword,
    this.statusMessage,
    this.username,
    this.phoneNumber,
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
  });

  static UserResponse fromMap(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    var user = UserResponse(
      id: json['_id'],
      displayName: json['displayName'],
      birthDate: json['birthDate'],
      email: json['email'],
      hasPassword: json['hasPassword'],
      statusMessage: json['statusMessage'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      avatarId: json['avatarId'] ?? '',
      avatarBlurhash: json['avatarBlurhash'] ?? '',
      lastEditUsernameAt: json['lastEditUsernameAt'] != null ? strToDateTime(json['lastEditUsernameAt']) : null,
      limitFriend: json['limitFriend'] ?? 0,
      friendRequestCount: json['friendRequestCount'] ?? 0,
      currentSessionKeyId: json['currentSessionKeyId'],
      onlineStatus: OnlineStatus.from(json['onlineStatus']),
      limitMultipleAccount: json['limitMultipleAccount'],
      maxChatFolder: json['maxChatFolder'],
      maxRoomInChatFolder: json['maxRoomInChatFolder'],
      enabledFeatures: json['features'] != null ? EnabledFeaturesModel.fromMap(json['features']) : null,
      accountSettings: json['settings'] != null ? AccountSettingsModel.fromMap(json['settings']) : null,
      purchaseRefId: json['purchaseRefId'],
      uchatDefaultEmojiItems: json['uchatDefaultEmojiItems'] != null
          ? List<DefaultEmojiItemModel>.from(
              json['uchatDefaultEmojiItems'].map((data) => DefaultEmojiItemModel.fromMap(data)))
          : null,
      accountDefaultEmojiItems: json['accountDefaultEmojiItems'] != null
          ? List<DefaultEmojiItemModel>.from(
              json['accountDefaultEmojiItems'].map((data) => DefaultEmojiItemModel.fromMap(data)))
          : null,
      uchatDefaultBookmarkEmojiTags: json['uchatDefaultBookmarkEmojiTags'] != null
          ? List<DefaultBookmarkTagItemModel>.from(
              json['uchatDefaultBookmarkEmojiTags'].map((data) => DefaultBookmarkTagItemModel.fromMap(data)))
          : null,
      accountDefaultBookmarkEmojiTags: json['accountDefaultBookmarkEmojiTags'] != null
          ? List<DefaultBookmarkTagItemModel>.from(
              json['accountDefaultBookmarkEmojiTags'].map((data) => DefaultBookmarkTagItemModel.fromMap(data)))
          : null,
      linkAccounts: json['linkAccounts'] != null ? LinkAccountsModel.fromJson(json['linkAccounts']) : null,
      isDeleted: json['deleted'],
    );

    Map<String, dynamic>? account = data['account'];
    if (account != null) {
      user
        ..id = account['_id']
        ..displayName = account['displayName']
        ..birthDate = account['birthDate']
        ..email = account['email']
        ..hasPassword = account['hasPassword']
        ..username = account['username']
        ..statusMessage = account['statusMessage'] ?? user.statusMessage
        ..avatarId = account['avatarId']
        ..avatarBlurhash = account['avatarBlurhash'] ?? user.avatarBlurhash
        ..phoneNumber = account['phoneNumber'] ?? user.phoneNumber
        ..background = account['background'] ?? user.background
        ..backgroundId = account['backgroundId'] ?? user.backgroundId
        ..backgroundBlurhash = account['backgroundBlurhash'] ?? user.backgroundBlurhash
        ..limitFriend = account['limitFriend'] ?? 100
        ..friendRequestCount = account['friendRequestCount'] ?? 0
        ..currentSessionKeyId = account['currentSessionKeyId']
        ..onlineStatus = OnlineStatus.from(account['onlineStatus'])
        ..onlineStatus = OnlineStatus.from(account['onlineStatus'])
        ..limitMultipleAccount = account['limitMultipleAccount']
        ..maxChatFolder = account['maxChatFolder']
        ..maxRoomInChatFolder = account['maxRoomInChatFolder']
        ..purchaseRefId = account['purchaseRefId']
        ..uchatDefaultEmojiItems = account['uchatDefaultEmojiItems'] != null
            ? List<DefaultEmojiItemModel>.from(
                account['uchatDefaultEmojiItems'].map((data) => DefaultEmojiItemModel.fromMap(data)))
            : null
        ..accountDefaultEmojiItems = account['accountDefaultEmojiItems'] != null
            ? List<DefaultEmojiItemModel>.from(
                account['accountDefaultEmojiItems'].map((data) => DefaultEmojiItemModel.fromMap(data)))
            : null
        ..uchatDefaultBookmarkEmojiTags = account['uchatDefaultBookmarkEmojiTags'] != null
            ? List<DefaultBookmarkTagItemModel>.from(
                account['uchatDefaultBookmarkEmojiTags'].map((data) => DefaultBookmarkTagItemModel.fromMap(data)))
            : null
        ..accountDefaultBookmarkEmojiTags = account['accountDefaultBookmarkEmojiTags'] != null
            ? List<DefaultBookmarkTagItemModel>.from(
                account['accountDefaultBookmarkEmojiTags'].map((data) => DefaultBookmarkTagItemModel.fromMap(data)))
            : null
        ..linkAccounts = account['linkAccounts'] != null ? LinkAccountsModel.fromJson(account['linkAccounts']) : null
        ..isDeleted = account['deleted'];

      if (account['lastEditUsernameAt'] != null) {
        user.lastEditUsernameAt = strToDateTime(account['lastEditUsernameAt']);
      }

      if (account['features'] != null) {
        user.enabledFeatures = EnabledFeaturesModel.fromMap(account['features']);
      }

      if (account['settings'] != null) {
        user.accountSettings = AccountSettingsModel.fromMap(account['settings']);
      }

      if (account['premiumPackage'] != null) {
        user.premiumPackage = PremiumPackageModel.fromMap(account['premiumPackage']);
      }
    }
    return user;
  }
}

abstract class UserResponseAbstract {
  String? id;
  String? displayName;
  String? birthDate;
  String? email;
  bool? hasPassword;
  String? statusMessage;
  String? username;
  String? phoneNumber;
  String? avatarId;
  String? avatarBlurhash;
  String? background;
  String? backgroundId;
  String? backgroundBlurhash;
  DateTime? lastEditUsernameAt;
  int? limitFriend;
  int? friendRequestCount;
  EnabledFeaturesModel? enabledFeatures;
  String? currentSessionKeyId;
  OnlineStatus? onlineStatus;
  int? limitMultipleAccount;
  int? maxChatFolder;
  int? maxRoomInChatFolder;
  AccountSettingsModel? accountSettings;
  String? purchaseRefId;
  PremiumPackageModel? premiumPackage;
  List<DefaultEmojiItemModel>? uchatDefaultEmojiItems;
  List<DefaultEmojiItemModel>? accountDefaultEmojiItems;
  List<DefaultBookmarkTagItemModel>? uchatDefaultBookmarkEmojiTags;
  List<DefaultBookmarkTagItemModel>? accountDefaultBookmarkEmojiTags;
  LinkAccountsModel? linkAccounts;
  bool? isDeleted;
}

mixin ToUserModel implements UserResponseAbstract {
  UserCollection toUserCollection() {
    return UserCollection(
      id: id,
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
    );
  }

  @override
  String toString() {
    return 'SID: $currentSessionKeyId,\n'
        'UserID: $id,\n'
        'UserName: $username,\n'
        'DisplayName: $displayName, \n'
        'birthDate: $birthDate';
  }
}
