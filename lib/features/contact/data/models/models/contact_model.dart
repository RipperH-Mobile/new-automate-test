import 'package:get/get.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/contact_type.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/entities/mixins/contact.dart';
import 'package:uchat/entities/mixins/user.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/entities/models/official_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

part 'contact_model.g.dart';

final _log = useLogger();

@embedded
class ContactModel with ContactMixin, UserMixin implements ContactInterface {
  @override
  String? avatarId;

  @override
  String? backgroundBlurhash;

  @override
  String? backgroundId;

  @override
  bool? blocked;

  @override
  DateTime? createdAt;

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
  bool? hidden;

  @override
  String? id;

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
  String? type;

  @override
  DateTime? updatedAt;

  @override
  String? username;

  @override
  DateTime? lastSeenAt;

  @override
  DateTime? lastTypedAt;

  @override
  bool? isTyping;

  @override
  AccountSettingsModel? settings;

  @override
  bool? vibraniumShield;

  @override
  DateTime? hiddenAt;
  @override
  DateTime? blockedAt;

  ContactModel({
    this.id,
    this.displayName,
    this.birthDate,
    this.username,
    this.email,
    this.avatarId,
    this.originalIsFriend,
    this.blocked,
    this.updatedAt,
    this.createdAt,
    this.phoneNumber,
    this.googleAccount,
    this.type,
    this.nickname,
    this.backgroundId,
    this.backgroundBlurhash,
    this.hidden,
    this.menu,
    this.richMenu,
    this.originalStatusMessage,
    this.lastSeenAt,
    this.lastTypedAt,
    this.isTyping,
    this.settings,
    this.vibraniumShield,
    this.hiddenAt,
    this.blockedAt,
    bool? isDeleted,
  }) : originalIsDeleted = isDeleted;

  factory ContactModel.fromMap(Map<String, dynamic> data) {
    var contact = ContactModel(
      id: data['accountId'] ?? data['_id'],
      username: data['username'],
      email: data['email'],
      displayName: data['displayName'],
      birthDate: data['birthDate'],
      avatarId: data['avatarId'],
      blocked: data['blocked'],
      phoneNumber: data['phoneNumber'],
      googleAccount: data['googleAccount'],
      originalIsFriend: data['isFriend'] ?? data['accepted'],
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
      settings: data['settings'] != null ? AccountSettingsModel.fromMap(data['settings']) : null,
    );

    if (data['deleted'] != null) {
      contact.isDeleted = data['deleted'];
    }

    if (data['type'] != null) {
      contact.type = data['type'];
    } else {
      contact.type = ContactType.normal.value;
    }

    if (contact.isDeleted) {
      contact.username = 'UNKNOWN'.tr;
      contact.displayName = 'UNKNOWN'.tr;
      contact.nickname = 'UNKNOWN'.tr;
    }

    contact.statusMessage = data['statusMessage'] ?? '';

    var account = data['account'];
    if (account != null) {
      contact
        ..id = account['accountId'] ?? account['_id']
        ..displayName = account['displayName']
        ..birthDate = account['birthDate']
        ..username = account['username']
        ..email = account['email']
        ..avatarId = account['avatarId']
        ..blocked = account['blocked'] ?? contact.blocked
        ..phoneNumber = account['phoneNumber'] ?? contact.phoneNumber
        ..googleAccount = account['googleAccount'] ?? contact.googleAccount
        ..isFriend = account['isFriend'] ?? contact.originalIsFriend
        ..isDeleted = account['deleted'] ?? contact.isDeleted
        ..backgroundId = account['backgroundId'] ?? contact.backgroundId
        ..backgroundBlurhash = account['backgroundBlurhash'] ?? contact.backgroundBlurhash
        ..hidden = account['hidden'] ?? contact.hidden;

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

      if (contact.isDeleted) {
        contact.username = 'UNKNOWN'.tr;
        contact.displayName = 'UNKNOWN'.tr;
        contact.nickname = 'UNKNOWN'.tr;
      }
      if (account['settings'] != null) {
        contact.settings = AccountSettingsModel.fromMap(account['settings']);
        contact.friendCanSeeMyLastSeen = account['settings']?['friend']?['canFriendSeeMyLastSeen'] ??
            account['friendCanSeeMyLastSeen'] ??
            contact.friendCanSeeMyLastSeen;
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
  String toString() =>
      '[ContactModel] id: $id, display: $displayName, birth: $birthDate, username: $username, avatarId: $avatarId, originalIsFriend: $originalIsFriend, blocked: $blocked, updatedAt: $updatedAt, createdAt: $createdAt, phoneNumber: $phoneNumber, googleAccount: $googleAccount, type: $type, nickname: $nickname, backgroundId: $backgroundId, backgroundBlurhash: $backgroundBlurhash, hidden: $hidden, menu: $menu, originalStatusMessage: $originalStatusMessage, lastSeenAt: $lastSeenAt, lastTypedAt: $lastTypedAt, isTyping: $isTyping';

  @override
  bool operator ==(Object other) {
    return other is ContactModel && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;
}
