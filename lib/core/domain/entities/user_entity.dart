import 'package:characters/characters.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/entities/enum/call_status_type.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/enum/pay_store_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/default_bookmark_tag_item_model.dart';
import 'package:uchat/entities/models/default_emoji_item_model.dart';
import 'package:uchat/entities/models/link_accounts_model.dart';
import 'package:uchat/features/auth/data/models/accepted_platform_document.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/app_env.dart';

class UserEntity {
  final String? id;
  final String? username;
  final String? displayName;
  final String? birthDate;
  final String? email;
  final bool? hasPassword;
  final String? avatarId;
  final String? originalStatusMessage;
  final OnlineStatus? onlineStatus;
  final bool? isCurrentUser;
  final String? phoneNumber;
  final String? backgroundId;
  final String? backgroundBlurhash;
  final String? token;
  final String? avatarBlurhash;
  final DateTime? lastEditUsernameAt;
  final int? limitFriend;
  final int? friendRequestCount;
  final List<String>? roomInvitedIds;

  /// Whether this user is hidden from multiple account screen
  final bool? isMAHidden;

  // DateTime when user login, used to for sorting in accounts center.
  final DateTime? loginAt;
  final String? shortcutPasscode;
  final EnabledFeaturesModel? enabledFeatures;

  final int? currentStateSeq;
  final int? schemaVersion;

  final CallStatusType? callStatus;
  final String? callOnSessionKeyId;

  final String? currentSessionKeyId;

  // Encryption
  // TODO is publicKey unused ?
  final String? publicKey;
  final String? privateKey;

  final bool? isNewMessageSoundEnable;
  final bool? isNewMessageAnimatedEnable;
  final String? newMessageSoundMeSelected;
  final String? newMessageSoundFriendSelected;
  final int? newMessageAnimatedType;
  final int? newMessageAnimatedDuration;
  final bool? isDeleted;
  final int? limitMultipleAccount;

  final AccountSettingsModel? accountSettings;
  final List<DefaultEmojiItemModel>? uchatDefaultEmojiItems;
  final List<DefaultEmojiItemModel>? accountDefaultEmojiItems;
  final List<DefaultBookmarkTagItemModel>? uchatDefaultBookmarkEmojiTags;
  final List<DefaultBookmarkTagItemModel>? accountDefaultBookmarkEmojiTags;

  final List<BookmarkTagModel>? allBookmarkEmojiTags;

  final String? appleUserId;
  final String? googleUserId;
  final String? premiumPackageId;
  final DateTime? subscribeAt;
  final DateTime? expireAt;

  final PayStoreType? payStore;

  final DateTime? nextReview;
  final String? appleOrderId;
  final String? googleOrderId;

  // Unique key to identify user for in app purchase (user id can't be use because format is not supported in app store / play store)
  final String? purchaseRefId;
  final PremiumPackageModel? premiumPackage;
  final List<AcceptedPlatformDocument>? acceptedPlatformDocument;
  final LinkAccountsModel? linkAccounts;
  final String? firebaseToken;

