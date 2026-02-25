import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/setting/domain/use_cases/generate_data_for_stress_test_use_case.dart';
import 'package:uchat/utils/datetime.dart';

class StressTestConfigDialog extends StatefulWidget {
  final Function(StressTestParams) onConfirm;

  const StressTestConfigDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<StressTestConfigDialog> createState() => _StressTestConfigDialogState();
}

class _StressTestConfigDialogState extends State<StressTestConfigDialog> {
  // Default values (reasonable starting points)
  double messageCount = 50.0;
  double contactCount = 3.0;
  double groupCount = 2.0;
  double groupMemberCount = 3.0;
  double oaCount = 2.0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDialogHeight = screenHeight * 0.9; // Use 90% of screen height
    final maxDialogWidth = screenWidth * 0.9; // Use 90% of screen width

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: maxDialogHeight,
          maxWidth: maxDialogWidth,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Fixed Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stress Test Configuration',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Configure the number of each data type to generate for stress testing',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Warning about limits
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.orange[700],
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Maximum Limits',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Generation will stop if limits are reached:\n'
                                  '• Messages: ${GenerateDataForStressTestUseCase.messageCountMax.toInt()}\n'
                                  '• Contacts: ${GenerateDataForStressTestUseCase.contactCountMax.toInt()}\n'
                                  '• Groups: ${GenerateDataForStressTestUseCase.groupCountMax.toInt()}\n'
                                  '• OAs: ${GenerateDataForStressTestUseCase.oaCountMax.toInt()}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.orange[700],
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Sliders
                    _buildSlider(
                      title: 'Messages per Room',
                      subtitle:
                          'Number of messages in each chat room (Max: ${GenerateDataForStressTestUseCase.messageCountMax.toInt()})',
                      icon: Icons.message,
                      value: messageCount,
                      min: 10,
                      max: GenerateDataForStressTestUseCase.messageCountMax,
                      divisions: ((GenerateDataForStressTestUseCase.messageCountMax - 10) / 10).toInt(),
                      onChanged: (value) => setState(() => messageCount = value),
                    ),

                    _buildSlider(
                      title: 'Friend Contacts',
                      subtitle:
                          'Number of friend contacts to create (Max: ${GenerateDataForStressTestUseCase.contactCountMax.toInt()})',
                      icon: Icons.people,
                      value: contactCount,
                      min: 1,
                      max: GenerateDataForStressTestUseCase.contactCountMax,
                      divisions: (GenerateDataForStressTestUseCase.contactCountMax - 1).toInt(),
                      onChanged: (value) => setState(() => contactCount = value),
                    ),

                    _buildSlider(
                      title: 'Group Chats',
                      subtitle:
                          'Number of group chats to create (Max: ${GenerateDataForStressTestUseCase.groupCountMax.toInt()})',
                      icon: Icons.group,
                      value: groupCount,
                      min: 1,
                      max: GenerateDataForStressTestUseCase.groupCountMax,
                      divisions: (GenerateDataForStressTestUseCase.groupCountMax - 1).toInt(),
                      onChanged: (value) => setState(() => groupCount = value),
                    ),

                    _buildSlider(
                      title: 'Group Members',
                      subtitle:
                          'Number of members in each group (Max: ${GenerateDataForStressTestUseCase.groupMemberCountMax.toInt()})',
                      icon: Icons.supervisor_account,
                      value: groupMemberCount,
                      min: 2,
                      max: GenerateDataForStressTestUseCase.groupMemberCountMax,
                      divisions: (GenerateDataForStressTestUseCase.groupMemberCountMax - 2).toInt(),
                      onChanged: (value) => setState(() => groupMemberCount = value),
                    ),

                    _buildSlider(
                      title: 'Official Accounts',
                      subtitle:
                          'Number of official accounts to create (Max: ${GenerateDataForStressTestUseCase.oaCountMax.toInt()})',
                      icon: Icons.business,
                      value: oaCount,
                      min: 1,
                      max: GenerateDataForStressTestUseCase.oaCountMax,
                      divisions: (GenerateDataForStressTestUseCase.oaCountMax - 1).toInt(),
                      onChanged: (value) => setState(() => oaCount = value),
                    ),

                    const SizedBox(height: 16),

                    // Summary
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Summary',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          const SizedBox(height: 8),
                          _buildSummaryRow('Total Messages', '~${_calculateTotalMessages()}'),
                          _buildSummaryRow(
                              'Total Rooms', '${contactCount.toInt() + groupCount.toInt() + oaCount.toInt()}'),
                          _buildSummaryRow('Total Contacts', '${contactCount.toInt() + oaCount.toInt()}'),
                          _buildSummaryRow(
                              'Estimated Time', '~${Duration(seconds: _estimateTime()).durationTextWithUnit}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Fixed Footer
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel'.tr),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final params = StressTestParams(
                          messageCount: messageCount.toInt(),
                          contactCount: contactCount.toInt(),
                          groupCount: groupCount.toInt(),
                          groupMemberCount: groupMemberCount.toInt(),
                          oaCount: oaCount.toInt(),
                        );
                        Navigator.of(context).pop();
                        widget.onConfirm(params);
                      },
                      icon: const Icon(Icons.rocket_launch),
                      label: Text('Generate'.tr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String title,
    required String subtitle,
    required IconData icon,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value.toInt().toString(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  int _calculateTotalMessages() {
    final totalRooms = contactCount + groupCount + oaCount;
    return (totalRooms * messageCount).toInt();
  }

  int _estimateTime() {
    final totalMessages = _calculateTotalMessages();
    // Rough estimate: ~0.1 second per message + room setup time
    return ((totalMessages * 0.1) + (contactCount + groupCount + oaCount) * 0.5).toInt();
  }
}
