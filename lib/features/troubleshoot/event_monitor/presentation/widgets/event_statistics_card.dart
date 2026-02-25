import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/troubleshoot/event_monitor/presentation/controllers/event_monitor_controller.dart';

class EventStatisticsCard extends StatelessWidget {
  final EventMonitorController controller;

  const EventStatisticsCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() {
        final isPaused = controller.isPaused.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Event Statistics',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPaused ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPaused ? Icons.pause : Icons.fiber_manual_record,
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isPaused ? 'PAUSED' : 'RECORDING',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatisticItem(
                    icon: Icons.event,
                    label: 'Total Events',
                    value: controller.totalEventCount.value.toString(),
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _StatisticItem(
                    icon: Icons.error,
                    label: 'Errors',
                    value: controller.errorCount.value.toString(),
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: _StatisticItem(
                    icon: Icons.timer,
                    label: 'Avg Time',
                    value: controller.formatDuration(controller.averageExecutionTime.value),
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _StatisticItem(
                    icon: Icons.category,
                    label: 'Event Types',
                    value: controller.availableEventTypes.length.toString(),
                    color: Colors.purple,
                  ),
                ),
              ],
            ),

            // Top Event Types
            if (controller.eventStatistics['statistics'] != null) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Most Frequent Events',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ..._getTopEventTypes().map((entry) {
                final percentage = ((entry.value / controller.totalEventCount.value) * 100)
                    .toStringAsFixed(1);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _formatEventTypeName(entry.key),
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${entry.value} ($percentage%)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ],
        );
      }),
    );
  }

  List<MapEntry<String, int>> _getTopEventTypes() {
    final stats = controller.eventStatistics['statistics'] as Map<String, dynamic>?;
    if (stats == null) return [];

    final eventCounts = <String, int>{};
    stats.forEach((key, value) {
      if (value is Map && value['firedCount'] != null) {
        eventCounts[key] = value['firedCount'] as int;
      }
    });

    final sortedEntries = eventCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedEntries.take(3).toList();
  }

  String _formatEventTypeName(String eventType) {
    String formatted = eventType.replaceAll('Event', '');
    formatted = formatted.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (Match m) => '${m[1]} ${m[2]}',
    );
    return formatted;
  }
}

class _StatisticItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatisticItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}