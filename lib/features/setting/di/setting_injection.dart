import 'package:get_it/get_it.dart';
import 'package:uchat/api/http.dart';
import 'package:uchat/api/socket.dart';
import 'package:uchat/features/cache_manager/data/repositories/cache_repository_impl.dart';
import 'package:uchat/features/cache_manager/domain/repositories/cache_repository.dart';
import 'package:uchat/features/cache_manager/domain/use_cases/clear_cache_use_case.dart';
import 'package:uchat/features/cache_manager/domain/use_cases/get_directory_stats_use_case.dart';
import 'package:uchat/features/setting/data/data_source/remote/setting_api_service.dart';
import 'package:uchat/features/setting/data/data_source/remote/setting_socket_service.dart';
import 'package:uchat/features/setting/data/repositories/setting_server_repository_impl.dart';
import 'package:uchat/features/setting/domain/repositories/setting_server_repository.dart';

import 'package:uchat/features/setting/domain/use_cases/check_can_change_phone_number_use_case.dart';
import 'package:uchat/features/setting/domain/use_cases/check_new_phone_number_use_case.dart';
import 'package:uchat/features/setting/domain/use_cases/update_phone_number_use_case.dart';

Future<void> registerSettingSingletonDependencies() async {
  final getIt = GetIt.instance;
  final httpCaller = getIt<HttpCaller>();
  final socketCaller = getIt<SocketCaller>();

  // Register Data sources
  getIt.registerSingleton<SettingApiService>(SettingApiService(httpCaller: httpCaller));
  getIt.registerSingleton<SettingSocketService>(SettingSocketService(socketCaller: socketCaller));

  // Register Repositories
  getIt.registerSingleton<SettingServerRepository>(SettingServerRepositoryImpl(
    socketCaller: socketCaller,
    settingApiService: getIt<SettingApiService>(),
    settingSocketService: getIt<SettingSocketService>(),
  ));

  getIt.registerSingleton<CacheRepository>(
    CacheRepositoryImpl(),
  );
}

Future<void> registerSettingFactoryDependencies() async {
  final getIt = GetIt.instance;

  // Register use case
  getIt.registerFactory(
    () => CheckCanChangePhoneNumberUseCase(
      settingServerRepository: getIt<SettingServerRepository>(),
    ),
  );
  getIt.registerFactory(
    () => CheckNewPhoneNumberUseCase(
      settingServerRepository: getIt<SettingServerRepository>(),
    ),
  );
  getIt.registerFactory(
    () => UpdatePhoneNumberUseCase(
      settingServerRepository: getIt<SettingServerRepository>(),
    ),
  );

  getIt.registerFactory<GetDirectoryStatsUseCase>(
    () => GetDirectoryStatsUseCase(getIt<CacheRepository>()),
  );

  getIt.registerFactory<ClearCacheUseCase>(
    () => ClearCacheUseCase(getIt<CacheRepository>()),
  );
}
