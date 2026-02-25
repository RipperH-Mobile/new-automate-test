import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/di/injector.dart';
import 'package:uchat/features/accounts_center/di/accounts_center_injection.dart';
import 'package:uchat/features/album/di/album_injection.dart';
import 'package:uchat/features/call/di/call_injection.dart';
import 'package:uchat/features/central_notification/di/central_notification_injection.dart';
import 'package:uchat/features/chat_folder/di/chat_folder_injection.dart';
import 'package:uchat/features/chat_room/chat_room_injection.dart';
import 'package:uchat/features/chat_room_detail/di/chat_room_detail_injection.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/contact/di/contact_injection.dart';
import 'package:uchat/features/media_gallery/di/media_gallery_injection.dart';
import 'package:uchat/features/profile/di/profile_injection.dart';
import 'package:uchat/features/setting/di/setting_injection.dart';
import 'package:uchat/features/sticker/di/sticker_injection.dart';
import 'package:uchat/features/sync/di/sync_injection.dart';

import '../../../di/core_injection.dart';
import '../../../di/notification_injection.dart';
import '../../../di/orchestrator_injection.dart';
import '../common/task_result.dart';

///
/// Register singleton dependencies
/// To register first, then it can be used with other places where it needs to be used.
/// !!! Only register class to GetIt instance.
///
Future<TaskResult> registerSingletonDependencies() async {
  final getIt = GetIt.instance;

  //
  // Main singletons
  // TODO: Waiting for separate by feature
  //
  await initSingletons();
  provideDataSources();
  provideRepositories();

  //
  // Core singletons
  //
  await registerCoreSingletonDependencies();
  await registerOrchestratorSingletonDependencies();
  await registerNotificationSingletonDependencies();

  //
  // Feature: Call (Calling)
  //
  await registerCallingSingletonDependencies(
    httpCaller: getIt<HttpCaller>(),
  );

  //
  // Feature: Central Notification
  //
  await registerCentralNotificationSingletonDependencies();

  //
  // Feature: Contact
  //
  await registerContactSingletonDependencies();

  //
  // Feature: Chat Room, Chat Room Detail, Chat Room List
  //
  await registerChatRoomSingletonDependencies();
  await registerChatRoomDetailSingletonDependencies();

  //
  // Feature: Accounts Center
  //
  await registerAccountsCenterSingletonDependencies();

  //
  // Feature: Album
  //
  await registerAlbumSingletonDependencies();

  //
  // Feature: Sync
  //
  await registerSyncSingletonDependencies(
    httpCaller: getIt<HttpCaller>(),
    socketCaller: getIt<SocketCaller>(),
  );

  //
  // Feature: Chat Folder
  //
  await registerChatFolderSingletonDependencies(
    httpCaller: getIt<HttpCaller>(),
    socketCaller: getIt<SocketCaller>(),
  );

  //
  // Feature: Sticker
  //
  await registerStickerSingletonDependencies(
    httpCaller: getIt<HttpCaller>(),
    socketCaller: getIt<SocketCaller>(),
  );

  //
  // Feature: Profile
  //
  await registerProfileSingletonDependencies(
    httpCaller: getIt<HttpCaller>(),
    socketCaller: getIt<SocketCaller>(),
  );

  // ! Change this to injection instead of register global ? not sure
  //
  // Feature: Setting
  //
  await registerSettingSingletonDependencies();

  //
  // Feature: Coin
  //
  await registerCoinSingletonDependencies(
    httpCaller: getIt<HttpCaller>(),
    socketCaller: getIt<SocketCaller>(),
  );

  //
  // Feature: Media Gallery
  //
  await registerMediaGallerySingletonDependencies();

  return TaskResult.next;
}

///
/// After register all singleton classes, initialize them.
///
Future<TaskResult> initializeSingletonDependencies() async {
  //
  // Core singletons
  //
  await initializeCoreSingletonDependencies();
  await initializeOrchestratorSingletonDependencies();
  await initializeNotificationSingletonDependencies();

  return TaskResult.next;
}
