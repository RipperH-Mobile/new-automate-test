import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/core/infrastructure/notification/debug/message_state_entity.dart';

/// Screen to display detailed information about a message state log
class MessageStateLogDetailsScreen extends StatelessWidget {
  const MessageStateLogDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Get.arguments['log'] as MessageStateEntity;
    final appColors = Get.theme.extension<AppColorsTheme>()!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 800; // Threshold for side-by-side layout

    return Scaffold(
      backgroundColor: appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Message State Details',
        leadingButton: AppControlButton.back(context: context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBasicInfoSection(context, log),
            const SizedBox(height: 24),
            _buildMessageCountsSection(context, log),
            const SizedBox(height: 24),
            _buildMessagesComparisonSection(context, log, isWideScreen),
            const SizedBox(height: 24),
            _buildComparisonSection(context, log),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection(BuildContext context, MessageStateEntity log) {
    final appColors = Get.theme.extension<AppColorsTheme>()!;

    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Basic Information',
        context: context,
        color: appColors.textDark,
      ),
      children: [
        _buildInfoRow(
          context,
          'Room ID',
          log.roomId,
        ),
        _buildInfoRow(
          context,
          'Timestamp',
          DateFormat.yMd().add_Hms().format(log.timestamp),
        ),
        if (log.currentRoute != null)
          _buildInfoRow(
            context,
            'Current Route',
            log.currentRoute!,
          ),
        if (log.isAppInForeground != null)
          _buildInfoRow(
            context,
            'App State',
            log.isAppInForeground! ? 'Foreground' : 'Background',
          ),
        if (log.fetchTimeMs != null)
          _buildInfoRow(
            context,
            'Fetch Time',
            '${log.fetchTimeMs}ms',
          ),
      ],
    );
  }

