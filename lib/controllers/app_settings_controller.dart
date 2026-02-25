import 'dart:async';

import 'package:async/async.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/services/meta_service.dart';
import 'package:uchat/core/domain/services/security_service.dart';
import 'package:uchat/core/domain/use_cases/get_public_config_use_case.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/cache_manager/presentation/screens/cache_overview_screen.dart';
import 'package:uchat/features/sync/domain/sync_domain.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets.dart';

final _log = useLogger();

class AppSettingsController extends GetxController {
  static AppSettingsController get instance => Get.find<AppSettingsController>();

  final appName = ''.obs;
  final packageName = ''.obs;
  final version = ''.obs;
  final buildNumber = ''.obs;
  final debugTapCount = 0.obs;
  final isOaUserInDb = false.obs;
  final enableEventBusTracking = false.obs;
  final _publicSettingCache = AsyncCache<String?>(const Duration(minutes: 30));

  ScrollController scrollController = ScrollController();

  ConfigInstance get generalConfig {
    return ConfigDb().general;
  }

  GetPublicConfigUseCase get getPublicConfigUseCase {
    return GetIt.I<GetPublicConfigUseCase>();
  }

  void initPackageInfo() {
    appName(GetIt.I<MetaService>().appName);
    packageName(GetIt.I<MetaService>().appId);
    version(GetIt.I<MetaService>().appVersion);
    buildNumber(GetIt.I<MetaService>().appBuildNumber);

    // Load event bus tracking configuration
    loadEventBusTrackingConfig();
  }

  Future<void> fetchPublicConfig({Duration timeout = const Duration(milliseconds: 1500)}) async {
    final helpCenterId = await _publicSettingCache.fetch(
      () async {
        String? id;

        try {
          final res = await getPublicConfigUseCase.call(NoParams()).timeout(timeout);

          id = res.helpCenterId;
          if (id != null && id.isNotEmpty && id != '-') {
            isOaUserInDb.value = true;
          }
        } on TimeoutException catch (e, s) {
          _log.i('Fetch public config timeout.', e, s);
        } catch (e, s) {
          _log.e('fetchPublicConfig error.', e, s);
        }

        return id;
      },
    );

    if (helpCenterId == null) return;

    await generalConfig.saveConfig(
      key: ConfigDb.getOAAccountIdConfigKey(),
      value: helpCenterId,
    );
  }

  void getAndSaveOaSystemAccountId(String? osSystemAccountId) async {
    if (osSystemAccountId == null) return;

    await generalConfig.saveConfig(
      key: ConfigDb.getOASystemAccountIdConfigKey(),
      value: osSystemAccountId,
    );
  }

  void handleBack() {
    Get.back();
  }

  void handleTapBuildVersion() async {
    final securityService = GetIt.I<SecurityService>();

    _log.d('handleTapBuildVersion ${debugTapCount()}');

    if (securityService.hasPasscode) {
      debugTapCount(debugTapCount() + 1);

      if (debugTapCount() == 6) {
        debugTapCount(0);

        eventBus.fire(PasscodeLaunchEvent(isDebug: true));
      }
    }

    EasyDebounce.debounce(
      'clearDebugTapCount',
      const Duration(seconds: 30),
      () async {
        debugTapCount(0);
      },
    );
  }

  void handleNoti() {
    Get.toNamed(Routes.settingNotification);
  }

  void handlePremiumPackagesStore() {
    Get.toNamed(Routes.settingPremiumPacksStore);
  }

  void handleTerms() async {
    Get.toNamed(Routes.settingTermsAndConditions);
  }

  void handlePrivacyPolicy() async {
    Get.toNamed(Routes.settingPrivacyPolicy);
  }

  void handleAboutApp() {
    Get.toNamed(Routes.aboutApp);
  }

  void handleChat() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickHiddenChats);
    Get.toNamed(Routes.settingChatHidden);
  }

  void handleCall() {
    Get.toNamed(Routes.settingCall);
  }

  void setRoutesSettingRightPanel({required String routes}) {
    // TODO: desktop implement
  }

  void handleDeveloperTools() {
    Get.toNamed(Routes.devTools);
  }

  void handleTroubleshoot() {
    Get.toNamed(Routes.settingTroubleshoot);
  }

  void handleCacheManager() {
    Get.to(const CacheOverviewScreen());
  }

  void handleTalker() {
    Get.toNamed(Routes.settingTalker);
  }

  void handleNotificationDebug() {
    Get.toNamed(Routes.notificationDebug);
  }

  void handleChangeLanguage() {
    Get.toNamed(Routes.settingChangeLanguage);
  }

  void handleHelpCenter() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickHelpCenter);
    Get.toNamed(Routes.settingHelpCenter);
  }

  void handleChangeFont() {
    Get.toNamed(Routes.settingChangeFont);
  }

  String get versionString {
    final stateSchemaVersion = GetIt.I<SyncService>().stateSchemaVersion;

    return '@version (Build @build / Database @databaseVersion)'.trParams(
      {
        'version': version(),
        'build': buildNumber(),
        'databaseVersion': stateSchemaVersion.toString(),
      },
    );
  }

  void toggleEnableEventBusTracking(bool? value) async {
    try {
      await UChatLoading.show(status: value == true ? 'Enabling tracking...' : 'Disabling tracking...');

      enableEventBusTracking.value = value ?? false;

      await generalConfig.saveConfig(
        key: ConfigDb.getEnableEventBusTrackingKey(),
        value: value,
      );

      setEventTrackingEnabled(value ?? false);

      await UChatLoading.hide();
      UChatLoading.success(
        message: value == true ? 'Event tracking enabled' : 'Event tracking disabled',
      );
    } catch (e, stackTrace) {
      _log.e('toggleEnableEventBusTracking error.', e, stackTrace);
      await UChatLoading.hide();
      UChatLoading.failed(message: 'Failed to toggle tracking');
    }
  }

  void loadEventBusTrackingConfig() async {
    enableEventBusTracking.value = await generalConfig.getBoolWithDefault(
      key: ConfigDb.getEnableEventBusTrackingKey(),
      defaultValue: false,
    );

    // Apply setting to event bus
    if (enableEventBusTracking.value) {
      setEventTrackingEnabled(true);
    }
  }

  UserController get userCtl {
    return Get.find<UserController>();
  }

  AppController get appCtl {
    return Get.find<AppController>();
  }
}
