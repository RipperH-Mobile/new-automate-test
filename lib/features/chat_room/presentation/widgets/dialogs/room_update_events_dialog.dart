import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/app_text.dart';

class RoomUpdateEventsDialog extends StatelessWidget {
  final List<Map<String, dynamic>> roomUpdateEventHistory;

  const RoomUpdateEventsDialog({
    super.key,
    required this.roomUpdateEventHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 600,
        ),
        padding: const EdgeInsets.all(AppSpace.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            const SizedBox(height: AppSpace.space4),
            _buildContent(context),
            const SizedBox(height: AppSpace.space4),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.webhook,
          size: 24,
          color: context.theme.appColors.textPrimary,
        ),
        const SizedBox(width: AppSpace.space2),
        Expanded(
          child: AppText.body2Bold(
            'Room Update Events'.tr,
            context: context,
            color: context.theme.appColors.textDarkest,
          ),
        ),
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.close,
            color: context.theme.appColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (roomUpdateEventHistory.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 48,
                color: context.theme.appColors.textLight.withValues(alpha: 0.5),
              ),
              const SizedBox(height: AppSpace.space4),
              AppText.body3(
                'No room update events recorded'.tr,
                context: context,
                color: context.theme.appColors.textDark,
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: roomUpdateEventHistory.length,
        separatorBuilder: (context, index) => Divider(
          color: context.theme.appColors.border.withValues(alpha: 0.3),
          height: 1,
        ),
        itemBuilder: (context, index) {
          final event = roomUpdateEventHistory[index];
          return _buildEventItem(context, event, index + 1);
        },
      ),
    );
  }

  Widget _buildEventItem(BuildContext context, Map<String, dynamic> event, int eventNumber) {
    final timestamp = DateTime.tryParse(event['timestamp'] ?? '');
    final eventRoomId = event['eventRoomId'] ?? '';
    final currentRoomId = event['currentRoomId'] ?? '';
    final matched = event['matched'] ?? false;
    final callStatus = event['callStatus'];
    final callType = event['callType'];
    final latestLastSeenAt = event['latestLastSeenAt'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.space2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: matched
                    ? context.theme.appColors.backgroundPrimaryLightest
                    : context.theme.appColors.backgroundNeutralLightest,
                  borderRadius: BorderRadius.circular(AppRadius.rounded),
                ),
                child: Center(
                  child: AppText.body4Bold(
                    '$eventNumber',
                    context: context,
                    color: matched
                      ? context.theme.appColors.textSuccess
                      : context.theme.appColors.textDark,
                  ),
                ),
              ),
              const SizedBox(width: AppSpace.space2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body3(
                      _formatTimestamp(timestamp),
                      context: context,
                      color: context.theme.appColors.textDarkest,
                    ),
                    AppText.body4(
                      'Event Room: $eventRoomId',
                      context: context,
                      color: context.theme.appColors.textDark,
                    ),
                    AppText.body4(
                      'Current Room: $currentRoomId',
                      context: context,
                      color: context.theme.appColors.textDark,
                    ),
                    Row(
                      children: [
                        Icon(
                          matched ? Icons.check_circle : Icons.cancel,
                          size: 14,
                          color: matched
                            ? context.theme.appColors.textSuccess
                            : context.theme.appColors.textLight,
                        ),
                        const SizedBox(width: 4),
                        AppText.body4(
                          matched ? 'Matched' : 'Not Matched',
                          context: context,
                          color: matched
                            ? context.theme.appColors.textSuccess
                            : context.theme.appColors.textLight,
                        ),
                      ],
                    ),
                    if (callStatus != null)
                      AppText.body4(
                        'Call Status: $callStatus',
                        context: context,
                        color: context.theme.appColors.textDark,
                      ),
                    if (callType != null)
                      AppText.body4(
                        'Call Type: $callType',
                        context: context,
                        color: context.theme.appColors.textDark,
                      ),
                    if (latestLastSeenAt != null)
                      AppText.body4(
                        'Latest Last Seen: ${_formatTimestamp(DateTime.tryParse(latestLastSeenAt ?? ''))}',
                        context: context,
                        color: context.theme.appColors.textDark,
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _copyEventDetails(event),
                icon: Icon(
                  Icons.copy,
                  size: 18,
                  color: context.theme.appColors.textLight,
                ),
              ),
            ],
          ),
          if (event['room'] != null) ...[
            const SizedBox(height: AppSpace.space2),
            _buildRoomDetails(context, event['room'] as Map<String, dynamic>),
          ],
        ],
      ),
    );
  }

  Widget _buildRoomDetails(BuildContext context, Map<String, dynamic> room) {
    // Extract key room properties
    final roomName = room['roomName'] ?? 'N/A';
    final roomType = room['roomType'] ?? 'N/A';
    final memberCount = room['memberCount'] ?? 0;

    return Container(
      padding: const EdgeInsets.all(AppSpace.space2),
      margin: const EdgeInsets.only(left: 32),
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightest,
        borderRadius: BorderRadius.circular(AppRadius.rounded),
        border: Border.all(
          color: context.theme.appColors.border.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(context, 'Name', roomName),
          _buildDetailRow(context, 'Type', roomType),
          _buildDetailRow(context, 'Members', memberCount.toString()),
          ExpansionTile(
            title: AppText.body4(
              'View Full JSON',
              context: context,
              color: context.theme.appColors.textPrimary,
            ),
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(top: AppSpace.space2),
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(
                  child: AppText.body4(
                    const JsonEncoder.withIndent('  ').convert(room),
                    context: context,
                    color: context.theme.appColors.textDark,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: AppText.body4Bold(
              '$label:',
              context: context,
              color: context.theme.appColors.textDarkest,
            ),
          ),
          Expanded(
            child: AppText.body4(
              value,
              context: context,
              color: context.theme.appColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _copyAllEvents,
            icon: const Icon(Icons.copy, size: 18),
            label: Text('Copy All'.tr),
            style: OutlinedButton.styleFrom(
              foregroundColor: context.theme.appColors.textPrimary,
              side: BorderSide(color: context.theme.appColors.borderPrimary),
            ),
          ),
        ),
        const SizedBox(width: AppSpace.space2),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.theme.appColors.backgroundPrimary,
              foregroundColor: Colors.white,
            ),
            child: Text('Close'.tr),
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return 'Unknown time';
    
    return timestamp.format('MMM dd, yyyy HH:mm:ss');
  }

  void _copyEventDetails(Map<String, dynamic> event) {
    const encoder = JsonEncoder.withIndent('  ');
    final jsonString = encoder.convert(event);

    Clipboard.setData(ClipboardData(text: jsonString));
    Get.snackbar(
      'Copied'.tr,
      'Event details copied to clipboard'.tr,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void _copyAllEvents() {
    final buffer = StringBuffer();
    buffer.writeln('Room Update Events History');
    buffer.writeln('==========================');
    buffer.writeln();

    for (int i = 0; i < roomUpdateEventHistory.length; i++) {
      final event = roomUpdateEventHistory[i];
      buffer.writeln('Event ${i + 1}:');
      buffer.writeln('----------------');

      const encoder = JsonEncoder.withIndent('  ');
      buffer.writeln(encoder.convert(event));
      buffer.writeln();
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    Get.snackbar(
      'Copied'.tr,
      'All events copied to clipboard'.tr,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}