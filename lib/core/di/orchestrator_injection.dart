import 'package:get_it/get_it.dart';

import '../infrastructure/orchestrator/navigation/deep_link_handler.dart';
import '../infrastructure/orchestrator/navigation/navigation_coordinator.dart';
import '../infrastructure/orchestrator/navigation/share_handler.dart';

///
/// Register singleton dependencies for orchestrator.
/// This function registers the Orchestrator, NavigationCoordinator,
/// and DeepLinkHandler as singletons in the GetIt service locator.
///
Future<void> registerOrchestratorSingletonDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<DeepLinkHandler>(DeepLinkHandler());
  getIt.registerSingleton<ShareHandler>(ShareHandler());
  getIt.registerSingleton<NavigationCoordinator>(NavigationCoordinator());
}

///
/// Initialize singleton dependencies for orchestrator.
/// This function initializes the DeepLinkHandler and NavigationCoordinator
///
Future<void> initializeOrchestratorSingletonDependencies() async {
  final getIt = GetIt.instance;

  await getIt<DeepLinkHandler>().initialize();
  await getIt<ShareHandler>().initialize();
  await getIt<NavigationCoordinator>().initialize();
}
