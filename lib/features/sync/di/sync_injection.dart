import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/central_notification/domain/use_cases/get_all_notifications_from_local_use_case.dart';
import 'package:uchat/features/central_notification/domain/use_cases/put_all_notifications_to_local_use_case.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_file_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_subscription_local_repository.dart';
import 'package:uchat/features/sync/data/data_source/remote/firebase_realtime_database_service.dart';
import 'package:uchat/features/sync/data/repositories/firebase_realtime_database_repository_impl.dart';
import 'package:uchat/features/sync/domain/repositories/firebase_realtime_database_repository.dart';
import 'package:uchat/features/sync/domain/use_cases/fetch_specific_firebase_state_use_case.dart';
import 'package:uchat/features/chat_room/utils/chat_room_utils.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/delete_contact_without_txn_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/put_contact_without_txn_use_case.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_message_bookmark_tags_use_case.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_message_use_case.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_user_use_case.dart';
import 'package:uchat/utils/encrypt_helper.dart';

import '../data/data_source/remote/sync_http_service.dart';
import '../data/data_source/remote/sync_socket_service.dart';
import '../data/repositories/sync_server_repository_impl.dart';
import '../domain/repositories/sync_server_repository.dart';
import '../domain/services/sync_service.dart';
import '../domain/use_cases/fetch_specific_state_use_case.dart';
import '../domain/use_cases/process_group_default_use_case.dart';
import '../domain/use_cases/process_group_friend_use_case.dart';
import '../domain/use_cases/process_group_message_use_case.dart';
import '../domain/use_cases/process_group_room_subscription_use_case.dart';
import '../domain/use_cases/process_group_room_use_case.dart';
import '../domain/use_cases/sync_handle_update_has_first_other_in_room_use_case.dart';
import '../domain/use_cases/sync_handle_update_room_subscription_use_case.dart';
import '../domain/use_cases/sync_handle_update_room_use_case.dart';

///
/// Initialize all singleton dependencies for sync feature.
///
Future<void> registerSyncSingletonDependencies({
  required HttpCaller httpCaller,
  required SocketCaller socketCaller,
}) async {
  final getIt = GetIt.instance;

  // Register all required services.
  final syncHttpService = getIt.registerSingleton<SyncHttpService>(
    SyncHttpService(httpCaller: httpCaller),
  );

  final syncSocketService = getIt.registerSingleton<SyncSocketService>(
    SyncSocketService(socketCaller: socketCaller),
  );

  // Register server call repository.
  getIt.registerSingleton<SyncServerRepository>(
    SyncServerRepositoryImpl(
      syncHttpService: syncHttpService,
      syncSocketService: syncSocketService,
    ),
  );

  // Register service
  getIt.registerSingleton<SyncService>(SyncService());
  getIt.registerSingleton<FirebaseRealtimeDatabaseService>(FirebaseRealtimeDatabaseService());

  getIt.registerSingleton<FirebaseRealtimeDatabaseRepository>(FirebaseRealtimeDatabaseRepositoryImpl(
    firebaseRealtimeDatabaseService: getIt<FirebaseRealtimeDatabaseService>(),
  ));
}

