import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections/bookmark_tag_collection.dart';
import 'package:uchat/entities/collections/chat_category_collection.dart';
import 'package:uchat/entities/collections/sorting_collection.dart';
import 'package:uchat/features/album/data/models/collections/album_collection.dart';
import 'package:uchat/features/album/data/models/collections/album_image_collection.dart';
import 'package:uchat/features/album/data/models/collections/album_task_collection.dart';
import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';
import 'package:uchat/features/chat_folder/data/models/collections/chat_folder_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/group_permission_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/pin_message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_invite_link_collection.dart';
import 'package:uchat/features/call_log/data/models/collections/call_log_collection.dart';
import 'package:uchat/features/chat_room_list/data/models/collection/recent_search_collection.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/sticker/data/models/collections/my_sticker_collection.dart';
import 'package:uchat/features/sticker/data/models/collections/sticker_collection.dart';
import 'package:uchat/features/sticker/data/models/collections/sticker_recently_search_collection.dart';
import 'package:uchat/utils/app_env.dart';

import 'collections.dart';

final _log = useLogger();

class DbManager {
  // Singleton pattern
  static final DbManager instance = DbManager._internal();

  factory DbManager() => instance;

  DbManager._internal();

  // Start body
  String? _currentUserId;
  Isar? generalInstance;
  Isar? authenticatedInstance;

  Future<Directory> createIsarDir() async {
    final dirPath = (await getApplicationDocumentsDirectory()).path;
    final isarDir = Directory('$dirPath/isar');

    if (!isarDir.existsSync()) {
      await isarDir.create(recursive: true);
    }

    return isarDir;
  }

  Future<void> openGeneralInstance() async {
    if (generalInstance?.isOpen == true) return;

    final isarDir = await createIsarDir();

    // Close and clear data when instance has opened.
    await generalInstance?.close();

    try {
      // Open new instance.
      generalInstance = await Isar.open(
        [
          UserCollectionSchema,
          ConfigCollectionSchema,
          AnnouncementCollectionSchema,
        ],
        name: 'GENERAL',
        inspector: false,
        maxSizeMiB: 512,
        directory: isarDir.path,
      );
    } catch (e, stackTrace) {
      _log.e('Call openGeneralInstance error.', e, stackTrace);
    }
  }

  Future<void> closeGeneralInstance() async {
    // Close and clear data when instance has opened.
    await generalInstance?.close();
  }

  Future<void> deleteGeneralInstance() async {
    await generalInstance?.close(deleteFromDisk: true);
  }

  Future<void> openAuthenticatedInstance({required String userId}) async {
    if (_currentUserId == userId && authenticatedInstance?.isOpen == true) {
      return;
    }

    final isarDir = await createIsarDir();

    // Close and clear data when instance has opened.
    // _log.d(
    //   'Check closing authenticated instance for: $_currentUserId,\n'
    //   'authenticatedInstance = $authenticatedInstance',
    // );
    try {
      await authenticatedInstance?.close();
      authenticatedInstance = null;
    } catch (e, stackTrace) {
      _log.e('Call close authenticated instance error.', e, stackTrace);
    }

    try {
      // _log.d(
      //   'Opening authenticated instance for: $userId,\n'
      //   'authenticatedInstance = $authenticatedInstance',
      // );

      // Open new instance.
      authenticatedInstance = await Isar.open(
        [
          AlbumCollectionSchema,
          AlbumImageCollectionSchema,
          AlbumTaskCollectionSchema,
          ContactCollectionSchema,
          CentralNotificationCollectionSchema,
          MessageCollectionSchema,
          RoomCollectionSchema,
          StickerCollectionSchema,
          MyStickerCollectionSchema,
          RoomFileCollectionSchema,
          RoomMemberCollectionSchema,
          RoomSubscriptionCollectionSchema,
          ConfigCollectionSchema,
          OfflineTaskCollectionSchema,
          IapTransactionCollectionSchema,
          ChatFolderCollectionSchema,
          PremiumPackageCollectionSchema,
          MessageReactionCollectionSchema,
          BookmarkTagCollectionSchema,
          ChatCategoryCollectionSchema,
          SortingCollectionSchema,
          StickerRecentlySearchCollectionSchema,
          GroupPermissionCollectionSchema,
          PinMessageCollectionSchema,
          RoomInviteLinkCollectionSchema,
          RecentSearchCollectionSchema,
          CallLogCollectionSchema,
        ],
        name: 'USER-$userId',
        inspector: AppEnv.enableIsarInspector,
        maxSizeMiB: 512,
        directory: isarDir.path,
      );

      _currentUserId = userId;

      _log.d(
        'Opened authenticated instance for: $_currentUserId,\n'
        'authenticatedInstance = $authenticatedInstance',
      );
    } catch (e, stackTrace) {
      _log.e('Call openAuthenticatedInstance error.', e, stackTrace);
    }
  }

  Future<void> clearAuthenticatedInstance() async {
    await DbManager().authenticatedInstance?.writeTxn(() async {
      await authenticatedInstance?.clear();
    });
  }

  Future<void> closeAuthenticatedInstance({String? userId}) async {
    final deleteFromDisk = userId = null;
    if (userId != _currentUserId) return;

    // For authenticated instance when close instance require to clear data.
    await authenticatedInstance?.close(deleteFromDisk: deleteFromDisk);
    authenticatedInstance = null;
    _currentUserId = null;
  }

  String? get currentUserId {
    return _currentUserId;
  }
}
