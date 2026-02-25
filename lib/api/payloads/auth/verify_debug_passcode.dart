import 'package:uchat/api/api.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/default_bookmark_tag_item_model.dart';
import 'package:uchat/entities/models/default_emoji_item_model.dart';
import 'package:uchat/entities/models/link_accounts_model.dart';
import 'package:uchat/utils/datetime.dart';

class VerifyDebugPasscodeRequest {
  String passcode;
  bool? force;

  VerifyDebugPasscodeRequest({
    required this.passcode,
    this.force,
  });

  Map<String, dynamic> toMap() {
    return {'passcode': passcode, 'force': force};
  }
}

class VerifyDebugPasscodeResponse with ToUserModel implements UserResponse {
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

  VerifyDebugPasscodeResponse({
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
  });

  factory VerifyDebugPasscodeResponse.fromMap(Map<String, dynamic> json) {
    Map<String, dynamic> account = json['account'];

    return VerifyDebugPasscodeResponse(
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
      purchaseRefId: json['account']?['purchaseRefId'],
      premiumPackage: json['account']?['premiumPackage'] != null
          ? PremiumPackageModel.fromMap(json['account']?['premiumPackage'])
          : null,
      uchatDefaultEmojiItems: account['uchatDefaultEmojiItems'] != null
          ? List<DefaultEmojiItemModel>.from(
              account['uchatDefaultEmojiItems'].map((x) => DefaultEmojiItemModel.fromMap(x)))
          : null,
      accountDefaultEmojiItems: account['accountDefaultEmojiItems'] != null
          ? List<DefaultEmojiItemModel>.from(
              account['accountDefaultEmojiItems'].map((x) => DefaultEmojiItemModel.fromMap(x)))
          : null,
      uchatDefaultBookmarkEmojiTags: account['uchatDefaultBookmarkEmojiTags'] != null
          ? List<DefaultBookmarkTagItemModel>.from(
              account['uchatDefaultBookmarkEmojiTags'].map((x) => DefaultBookmarkTagItemModel.fromMap(x)))
          : null,
      accountDefaultBookmarkEmojiTags: account['accountDefaultBookmarkEmojiTags'] != null
          ? List<DefaultBookmarkTagItemModel>.from(
              account['accountDefaultBookmarkEmojiTags'].map((x) => DefaultBookmarkTagItemModel.fromMap(x)))
          : null,
      linkAccounts: account['linkAccounts'] != null ? LinkAccountsModel.fromJson(account['linkAccounts']) : null,
      isDeleted: account['deleted'],
    );
  }
}
