import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

import '../../../domain/services/meta_service.dart';
import '../models/payloads/app_version/check_app_version.dart';
import 'backend_path.dart' as backend_path;

class AppVersionHttpDataSource {
  final HttpCaller httpCaller;
  final MetaService metaService;

  AppVersionHttpDataSource({required this.httpCaller, required this.metaService});

  ///
  /// Fetches the app version from the server.
  ///
  Future<CheckAppVersionResponse?> checkAppVersion() async {
    final appVersion = metaService.appVersion;
    final osName = metaService.deviceType.toUpperCase();

    useLogger().d('ZZZ => Checking app version: $appVersion on OS: $osName');

    final request = CheckAppVersionRequest(
      osName: osName,
      version: appVersion,
    );

    final httpResp = await httpCaller.post(
      backend_path.checkAppVersion.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3((data) => CheckAppVersionResponse.fromMap(data));
  }
}
