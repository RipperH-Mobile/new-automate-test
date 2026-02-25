import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/queue_monitor_dashboard_controller.dart';

/// Queue Metrics Card Widget
class QueueMetricsCard extends StatelessWidget {
  final QueueMonitorDashboardController controller;

  const QueueMetricsCard({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Text(
          'Detailed Metrics',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.analytics),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => _buildMetricsContent(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsContent(BuildContext context) {
    final summary = controller.performanceSummary.value;
    final metrics = controller.queueMetrics.value;

    if (summary == null) {
      return const Center(
        child: Text('No metrics available'),
      );
    }

    return Column(
      children: [
        // Performance Overview
        _buildMetricsRow(context, [
          _buildMetricItem(
            context,
            'Total Processed',
            '${summary.totalProcessed}',
            Icons.done_all,
            Colors.blue,
          ),
          _buildMetricItem(
            context,
            'Failed Jobs',
            '${summary.totalFailed}',
            Icons.error,
            summary.totalFailed > 0 ? Colors.red : Colors.green,
          ),
        ]),

        const SizedBox(height: 16),

        // Timing Metrics
        _buildMetricsRow(context, [
          _buildMetricItem(
            context,
            'Avg Processing',
            controller.formatDuration(summary.averageProcessingTime.round()),
            Icons.speed,
            summary.averageProcessingTime < 3000 ? Colors.green : Colors.orange,
          ),
          _buildMetricItem(
            context,
            'Slow Jobs',
            '${summary.slowJobs}',
            Icons.slow_motion_video,
            summary.slowJobs > 0 ? Colors.orange : Colors.green,
          ),
        ]),

        const SizedBox(height: 16),

        // Current State
        if (metrics != null) ...[
          _buildMetricsRow(context, [
            _buildMetricItem(
              context,
              'Active Now',
              '${metrics.activeJobCount}',
              Icons.work,
              metrics.activeJobCount > 0 ? Colors.blue : Colors.grey,
            ),
            _buildMetricItem(
              context,
              'Last Updated',
              _formatTimeAgo(metrics.timestamp),
              Icons.access_time,
              Colors.grey,
            ),
          ]),
        ],

        // Success Rate Progress Bar
        const SizedBox(height: 16),
        _buildSuccessRateBar(context, summary),
      ],
    );
  }

  Widget _buildMetricsRow(BuildContext context, List<Widget> children) {
    return Row(
      children: children
          .map((child) => Expanded(child: child))
          .expand((widget) => [widget, const SizedBox(width: 16)])
          .toList()
        ..removeLast(), // Remove last SizedBox
    );
  }

  Widget _buildMetricItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessRateBar(BuildContext context, summary) {
    final successRate = summary.successRate;
    final percentage = (successRate * 100).toStringAsFixed(1);

    Color barColor;
    if (successRate >= 0.95) {
      barColor = Colors.green;
    } else if (successRate >= 0.8) {
      barColor = Colors.orange;
    } else {
      barColor = Colors.red;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Success Rate',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$percentage%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: barColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: successRate,
          backgroundColor: Colors.grey.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(barColor),
          minHeight: 8,
        ),
        const SizedBox(height: 4),
        Text(
          '${summary.totalProcessed - summary.totalFailed} successful out of ${summary.totalProcessed} total',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}