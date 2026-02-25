import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/app_text.dart';

class RoomChangesDialog extends StatelessWidget {
  final List<Map<String, dynamic>> roomChangeHistory;

  const RoomChangesDialog({
    super.key,
    required this.roomChangeHistory,
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
        Assets.vectors.roomChangesHistory.svg(
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            context.theme.appColors.textPrimary,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: AppSpace.space2),
        Expanded(
          child: AppText.body2Bold(
            'Room Changes History'.tr,
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
    if (roomChangeHistory.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: 48,
                color: context.theme.appColors.textLight.withValues(alpha: 0.5),
              ),
              const SizedBox(height: AppSpace.space4),
              AppText.body3(
                'No room changes recorded'.tr,
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
        itemCount: roomChangeHistory.length,
        separatorBuilder: (context, index) => Divider(
          color: context.theme.appColors.border.withValues(alpha: 0.3),
          height: 1,
        ),
        itemBuilder: (context, index) {
          final change = roomChangeHistory[index];
          return _buildChangeItem(context, change, index + 1);
        },
      ),
    );
  }

  Widget _buildChangeItem(BuildContext context, Map<String, dynamic> change, int changeNumber) {
    final timestamp = DateTime.tryParse(change['timestamp'] ?? '');
    final source = change['source'] ?? 'Unknown';
    final changeContext = change['context'] ?? '';

    // Extract changes from the nested structure
    final changes = change['changes'] as Map<String, dynamic>? ?? <String, dynamic>{};

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
                  color: context.theme.appColors.backgroundPrimaryLightest,
                  borderRadius: BorderRadius.circular(AppRadius.rounded),
                ),
                child: Center(
                  child: AppText.body4Bold(
                    '$changeNumber',
                    context: context,
                    color: context.theme.appColors.textPrimary,
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
                    if (source.isNotEmpty || changeContext.isNotEmpty)
                      AppText.body4(
                        'Source: $source${changeContext.isNotEmpty ? ' ($changeContext)' : ''}',
                        context: context,
                        color: context.theme.appColors.textDark,
                      ),
                    // Show call stack if available
                    if (change['callStack'] != null && (change['callStack'] as List).isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.call_split,
                              size: 12,
                              color: context.theme.appColors.textLight,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: AppText.body4(
                                (change['callStack'] as List).join(' → '),
                                context: context,
                                color: context.theme.appColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (changes.isNotEmpty) ...[
            const SizedBox(height: AppSpace.space2),
            _buildChangeDetails(context, changes),
          ],
        ],
      ),
    );
  }

  Widget _buildChangeDetails(BuildContext context, Map<String, dynamic> changes) {
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
        children: changes.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: _buildChangeEntry(context, entry.key, entry.value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChangeEntry(BuildContext context, String fieldName, dynamic changeData) {
    if (changeData is! Map<String, dynamic>) {
      return const SizedBox.shrink();
    }

    final from = changeData['from'];
    final to = changeData['to'];
    final fieldDisplayName = _formatFieldName(fieldName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field name with icon
        Row(
          children: [
            Icon(
              _getFieldIcon(fieldName),
              size: 16,
              color: context.theme.appColors.textPrimary,
            ),
            const SizedBox(width: 6),
            AppText.body4Bold(
              fieldDisplayName,
              context: context,
              color: context.theme.appColors.textDarkest,
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Change description
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: AppText.body4(
            _formatChangeDescription(fieldName, from, to),
            context: context,
            color: context.theme.appColors.textDark,
          ),
        ),
      ],
    );
  }

  IconData _getFieldIcon(String fieldName) {
    switch (fieldName) {
      case 'roomName':
        return Icons.edit;
      case 'memberCount':
        return Icons.people;
      case 'roomType':
        return Icons.category;
      case 'isPublic':
        return Icons.public;
      case 'description':
        return Icons.description;
      case 'roomId':
        return Icons.fingerprint;
      default:
        return Icons.change_circle;
    }
  }

  String _formatChangeDescription(String fieldName, dynamic from, dynamic to) {
    switch (fieldName) {
      case 'roomName':
        return from == null
            ? 'Set to "${_formatDisplayValue(to)}"'
            : 'From "${_formatDisplayValue(from)}" to "${_formatDisplayValue(to)}"';

      case 'memberCount':
        final fromCount = from?.toString() ?? '0';
        final toCount = to?.toString() ?? '0';
        return 'From $fromCount to $toCount members';

      case 'roomType':
        return from == null
            ? 'Set to ${_formatRoomType(to)}'
            : 'From ${_formatRoomType(from)} to ${_formatRoomType(to)}';

      case 'isPublic':
        final fromValue = from == true ? 'Public' : 'Private';
        final toValue = to == true ? 'Public' : 'Private';
        return from == null
            ? 'Set to $toValue'
            : 'From $fromValue to $toValue';

      case 'description':
        final fromValue = (from == null || from.toString().isEmpty) ? 'Empty' : '"${_formatDisplayValue(from)}"';
        final toValue = (to == null || to.toString().isEmpty) ? 'Empty' : '"${_formatDisplayValue(to)}"';
        return 'From $fromValue to $toValue';

      default:
        return from == null
            ? 'Set to ${_formatDisplayValue(to)}'
            : 'From ${_formatDisplayValue(from)} to ${_formatDisplayValue(to)}';
    }
  }

  String _formatDisplayValue(dynamic value) {
    if (value == null) return 'Not specified';
    if (value is bool) return value ? 'Enabled' : 'Disabled';
    if (value is String && value.isEmpty) return 'Empty';
    return value.toString();
  }

  String _formatRoomType(dynamic type) {
    switch (type?.toString()) {
      case 'group':
        return 'Group';
      case 'direct':
        return 'Direct Chat';
      case 'channel':
        return 'Channel';
      case 'public':
        return 'Public Room';
      default:
        return type?.toString() ?? 'Not specified';
    }
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _copyAllChanges(),
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

  String _formatFieldName(String fieldName) {
    switch (fieldName) {
      case 'roomId':
        return 'Room ID';
      case 'roomName':
        return 'Name';
      case 'memberCount':
        return 'Members';
      case 'roomType':
        return 'Type';
      case 'isPublic':
        return 'Public';
      case 'description':
        return 'Description';
      default:
        return fieldName;
      // return fieldName.replaceAll(RegExp(r'([A-Z])'), ' \$1').toLowerCase().capitalize ?? fieldName;
    }
  }

  void _copyAllChanges() {
    final buffer = StringBuffer();
    buffer.writeln('Room Changes History');
    buffer.writeln('===================');
    buffer.writeln();

    for (int i = 0; i < roomChangeHistory.length; i++) {
      final change = roomChangeHistory[i];
      final timestamp = DateTime.tryParse(change['timestamp'] ?? '');
      final source = change['source'] ?? 'Unknown';
      final changeContext = change['context'] ?? '';

      buffer.writeln('Change ${i + 1}:');
      buffer.writeln('Time: ${_formatTimestamp(timestamp)}');
      buffer.writeln('Source: $source${changeContext.isNotEmpty ? ' ($changeContext)' : ''}');

      // Add call stack if available
      if (change['callStack'] != null && (change['callStack'] as List).isNotEmpty) {
        buffer.writeln('Call Stack: ${(change['callStack'] as List).join(' → ')}');
      }

      // Extract and format changes
      final changes = change['changes'] as Map<String, dynamic>? ?? <String, dynamic>{};

      if (changes.isNotEmpty) {
        buffer.writeln('Changes:');
        changes.forEach((key, value) {
          buffer.writeln('  ${_formatFieldName(key)}: ${_formatChangeDescription(key, value['from'], value['to'])}');
        });
      }

      buffer.writeln();
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    Get.snackbar(
      'Copied'.tr,
      'Room changes history copied to clipboard'.tr,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
