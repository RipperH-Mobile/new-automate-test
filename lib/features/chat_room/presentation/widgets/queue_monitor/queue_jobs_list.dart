import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_adding_queue_monitor.dart';
import 'package:uchat/features/chat_room/presentation/controllers/queue_monitor_dashboard_controller.dart';

/// Queue Jobs List Widget
class QueueJobsList extends StatelessWidget {
  final QueueMonitorDashboardController controller;

  const QueueJobsList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final jobs = controller.filteredJobs;

      if (jobs.isEmpty) {
        return const SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: Center(
              child: Text('No jobs to display'),
            ),
          ),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final job = jobs[index];
            return _buildJobItem(context, job, index);
          },
          childCount: jobs.length,
        ),
      );
    });
  }

  Widget _buildJobItem(BuildContext context, MessageQueueJobInfo job, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        leading: _buildJobStatusIcon(job),
        title: Text(
          job.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        subtitle: Text(
          '${_formatTime(job.startTime)} • ${controller.formatDuration(job.processingDuration)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (job.isStuck)
              const Icon(
                Icons.warning,
                color: Colors.orange,
                size: 16,
              ),
            if (job.processingDuration > 5000 && job.isRunning)
              const Icon(
                Icons.slow_motion_video,
                color: Colors.orange,
                size: 16,
              ),
            const SizedBox(width: 8),
            _buildStatusChip(context, job),
          ],
        ),
        children: [
          _buildJobDetails(context, job),
        ],
      ),
    );
  }

  Widget _buildJobStatusIcon(MessageQueueJobInfo job) {
    if (job.isRunning) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            job.isStuck ? Colors.orange : Colors.blue,
          ),
        ),
      );
    } else if (job.isSuccess) {
      return const Icon(Icons.check_circle, color: Colors.green);
    } else {
      return const Icon(Icons.error, color: Colors.red);
    }
  }

  Widget _buildStatusChip(BuildContext context, MessageQueueJobInfo job) {
    Color color;
    String label;

    if (job.isRunning) {
      color = job.isStuck ? Colors.orange : Colors.blue;
      label = job.isStuck ? 'Stuck' : 'Running';
    } else if (job.isSuccess) {
      color = Colors.green;
      label = 'Completed';
    } else {
      color = Colors.red;
      label = 'Failed';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildJobDetails(BuildContext context, MessageQueueJobInfo job) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job ID and Copy Button
          Row(
            children: [
              Expanded(
                child: _buildDetailRow(context, 'Job ID', job.id),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 16),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: job.id));
                  Get.snackbar(
                    'Copied',
                    'Job ID copied to clipboard',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 1),
                  );
                },
                tooltip: 'Copy Job ID',
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Room ID
          _buildDetailRow(context, 'Room ID', job.roomId),

          const SizedBox(height: 8),

          // Timing Information
          Row(
            children: [
              Expanded(
                child: _buildDetailRow(context, 'Started', _formatDateTime(job.startTime)),
              ),
              if (job.endTime != null)
                Expanded(
                  child: _buildDetailRow(context, 'Ended', _formatDateTime(job.endTime!)),
                ),
            ],
          ),

          const SizedBox(height: 8),

          // Duration and Status
          Row(
            children: [
              Expanded(
                child: _buildDetailRow(
                  context,
                  'Duration',
                  controller.formatDuration(job.processingDuration),
                ),
              ),
              Expanded(
                child: _buildDetailRow(
                  context,
                  'Status',
                  job.isRunning ? 'Running' : (job.isSuccess ? 'Success' : 'Failed'),
                ),
              ),
            ],
          ),

          // Error Message (if any)
          if (job.errorMessage != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Error Message',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    job.errorMessage!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red[800],
                        ),
                  ),
                ],
              ),
            ),
          ],

          // Performance Indicators
          if (job.isStuck || job.processingDuration > 5000) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.orange, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Performance Notice',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (job.isStuck)
                    Text(
                      '• This job appears to be stuck (running for over 2 minutes)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.orange[800],
                          ),
                    ),
                  if (job.processingDuration > 5000)
                    Text(
                      '• This job is taking longer than expected (>${controller.formatDuration(5000)})',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.orange[800],
                          ),
                    ),
                ],
              ),
            ),
          ],

          // Actions
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  final jobData = job.toJson();
                  final jsonString = const JsonEncoder.withIndent('  ').convert(jobData);
                  Clipboard.setData(ClipboardData(text: jsonString));
                  Get.snackbar(
                    'Copied',
                    'Job details copied to clipboard',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 1),
                  );
                },
                icon: const Icon(Icons.content_copy, size: 16),
                label: const Text('Copy Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}:'
        '${dateTime.second.toString().padLeft(2, '0')}';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month} ${_formatTime(dateTime)}';
  }
}
