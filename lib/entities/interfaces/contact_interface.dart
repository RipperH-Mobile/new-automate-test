import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/entities/models/official_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';

import 'user_interface.dart';

abstract class ContactInterface implements UserInterface {
  DateTime? createdAt;
  DateTime? updatedAt;
  String? phoneNumber;
  String? type;
  String? nickname;

  @override
  String? backgroundId;

  String? backgroundBlurhash;
  bool? hidden = false;
  OfficialMenuModel? menu;
  RichMenuModel? richMenu;
  DateTime? lastSeenAt;
  DateTime? lastTypedAt;
  bool? isTyping;

  bool? blocked = false;
  bool? originalIsFriend;
  bool get isFriend;
  set isFriend(bool isFriend);
  bool? friendCanSeeMyLastSeen;

  bool? originalIsDeleted;

  bool? get isDeleted;

  AccountSettingsModel? settings;

  bool? vibraniumShield;

  DateTime? hiddenAt;
  DateTime? blockedAt;

  set isDeleted(bool? deleted);

  String? get name;

  bool get isOfficial;

  bool get isBlocked;

  bool get isHidden;

  bool get hasOfficialMenu;

  String? get backgroundUrl;

  String? get shortName;

  String get shortNickname;

  String get shortDisplayName;
}
