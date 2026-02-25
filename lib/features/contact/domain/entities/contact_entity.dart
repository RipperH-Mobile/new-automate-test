import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/contact_type.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/entities/mixins.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/utils/datetime.dart';

class ContactEntity with ContactMixin, UserMixin implements ContactInterface {
  @override
  String? id;

  @override
  String? avatarId;

  @override
  String? displayName;

  @override
  String? birthDate;

  @override
  String? email;

  String? googleAccount;

  @override
  bool? hasPassword;

  @override
  String? username;

  @override
  String? backgroundBlurhash;

  @override
  String? backgroundId;

  @override
  bool? blocked;

  @override
  DateTime? createdAt;

  @override
  bool? hidden;

  @override
  bool? originalIsFriend;

  @override
  bool? friendCanSeeMyLastSeen;

  @override
  OfficialMenuModel? menu;

  @override
  RichMenuModel? richMenu;

  @override
  String? nickname;

  @override
  bool? originalIsDeleted;

  @override
  String? originalStatusMessage;

  @override
  @Enumerated(EnumType.name)
  OnlineStatus? onlineStatus;

  @override
  String? phoneNumber;

  @override
  @Index()
  String? type;

  @override
  @Index()
  DateTime? updatedAt;

  @override
  DateTime? lastSeenAt;

  @override
  DateTime? lastTypedAt;

  /// This variable is used for helping update variable [lastTypedAt] only.
  /// This will be used to set [lastTypedAt] to null if [isTyping] is false
  /// DON'T use this to check whether this user is currently typing.
  @override
  bool? isTyping;

  @override
  AccountSettingsModel? settings;

  @override
  bool? vibraniumShield;

  @override
  @Index()
  DateTime? hiddenAt;
  @override
  @Index()
  DateTime? blockedAt;

  String? get nameLowercase {
    return name?.toLowerCase();
  }

  ContactEntity({
    this.id,
    this.avatarId,
    this.displayName,
    this.birthDate,
    this.email,
    this.googleAccount,
    this.hasPassword,
    this.username,
    this.backgroundBlurhash,
    this.backgroundId,
    this.blocked,
    this.createdAt,
    this.hidden,
    this.originalIsFriend,
    this.friendCanSeeMyLastSeen,
    this.menu,
    this.richMenu,
    this.nickname,
    this.originalIsDeleted,
    this.originalStatusMessage,
    this.onlineStatus,
    this.phoneNumber,
    this.type,
    this.updatedAt,
    this.lastSeenAt,
    this.lastTypedAt,
    this.isTyping,
    this.settings,
    this.vibraniumShield,
    this.hiddenAt,
    this.blockedAt,
  });

  ContactEntity copyWith({
    String? id,
    String? avatarId,
    String? displayName,
    String? birthDate,
    String? email,
    String? googleAccount,
    bool? hasPassword,
    String? username,
    String? backgroundBlurhash,
    String? backgroundId,
    bool? blocked,
    DateTime? createdAt,
    bool? hidden,
    bool? originalIsFriend,
    bool? friendCanSeeMyLastSeen,
    OfficialMenuModel? menu,
    RichMenuModel? richMenu,
    String? nickname,
    bool? originalIsDeleted,
    String? originalStatusMessage,
    OnlineStatus? onlineStatus,
    String? phoneNumber,
    String? type,
    DateTime? updatedAt,
    DateTime? lastSeenAt,
    DateTime? lastTypedAt,
    bool? isTyping,
    AccountSettingsModel? settings,
  }) {
    return ContactEntity(
      id: id ?? this.id,
      avatarId: avatarId ?? this.avatarId,
      displayName: displayName ?? this.displayName,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      googleAccount: googleAccount ?? this.googleAccount,
      hasPassword: hasPassword ?? this.hasPassword,
      username: username ?? this.username,
      backgroundBlurhash: backgroundBlurhash ?? this.backgroundBlurhash,
      backgroundId: backgroundId ?? this.backgroundId,
      blocked: blocked ?? this.blocked,
      createdAt: createdAt ?? this.createdAt,
      hidden: hidden ?? this.hidden,
      originalIsFriend: originalIsFriend ?? this.originalIsFriend,
      friendCanSeeMyLastSeen: friendCanSeeMyLastSeen ?? this.friendCanSeeMyLastSeen,
      menu: menu ?? this.menu,
      richMenu: richMenu ?? this.richMenu,
      nickname: nickname ?? this.nickname,
      originalIsDeleted: originalIsDeleted ?? this.originalIsDeleted,
      originalStatusMessage: originalStatusMessage ?? this.originalStatusMessage,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      lastTypedAt: lastTypedAt ?? this.lastTypedAt,
      isTyping: isTyping ?? this.isTyping,
      settings: settings ?? this.settings,
    );
  }

