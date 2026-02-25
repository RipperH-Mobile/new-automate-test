import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/services/app_version_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/notification/notification_manager.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/call_native_method_channel.dart';
import 'package:uchat/features/home/home_controller.dart';
import 'package:uchat/features/setting/domain/use_cases/generate_data_for_stress_test_use_case.dart';
import 'package:uchat/features/sync/domain/events/init_complete_event.dart';
import 'package:uchat/features/sync/domain/services/sync_processor_service.dart';
import 'package:uchat/features/sync/domain/services/sync_service.dart';
import 'package:uchat/screens/setting_troubleshoot/proxy/proxy_settings_controller.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

import 'proxy/proxy_settings_dialog.dart';
import 'stress_test_config_dialog.dart';

final _log = useLogger();

class SettingTroubleshootController extends GetxController {
  final enableScreenRecordInSecretChat = false.obs;
  final enableLogToTalker = false.obs;
  final enableTroubleshootEasyAccess = false.obs;
  final enableFirebaseState = false.obs;

  final configGeneral = GetIt.I<ConfigDb>().general;
  final configAuthenticated = GetIt.I<ConfigDb>().authenticated;

  StreamSubscription? resetCompleteSubscription;

  bool get isForceUpdate => GetIt.I<AppVersionService>().lastVersionForceUpdate;
  final enableWarMode = false.obs;

  @override
  void onInit() async {
    enableScreenRecordInSecretChat.value = await configAuthenticated.getBoolWithDefault(
      key: ConfigDb.getEnableScreenRecordInSecretChatConfigKey(),
      defaultValue: false,
    );

    enableLogToTalker.value = await configGeneral.getBoolWithDefault(
      key: ConfigDb.getEnableLogToTalkerKey(),
      defaultValue: false,
    );

    enableTroubleshootEasyAccess.value = await configGeneral.getBoolWithDefault(
      key: ConfigDb.getEnableTroubleshootEasyAccess(),
      defaultValue: false,
    );

    enableWarMode.value = await configAuthenticated.getBoolWithDefault(
      key: ConfigDb.getEnableWarModeConfigKey(),
      defaultValue: false,
    );

    _getOnesignalTag();

    super.onInit();
  }

  @override
  void onClose() {
    resetCompleteSubscription?.cancel();
    super.onClose();
  }

  void handleBack() {
    Get.back();
  }