  Widget _buildMessageCountsSection(BuildContext context, MessageStateEntity log) {
    final appColors = Get.theme.extension<AppColorsTheme>()!;
    final hasDiscrepancy = log.totalDatabaseMessageCount != log.totalUiMessageCount;

    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Message Counts',
        context: context,
        color: appColors.textDark,
      ),
      children: [
        _buildInfoRow(
          context,
          'Database Messages',
          '${log.totalDatabaseMessageCount}',
        ),
        _buildInfoRow(
          context,
          'UI Messages',
          '${log.totalUiMessageCount}',
        ),
        if (hasDiscrepancy)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.warning,
                      color: Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    AppText.body2Bold(
                      'Discrepancy Detected',
                      context: context,
                      color: Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                AppText.caption1(
                  'Database has ${log.totalDatabaseMessageCount - log.totalUiMessageCount} more messages than UI',
                  context: context,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildMessagesComparisonSection(BuildContext context, MessageStateEntity log, bool isWideScreen) {
    final appColors = Get.theme.extension<AppColorsTheme>()!;

    // Side-by-side layout for wide screens
    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Messages Comparison (Side by Side)',
        context: context,
        color: appColors.textDark,
      ),
      children: [
        SizedBox(
          height: 400, // Fixed height for the comparison view
          child: Row(
            children: [
              // Left column - Database Messages
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: appColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: appColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: AppText.body4Bold(
                          'Database Messages',
                          context: context,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: log.databaseMessages.isEmpty
                            ? Center(
                                child: AppText.caption1(
                                  'No messages found',
                                  context: context,
                                  color: appColors.textLight,
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: log.databaseMessages.length,
                                itemBuilder: (context, index) {
                                  final message = log.databaseMessages[index];
                                  final isMatching = _isMessageMatching(message, log.uiMessages);
                                  return _buildMessageItemWithIndicator(context, message,
                                      isDatabase: true, isMatching: isMatching);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              // Right column - UI Messages
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: appColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: appColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: AppText.body4Bold(
                          'UI Messages',
                          context: context,
                          color: Colors.green,
                        ),
                      ),
                      Expanded(
                        child: log.uiMessages.isEmpty
                            ? Center(
                                child: AppText.caption1(
                                  'No messages found',
                                  context: context,
                                  color: appColors.textLight,
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: log.uiMessages.length,
                                itemBuilder: (context, index) {
                                  final message = log.uiMessages[index];
                                  final isMatching = _isMessageMatching(message, log.databaseMessages);
                                  return _buildMessageItemWithIndicator(context, message,
                                      isDatabase: false, isMatching: isMatching);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonSection(BuildContext context, MessageStateEntity log) {
    final appColors = Get.theme.extension<AppColorsTheme>()!;

    // Find messages that are in database but not in UI
    final dbMessageIds = log.databaseMessages.map((m) => m.id ?? m.ref).toSet();
    final uiMessageIds = log.uiMessages.map((m) => m.id ?? m.ref).toSet();
    final missingInUi = dbMessageIds.difference(uiMessageIds);
    final missingInDb = uiMessageIds.difference(dbMessageIds);

    if (missingInUi.isEmpty && missingInDb.isEmpty) {
      return const SizedBox.shrink();
    }

    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Message Comparison',
        context: context,
        color: appColors.textDark,
      ),
      children: [
        if (missingInUi.isNotEmpty) ...[
          AppText.caption1Bold(
            'Messages in Database but not in UI:',
            context: context,
            color: Colors.orange,
          ),
          const SizedBox(height: 4),
          ...missingInUi.map((id) => Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 4),
                child: AppText.caption1(
                  '• ${id ?? 'Unknown'}',
                  context: context,
                ),
              )),
          const SizedBox(height: 8),
        ],
        if (missingInDb.isNotEmpty) ...[
          AppText.caption1Bold(
            'Messages in UI but not in Database:',
            context: context,
            color: Colors.blue,
          ),
          const SizedBox(height: 4),
          ...missingInDb.map((id) => Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 4),
                child: AppText.caption1(
                  '• ${id ?? 'Unknown'}',
                  context: context,
                ),
              )),
        ],
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final appColors = Get.theme.extension<AppColorsTheme>()!;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: AppText.caption1(
              label,
              context: context,
              color: appColors.textLight,
            ),
          ),
          Expanded(
            child: AppText.caption1(
              value,
              context: context,
              color: appColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItemWithIndicator(BuildContext context, dynamic message,
      {required bool isDatabase, required bool isMatching}) {
    final appColors = Get.theme.extension<AppColorsTheme>()!;

    return GestureDetector(
      onTap: () => _showMessageJsonDialog(context, message, isDatabase),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDatabase ? appColors.surface : appColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isMatching
                ? Colors.green.withValues(alpha: 0.6)
                : (isDatabase ? Colors.orange.withValues(alpha: 0.6) : Colors.red.withValues(alpha: 0.6)),
            width: isMatching ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Matching indicator
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isMatching ? Colors.green : (isDatabase ? Colors.orange : Colors.red),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Spacer(),
                if (message.createdAt != null)
                  AppText.caption1(
                    DateFormat.Hms().format(message.createdAt!),
                    context: context,
                    color: appColors.textLight,
                  ),
              ],
            ),
            if (message.message != null && message.message!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: AppText.caption1(
                  message.message!.length > 50 ? '${message.message!.substring(0, 50)}...' : message.message!,
                  context: context,
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool _isMessageMatching(dynamic message, List<dynamic> otherList) {
    final messageId = message.id ?? message.ref;
    if (messageId == null) return false;

    return otherList.any((otherMessage) {
      final otherMessageId = otherMessage.id ?? otherMessage.ref;
      return otherMessageId == messageId;
    });
  }

  void _showMessageJsonDialog(BuildContext context, dynamic message, bool isDatabase) {
    final appColors = Get.theme.extension<AppColorsTheme>()!;

    // Convert message to JSON with error handling
    String jsonString;
    try {
      final messageMap = message.toMap();
      jsonString = const JsonEncoder.withIndent('  ').convert(messageMap);
    } catch (e) {
      // Fallback to toString if toMap fails
      try {
        jsonString = const JsonEncoder.withIndent('  ').convert({
          'error': 'Failed to convert message to map',
          'messageString': message.toString(),
          'messageType': message.runtimeType.toString(),
        });
      } catch (e2) {
        jsonString = 'Error: Could not convert message to JSON\n${e.toString()}\n${e2.toString()}';
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: appColors.surfaceDark,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText.body3Bold(
                      '${isDatabase ? 'Database' : 'UI'} Message Details',
                      context: context,
                      color: appColors.textPrimary,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close,
                        color: appColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppText.caption1Bold(
                        'JSON Format',
                        context: context,
                        color: appColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _copyJsonToClipboard(context, jsonString),
                      icon: Icon(
                        Icons.copy,
                        color: appColors.textPrimary,
                        size: 20,
                      ),
                      tooltip: 'Copy JSON',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: appColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: appColors.border),
                    ),
                    child: SingleChildScrollView(
                      child: SelectableText(
                        jsonString,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: appColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: AppText.button1(
                        'Close',
                        context: context,
                        color: appColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _copyJsonToClipboard(BuildContext context, String jsonString) async {
    try {
      await Clipboard.setData(ClipboardData(text: jsonString));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppText.caption1(
              'JSON copied to clipboard',
              context: context,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppText.caption1(
              'Failed to copy JSON: $error',
              context: context,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
