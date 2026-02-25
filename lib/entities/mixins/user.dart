import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/app_env.dart';

mixin UserMixin implements UserInterface {
  String? _showName;

  @override
  bool get hasAvatar {
    return avatarId != null && avatarId != '';
  }

  String get showName {
    _showName = displayName ?? username;
    if (_showName != null) {
      return _showName!;
    }

    return 'UNKNOWN'.tr;
  }

  bool get hasShowName {
    _showName = displayName ?? username;
    if (_showName != null) {
      return true;
    }

    return false;
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

  // TODO (improve) Change this to nullable and return null when avatarId is null.
  @override
  String get avatarUrl {
    try {
      if (avatarId != null && avatarId != '') {
        return GetIt.I<FileService>().getAvatarUrl(avatarId!);
      }

      return '${AppEnv.apiUrl}avatar/icon_no_avatar.png';
    } catch (e) {
      return '';
    }
  }

  String get avatarPublic {
    if (id != null && id != '') {
      return GetIt.I<AccountService>().getUserPublicAvatar(id!);
    }
    return 'https://api.next.uchat.social/api/v2/users/$id/public-avatar';
  }

  @override
  String get statusMessage {
    return originalStatusMessage ?? '';
  }

  @override
  set statusMessage(String? statusMessage) {
    originalStatusMessage = statusMessage;
  }

  @ignore
  @override
  String get widgetKey {
    return 'USER-$id';
  }
}