  void handleCopy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    await UChatLoading.success(message: 'Copied!'.tr);
  }

  void handleResetState() async {
    await UChatLoading.show(status: 'Resetting...'.tr);
    SocketCaller().disconnect();
    SocketCaller().connect();

    syncSvc.addInitQueue();
    resetCompleteSubscription = eventBus.on<InitCompleteEvent>().listen((event) async {
      if (event.isError) {
        await UChatLoading.failed(message: 'Reset failed!'.tr);
      } else {
        await UChatLoading.success(message: 'Reset complete!'.tr);
      }
      resetCompleteSubscription?.cancel();
      resetCompleteSubscription = null;
    });
  }

  void handleSendDebugInformation() async {
    try {
      await useLogger().sendTroubleshootMessage(topic: 'debug_information');
      await UChatLoading.success(message: 'Send debug information success!'.tr);
    } catch (e, stackTrace) {
      useLogger().e('Failed to send debug information', e, stackTrace);
      await UChatLoading.failed(message: 'Send debug information failed!'.tr);
    }
  }

  void handleDisconnectSocket() async {
    SocketCaller().disconnect(afterDisconnect: () {
      UChatLoading.clearToast();
      UChatLoading.success(message: 'Disconnect complete!'.tr);
    });
  }

  void handleReconnectSocket() async {
    SocketCaller().reconnect();
  }

  ///
  /// Create mock data for stress test by creating collection and add it to local db.
  ///
  void addDataForStressTest(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => StressTestConfigDialog(
        onConfirm: (StressTestParams params) async {
          await _executeStressTestWithParams(context, params);
        },
      ),
    );
  }

  /// Execute stress test data generation with custom parameters
  Future<void> _executeStressTestWithParams(BuildContext context, StressTestParams params) async {
    final totalMessages = (params.contactCount + params.groupCount + params.oaCount) * params.messageCount;

    // Show confirmation dialog with actual numbers
    UChatNewDialog.showDialog(
      context: context,
      title: 'Confirm Stress Test'.tr,
      description: 'This will generate:\n'
              '• ${params.messageCount} messages per room\n'
              '• ${params.contactCount} friend contacts\n'
              '• ${params.groupCount} group chats\n'
              '• ${params.oaCount} official accounts\n'
              '• Total: ~$totalMessages messages\n\n'
              'This may take a few minutes. Continue?'
          .tr,
      onConfirm: () async {
        try {
          // The use case now handles its own progress updates
          final useCase = GetIt.I<GenerateDataForStressTestUseCase>();
          await useCase.callWithCustomParams(params);
        } catch (e) {
          _log.e('Stress test data generation failed: $e');
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e is Exception ? e : Exception(e.toString()),
          );
        }
      },
    );
  }

  ///
  /// Account information
  ///

  String get token {
    final currentToken = userCtl.currentToken.value;
    if (currentToken != null) {
      return '${currentToken.substring(0, 10)}.........${currentToken.substring(currentToken.length - 5)}';
    }
    return '-';
  }

  String get accountId {
    if (userCtl.currentUser() != null) {
      return userCtl.currentUser()?.id ?? '-';
    }
    return '-';
  }

  String get sessionId {
    if (userCtl.currentUser() != null) {
      return userCtl.currentUser()?.currentSessionKeyId ?? '-';
    }
    return '-';
  }

  void handleCopyToken() async {
    final currentToken = userCtl.currentToken.value;
    if (currentToken == null) {
      UChatLoading.failed(message: 'Failed to copy token!'.tr);
      return;
    }

    await Clipboard.setData(ClipboardData(text: currentToken));
    await UChatLoading.success(message: '${'Copied!'.tr}: $token');
  }

  void handleCopySid() async {
    await Clipboard.setData(ClipboardData(
      text: sessionId,
    ));
    await UChatLoading.success(message: 'Copied!'.tr);
  }

  void handleCopyAid() async {
    await Clipboard.setData(ClipboardData(
      text: accountId,
    ));
    await UChatLoading.success(message: 'Copied!'.tr);
  }

  ///
  /// OneSignal Data
  ///

  final onesignalTags = 'NONE'.obs;
  final onesignalId = 'NONE'.obs;
  final onesignalPushSubscriptionId = 'NONE'.obs;

  String get callOnSessionKeyId {
    if (userCtl.currentUser() != null) {
      return userCtl.currentUser()?.callOnSessionKeyId ?? '-';
    }
    return '-';
  }

  void handleCopyCid() async {
    await Clipboard.setData(ClipboardData(
      text: callOnSessionKeyId,
    ));
    await UChatLoading.success(message: 'Copied!'.tr);
  }

  void _getOnesignalTag() async {
    useLogger().d('Get OneSignal tags');
    final oneSignalId = await OneSignal.User.getOnesignalId();
    if (oneSignalId != null) {
      onesignalId.value = oneSignalId;
    }

    final pushSubscriptionId = OneSignal.User.pushSubscription.id;
    if (pushSubscriptionId != null) {
      onesignalPushSubscriptionId.value = pushSubscriptionId;
    }

    final tags = await OneSignal.User.getTags();
    final convert = tags.keys.map((key) => '$key => ${tags[key]}');

    if (convert.isNotEmpty) {
      onesignalTags.value = convert.reduce((value, element) {
        return '$value\n$element';
      });
    }
  }

  void handleSetupOneSignal() async {
    try {
      await PermissionController.instance.checkNotificationPermission();
    } catch (e) {
      // Handle permission error
      UChatLoading.failed(message: 'Failed to setup permission'.tr);
      return;
    }

    try {
      final notificationService = GetIt.I<NotificationManager>();
      await notificationService.onUnauthenticated();
      await notificationService.onAuthenticated();
    } catch (e) {
      // Handle OneSignal setup error
      UChatLoading.failed(message: 'Failed to setup OneSignal'.tr);
      return;
    }

    UChatLoading.success(message: 'Setup complete!'.tr);
    _getOnesignalTag();
  }

  void handleCopyVoipToken() async {
    await Clipboard.setData(ClipboardData(
      text: UChatCallNativeMethodChanel.instance.voipToken,
    ));

    UChatLoading.clearToast();
    UChatLoading.success(message: 'Copied!'.tr);
  }

  void handleCopyCallOneSignalID() async {
    await Clipboard.setData(ClipboardData(
      text: UChatCallNativeMethodChanel.instance.oneSignalId,
    ));

    UChatLoading.clearToast();
    UChatLoading.success(message: 'Copied!'.tr);
  }

  void toggleEnableWarModeConfigKey(bool? value) async {
    try {
      await UChatLoading.show();
      enableWarMode(value);
      await configAuthenticated.saveConfig(key: ConfigDb.getEnableWarModeConfigKey(), value: value);
    } catch (e, stackTrace) {
      _log.e('toggleEnableWarModeConfigKey error.', e, stackTrace);
    }
    await UChatLoading.hide();
  }

  void toggleEnableScreenRecordInSecretChat(bool? value) async {
    try {
      await UChatLoading.show();
      enableScreenRecordInSecretChat(value);
      await configAuthenticated.saveConfig(key: ConfigDb.getEnableScreenRecordInSecretChatConfigKey(), value: value);
    } catch (e, stackTrace) {
      _log.e('toggleEnableScreenRecordInSecretChat error.', e, stackTrace);
    }
    await UChatLoading.hide();
  }

  void toggleEnableLogToTalker(bool? value) async {
    try {
      await UChatLoading.show();
      enableLogToTalker(value);

      talker.settings.enabled = value ?? false;
      await configGeneral.saveConfig(key: ConfigDb.getEnableLogToTalkerKey(), value: value);
    } catch (e, stackTrace) {
      _log.e('toggleEnableLogToTalker error.', e, stackTrace);
    } finally {
      await UChatLoading.hide();
    }
  }

  void toggleEnableTroubleshootEasyAccess(bool? value) async {
    try {
      await UChatLoading.show();
      enableTroubleshootEasyAccess(value);

      await configGeneral.saveConfig(key: ConfigDb.getEnableTroubleshootEasyAccess(), value: value);
      await configGeneral.clearConfig(key: ConfigDb.getTroubleshootEasyAccessPositionX());
      await configGeneral.clearConfig(key: ConfigDb.getTroubleshootEasyAccessPositionY());

      await HomeController.instance.loadEnableTroubleshootEasyAccess();
    } catch (e, stackTrace) {
      _log.e('toggleEnableTroubleshootEasyAccess error.', e, stackTrace);
    }
    await UChatLoading.hide();
  }

  AppSettingsController get appSettingCtl {
    return Get.find<AppSettingsController>();
  }

  ConnectivityController get connectivityCtl {
    return Get.find<ConnectivityController>();
  }

  UserController get userCtl {
    return Get.find<UserController>();
  }

  UChatCallController get callCtl {
    return GetIt.I<UChatCallController>();
  }

  ///
  /// For configure proxy settings
  ///
  Future<Map<String, dynamic>?> showProxySettingsDialog({
    bool? initialEnabled,
    String? initialIp,
    String? initialPort,
  }) async {
    final ctl = Get.put(ProxySettingsController());
    await ctl.loadConfig();

    return await Get.dialog<Map<String, dynamic>>(
      const ProxySettingsDialog(),
      barrierDismissible: false,
    );
  }

  ///
  /// Sync Service data
  ///
  SyncService get syncSvc {
    return GetIt.I<SyncService>();
  }

  List<SyncProcessorService> get syncProcessors => syncSvc.syncProcessors;

  ///
  /// App Version Service
  ///

  AppVersionService get appVersionSvc {
    return GetIt.I<AppVersionService>();
  }
}