  factory ContactEntity.fromMap(Map<String, dynamic> data) {
    var contact = ContactEntity(
      id: data['_id'],
      username: data['username'],
      email: data['email'],
      displayName: data['displayName'],
      birthDate: data['birthDate'],
      googleAccount: data['googleAccount'],
      avatarId: data['avatarId'],
      blocked: data['blocked'],
      onlineStatus: OnlineStatus.from(data['onlineStatus']),
      phoneNumber: data['phoneNumber'],
      originalIsFriend: data['isFriend'] ?? data['accepted'],
      friendCanSeeMyLastSeen: data['settings']?['friend']?['canFriendSeeMyLastSeen'] ?? data['friendCanSeeMyLastSeen'],
      settings: data['settings'] != null ? AccountSettingsModel.fromMap(data['settings']) : null,
      createdAt: strToDateTime(data['createdAt']),
      updatedAt: strToDateTime(data['updatedAt']),
      nickname: data['nickname'],
      backgroundId: data['backgroundId'],
      backgroundBlurhash: data['backgroundBlurhash'],
      hidden: data['hidden'],
      lastSeenAt: strToDateTime(data['lastSeenAt']),
      lastTypedAt: strToDateTime(data['lastTypedAt']),
      isTyping: data['isTyping'],
      vibraniumShield: data['vibraniumShield'],
      hiddenAt: data['hiddenAt'] != null ? strToDateTime(data['hiddenAt']) : null,
      blockedAt: data['blockedAt'] != null ? strToDateTime(data['blockedAt']) : null,
    );

    if (data['removed'] != null && data['removed'] is bool) {
      contact.originalIsDeleted = data['removed'];
    }

    if (data['type'] != null) {
      contact.type = data['type'];
    } else {
      contact.type = ContactType.normal.value;
    }

    contact.statusMessage = data['statusMessage'];

    var account = data['account'];
    if (account != null) {
      contact
        ..id = account['_id']
        ..displayName = account['displayName']
        ..birthDate = account['birthDate']
        ..username = account['username']
        ..email = account['email']
        ..statusMessage = account['statusMessage']
        ..avatarId = account['avatarId']
        ..blocked = account['blocked'] ?? contact.blocked
        ..onlineStatus = OnlineStatus.from(account['onlineStatus'])
        ..phoneNumber = account['phoneNumber'] ?? contact.phoneNumber
        ..isFriend = account['isFriend'] ?? contact.originalIsFriend
        ..isDeleted = account['deleted'] ?? contact.isDeleted
        ..backgroundId = account['backgroundId'] ?? contact.backgroundId
        ..backgroundBlurhash = account['backgroundBlurhash'] ?? contact.backgroundBlurhash
        ..hidden = account['hidden'] ?? contact.hidden;

      if (account['settings'] != null) {
        contact.settings = AccountSettingsModel.fromMap(account['settings']);
        contact.friendCanSeeMyLastSeen = account['settings']['friend']['canFriendSeeMyLastSeen'] ??
            account['friendCanSeeMyLastSeen'] ??
            contact.friendCanSeeMyLastSeen;
      }

      if (account['type'] != null) {
        contact.type = account['type'];
      }

      if (account['lastSeenAt'] != null) {
        contact.lastSeenAt = strToDateTime(account['lastSeenAt']);
      }

      if (account['lastTypedAt'] != null) {
        contact.lastTypedAt = strToDateTime(account['lastTypedAt']);
      }

      if (account['isTyping'] != null) {
        contact.isTyping = account['isTyping'];
      }

      contact.type ??= ContactType.normal.value;
    }

    final menu = data['menu'];
    if (menu != null) {
      contact.menu = OfficialMenuModel.fromMap(menu);
    }

    return contact;
  }

  @override
  bool operator ==(Object other) {
    return other is ContactEntity && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return '[ContactCollection] ID: $id,\n'
        'IsFriend: $isFriend,\n'
        'IsDeleted: $isDeleted,\n'
        'IsOfficial: $isOfficial';
  }
}
