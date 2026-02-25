import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';
import 'package:uchat/widgets/setting/setting_switch_row.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';
import 'package:uchat/features/notification_debug/presentation/controllers/notification_debug_controller.dart';
import 'package:uchat/features/notification_debug/presentation/widgets/message_state_log_item_widget.dart';
import 'package:uchat/features/notification_debug/presentation/widgets/notification_log_item_widget.dart';

/// Main screen for notification debug tools
///
/// This screen provides access to notification logging controls, debug data
/// visualization, and filtering options.
class NotificationDebugScreen extends GetView<NotificationDebugController> {
  const NotificationDebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: Get.theme.extension<AppColorsTheme>()!.surfaceDark,
      appBar: AppBarDefault(
        title: 'Notification Debugger',
        leadingButton: AppControlButton.back(context: context),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.body1(
                  controller.errorMessage.value!,
                  context: context,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refreshData,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMemoryInfoSection(context),
              const SizedBox(height: 16),
              _buildLoggingControlSection(context),
              const SizedBox(height: 24),
              _buildRecentLogsSection(context),
              const SizedBox(height: 24),
              _buildMessageStateLogsSection(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMemoryInfoSection(BuildContext context) {
    final appColors = Get.theme.extension<AppColorsTheme>()!;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: appColors.borderInformation,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: appColors.iconInformation,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.body3Bold(
                  'Memory-Only Logging',
                  context: context,
                  color: appColors.textInformation,
                ),
                const SizedBox(height: 4),
                AppText.body3(
                  'Debug logs are stored in memory only and will be automatically cleared when the app is killed or terminated.',
                  context: context,
                  color: appColors.textInformation,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggingControlSection(BuildContext context) {
    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Logging Control',
        context: context,
        color: Get.theme.extension<AppColorsTheme>()!.textDark,
      ),
      children: [
        Obx(
          () => SettingSwitchRow(
            title: 'Enable Notification Logging',
            description: 'Log notification events for debugging',
            value: controller.isEnabled.value,
            onTap: (value) => controller.toggleLogging(),
          ),
        ),
        _buildDebugOption(
          context,
          'Clear All Data',
          'Clear all debug data from memory',
          Icons.delete,
          controller.clearAllData,
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildDebugOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : Get.theme.extension<AppColorsTheme>()!.textLight,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.body1(
                    title,
                    context: context,
                    color: isDestructive ? Colors.red : null,
                  ),
                  AppText.body2(
                    subtitle,
                    context: context,
                    color: Get.theme.extension<AppColorsTheme>()!.textLight,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Get.theme.extension<AppColorsTheme>()!.textLight.withValues(alpha: 0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLogsSection(BuildContext context) {
    return Obx(() {
      if (!controller.isEnabled.value || controller.notificationLogs.isEmpty) {
        return const SizedBox.shrink();
      }

      return SettingFrameContainer.withChildren(
        context: context,
        header: AppText.body4Bold(
          'Recent Notification Logs',
          context: context,
          color: Get.theme.extension<AppColorsTheme>()!.textDark,
        ),
        children: [
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: controller.notificationLogs.length,
              itemBuilder: (context, index) {
                final log = controller.notificationLogs[index];
                return NotificationLogItemWidget(
                  log: log,
                  onTap: () => controller.showNotificationLogDetails(log),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildMessageStateLogsSection(BuildContext context) {
    return Obx(() {
      if (!controller.isEnabled.value || controller.messageStateLogs.isEmpty) {
        return const SizedBox.shrink();
      }

      return SettingFrameContainer.withChildren(
        context: context,
        header: AppText.body4Bold(
          'Message State Logs',
          context: context,
          color: Get.theme.extension<AppColorsTheme>()!.textDark,
        ),
        children: [
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: controller.messageStateLogs.length,
              itemBuilder: (context, index) {
                final log = controller.messageStateLogs[index];
                return MessageStateLogItemWidget(
                  log: log,
                  onTap: () => controller.showMessageStateLogDetails(log),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
