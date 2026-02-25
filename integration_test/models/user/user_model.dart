import 'user_features.dart';
import 'user_settings.dart';

// ==========================================
// HELPER FUNCTIONS (Date Handling)
// ==========================================

/// แปลงค่าจาก MongoDB JSON (ที่มี $date) หรือ String ให้เป็น DateTime
DateTime? _parseMongoDate(dynamic val) {
  if (val == null) return null;
  if (val is String) return DateTime.tryParse(val);
  if (val is Map && val.containsKey('\$date')) {
    return DateTime.tryParse(val['\$date']);
  }
  return null;
}

/// แปลง DateTime กลับเป็นรูปแบบ MongoDB { "$date": ... }
dynamic _toMongoDate(DateTime? date) {
  if (date == null) return null;
  return {"\$date": date.toIso8601String()};
}

// ==========================================
// MAIN USER MODEL
// ==========================================

class UserModel {
  String? id; // _id
  String? type;
  String? username;
  String? password;
  String? phoneNumber;
  String? displayName;
  DateTime? lastLoginAt;
  bool? isUseGodMode;
  bool? isBanned;
  int? limitFriend;
  int? limitOfficialAccount;
  int? limitMultipleAccount;
  bool? isAdmin;
  bool? deleted;
  List<String>? roomInvitedIds;
  String? onlineStatus;
  UserFeatures? features;
  UserSettings? settings;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v; // __v

