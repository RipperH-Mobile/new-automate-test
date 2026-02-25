import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_adding_queue_monitor.dart';
import 'package:uchat/features/chat_room/presentation/controllers/queue_monitor_dashboard_controller.dart';

/// Queue Status Card Widget
class QueueStatusCard extends StatelessWidget {
  final QueueMonitorDashboardController controller;

  const QueueStatusCard({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Queue Status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() => _buildStatusBadge(context)),
              ],
            ),
            const SizedBox(height: 16),
            Obx(() => _buildStatusDetails(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final state = controller.currentState.value;
    final color = controller.getStateColor(state);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            state.displayName,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDetails(BuildContext context) {
    final summary = controller.performanceSummary.value;
    final activeJobs = controller.jobsList.where((job) => job.isRunning).length;

    return Column(
      children: [
        // Active Jobs and Health Status
        Row(
          children: [
            Expanded(
              child: _buildStatusItem(
                context,
                'Active Jobs',
                '$activeJobs',
                Icons.work,
                activeJobs > 0 ? Colors.blue : Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildHealthStatus(context),
            ),
          ],
        ),

        if (summary != null) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatusItem(
                  context,
                  'Success Rate',
                  '${(summary.successRate * 100).toStringAsFixed(1)}%',
                  Icons.check_circle,
                  summary.successRate >= 0.95 ? Colors.green : Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatusItem(
                  context,
                  'Avg Time',
                  controller.formatDuration(summary.averageProcessingTime.round()),
                  Icons.timer,
                  summary.averageProcessingTime < 3000 ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
        ],

        // Warnings
        if (summary != null && (!summary.isHealthy || summary.stuckJobs > 0)) ...[
          const SizedBox(height: 12),
          _buildWarnings(context, summary),
        ],
      ],
    );
  }

  Widget _buildStatusItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHealthStatus(BuildContext context) {
    final summary = controller.performanceSummary.value;
    final isHealthy = summary?.isHealthy ?? true;
    final color = controller.getHealthColor();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            isHealthy ? Icons.favorite : Icons.warning,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            isHealthy ? 'Healthy' : 'Issues',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Health Status',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWarnings(BuildContext context, MessageQueuePerformanceSummary summary) {
    final warnings = <String>[];

    if (summary.stuckJobs > 0) {
      warnings.add('${summary.stuckJobs} stuck jobs detected');
    }

    if (summary.successRate < 0.95) {
      warnings.add('Low success rate: ${(summary.successRate * 100).toStringAsFixed(1)}%');
    }

    if (summary.averageProcessingTime > 5000) {
      warnings.add('Slow processing: ${controller.formatDuration(summary.averageProcessingTime.round())} avg');
    }

    if (warnings.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 16),
              const SizedBox(width: 8),
              Text(
                'Performance Warnings',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...warnings.map((warning) => Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              '• $warning',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.orange[800],
              ),
            ),
          )),
        ],
      ),
    );
  }
}