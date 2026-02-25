import 'package:get_it/get_it.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/accounts_center/domain/services/accounts_center_service.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/clear_all_user_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/clear_shortcut_passcode_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/find_user_with_shortcut_passcode_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/get_any_account_has_shortcut_passcode_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/get_new_current_user_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/get_session_expired_account_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/process_before_add_account_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/remove_account_from_local_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/set_shortcut_passcode_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/toggle_hidden_account_use_case.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_api_service_new.dart';

Future<void> registerAccountsCenterSingletonDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<AccountsCenterService>(AccountsCenterService());
}

Future<void> registerAccountsCenterFactoryDependencies() async {
  final getIt = GetIt.instance;

  // Register use cases.
  getIt.registerFactory(
    () => ProcessBeforeAddAccountUseCase(
      userLocalRepository: getIt<UserLocalRepository>(),
      authApiServiceNew: getIt<AuthApiServiceNew>(),
    ),
  );
  getIt.registerFactory(
    () => RemoveAccountFromLocalUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
  getIt.registerFactory(
    () => ToggleHiddenAccountUseCase(
      userLocalRepository: getIt<UserLocalRepository>(),
      eventBus: eventBus,
    ),
  );
  getIt.registerFactory(
    () => SetShortCutPasscodeUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
  getIt.registerFactory(
    () => FindUserWithShortcutPasscodeUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
  getIt.registerFactory(
    () => ClearShortcutPasscodeUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
  getIt.registerFactory(
    () => GetSessionExpiredAccountUseCase(accountService: getIt<AccountService>()),
  );
  getIt.registerFactory(
    () => GetNewCurrentUserUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
  getIt.registerFactory(
    () => GetAnyAccountHasShortcutPasscodeUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
  getIt.registerFactory(
    () => ClearAllUserUseCase(userLocalRepository: getIt<UserLocalRepository>()),
  );
}
