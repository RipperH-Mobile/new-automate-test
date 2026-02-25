import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/auth_code_verify_token_use_case.dart';

import '../domain/repositories/auth_server_repository.dart';

/// This file is part of the Auth feature's dependency injection setup.
Future<void> registerAuthFactoryDependencies() async {
  final getIt = GetIt.instance;

  // Register use cases
  getIt.registerFactory<AuthCodeVerifyTokenUseCase>(
    () => AuthCodeVerifyTokenUseCase(authServerRepository: getIt<AuthServerRepository>()),
  );
}
