import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_log_entity.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/widgets/app_text.dart';

/// Widget for displaying a single notification log entry
/// 
/// This widget provides a compact view of a notification log entry with
/// key information and visual indicators for different log types.
class NotificationLogItemWidget extends StatelessWidget {
  final NotificationLogEntity log;
  final VoidCallback? onTap;

  const NotificationLogItemWidget({
    super.key,
    required this.log,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Get.theme.extension<AppColorsTheme>()!.borderLight,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildLogTypeIcon(context),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppText.body2Bold(
                          _truncateId(log.notificationId),
                          context: context,
                        ),
                      ),
                      if (log.processingTimeMs != null)
                        AppText.caption1(
                          '${log.processingTimeMs}ms',
                          context: context,
                          color: _getProcessingTimeColor(context, log.processingTimeMs!),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      AppText.caption1(
                        _formatDateTime(log.timestamp),
                        context: context,
                      ),
                      const SizedBox(width: 8),
                      AppText.caption1(
                        'Room: ${_truncateId(log.roomId)}',
                        context: context,
                      ),
                      if (log.queueLength != null) ...[
                        const SizedBox(width: 8),
                        AppText.caption1(
                          'Queue: ${log.queueLength}',
                          context: context,
                        ),
                      ],
                    ],
                  ),
                  if (log.currentRoute != null) ...[
                    const SizedBox(height: 4),
                    AppText.caption1(
                      'Route: ${log.currentRoute}',
                      context: context,
                      color: Get.theme.extension<AppColorsTheme>()!.textLight,
                    ),
                  ],
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

  Widget _buildLogTypeIcon(BuildContext context) {
    Color iconColor;
    IconData iconData;

    switch (log.logType) {
      case NotificationLogType.received:
        iconColor = Colors.blue;
        iconData = Icons.notifications;
        break;
      case NotificationLogType.clicked:
        iconColor = Colors.green;
        iconData = Icons.touch_app;
        break;
      case NotificationLogType.handled:
        iconColor = Colors.orange;
        iconData = Icons.done_all;
        break;
      case NotificationLogType.error:
        iconColor = Colors.red;
        iconData = Icons.error;
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 20,
      ),
    );
  }

  Color _getProcessingTimeColor(BuildContext context, int processingTimeMs) {
    if (processingTimeMs < 100) {
      return Colors.green;
    } else if (processingTimeMs < 500) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _truncateId(String id) {
    if (id.length <= 12) return id;
    return '${id.substring(0, 6)}...${id.substring(id.length - 6)}';
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.month}/${dateTime.day} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
