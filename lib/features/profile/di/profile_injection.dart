import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/contact/data/data_source/local/contact_db.dart';
import 'package:uchat/features/profile/data/data_source/remote/profile_http_service.dart';
import 'package:uchat/features/profile/data/data_source/remote/profile_socket_service.dart';
import 'package:uchat/features/profile/data/repositories/profile_local_repository_impl.dart';
import 'package:uchat/features/profile/data/repositories/profile_server_repository_impl.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/features/profile/domain/use_cases/get_profile_local_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/get_profile_server_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/get_room_by_account_id_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/update_profile_use_case.dart';

///
/// Initialize Profile singleton Dependencies
///
Future<void> registerProfileSingletonDependencies({
  required HttpCaller httpCaller,
  required SocketCaller socketCaller,
}) async {
  final getIt = GetIt.instance;

  // Register Data Sources
  getIt.registerLazySingleton<ProfileHttpService>(
    () => ProfileHttpService(
      httpCaller: httpCaller,
    ),
  );
  getIt.registerLazySingleton<ProfileSocketService>(
    () => ProfileSocketService(
      socketCaller: socketCaller,
    ),
  );

  // Register Repositories
  getIt.registerLazySingleton<ProfileServerRepository>(
    () => ProfileServerRepositoryImpl(
      profileHttpService: getIt<ProfileHttpService>(),
      profileSocketService: getIt<ProfileSocketService>(),
      socketCaller: socketCaller,
      log: getIt<LoggerService>(),
    ),
  );
  getIt.registerLazySingleton<ProfileLocalRepository>(
    () => ProfileLocalRepositoryImpl(
      contactDb: GetIt.I<ContactDb>(),
      roomMemberDb: GetIt.I<RoomMemberDb>(),
      roomDB: GetIt.I<RoomDb>(),
    ),
  );
}

///
/// Initialize Profile factory Dependencies
///
Future<void> registerProfileFactoryDependencies(
    {required ProfileServerRepository profileServerRepository,
    required ProfileLocalRepository profileLocalRepository}) async {
  final getIt = GetIt.instance;

  // Register Use Cases
  getIt.registerFactory<GetProfileLocalUseCase>(
    () => GetProfileLocalUseCase(
      profileLocalRepository: profileLocalRepository,
    ),
  );
  getIt.registerFactory<GetProfileServerUseCase>(
    () => GetProfileServerUseCase(
      profileServerRepository: profileServerRepository,
    ),
  );

  getIt.registerFactory<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(
      profileServerRepository: profileServerRepository,
      profileLocalRepository: profileLocalRepository,
    ),
  );
  getIt.registerFactory<GetRoomByAccountIdUseCase>(
    () => GetRoomByAccountIdUseCase(
      profileLocalRepository: profileLocalRepository,
    ),
  );
}
