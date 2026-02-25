import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/entities/enum/contact_type.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/contact/data/data_source/local/contact_db.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';

class ProfileLocalRepositoryImpl extends ProfileLocalRepository {
  final ContactDb contactDb;
  final RoomMemberDb roomMemberDb;
  final RoomDb roomDB;

  ProfileLocalRepositoryImpl({
    required this.contactDb,
    required this.roomMemberDb,
    required this.roomDB,
  });

  @override
  Future<ProfileEntity?> getContact(String id) async {
    final contact = await contactDb.getContact(id);

    if (contact == null) {
      return null;
    }

    return ProfileEntity(
      id: contact.id ?? '',
      username: contact.username ?? '',
      phoneNumber: contact.phoneNumber ?? '',
      displayName: contact.displayName ?? '',
      statusMessage: contact.originalStatusMessage,
      avatarId: contact.avatarId,
      onlineStatus: contact.onlineStatus ?? OnlineStatus.offline,
      deleted: contact.isDeleted,
      settings: contact.settings ?? AccountSettingsModel(),
      isFriend: contact.isFriend,
      friendNickname: contact.nickname,
      isBlocked: contact.isBlocked,
      type: contact.type != null ? ContactType.from(contact.type!) : ContactType.normal,
    );
  }

  @override
  Future<RoomEntity?> getRoomByAccountId(String accountId) async {
    String? roomId = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(accountId);
    RoomCollection? room = await roomDB.getRoom(roomId ?? '');
    if (room == null) {
      return null;
    }
    return room.toEntity();
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) async {
    ContactCollection? contact = await contactDb.getContact(profile.id);

    if (contact == null) {
      throw NullResponseException();
    }

    // force update contact with new profile data
    // can't use contact.copyWith because nullable fields are not copied
    contact = ContactCollection(
      // force update with new profile data
      id: profile.id,
      username: profile.username,
      phoneNumber: profile.phoneNumber,
      displayName: profile.displayName,
      originalStatusMessage: profile.statusMessage,
      avatarId: profile.avatarId,
      onlineStatus: profile.onlineStatus,
      settings: profile.settings,
      nickname: profile.friendNickname,
      // use original fields
      birthDate: contact.birthDate,
      email: contact.email,
      googleAccount: contact.googleAccount,
      hasPassword: contact.hasPassword,
      backgroundBlurhash: contact.backgroundBlurhash,
      backgroundId: contact.backgroundId,
      blocked: contact.blocked,
      createdAt: contact.createdAt,
      hidden: contact.hidden,
      originalIsFriend: contact.originalIsFriend,
      friendCanSeeMyLastSeen: contact.friendCanSeeMyLastSeen,
      menu: contact.menu,
      originalIsDeleted: contact.originalIsDeleted,
      type: contact.type,
      updatedAt: contact.updatedAt,
      lastSeenAt: contact.lastSeenAt,
      lastTypedAt: contact.lastTypedAt,
      isTyping: contact.isTyping,
      blockedAt: contact.blockedAt,
      hiddenAt: contact.hiddenAt,
      vibraniumShield: contact.vibraniumShield,
    );

    await contactDb.putContact(contact);
  }
}