  UserModel({
    this.id,
    this.type,
    this.username,
    this.password,
    this.phoneNumber,
    this.displayName,
    this.lastLoginAt,
    this.isUseGodMode,
    this.isBanned,
    this.limitFriend,
    this.limitOfficialAccount,
    this.limitMultipleAccount,
    this.isAdmin,
    this.deleted,
    this.roomInvitedIds,
    this.onlineStatus,
    this.features,
    this.settings,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  /// -----------------------------------------------------------------------
  /// FACTORY: CREATE DEFAULT (สำหรับสร้าง User ใหม่จาก CSV)
  /// -----------------------------------------------------------------------
  factory UserModel.createDefault({
    required String username,
    required String password,
    required String phoneNumber,
    required String displayName,
  }) {
    DateTime now = DateTime.now().toUtc();

    return UserModel(
      type: "NORMAL",
      username: username,
      password: password,
      phoneNumber: phoneNumber,
      displayName: displayName,
      lastLoginAt: null,
      isUseGodMode: true,
      isBanned: false,
      limitFriend: 400,
      limitOfficialAccount: 300,
      limitMultipleAccount: 2,
      isAdmin: false,
      deleted: false,
      roomInvitedIds: [],
      onlineStatus: "ONLINE",
      createdAt: now,
      updatedAt: now,
      v: 0,

      // --- Default Features ---
      features: UserFeatures(
        secretRoom: SecretRoomFeature(enabled: true, maxSecond: 86400),
        call: BaseFeature(enabled: true, isTest: false),
        multipleAccount: MultipleAccountFeature(
            enabled: true, canUseShortCutPasscode: true, canHideFromList: true, maxMultipleAccount: 2),
        helpCenter: BaseFeature(enabled: true),
        coin: BaseFeature(enabled: true),
        holdChat: HoldChatFeature(enabled: true, withScroll: false),
        newMessageEffect: NewMessageEffectFeature(enabled: true, animation: true, sound: false),
        chatFolder: ChatFolderFeature(enabled: true, maxChatFolder: 10, maxRoomInChatFolder: 100),
        chatFolderV2: ChatFolderFeature(enabled: false, maxChatFolder: 10, maxRoomInChatFolder: 100),
        pin: PinFeature(enabled: true, maxPin: 10),
        webhook: BaseFeature(enabled: false),
        uploadPro: BaseFeature(enabled: false),
        troubleshoot: BaseFeature(enabled: false),
        premiumStore: BaseFeature(enabled: false),
        talker: BaseFeature(enabled: false),
        previewFont: BaseFeature(enabled: false),
        lockMessage: BaseFeature(enabled: false),
        bookmark: BookmarkFeature(enabled: false, emojiTag: false),
        reactMessage: BaseFeature(enabled: true),
        groupPermission: BaseFeature(enabled: true),
        useFirebaseState: BaseFeature(enabled: false),
        inviteLink: BaseFeature(enabled: true),
        pinMessage: BaseFeature(enabled: true),
        experience: ExperienceFeature(
            enabled: false,
            shareScreen: false,
            pip: false,
            whoRead: false,
            virtualBackground: false,
            beautyFilter: false,
            stickerSendingTransition: false),
        debugAccount: BaseFeature(enabled: false),
        analytic: BaseFeature(enabled: false),
      ),

      // --- Default Settings ---
      settings: UserSettings(
        call: CallSettings(enabled: true, allowIncomingCall: true, allowCallKit: true),
        chat: ChatSettings(enabled: true, chatFolder: true, showCategory: false, sort: "TIME_LATEST"),
        friend: FriendSettings(
          enabled: true,
          canFriendSeeMyLastSeen: true,
          allowFriendAdd: AllowFriendAddSettings(
              enabled: true, canAddByPhoneNumber: true, canAddByUsername: true, canAddFromGroup: true),
        ),
        notification: NotificationSettings(enabled: true, hiddenMessage: false),
        profile: ProfileSettings(enabled: true, hiddenPhoneNumber: false),
        security: SecuritySettings(enabled: true, allowMultiFactor: false),
        analytic: AnalyticSettings(enabled: false),
      ),
    );
  }

  /// แปลง JSON Map -> Object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString(),
      type: json['type'],
      username: json['username'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
      lastLoginAt: _parseMongoDate(json['lastLoginAt']),
      isUseGodMode: json['isUseGodMode'],
      isBanned: json['isBanned'],
      limitFriend: json['limitFriend'],
      limitOfficialAccount: json['limitOfficialAccount'],
      limitMultipleAccount: json['limitMultipleAccount'],
      isAdmin: json['isAdmin'],
      deleted: json['deleted'],
      roomInvitedIds: json['roomInvitedIds'] != null ? List<String>.from(json['roomInvitedIds']) : [],
      onlineStatus: json['onlineStatus'],
      features: json['features'] != null ? UserFeatures.fromJson(json['features']) : null,
      settings: json['settings'] != null ? UserSettings.fromJson(json['settings']) : null,
      createdAt: _parseMongoDate(json['createdAt']),
      updatedAt: _parseMongoDate(json['updatedAt']),
      v: json['__v'],
    );
  }

  /// แปลง Object -> JSON Map
  Map<String, dynamic> toJson() {
    return {
      // '_id': id, // Uncomment ถ้าต้องการส่ง ID กลับ
      'type': type,
      'username': username,
      'password': password,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'lastLoginAt': _toMongoDate(lastLoginAt),
      'isUseGodMode': isUseGodMode,
      'isBanned': isBanned,
      'limitFriend': limitFriend,
      'limitOfficialAccount': limitOfficialAccount,
      'limitMultipleAccount': limitMultipleAccount,
      'isAdmin': isAdmin,
      'deleted': deleted,
      'roomInvitedIds': roomInvitedIds,
      'onlineStatus': onlineStatus,
      'features': features?.toJson(),
      'settings': settings?.toJson(),
      'createdAt': _toMongoDate(createdAt),
      'updatedAt': _toMongoDate(updatedAt),
      '__v': v,
    };
  }
}

// ==========================================
// FEATURES CLASSES
// ==========================================

class UserFeatures {
  SecretRoomFeature? secretRoom;
  BaseFeature? call;
  MultipleAccountFeature? multipleAccount;
  BaseFeature? helpCenter;
  BaseFeature? coin;
  HoldChatFeature? holdChat;
  NewMessageEffectFeature? newMessageEffect;
  ChatFolderFeature? chatFolder;
  ChatFolderFeature? chatFolderV2;
  PinFeature? pin;
  BaseFeature? webhook;
  BaseFeature? uploadPro;
  BaseFeature? troubleshoot;
  BaseFeature? premiumStore;
  BaseFeature? talker;
  BaseFeature? previewFont;
  BaseFeature? lockMessage;
  BookmarkFeature? bookmark;
  BaseFeature? reactMessage;
  BaseFeature? groupPermission;
  BaseFeature? useFirebaseState;
  BaseFeature? inviteLink;
  BaseFeature? pinMessage;
  ExperienceFeature? experience;
  BaseFeature? debugAccount;
  BaseFeature? analytic;

  UserFeatures({
    this.secretRoom,
    this.call,
    this.multipleAccount,
    this.helpCenter,
    this.coin,
    this.holdChat,
    this.newMessageEffect,
    this.chatFolder,
    this.chatFolderV2,
    this.pin,
    this.webhook,
    this.uploadPro,
    this.troubleshoot,
    this.premiumStore,
    this.talker,
    this.previewFont,
    this.lockMessage,
    this.bookmark,
    this.reactMessage,
    this.groupPermission,
    this.useFirebaseState,
    this.inviteLink,
    this.pinMessage,
    this.experience,
    this.debugAccount,
    this.analytic,
  });