///
/// Initialize all factory dependencies for sync feature.
///
Future<void> registerSyncFactoryDependencies({
  required SyncService syncService,
  required ChatRoomLocalCompatRepository chatRoomLocalRepository,
  required RoomSubscriptionLocalRepository roomSubscriptionLocalRepository,
  required RoomFileLocalRepository roomFileLocalRepository,
  required MessageLocalRepository messageLocalRepository,
  required RoomMemberLocalRepository roomMemberLocalRepository,
  required FirebaseRealtimeDatabaseRepository firebaseRealtimeDatabaseRepository,
  required PinMessageLocalRepository pinMessageLocalRepository,
}) async {
  final getIt = GetIt.instance;

  // Register use cases
  getIt.registerFactory<ProcessGroupDefaultUseCase>(
    () => ProcessGroupDefaultUseCase(
      messageLocalRepository: messageLocalRepository,
      pinMessageLocalRepository: pinMessageLocalRepository,
    ),
  );
  getIt.registerFactory<ProcessGroupFriendUseCase>(
    () => ProcessGroupFriendUseCase(
      log: GetIt.I<LoggerService>(),
      eventBus: eventBus,
      roomSubDb: GetIt.I<RoomSubscriptionDb>(),
      roomMemberDb: GetIt.I<RoomMemberDb>(),
      messageDb: GetIt.I<MessageDb>(),
      contactLocalRepository: GetIt.I<ContactLocalRepository>(),
      syncHandleUpdateUserUseCase: GetIt.I<SyncHandleUpdateUserUseCase>(),
      getContactUseCase: GetIt.I<GetContactUseCase>(),
      deleteContactWithoutTxnUseCase: GetIt.I<DeleteContactWithoutTxnUseCase>(),
      putContactWithoutTxnUseCase: GetIt.I<PutContactWithoutTxnUseCase>(),
      getAllNotificationsFromLocalUseCase: GetIt.I<GetAllNotificationsFromLocalUseCase>(),
      putAllNotificationsToLocalUseCase: GetIt.I<PutAllNotificationsToLocalUseCase>(),
    ),
  );
  getIt.registerFactory<ProcessGroupMessageUseCase>(
    () => ProcessGroupMessageUseCase(),
  );
  getIt.registerFactory<ProcessGroupRoomSubscriptionUseCase>(
    () => ProcessGroupRoomSubscriptionUseCase(),
  );
  getIt.registerFactory<ProcessGroupRoomUseCase>(
    () => ProcessGroupRoomUseCase(),
  );
  getIt.registerFactory<SyncHandleUpdateHasFirstOtherInRoomUseCase>(
    () => SyncHandleUpdateHasFirstOtherInRoomUseCase(
      roomSubscriptionLocalRepository: roomSubscriptionLocalRepository,
      roomMemberLocalRepository: roomMemberLocalRepository,
    ),
  );
  getIt.registerFactory<SyncHandleUpdateRoomSubscriptionUseCase>(
    () => SyncHandleUpdateRoomSubscriptionUseCase(
      log: GetIt.I<LoggerService>(),
      eventBus: eventBus,
      syncService: syncService,
      chatRoomUtils: GetIt.I<IChatRoomUtils>(),
      encryptHelper: EncryptHelper.instance,
      chatRoomLocalRepository: chatRoomLocalRepository,
      roomSubscriptionLocalRepository: roomSubscriptionLocalRepository,
      roomFileLocalRepository: roomFileLocalRepository,
      messageLocalRepository: GetIt.I<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<SyncHandleUpdateRoomUseCase>(
    () => SyncHandleUpdateRoomUseCase(),
  );
  getIt.registerFactory<SyncHandleUpdateUserUseCase>(
    () => SyncHandleUpdateUserUseCase(),
  );
  getIt.registerFactory<SyncHandleUpdateMessageBookmarkTagsUseCase>(
    () => SyncHandleUpdateMessageBookmarkTagsUseCase(),
  );
  getIt.registerFactory<SyncHandleUpdateMessageUseCase>(
    () => SyncHandleUpdateMessageUseCase(
      messageLocalRepository: messageLocalRepository,
      roomSubscriptionLocalRepository: roomSubscriptionLocalRepository,
      roomFileLocalRepository: roomFileLocalRepository,
    ),
  );

  getIt.registerFactory<FetchSpecificStateUseCase>(() => FetchSpecificStateUseCase());
  getIt.registerFactory<FetchSpecificFirebaseStateUseCase>(
    () => FetchSpecificFirebaseStateUseCase(
      firebaseRealtimeDatabaseRepository: firebaseRealtimeDatabaseRepository,
    ),
  );
}
