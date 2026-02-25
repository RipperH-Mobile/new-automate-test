import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uchat/core/infrastructure/notification/debug/message_state_entity.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/widgets/app_text.dart';

/// Widget to display a message state log item in the debug screen
class MessageStateLogItemWidget extends StatelessWidget {
  final MessageStateEntity log;
  final VoidCallback? onTap;

  const MessageStateLogItemWidget({
    super.key,
    required this.log,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Get.theme.extension<AppColorsTheme>()!;
    
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: appColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: appColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with room ID and timestamp
            Row(
              children: [
                Expanded(
                  child: AppText.body2Bold(
                    'Room: ${log.roomId}',
                    context: context,
                    color: appColors.textPrimary,
                  ),
                ),
                AppText.caption1(
                  DateFormat.Hms().format(log.timestamp),
                  context: context,
                  color: appColors.textLight,
                ),
              ],
            ),
            const SizedBox(height: 4),
            
            // Message counts
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.storage,
                        size: 16,
                        color: appColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      AppText.caption1(
                        'DB: ${log.totalDatabaseMessageCount}',
                        context: context,
                        color: appColors.textLight,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_android,
                        size: 16,
                        color: appColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      AppText.caption1(
                        'UI: ${log.totalUiMessageCount}',
                        context: context,
                        color: appColors.textLight,
                      ),
                    ],
                  ),
                ),
                if (log.fetchTimeMs != null)
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 16,
                        color: appColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      AppText.caption1(
                        '${log.fetchTimeMs}ms',
                        context: context,
                        color: appColors.textLight,
                      ),
                    ],
                  ),
              ],
            ),
            
            // Discrepancy indicator
            if (log.totalDatabaseMessageCount != log.totalUiMessageCount)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: AppText.caption1(
                  '⚠️ Discrepancy: DB has ${log.totalDatabaseMessageCount - log.totalUiMessageCount} more messages',
                  context: context,
                  color: Colors.orange,
                ),
              ),
          ],
        ),
      ),
    );
  }
}