  factory UserFeatures.fromJson(Map<String, dynamic> json) {
    return UserFeatures(
      secretRoom: json['secretRoom'] != null ? SecretRoomFeature.fromJson(json['secretRoom']) : null,
      call: json['call'] != null ? BaseFeature.fromJson(json['call']) : null,
      multipleAccount:
          json['multipleAccount'] != null ? MultipleAccountFeature.fromJson(json['multipleAccount']) : null,
      helpCenter: json['helpCenter'] != null ? BaseFeature.fromJson(json['helpCenter']) : null,
      coin: json['coin'] != null ? BaseFeature.fromJson(json['coin']) : null,
      holdChat: json['holdChat'] != null ? HoldChatFeature.fromJson(json['holdChat']) : null,
      newMessageEffect:
          json['newMessageEffect'] != null ? NewMessageEffectFeature.fromJson(json['newMessageEffect']) : null,
      chatFolder: json['chatFolder'] != null ? ChatFolderFeature.fromJson(json['chatFolder']) : null,
      chatFolderV2: json['chatFolderV2'] != null ? ChatFolderFeature.fromJson(json['chatFolderV2']) : null,
      pin: json['pin'] != null ? PinFeature.fromJson(json['pin']) : null,
      webhook: json['webhook'] != null ? BaseFeature.fromJson(json['webhook']) : null,
      uploadPro: json['uploadPro'] != null ? BaseFeature.fromJson(json['uploadPro']) : null,
      troubleshoot: json['troubleshoot'] != null ? BaseFeature.fromJson(json['troubleshoot']) : null,
      premiumStore: json['premiumStore'] != null ? BaseFeature.fromJson(json['premiumStore']) : null,
      talker: json['talker'] != null ? BaseFeature.fromJson(json['talker']) : null,
      previewFont: json['previewFont'] != null ? BaseFeature.fromJson(json['previewFont']) : null,
      lockMessage: json['lockMessage'] != null ? BaseFeature.fromJson(json['lockMessage']) : null,
      bookmark: json['bookmark'] != null ? BookmarkFeature.fromJson(json['bookmark']) : null,
      reactMessage: json['reactMessage'] != null ? BaseFeature.fromJson(json['reactMessage']) : null,
      groupPermission: json['groupPermission'] != null ? BaseFeature.fromJson(json['groupPermission']) : null,
      useFirebaseState: json['useFirebaseState'] != null ? BaseFeature.fromJson(json['useFirebaseState']) : null,
      inviteLink: json['inviteLink'] != null ? BaseFeature.fromJson(json['inviteLink']) : null,
      pinMessage: json['pinMessage'] != null ? BaseFeature.fromJson(json['pinMessage']) : null,
      experience: json['experience'] != null ? ExperienceFeature.fromJson(json['experience']) : null,
      debugAccount: json['debugAccount'] != null ? BaseFeature.fromJson(json['debugAccount']) : null,
      analytic: json['analytic'] != null ? BaseFeature.fromJson(json['analytic']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secretRoom': secretRoom?.toJson(),
      'call': call?.toJson(),
      'multipleAccount': multipleAccount?.toJson(),
      'helpCenter': helpCenter?.toJson(),
      'coin': coin?.toJson(),
      'holdChat': holdChat?.toJson(),
      'newMessageEffect': newMessageEffect?.toJson(),
      'chatFolder': chatFolder?.toJson(),
      'chatFolderV2': chatFolderV2?.toJson(),
      'pin': pin?.toJson(),
      'webhook': webhook?.toJson(),
      'uploadPro': uploadPro?.toJson(),
      'troubleshoot': troubleshoot?.toJson(),
      'premiumStore': premiumStore?.toJson(),
      'talker': talker?.toJson(),
      'previewFont': previewFont?.toJson(),
      'lockMessage': lockMessage?.toJson(),
      'bookmark': bookmark?.toJson(),
      'reactMessage': reactMessage?.toJson(),
      'groupPermission': groupPermission?.toJson(),
      'useFirebaseState': useFirebaseState?.toJson(),
      'inviteLink': inviteLink?.toJson(),
      'pinMessage': pinMessage?.toJson(),
      'experience': experience?.toJson(),
      'debugAccount': debugAccount?.toJson(),
      'analytic': analytic?.toJson(),
    };
  }
}
