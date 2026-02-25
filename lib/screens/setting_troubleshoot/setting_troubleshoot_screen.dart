import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/api/http.dart';
import 'package:uchat/api/socket.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/features/call/call_native_method_channel.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/setting/setting_header.dart';

import 'setting_troubleshoot_controller.dart';

class SettingTroubleshootScreen extends GetView<SettingTroubleshootController> {
  const SettingTroubleshootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return ScaffoldBasic(
      child: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            AppBarWithCallHeader<SliverAppBar>(
              centerTitle: false,
              title: GestureDetector(
                child: AppBarTitle(
                  title: 'Troubleshoot'.tr,
                  fontSize: 18,
                ),
              ),
              leading: isMobile ? AppBarBackButton(onPressed: () => controller.handleBack()) : null,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SettingSpacer(),
                  const SettingDivider(),
                  SettingRow(
                    title: 'Reset'.tr,
                    onPressed: controller.handleResetState,
                  ),
                  const SettingDivider(),
                  SettingRow(
                    title: 'Send debug information'.tr,
                    onPressed: controller.handleSendDebugInformation,
                  ),
                  const SettingDivider(),
                  const SettingSpacer(),
                  Obx(() {
                    return UChatSwitchRowMenu(
                      title: 'Enable troubleshoot easy access'.tr,
                      value: controller.enableTroubleshootEasyAccess.value,
                      onTap: controller.toggleEnableTroubleshootEasyAccess,
                      hasTopBorder: true,
                      hasHorizontalBorder: !isMobile,
                      borderRadius: !isMobile ? 10 : null,
                    );
                  }),
                  Obx(() {
                    if (UserController.instance.enableTalker) {
                      return UChatSwitchRowMenu(
                        title: 'Enable Log to Talker'.tr,
                        value: controller.enableLogToTalker.value,
                        onTap: controller.toggleEnableLogToTalker,
                        hasTopBorder: true,
                        hasBottomBorder: true,
                        hasHorizontalBorder: !isMobile,
                        borderRadius: !isMobile ? 10 : null,
                      );
                    }

                    return const SizedBox();
                  }),
                  Obx(() {
                    return UChatSwitchRowMenu(
                      title: 'Enable screen record in secret chat'.tr,
                      value: controller.enableScreenRecordInSecretChat.value,
                      onTap: controller.toggleEnableScreenRecordInSecretChat,
                      hasTopBorder: !UserController.instance.enableTalker,
                      hasBottomBorder: true,
                      hasHorizontalBorder: !isMobile,
                      borderRadius: !isMobile ? 10 : null,
                    );
                  }),

                  SettingRow(
                    title: 'Add mock data for stress test'.tr,
                    onPressed: () {
                      controller.addDataForStressTest(context);
                    },
                  ),
                  const SettingDivider(),
                  SettingRow(
                    title: 'Proxy settings'.tr,
                    onPressed: () {
                      controller.showProxySettingsDialog();
                    },
                  ),

                  Obx(() {
                    return UChatSwitchRowMenu(
                      title: 'Enable beta mode'.tr,
                      value: controller.enableWarMode.value,
                      onTap: controller.toggleEnableWarModeConfigKey,
                    );
                  }),
                  const SettingSpacer(),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: '${'App version'.tr} (${'App build'.tr})',
                      value: '${controller.appSettingCtl.version()} (${controller.appSettingCtl.buildNumber()})',
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Schema version'.tr,
                      value: controller.syncSvc.stateSchemaVersion.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Builder(builder: (context) {
                    String value = '- NONE -'.tr;
                    if (controller.appVersionSvc.lastVersion != null) {
                      final version = controller.appVersionSvc.lastVersion?.toString();
                      final isForceUpdate = controller.isForceUpdate ? 'Yes'.tr : 'No'.tr;
                      value = '$version (Force: $isForceUpdate)';
                    }
                    return SettingRowValue(
                      title: 'Last Version'.tr,
                      value: value,
                    );
                  }),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'Last check update'.tr,
                    value: controller.appVersionSvc.lastUpdate?.toString() ?? '- NONE -'.tr,
                  ),
                  const SettingDivider(),
                  SettingRow(
                    title: 'Clear check update cache'.tr,
                    onPressed: controller.appVersionSvc.resetCache,
                  ),
                  const SettingDivider(),

                  // ------------------------------------------------
                  // Env
                  // ------------------------------------------------
                  const SettingHeader(title: 'ENV'),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'Api URL'.tr,
                    value: AppEnv.apiUrl,
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'Socket URL'.tr,
                    value: AppEnv.socketUrl,
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'LiveKit URL'.tr,
                    value: AppEnv.socketLiveKit,
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '${'Is Debug'.tr} / ${'Is Prod'.tr} / kDebugMode',
                    value: '${AppEnv.isDebug.toString()} / ${AppEnv.isProd.toString()} / ${kDebugMode.toString()}',
                  ),
                  const SettingDivider(),

