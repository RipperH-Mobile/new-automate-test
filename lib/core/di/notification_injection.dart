import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/services/life_cycle_service.dart';
import 'package:uchat/core/domain/services/security_service.dart';
import 'package:uchat/core/domain/services/snackbar_service.dart';

import '../infrastructure/notification/implementation/notification_onesignal_manager_impl.dart';
import '../infrastructure/notification/notification_manager.dart';

Future<void> registerNotificationSingletonDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<NotificationManager>(
    () => NotificationOnesignalManagerImpl(
      userService: UserController.instance,
      snackbarService: getIt<SnackbarService>(),
      lifeCycleService: getIt<LifeCycleService>(),
      securityService: getIt<SecurityService>(),
    ),
  );
}

Future<void> initializeNotificationSingletonDependencies() async {
  final getIt = GetIt.instance;

  await getIt<NotificationManager>().initialize();
}
