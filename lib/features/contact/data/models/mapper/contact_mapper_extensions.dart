import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

extension ContactCollectionExtensions on ContactCollection {
  ContactEntity toEntity() {
    return ContactEntity(
      id: id,
      avatarId: avatarId,
      displayName: displayName,
      birthDate: birthDate,
      email: email,
      googleAccount: googleAccount,
      hasPassword: hasPassword,
      username: username,
      backgroundBlurhash: backgroundBlurhash,
      backgroundId: backgroundId,
      blocked: blocked,
      createdAt: createdAt,
      hidden: hidden,
      originalIsFriend: originalIsFriend,
      friendCanSeeMyLastSeen: friendCanSeeMyLastSeen,
      menu: menu,
      richMenu: richMenu,
      nickname: nickname,
      originalIsDeleted: originalIsDeleted,
      originalStatusMessage: statusMessage,
      onlineStatus: onlineStatus,
      phoneNumber: phoneNumber,
      type: type,
      updatedAt: updatedAt,
      lastSeenAt: lastSeenAt,
      lastTypedAt: lastTypedAt,
      isTyping: isTyping,
      settings: settings,
      vibraniumShield: vibraniumShield,
      hiddenAt: hiddenAt,
      blockedAt: blockedAt,
    );
  }
}

extension ContactEntityExtensions on ContactEntity {
  ContactCollection toCollection() {
    return ContactCollection(
      id: id,
      avatarId: avatarId,
      displayName: displayName,
      birthDate: birthDate,
      email: email,
      googleAccount: googleAccount,
      hasPassword: hasPassword,
      username: username,
      backgroundBlurhash: backgroundBlurhash,
      backgroundId: backgroundId,
      blocked: blocked,
      createdAt: createdAt,
      hidden: hidden,
      originalIsFriend: originalIsFriend,
      friendCanSeeMyLastSeen: friendCanSeeMyLastSeen,
      menu: menu,
      richMenu: richMenu,
      nickname: nickname,
      originalIsDeleted: originalIsDeleted,
      originalStatusMessage: originalStatusMessage,
      onlineStatus: onlineStatus,
      phoneNumber: phoneNumber,
      type: type,
      updatedAt: updatedAt,
      lastSeenAt: lastSeenAt,
      lastTypedAt: lastTypedAt,
      isTyping: isTyping,
      settings: settings,
      vibraniumShield: vibraniumShield,
      hiddenAt: hiddenAt,
      blockedAt: blockedAt,
    );
  }
}

extension ContactCollectionListExtensions on List<ContactCollection> {
  List<ContactEntity> toEntities() {
    return map((collection) => collection.toEntity()).toList();
  }
}

extension ContactEntityListExtensions on List<ContactEntity> {
  List<ContactCollection> toCollections() {
    return map((entity) => entity.toCollection()).toList();
  }
}