                  // ------------------------------------------------
                  // Connectivity
                  // ------------------------------------------------
                  const SettingHeader(title: 'Connectivity'),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Status'.tr,
                      value: ConnectivityController.instance.connectivityStatus.toString(),
                    );
                  }),
                  const SettingDivider(),

                  // ------------------------------------------------
                  // Socket Connection
                  // ------------------------------------------------
                  const SettingHeader(title: 'Socket Connection'),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Socket ID'.tr,
                      value: SocketCaller().socketId,
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Reconnect Count'.tr,
                      value: SocketCaller().reconnectCount.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Reconnect Attempts'.tr,
                      value: SocketCaller().reconnectAttempts.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Last reconnect at (excluded delay)'.tr,
                      value: SocketCaller().lastReconnectTime.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Reconnect Attempts Delay (ms)'.tr,
                      value: SocketCaller().reconnectCurrentDelayMs.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Waiting for Reconnect'.tr,
                      value: SocketCaller().isWaitingForReconnectAttempts ? 'Yes'.tr : 'No'.tr,
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Heartbeat History Count'.tr,
                      value: SocketCaller().heartbeat.heartbeatHistory.length.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Last Heartbeat at'.tr,
                      value: SocketCaller().heartbeat.lastHeartbeatTime.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Average Latency'.tr,
                      value: '${SocketCaller().heartbeat.averageLatency.toString()} ms',
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Package Loss Rate'.tr,
                      value: '${(SocketCaller().heartbeat.packetLossRate * 100).toString()} %',
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    SocketCaller().heartbeat.packetLossRate;
                    SocketCaller().heartbeat.averageLatency;
                    return SettingRowValue(
                      title: 'Is Ready for call'.tr,
                      value: SocketCaller().isReadyForCall ? 'Yes'.tr : 'No'.tr,
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    SocketCaller().isConnecting;
                    return SettingRowValue(
                      title: '${'Is Connected'.tr} / ${'Is Connecting'.tr}',
                      value: '${SocketCaller().isConnected ? 'Yes'.tr : 'No'.tr} /'
                          ' ${SocketCaller().isConnecting ? 'Yes'.tr : 'No'.tr}',
                    );
                  }),
                  const SettingDivider(),
                  SettingRow(
                    title: 'Disconnect socket'.tr,
                    onPressed: controller.handleDisconnectSocket,
                  ),
                  const SettingDivider(),
                  SettingRow(
                    title: 'Reconnect socket'.tr,
                    onPressed: controller.handleReconnectSocket,
                  ),
                  const SettingDivider(),

                  // ------------------------------------------------
                  // Socket Connection
                  // ------------------------------------------------
                  const SettingHeader(title: 'Socket Monitoring'),
                  const SettingDivider(),
                  Obx(() {
                    SocketCaller().monitoring.lastCheckedTime;

                    return SettingRowValue(
                      title: 'Is started'.tr,
                      value: SocketCaller().monitoring.isStarted ? 'Yes'.tr : 'No'.tr,
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Last checked at'.tr,
                      value: SocketCaller().monitoring.lastCheckedTime?.toString() ?? '- NONE -'.tr,
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Last force reconnect time'.tr,
                      value: SocketCaller().monitoring.lastForceReconnectTime?.toString() ?? '- NONE -'.tr,
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Force reconnect count'.tr,
                      value: SocketCaller().monitoring.forceReconnectCount.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Found disconnected count'.tr,
                      value: SocketCaller().monitoring.foundDisconnectedCount.toString(),
                    );
                  }),
                  const SettingDivider(),

                  // ------------------------------------------------
                  // HTTP Connection
                  // ------------------------------------------------
                  const SettingHeader(title: 'Http Connection'),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Heartbeat History Count'.tr,
                      value: HttpCaller().heartbeat.heartbeatHistory.length.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Last Heartbeat at'.tr,
                      value: HttpCaller().heartbeat.lastHeartbeatTime.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Average Latency'.tr,
                      value: '${HttpCaller().heartbeat.averageLatency.toString()} ms',
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Success Rate'.tr,
                      value: '${(HttpCaller().heartbeat.successRate * 100).toString()}%',
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Network Healthy?'.tr,
                      value: HttpCaller().heartbeat.isNetworkHealthy ? 'Yes'.tr : 'No'.tr,
                    );
                  }),
                  const SettingDivider(),

                  // ------------------------------------------------
                  // Account
                  // ------------------------------------------------
                  SettingHeader(title: 'Account'.tr),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'SID'.tr,
                      value: controller.sessionId,
                      iconRight: Icons.copy_rounded,
                      onPressed: controller.handleCopySid,
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'AID'.tr,
                      value: controller.accountId,
                      iconRight: Icons.copy_rounded,
                      onPressed: controller.handleCopyAid,
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'TOKEN'.tr,
                      value: controller.token,
                      iconRight: Icons.copy_rounded,
                      onPressed: controller.handleCopyToken,
                    );
                  }),
                  const SettingDivider(),

                  // ------------------------------------------------
                  // OneSignal
                  // ------------------------------------------------
                  const SettingHeader(title: 'OneSignal'),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'OneSignal App ID'.tr,
                    value: AppEnv.oneSignalAppID,
                    iconRight: Icons.copy_rounded,
                    onPressed: () => controller.handleCopy(AppEnv.oneSignalAppID),
                  ),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Onesignal User ID'.tr,
                      value: controller.onesignalId.value,
                      iconRight: Icons.copy_rounded,
                      onPressed: () => controller.handleCopy(controller.onesignalId.value),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Onesignal Subscription ID'.tr,
                      value: controller.onesignalPushSubscriptionId.value,
                      iconRight: Icons.copy_rounded,
                      onPressed: () => controller.handleCopy(controller.onesignalPushSubscriptionId.value),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Onesignal Tags'.tr,
                      value: controller.onesignalTags.value,
                    );
                  }),
                  const SettingDivider(),
                  SettingRow(
                    title: 'Setup OneSignal'.tr,
                    onPressed: controller.handleSetupOneSignal,
                  ),
                  const SettingDivider(),

                  // ------------------------------------------------
                  // Call
                  // ------------------------------------------------
                  SettingHeader(title: 'Call'.tr),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'OneSignal Call App ID'.tr,
                    value: AppEnv.oneSignalCallAppID,
                    iconRight: Icons.copy_rounded,
                    onPressed: () => controller.handleCopy(AppEnv.oneSignalCallAppID),
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'OneSignal Call User ID'.tr,
                    value: UChatCallNativeMethodChanel.instance.oneSignalId,
                    iconRight: Icons.copy_rounded,
                    onPressed: () => controller.handleCopyCallOneSignalID(),
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'VoIP Token'.tr,
                    value: UChatCallNativeMethodChanel.instance.voipToken,
                    iconRight: Icons.copy_rounded,
                    onPressed: () => controller.handleCopyVoipToken(),
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'Test Type'.tr,
                    value: UChatCallNativeMethodChanel.instance.testType.toString(),
                  ),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Call On Session ID'.tr,
                      value: controller.callOnSessionKeyId,
                      iconRight: Icons.copy_rounded,
                      onPressed: () => controller.handleCopy(controller.callOnSessionKeyId),
                    );
                  }),
                  const SettingDivider(),
                  // TODO: Call controller deprecated change to new ctl.
                  // Obx(() {
                  //   return SettingRowValue(
                  //     title: 'callState'.tr,
                  //     value: controller.callCtl.callState().toString(),
                  //   );
                  // }),
                  // const SettingDivider(),

                  // ------------------------------------------------
                  // State
                  // ------------------------------------------------
                  const SettingHeader(title: 'State'),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Is sync processing?'.tr,
                      value: controller.syncSvc.isSyncProcessing ? 'Yes'.tr : 'No'.tr,
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Is sync queue processing?'.tr,
                      value: controller.syncSvc.isQueueProcessing() ? 'Yes'.tr : 'No'.tr,
                    );
                  }),
                  const SettingDivider(),

                  Obx(() {
                    controller.syncSvc.lastSyncTime;
                    return SettingRowValue(
                      title: 'Queue processing size'.tr,
                      value: controller.syncSvc.queue.size.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Last sync at'.tr,
                      value: controller.syncSvc.lastSyncTime.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Last network checked at'.tr,
                      value: controller.syncSvc.lastNetworkCheckTime.toString(),
                    );
                  }),
                  const SettingDivider(),
                  Obx(() {
                    return SettingRowValue(
                      title: 'Last run sync manual at'.tr,
                      value: controller.syncSvc.lastRunManualSync.toString(),
                    );
                  }),
                  const SettingDivider(),

                  // ------------------------------------------------
                  // State Processors
                  // ------------------------------------------------

                  for (final syncProcessor in controller.syncProcessors) ...[
                    SettingHeader(title: 'State Processors: ${syncProcessor.group}'),
                    const SettingDivider(),
                    Obx(() {
                      return SettingRowValue(
                        title: '[${syncProcessor.group}] Current State version'.tr,
                        value: syncProcessor.currentStateSeq.toString(),
                      );
                    }),
                    const SettingDivider(),
                    Obx(() {
                      return SettingRowValue(
                        title: '[${syncProcessor.group}] First sync version'.tr,
                        value: syncProcessor.syncingFirstStateSeq.toString(),
                      );
                    }),
                    const SettingDivider(),
                    Obx(() {
                      return SettingRowValue(
                        title: '[${syncProcessor.group}] Last sync version'.tr,
                        value: syncProcessor.syncingLastStateSeq.toString(),
                      );
                    }),
                    const SettingDivider(),
                    SettingRowValue(
                      title: '[${syncProcessor.group}] Add state queue size'.tr,
                      value: syncProcessor.addStateQueue.size.toString(),
                    ),
                    const SettingDivider(),
                    SettingRowValue(
                      title: '[${syncProcessor.group}] Sync queue size'.tr,
                      value: syncProcessor.syncQueue.size.toString(),
                    ),
                    const SettingDivider(),
                  ],

                  // ------------------------------------------------
                  // Date
                  // ------------------------------------------------
                  const SettingHeader(title: 'Date'),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'Date Now With ToUTC'.tr,
                    value: DateTime.now().toUtc().toIso8601String(),
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: 'Date Now'.tr,
                    value: DateTime.now().toIso8601String(),
                  ),
                  const SettingDivider(),
                  const SettingHeader(title: 'Enable Feature'),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[call] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.call?.enabled?.toString() ?? 'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[call] isTest'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.call?.isTest?.toString() ?? 'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[chatFolder] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.chatFolder?.enabled?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[chatFolder] maxChatFolder'.tr,
                    value:
                        UserController.instance.currentUser()?.enabledFeatures?.chatFolder?.maxChatFolder?.toString() ??
                            'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[chatFolder] maxRoomInChatFolder'.tr,
                    value: UserController.instance
                            .currentUser()
                            ?.enabledFeatures
                            ?.chatFolder
                            ?.maxRoomInChatFolder
                            ?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[chatFolderV2] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.chatFolderV2?.enabled?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[chatFolderV2] maxChatFolder'.tr,
                    value: UserController.instance
                            .currentUser()
                            ?.enabledFeatures
                            ?.chatFolderV2
                            ?.maxChatFolder
                            ?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[chatFolderV2] maxRoomInChatFolder'.tr,
                    value: UserController.instance
                            .currentUser()
                            ?.enabledFeatures
                            ?.chatFolderV2
                            ?.maxRoomInChatFolder
                            ?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[coin] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.coin?.enabled?.toString() ?? 'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[help center] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.helpCenter?.enabled?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[hold chat] enable'.tr,
                    value:
                        UserController.instance.currentUser()?.enabledFeatures?.holdChat?.enabled?.toString() ?? 'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[hold chat] with scroll'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.holdChat?.withScroll?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[multi account] enable'.tr,
                    value:
                        UserController.instance.currentUser()?.enabledFeatures?.multipleAccount?.enabled?.toString() ??
                            'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[multi account] canUseShortCutPasscode'.tr,
                    value: UserController.instance
                            .currentUser()
                            ?.enabledFeatures
                            ?.multipleAccount
                            ?.canUseShortCutPasscode
                            ?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[multi account] canHideFromList'.tr,
                    value: UserController.instance
                            .currentUser()
                            ?.enabledFeatures
                            ?.multipleAccount
                            ?.canHideFromList
                            ?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[new message] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.newMessage?.enabled?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[new message] animation'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.newMessage?.animation?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[new message] sound'.tr,
                    value:
                        UserController.instance.currentUser()?.enabledFeatures?.newMessage?.sound?.toString() ?? 'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[premiumStore] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.premiumStore?.enabled?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[secretRoom] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.secretRoom?.enabled?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[talker] enable'.tr,
                    value:
                        UserController.instance.currentUser()?.enabledFeatures?.talker?.enabled?.toString() ?? 'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[troubleshoot] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.troubleshoot?.enabled?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[uploadPro] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.uploadPro?.enabled?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[webhook] enable'.tr,
                    value:
                        UserController.instance.currentUser()?.enabledFeatures?.webhook?.enabled?.toString() ?? 'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[debugAccount] enable'.tr,
                    value: UserController.instance.currentUser()?.enabledFeatures?.debugAccount?.enabled?.toString() ??
                        'null',
                  ),
                  const SettingDivider(),
                  SettingRowValue(
                    title: '[analytic] enable'.tr,
                    value:
                        UserController.instance.currentUser()?.enabledFeatures?.analytic?.enabled?.toString() ?? 'null',
                  ),
                  const SettingDivider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
