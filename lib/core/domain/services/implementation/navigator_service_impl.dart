import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/services/navigator_service.dart';
import 'package:uchat/core/domain/services/url_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

class NavigatorServiceImpl implements NavigatorService {
  @override
  Future<void> goToAppStore() async {
    try {
      if (Platform.isIOS) {
        await GetIt.I<UrlService>().open(
          'https://apps.apple.com/th/app/uchat-messenger/id1578162044',
          mode: LauncherMode.externalNonBrowserApplication,
        );
      } else if (Platform.isAndroid) {
        await GetIt.I<UrlService>().open(
          'https://play.google.com/store/apps/details?id=social.uchat',
          mode: LauncherMode.externalNonBrowserApplication,
        );
      } else {
        useLogger().e('Unknown platform can not go to store');
        return;
      }
    } catch (e, stackTrace) {
      useLogger().e('Go to AppStore failed.', e, stackTrace);
    }
  }
}
