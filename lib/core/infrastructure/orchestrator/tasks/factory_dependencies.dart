import 'package:get_it/get_it.dart';
import 'package:uchat/core/di/core_injection.dart';
import 'package:uchat/di/injector.dart';
import 'package:uchat/features/accounts_center/di/accounts_center_injection.dart';
import 'package:uchat/features/album/di/album_injection.dart';
import 'package:uchat/features/auth/di/auth_injection.dart';
import 'package:uchat/features/central_notification/di/central_notification_injection.dart';
import 'package:uchat/features/chat_folder/di/chat_folder_injection.dart';
import 'package:uchat/features/chat_folder/domain/chat_folder_domain.dart';
import 'package:uchat/features/chat_room/chat_room_injection.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room_detail/di/chat_room_detail_injection.dart';
import 'package:uchat/features/chat_room_list/di/chat_room_list_injection.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/contact/di/contact_injection.dart';
import 'package:uchat/features/profile/di/profile_injection.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/features/setting/di/setting_injection.dart';
import 'package:uchat/features/sticker/di/sticker_injection.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_remote_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/sticker_search_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/features/sync/di/sync_injection.dart';
import 'package:uchat/features/sync/domain/repositories/firebase_realtime_database_repository.dart';
import 'package:uchat/features/sync/domain/services/sync_service.dart';
import 'package:uchat/features/sync/domain/sync_domain.dart';

import '../common/task_result.dart';

///
/// Register factory dependencies
/// Centralized place to register all factory dependencies.
///
Future<TaskResult> registerFactoryDependencies() async {
  final getIt = GetIt.instance;

  //
  // Main singletons
  // TODO: Waiting for separate by feature
  //
  provideUseCases();
  provideFlowManager();

  await registerCoreFactoryDependencies();

  // Feature: Accounts Center
  await registerAccountsCenterFactoryDependencies();

  //
  // Feature: Auth
  //
  await registerAuthFactoryDependencies();

  //
  // Feature: Central Notification
  //
  await registerCentralNotificationFactoryDependencies();

  //
  // Feature: Contact
  //
  await registerContactFactoryDependencies();

  //
  // Feature: Chat Room, Chat Room Detail, Chat Room List
  //
  await registerChatRoomFactoryDependencies();
  await registerChatRoomDetailFactoryDependencies();
  await registerChatRoomListFactoryDependencies();

  //
  // Feature: Album
  //
  await registerAlbumFactoryDependencies();

  //
  // Feature: Sync
  //
  await registerSyncFactoryDependencies(
    syncService: getIt<SyncService>(),
    chatRoomLocalRepository: getIt<ChatRoomLocalCompatRepository>(),
    roomSubscriptionLocalRepository: getIt<RoomSubscriptionLocalRepository>(),
    roomFileLocalRepository: getIt<RoomFileLocalRepository>(),
    messageLocalRepository: getIt<MessageLocalRepository>(),
    roomMemberLocalRepository: getIt<RoomMemberLocalRepository>(),
    firebaseRealtimeDatabaseRepository: getIt<FirebaseRealtimeDatabaseRepository>(),
    pinMessageLocalRepository: getIt<PinMessageLocalRepository>(),
  );

  //
  // Feature: Chat Folder
  //
  await registerChatFolderFactoryDependencies(
    chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
    chatFolderLocalRepository: getIt<ChatFolderLocalRepository>(),
  );

  //
  // Feature: Profile
  //
  await registerProfileFactoryDependencies(
    profileServerRepository: getIt<ProfileServerRepository>(),
    profileLocalRepository: getIt<ProfileLocalRepository>(),
  );

  //
  // Feature: Setting
  //
  await registerSettingFactoryDependencies();

  //
  // Feature: Coin
  //
  await registerCoinFactoryDependencies();

  //
  // Feature: Sticker
  //
  await registerStickerFactoryDependencies(
    myStickerLocalRepository: getIt<MyStickerLocalRepository>(),
    myStickerRemoteRepository: getIt<MyStickerRemoteRepository>(),
    storeStickerLocalRepository: getIt<StoreStickerLocalRepository>(),
    storeStickerRemoteRepository: getIt<StoreStickerRemoteRepository>(),
    stickerSearchLocalRepository: getIt<StickerSearchLocalRepository>(),
  );

  return TaskResult.next;
}
