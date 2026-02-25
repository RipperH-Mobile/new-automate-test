import 'package:characters/characters.dart';
import 'package:uchat/entities/enum/contact_type.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/utils/app_env.dart';

class ProfileEntity {
  final String id;
  final String username;
  final String? phoneNumber;
  final String displayName;
  final String? statusMessage;
  final String? avatarId;
  final String? avatarBlurhash;
  final OnlineStatus onlineStatus;
  final bool deleted;
  final bool isBlocked;
  final AccountSettingsModel settings;
  final String? currentSessionKeyId;
  final bool isFriend;
  final String? friendNickname;
  final ContactType type;

  const ProfileEntity({
    required this.id,
    required this.username,
    this.phoneNumber,
    required this.displayName,
    this.statusMessage,
    this.avatarId,
    this.avatarBlurhash,
    required this.onlineStatus,
    this.deleted = false,
    this.isBlocked = false,
    required this.settings,
    this.currentSessionKeyId,
    required this.isFriend,
    this.friendNickname,
    this.type = ContactType.normal,
  });

  String get getName => (friendNickname != null && friendNickname!.isNotEmpty) ? friendNickname! : displayName;

  String get shortDisplayName {
    final characters = displayName.characters;
    if (characters.length > 15) {
      final short = displayName.characters.take(10);

      return '$short...';
    } else {
      return displayName;
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

  ProfileEntity copyWith({
    String? id,
    String? username,
    String? phoneNumber,
    String? displayName,
    String? statusMessage,
    String? avatarId,
    String? avatarBlurhash,
    OnlineStatus? onlineStatus,
    bool? deleted,
    bool? isBlocked,
    AccountSettingsModel? settings,
    String? currentSessionKeyId,
    bool? isFriend,
    String? friendNickname,
    ContactType? type,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      statusMessage: statusMessage ?? this.statusMessage,
      avatarId: avatarId ?? this.avatarId,
      avatarBlurhash: avatarBlurhash ?? this.avatarBlurhash,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      deleted: deleted ?? this.deleted,
      isBlocked: isBlocked ?? this.isBlocked,
      settings: settings ?? this.settings,
      currentSessionKeyId: currentSessionKeyId ?? this.currentSessionKeyId,
      isFriend: isFriend ?? this.isFriend,
      friendNickname: friendNickname ?? this.friendNickname,
      type: type ?? this.type,
    );
  }

  factory ProfileEntity.fromJson(Map<String, dynamic> json) {
    return ProfileEntity(
      id: json['_id'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
      statusMessage: json['statusMessage'],
      avatarId: json['avatarId'],
      avatarBlurhash: json['avatarBlurhash'],
      onlineStatus: OnlineStatus.from(json['onlineStatus']) ?? OnlineStatus.offline,
      deleted: json['deleted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      settings: AccountSettingsModel.fromMap(json['settings']),
      currentSessionKeyId: json['currentSessionKeyId'],
      isFriend: json['isFriend'] ?? false,
      friendNickname: json['friendNickname'],
      type: json['type'] != null ? ContactType.from(json['type']) : ContactType.normal,
    );
  }
}