  UserEntity({
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

  UserEntity update(UserEntity user) {
    return UserEntity(
      id: user.id ?? id,
      username: user.username ?? username,
      displayName: user.displayName ?? displayName,
      birthDate: user.birthDate ?? birthDate,
      email: user.email ?? email,
      hasPassword: user.hasPassword ?? hasPassword,
      phoneNumber: user.phoneNumber ?? phoneNumber,
      // for status message, we need to allow null value to clear it
      originalStatusMessage: user.originalStatusMessage,
      avatarId: user.avatarId ?? avatarId,
      token: user.token ?? token,
      avatarBlurhash: user.avatarBlurhash ?? avatarBlurhash,
      backgroundId: user.backgroundId ?? backgroundId,
      backgroundBlurhash: user.backgroundBlurhash ?? backgroundBlurhash,
      lastEditUsernameAt: user.lastEditUsernameAt ?? lastEditUsernameAt,
      limitFriend: user.limitFriend ?? limitFriend,
      friendRequestCount: user.friendRequestCount ?? friendRequestCount,
      roomInvitedIds: user.roomInvitedIds ?? roomInvitedIds,
      onlineStatus: user.onlineStatus ?? onlineStatus,
      isCurrentUser: user.isCurrentUser ?? isCurrentUser,
      isMAHidden: user.isMAHidden ?? isMAHidden,
      loginAt: user.loginAt ?? loginAt,
      shortcutPasscode: user.shortcutPasscode ?? shortcutPasscode,
      enabledFeatures: user.enabledFeatures ?? enabledFeatures,
      currentStateSeq: user.currentStateSeq ?? currentStateSeq,
      schemaVersion: user.schemaVersion ?? schemaVersion,
      callStatus: user.callStatus ?? callStatus,
      currentSessionKeyId: user.currentSessionKeyId ?? currentSessionKeyId,
      callOnSessionKeyId: user.callOnSessionKeyId ?? callOnSessionKeyId,
      publicKey: user.publicKey ?? publicKey,
      privateKey: user.privateKey ?? privateKey,
      isNewMessageSoundEnable: user.isNewMessageSoundEnable ?? isNewMessageSoundEnable,
      isNewMessageAnimatedEnable: user.isNewMessageAnimatedEnable ?? isNewMessageAnimatedEnable,
      newMessageSoundMeSelected: user.newMessageSoundMeSelected ?? newMessageSoundMeSelected,
      newMessageSoundFriendSelected: user.newMessageSoundFriendSelected ?? newMessageSoundFriendSelected,
      newMessageAnimatedType: user.newMessageAnimatedType ?? newMessageAnimatedType,
      newMessageAnimatedDuration: user.newMessageAnimatedDuration ?? newMessageAnimatedDuration,
      isDeleted: user.isDeleted ?? isDeleted,
      limitMultipleAccount: user.limitMultipleAccount ?? limitMultipleAccount,
      accountSettings: user.accountSettings ?? accountSettings,
      appleUserId: user.appleUserId ?? appleUserId,
      googleUserId: user.googleUserId ?? googleUserId,
      premiumPackageId: user.premiumPackageId ?? premiumPackageId,
      subscribeAt: user.subscribeAt ?? subscribeAt,
      expireAt: user.expireAt ?? expireAt,
      payStore: user.payStore ?? payStore,
      nextReview: user.nextReview ?? nextReview,
      appleOrderId: user.appleOrderId ?? appleOrderId,
      googleOrderId: user.googleOrderId ?? googleOrderId,
      purchaseRefId: user.purchaseRefId ?? purchaseRefId,
      premiumPackage: user.premiumPackage ?? premiumPackage,
      uchatDefaultEmojiItems: user.uchatDefaultEmojiItems ?? uchatDefaultEmojiItems,
      accountDefaultEmojiItems: user.accountDefaultEmojiItems ?? accountDefaultEmojiItems,
      uchatDefaultBookmarkEmojiTags: user.uchatDefaultBookmarkEmojiTags ?? uchatDefaultBookmarkEmojiTags,
      accountDefaultBookmarkEmojiTags: user.accountDefaultBookmarkEmojiTags ?? accountDefaultBookmarkEmojiTags,
      allBookmarkEmojiTags: user.allBookmarkEmojiTags ?? allBookmarkEmojiTags,
      acceptedPlatformDocument: user.acceptedPlatformDocument ?? acceptedPlatformDocument,
      linkAccounts: user.linkAccounts ?? linkAccounts,
      firebaseToken: user.firebaseToken ?? firebaseToken,
    );
  }

  UserEntity copyWith({
    String? id,
    String? username,
    String? displayName,
    String? birthDate,
    String? email,
    bool? hasPassword,
    String? phoneNumber,
    String? originalStatusMessage,
    bool forceClearStatusMessage = false,
    String? avatarId,
    String? token,
    String? avatarBlurhash,
    String? backgroundId,
    String? backgroundBlurhash,
    DateTime? lastEditUsernameAt,
    int? limitFriend,
    int? friendRequestCount,
    List<String>? roomInvitedIds,
    OnlineStatus? onlineStatus,
    bool? isCurrentUser,
    bool? isMAHidden,
    DateTime? loginAt,
    String? shortcutPasscode,
    bool forceDeleteShortcutPasscode = false,
    EnabledFeaturesModel? enabledFeatures,
    int? currentStateSeq,
    int? schemaVersion,
    CallStatusType? callStatus,
    String? currentSessionKeyId,
    String? callOnSessionKeyId,
    String? publicKey,
    String? privateKey,
    bool? isNewMessageSoundEnable,
    bool? isNewMessageAnimatedEnable,
    String? newMessageSoundMeSelected,
    String? newMessageSoundFriendSelected,
    int? newMessageAnimatedType,
    int? newMessageAnimatedDuration,
    bool? isDeleted,
    int? limitMultipleAccount,
    AccountSettingsModel? accountSettings,
    List<DefaultEmojiItemModel>? uchatDefaultEmojiItems,
    List<DefaultEmojiItemModel>? accountDefaultEmojiItems,
    List<DefaultBookmarkTagItemModel>? uchatDefaultBookmarkEmojiTags,
    List<DefaultBookmarkTagItemModel>? accountDefaultBookmarkEmojiTags,
    List<BookmarkTagModel>? allBookmarkEmojiTags,
    String? appleUserId,
    String? googleUserId,
    String? premiumPackageId,
    DateTime? subscribeAt,
    DateTime? expireAt,
    PayStoreType? payStore,
    DateTime? nextReview,
    String? appleOrderId,
    String? googleOrderId,
    String? purchaseRefId,
    PremiumPackageModel? premiumPackage,
    List<AcceptedPlatformDocument>? acceptedPlatformDocument,
    LinkAccountsModel? linkAccounts,
    String? firebaseToken,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      hasPassword: hasPassword ?? this.hasPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      originalStatusMessage: forceClearStatusMessage ? null : originalStatusMessage ?? this.originalStatusMessage,
      avatarId: avatarId ?? this.avatarId,
      token: token ?? this.token,
      avatarBlurhash: avatarBlurhash ?? this.avatarBlurhash,
      backgroundId: backgroundId ?? this.backgroundId,
      backgroundBlurhash: backgroundBlurhash ?? this.backgroundBlurhash,
      lastEditUsernameAt: lastEditUsernameAt ?? this.lastEditUsernameAt,
      limitFriend: limitFriend ?? this.limitFriend,
      friendRequestCount: friendRequestCount ?? this.friendRequestCount,
      roomInvitedIds: roomInvitedIds ?? this.roomInvitedIds,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      isMAHidden: isMAHidden ?? this.isMAHidden,
      loginAt: loginAt ?? this.loginAt,
      shortcutPasscode: forceDeleteShortcutPasscode == true ? null : shortcutPasscode ?? this.shortcutPasscode,
      enabledFeatures: enabledFeatures ?? this.enabledFeatures,
      currentStateSeq: currentStateSeq ?? this.currentStateSeq,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      callStatus: callStatus ?? this.callStatus,
      currentSessionKeyId: currentSessionKeyId ?? this.currentSessionKeyId,
      callOnSessionKeyId: callOnSessionKeyId ?? this.callOnSessionKeyId,
      publicKey: publicKey ?? this.publicKey,
      privateKey: privateKey ?? this.privateKey,
      isNewMessageSoundEnable: isNewMessageSoundEnable ?? this.isNewMessageSoundEnable,
      isNewMessageAnimatedEnable: isNewMessageAnimatedEnable ?? this.isNewMessageAnimatedEnable,
      newMessageSoundMeSelected: newMessageSoundMeSelected ?? this.newMessageSoundMeSelected,
      newMessageSoundFriendSelected: newMessageSoundFriendSelected ?? this.newMessageSoundFriendSelected,
      newMessageAnimatedType: newMessageAnimatedType ?? this.newMessageAnimatedType,
      newMessageAnimatedDuration: newMessageAnimatedDuration ?? this.newMessageAnimatedDuration,
      isDeleted: isDeleted ?? this.isDeleted,
      limitMultipleAccount: limitMultipleAccount ?? this.limitMultipleAccount,
      accountSettings: accountSettings ?? this.accountSettings,
      uchatDefaultEmojiItems: uchatDefaultEmojiItems ?? this.uchatDefaultEmojiItems,
      accountDefaultEmojiItems: accountDefaultEmojiItems ?? this.accountDefaultEmojiItems,
      uchatDefaultBookmarkEmojiTags: uchatDefaultBookmarkEmojiTags ?? this.uchatDefaultBookmarkEmojiTags,
      accountDefaultBookmarkEmojiTags: accountDefaultBookmarkEmojiTags ?? this.accountDefaultBookmarkEmojiTags,
      allBookmarkEmojiTags: allBookmarkEmojiTags ?? this.allBookmarkEmojiTags,
      appleUserId: appleUserId ?? this.appleUserId,
      googleUserId: googleUserId ?? this.googleUserId,
      premiumPackageId: premiumPackageId ?? this.premiumPackageId,
      subscribeAt: subscribeAt ?? this.subscribeAt,
      expireAt: expireAt ?? this.expireAt,
      payStore: payStore ?? this.payStore,
      nextReview: nextReview ?? this.nextReview,
      appleOrderId: appleOrderId ?? this.appleOrderId,
      googleOrderId: googleOrderId ?? this.googleOrderId,
      purchaseRefId: purchaseRefId ?? this.purchaseRefId,
      premiumPackage: premiumPackage ?? this.premiumPackage,
      acceptedPlatformDocument: acceptedPlatformDocument ?? this.acceptedPlatformDocument,
      linkAccounts: linkAccounts ?? this.linkAccounts,
      firebaseToken: firebaseToken ?? this.firebaseToken,
    );
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
    );

    contact.statusMessage = originalStatusMessage;

    return contact;
  }

  DateTime? get dBirthdate {
    if (birthDate != null) {
      return DateTime.tryParse(birthDate!);
    }
    return null;
  }

  bool get hasAvatar {
    return avatarId != null && avatarId != '';
  }

  String? get backgroundUrl {
    if (backgroundId != null && backgroundId != '') {
      return FileService().getProfileBackgroundUrl(backgroundId!);
    }
    return null;
  }

  String get shortDisplayName {
    if (displayName == null) return '';

    final characters = displayName!.characters;
    if (characters.length > 15) {
      final short = displayName?.characters.take(10);

      return '$short...';
    } else {
      return displayName!;
    }
  }

  String get avatarUrl {
    try {
      if (avatarId != null && avatarId != '') {
        return FileService().getAvatarUrl(avatarId!);
      }

      return '${AppEnv.apiUrl}avatar/icon_no_avatar.png';
    } catch (e) {
      return '';
    }
  }

  String get avatarPublic {
    if (id != null && id != '') {
      return AccountService().getUserPublicAvatar(id!);
    }
    return 'https://api.next.uchat.social/api/v2/users/$id/public-avatar';
  }

  String get statusMessage {
    return originalStatusMessage ?? '';
  }

  // set statusMessage(String? statusMessage) {
  //   // originalStatusMessage = statusMessage;
  //  copyWith(
  //     originalStatusMessage: statusMessage,
  //   );
  // }

  String get widgetKey {
    return 'USER-$id';
  }

  bool get isCalling {
    final callConditionList = [
      CallStatusType.calling,
      CallStatusType.inProgress,
      CallStatusType.created,
    ];
    return callConditionList.contains(callStatus);
  }

  @override
  String toString() {
    return '[UserEntity]\n'
        'UserID: $id\n'
        'UserName: $username\n'
        'DisplayName: $displayName\n'
        'birthDate: $birthDate\n\n'
        'email: $email\n\n'
        '$enabledFeatures';
  }
}
