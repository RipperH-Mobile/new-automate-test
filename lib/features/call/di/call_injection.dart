import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';

import '../data/data_source/remote/voip_http_service.dart';

///
/// Initialize all singleton dependencies for calling feature.
///
Future<void> registerCallingSingletonDependencies({
  required HttpCaller httpCaller,
}) async {
  final getIt = GetIt.instance;

  // Register all required services.
  getIt.registerSingleton<VoipHttpService>(
    VoipHttpService(httpCaller: httpCaller),
  );
}

///
/// Initialize all factory dependencies for calling feature.
///
Future<void> registerCallingFactoryDependencies() async {
  // TODO: Implement this function
}
