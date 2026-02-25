import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/features/central_notification/domain/use_cases/delete_notifications_from_local_use_case.dart';

import '../data/data_source/local/central_notification_db.dart';
import '../data/data_source/remote/central_notification_api_service.dart';
import '../data/data_source/remote/central_notification_socket_service.dart';
import '../data/repository/central_notification_local_repository_impl.dart';
import '../data/repository/central_notification_server_repository_impl.dart';
import '../domain/repository/central_notification_local_repository.dart';
import '../domain/repository/central_notification_server_repository.dart';
import '../domain/use_cases/accept_room_use_case.dart';
import '../domain/use_cases/clear_local_notifications_use_case.dart';
import '../domain/use_cases/delete_notification_from_local_use_case.dart';
import '../domain/use_cases/delete_notification_use_case.dart';
import '../domain/use_cases/fetch_notifications_from_server_use_case.dart';
import '../domain/use_cases/get_all_notifications_from_local_use_case.dart';
import '../domain/use_cases/put_all_notifications_to_local_use_case.dart';
import '../domain/use_cases/put_notification_to_local_use_case.dart';

Future<void> registerCentralNotificationSingletonDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<CentralNotificationDb>(
    CentralNotificationDb(),
  );

  getIt.registerSingleton<CentralNotificationApiService>(
    CentralNotificationApiService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerSingleton<CentralNotificationSocketService>(
    CentralNotificationSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<CentralNotificationLocalRepository>(
    CentralNotificationLocalRepositoryImpl(
      centralNotificationDb: getIt<CentralNotificationDb>(),
    ),
  );

  getIt.registerSingleton<CentralNotificationServerRepository>(
    CentralNotificationServerRepositoryImpl(
      socketCaller: getIt<SocketCaller>(),
      centralNotificationApiService: getIt<CentralNotificationApiService>(),
      centralNotificationSocketService: getIt<CentralNotificationSocketService>(),
    ),
  );
}

Future<void> registerCentralNotificationFactoryDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerFactory(
    () => AcceptRoomUseCase(),
  );

  getIt.registerFactory(
    () => ClearLocalNotificationsUseCase(),
  );

  getIt.registerFactory(
    () => DeleteNotificationFromLocalUseCase(),
  );

  getIt.registerFactory(
    () => DeleteNotificationsUseCase(),
  );

  getIt.registerFactory(
    () => FetchNotificationsFromServerUseCase(),
  );

  getIt.registerFactory(
    () => GetAllNotificationsFromLocalUseCase(),
  );

  getIt.registerFactory(
    () => PutAllNotificationsToLocalUseCase(),
  );

  getIt.registerFactory(
    () => PutNotificationToLocalUseCase(),
  );

  getIt.registerFactory(
    () => DeleteNotificationsFromLocalUseCase(),
  );
}
