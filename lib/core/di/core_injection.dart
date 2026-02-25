import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/core/data/repositories/platform_document_repository_impl.dart';
import 'package:uchat/core/domain/repositories/platform_document_repository.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/core/domain/services/implementation/url_service_impl.dart';
import 'package:uchat/core/domain/services/platform_document_service.dart';
import 'package:uchat/core/domain/services/security_service.dart';
import 'package:uchat/core/domain/services/snackbar_service.dart';
import 'package:uchat/core/domain/services/url_service.dart';
import 'package:uchat/core/domain/use_cases/get_all_users_use_case.dart';
import 'package:uchat/core/domain/use_cases/get_chat_room_for_share_use_case.dart';
import 'package:uchat/core/domain/use_cases/get_recent_chat_room_for_share_use_case.dart';
import 'package:uchat/core/domain/use_cases/get_user_by_id_use_case.dart';
import 'package:uchat/core/domain/use_cases/get_user_count_use_case.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_debug_toggle_service.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_logger.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/utils/link_preview_wrapper.dart';
import 'package:uchat/utils/vibrate.dart';

import '../data/data_sources/local/platform_document_local_data_source.dart';
import '../data/data_sources/remote/app_version_http_data_source.dart';
import '../data/data_sources/remote/platform_document_http_data_source.dart';
import '../domain/services/app_version_service.dart';
import '../domain/services/dialog_service.dart';
import '../domain/services/implementation/app_version_service_impl.dart';
import '../domain/services/implementation/native_method_channel_service_impl.dart';
import '../domain/services/implementation/navigator_service_impl.dart';
import '../domain/services/implementation/platform_document_service_impl.dart';
import '../domain/services/life_cycle_service.dart';
import '../domain/services/meta_service.dart';
import '../domain/services/native_method_channel_service.dart';
import '../domain/services/navigator_service.dart';
import '../presentation/services/dialog_service_impl.dart';
import '../presentation/services/life_cycle_service_impl.dart';
import '../presentation/services/security_service_impl.dart';
import '../presentation/services/snackbar_service_impl.dart';
import '../services/messaging/message_queue_service.dart';

Future<void> registerCoreSingletonDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<NativeMethodChannelService>(NativeMethodChannelServiceImpl());
  getIt.registerSingleton<DialogService>(DialogServiceImpl());
  getIt.registerSingleton<SnackbarService>(SnackbarServiceImpl());
  getIt.registerSingleton<NavigatorService>(NavigatorServiceImpl());
  getIt.registerSingleton<UrlService>(UrlServiceImpl());

  // Register debug services
  getIt.registerSingleton<NotificationDebugToggleService>(NotificationDebugToggleService());
  getIt.registerSingleton<NotificationLogger>(NotificationLogger());

  // Register di for life cycle and using get x for presentation use
  getIt.registerSingleton<LifeCycleService>(LifeCycleServiceImpl());
  Get.put<LifeCycleService>(getIt<LifeCycleService>());

  // Register di for security service and using get x for presentation use
  getIt.registerLazySingleton<SecurityService>(
    () => SecurityServiceImpl(
      authConfig: ConfigDb.instance.authenticated,
      generalConfig: ConfigDb.instance.general,
    ),
  );
  Get.put<SecurityService>(getIt<SecurityService>());

  //
  // App Version Registration
  //
  getIt.registerLazySingleton<AppVersionHttpDataSource>(
    () => AppVersionHttpDataSource(
      httpCaller: getIt<HttpCaller>(),
      metaService: getIt<MetaService>(),
    ),
  );

  getIt.registerLazySingleton<AppVersionService>(
    () => AppVersionServiceImpl(
      httpDataSource: getIt<AppVersionHttpDataSource>(),
      metaService: getIt<MetaService>(),
      dialogService: getIt<DialogService>(),
      navigatorService: getIt<NavigatorService>(),
      generalConfig: ConfigDb.instance.general,
    ),
  );

  //
  // Platform Document Registration
  //
  getIt.registerLazySingleton<PlatformDocumentHttpDataSource>(
    () => PlatformDocumentHttpDataSource(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerLazySingleton<PlatformDocumentLocalDataSource>(
    () => PlatformDocumentLocalDataSource(
      config: ConfigDb.instance.general,
    ),
  );

  getIt.registerLazySingleton<PlatformDocumentRepository>(
    () => PlatformDocumentRepositoryImpl(
      httpDataSource: getIt<PlatformDocumentHttpDataSource>(),
      localDataSource: getIt<PlatformDocumentLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<PlatformDocumentService>(
    () => PlatformDocumentServiceImpl(
      repository: getIt<PlatformDocumentRepository>(),
    ),
  );

  getIt.registerLazySingleton<VibrateUtil>(() => VibrateUtil());

  getIt.registerLazySingleton<LinkPreviewWrapper>(() => const LinkPreviewWrapper());
}

Future<void> initializeCoreSingletonDependencies() async {
  final getIt = GetIt.instance;

  await getIt<NativeMethodChannelService>().initialize();

  // Initialize notification logger
  getIt<NotificationLogger>().initialize();

  await getIt<AppVersionService>().initialize();

  getIt.registerSingleton<MessageQueueService>(
    MessageQueueService(),
    instanceName: MessageQueueService.instanceNameMessage,
  );
  getIt.registerSingleton<MessageQueueService>(
    MessageQueueService(),
    instanceName: MessageQueueService.instanceNameMedia,
  );
}

Future<void> registerCoreFactoryDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerFactory<GetChatRoomForShareUseCase>(() => GetChatRoomForShareUseCase());
  getIt.registerFactory<GetRecentChatRoomForShareUseCase>(
    () => GetRecentChatRoomForShareUseCase(
      getIt<ChatRoomLocalRepository>(),
      getIt<FileService>(),
    ),
  );
  getIt.registerFactory(
    () => GetAllUsersUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
  getIt.registerFactory(
    () => GetUserCountUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
  getIt.registerFactory(
    () => GetUserByIdUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
}
