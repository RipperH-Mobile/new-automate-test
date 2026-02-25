import 'package:isar_community/isar.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/entities/mixins.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'contact_collection.g.dart';

final _log = useLogger();

@Collection(accessor: 'contacts')
@Name('Contact')
class ContactCollection with ContactMixin, UserMixin implements ContactInterface {
  @override
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id!);

  @override
  String? avatarId;

  @override
  @Index()
  String? displayName;

  @override
  String? birthDate;

  @override
  String? email;

  String? googleAccount;

  @override
  bool? hasPassword;

  @override
  @Index(unique: true, replace: true)
  String? username;

  @override
  String? backgroundBlurhash;

  @override
  String? backgroundId;

  @override
  @Index()
  bool? blocked;

  @override
  DateTime? createdAt;

  @override
  bool? hidden;

  @override
  @Index()
  bool? originalIsFriend;

  @override
  bool? friendCanSeeMyLastSeen;

  @override
  OfficialMenuModel? menu;

  @override
  RichMenuModel? richMenu;

  @override
  @Index()
  String? nickname;

  @override
  @Index()
  bool? originalIsDeleted;

  @override
  String? originalStatusMessage;

  @override
  @Enumerated(EnumType.name)
  OnlineStatus? onlineStatus;

  @override
  @Index()
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

  /// NOTE.[vibraniumShield] is variable for checking other person is blocked my account
  /// [vibraniumShield] == true => other person is blocked my account
  /// [vibraniumShield] == flase || null => other person is not blocked my account
  @override
  bool? vibraniumShield;

  /// NOTE.[hiddenAt] is variable for check when this account has been hidden
  @override
  @Index()
  DateTime? hiddenAt;

  /// NOTE.[blockedAt] is variable for check when this account has been blocked
  @override
  @Index()
  DateTime? blockedAt;

  @override
  @Index()
  bool get isOfficial {
    return super.isOfficial;
  }

  @override
  @Index()
  bool get isBlocked {
    return super.isBlocked;
  }

  @override
  @Index()
  bool get isHidden {
    return super.isHidden;
  }

  @override
  @Index()
  bool get isFriend {
    return super.isFriend;
  }

  @override
  @Index()
  bool get isDeleted {
    return super.isDeleted;
  }

  @override
  @Index()
  bool get canShowInFriendSearch {
    return super.canShowInFriendSearch;
  }

  @override
  @Index()
  bool get canShowInOfficialAccountSearch {
    return super.canShowInOfficialAccountSearch;
  }

  @override
  @Index()
  bool get canShowInFriendList {
    return super.canShowInFriendList;
  }

  @override
  @Index()
  bool get canShowInOfficialAccountList {
    return super.canShowInOfficialAccountList;
  }

  @override
  @Index()
  bool get canShowInShareContact {
    return super.canShowInShareContact;
  }

  @override
  @Index()
  bool get canChatWith {
    return super.canChatWith;
  }

  @Index()
  String? get nameLowercase {
    return name?.toLowerCase();
  }

  ContactCollection({
    this.id,
    this.displayName,
    this.originalStatusMessage,
    this.birthDate,
    this.username,
    this.email,
    this.googleAccount,
    this.avatarId,
    this.originalIsFriend,
    this.friendCanSeeMyLastSeen,
    this.blocked,
    this.updatedAt,
    this.createdAt,
    this.onlineStatus,
    this.phoneNumber,
    this.type,
    this.nickname,
    this.backgroundId,
    this.backgroundBlurhash,
    this.hidden,
    this.menu,
    this.richMenu,
    this.lastSeenAt,
    this.lastTypedAt,
    this.isTyping,
    this.hasPassword,
    this.originalIsDeleted = false,
    this.settings,
    this.vibraniumShield,
    this.hiddenAt,
    this.blockedAt,
  });

  factory ContactCollection.fromMap(Map<String, dynamic> data) {
    var contact = ContactCollection(
      id: data['_id'] ?? data['accountId'],
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
      createdAt: data['createdAt'] != null ? strToDateTime(data['createdAt']) : null,
      updatedAt: data['updatedAt'] != null ? strToDateTime(data['updatedAt']) : null,
      nickname: data['nickname'],
      backgroundId: data['backgroundId'],
      backgroundBlurhash: data['backgroundBlurhash'],
      hidden: data['hidden'],
      lastSeenAt: data['lastSeenAt'] != null ? strToDateTime(data['lastSeenAt']) : null,
      lastTypedAt: data['lastTypedAt'] != null ? strToDateTime(data['lastTypedAt']) : null,
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
      try {
        contact.menu = OfficialMenuModel.fromMap(menu);
      } catch (e, stackTrace) {
        _log.e('Error parse menu. (${data['menu']})', e, stackTrace);
      }
    }

    return contact;
  }

  @override
  bool operator ==(Object other) {
    return other is ContactCollection && id == other.id;
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

  ContactCollection copyWith({
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
    return ContactCollection(
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
}
