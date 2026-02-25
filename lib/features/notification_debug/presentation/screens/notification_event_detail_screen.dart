import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_log_entity.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

/// Screen for displaying detailed information about notification events
/// 
/// This screen shows comprehensive details about a notification log entry,
/// including all associated data, timing information, and related events.
class NotificationEventDetailScreen extends StatelessWidget {
  const NotificationEventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the log entity from arguments
    final dynamic args = Get.arguments;
    final NotificationLogEntity? log = args?['log'];
    
    if (log == null) {
      return ScaffoldBasic(
        backgroundColor: Get.theme.extension<AppColorsTheme>()!.surfaceDark,
        appBar: AppBarDefault(
          title: 'Notification Details',
          leadingButton: AppControlButton.back(context: context),
        ),
        child: const Center(
          child: Text('No notification data available'),
        ),
      );
    }

    return ScaffoldBasic(
      backgroundColor: Get.theme.extension<AppColorsTheme>()!.surfaceDark,
      appBar: AppBarDefault(
        title: 'Notification Details',
        leadingButton: AppControlButton.back(context: context),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBasicInfoSection(context, log),
            const SizedBox(height: 24),
            _buildTimingInfoSection(context, log),
            const SizedBox(height: 24),
            _buildStateInfoSection(context, log),
            const SizedBox(height: 24),
            _buildDataSection(context, log),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection(BuildContext context, NotificationLogEntity log) {
    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Basic Information',
        context: context,
        color: Get.theme.extension<AppColorsTheme>()!.textDark,
      ),
      children: [
        _buildDetailRow(
          context,
          'Notification ID',
          log.notificationId,
        ),
        _buildDetailRow(
          context,
          'Room ID',
          log.roomId,
        ),
        _buildDetailRow(
          context,
          'Log Type',
          _getLogTypeLabel(log.logType),
        ),
        _buildDetailRow(
          context,
          'Timestamp',
          _formatDateTime(log.timestamp),
        ),
      ],
    );
  }

  Widget _buildTimingInfoSection(BuildContext context, NotificationLogEntity log) {
    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Timing Information',
        context: context,
        color: Get.theme.extension<AppColorsTheme>()!.textDark,
      ),
      children: [
        if (log.processingTimeMs != null)
          _buildDetailRow(
            context,
            'Processing Time',
            '${log.processingTimeMs} ms',
          ),
        if (log.queueLength != null)
          _buildDetailRow(
            context,
            'Queue Length',
            '${log.queueLength}',
          ),
      ],
    );
  }

  Widget _buildStateInfoSection(BuildContext context, NotificationLogEntity log) {
    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'State Information',
        context: context,
        color: Get.theme.extension<AppColorsTheme>()!.textDark,
      ),
      children: [
        if (log.messageCountInDb != null)
          _buildDetailRow(
            context,
            'Message Count in DB',
            '${log.messageCountInDb}',
          ),
        if (log.currentRoute != null)
          _buildDetailRow(
            context,
            'Current Route',
            log.currentRoute!,
          ),
        if (log.isAppInForeground != null)
          _buildDetailRow(
            context,
            'App in Foreground',
            log.isAppInForeground! ? 'Yes' : 'No',
          ),
      ],
    );
  }

  Widget _buildDataSection(BuildContext context, NotificationLogEntity log) {
    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Notification Data',
        context: context,
        color: Get.theme.extension<AppColorsTheme>()!.textDark,
      ),
      children: [
        _buildJsonViewer(context, log.notificationData),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: AppText.body2Bold(
              label,
              context: context,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppText.body2(
              value,
              context: context,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJsonViewer(BuildContext context, Map<String, dynamic> data) {
    if (data.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: AppText.body2(
          'No additional data',
          context: context,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.extension<AppColorsTheme>()!.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Get.theme.extension<AppColorsTheme>()!.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.body2Bold(
            'JSON Data',
            context: context,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Get.theme.extension<AppColorsTheme>()!.surface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _formatJson(data),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Get.theme.extension<AppColorsTheme>()!.textDarkest,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLogTypeLabel(NotificationLogType type) {
    switch (type) {
      case NotificationLogType.received:
        return 'Received';
      case NotificationLogType.clicked:
        return 'Clicked';
      case NotificationLogType.handled:
        return 'Handled';
      case NotificationLogType.error:
        return 'Error';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}:'
        '${dateTime.second.toString().padLeft(2, '0')}';
  }

  String _formatJson(Map<String, dynamic> data) {
    const encoder = JsonEncoder.withIndent('  ');
    try {
      return encoder.convert(data);
    } catch (e) {
      return 'Error formatting JSON: $e';
    }
  }
}

