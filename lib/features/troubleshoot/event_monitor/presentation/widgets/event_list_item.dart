import 'package:flutter/material.dart';
import 'package:uchat/core/event_bus/event_bus.dart';

class EventListItem extends StatelessWidget {
  final TrackedEvent event;
  final VoidCallback? onTap;
  final VoidCallback? onCopy;

  const EventListItem({
    Key? key,
    required this.event,
    this.onTap,
    this.onCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(event.status);
    final statusIcon = _getStatusIcon(event.status);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: statusColor, width: 3),
            bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Icon
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 8, top: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                statusIcon,
                size: 14,
                color: statusColor,
              ),
            ),

            // Event Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Type
                  Text(
                    _formatEventType(event.eventType),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),

                  // Timestamp and Duration
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTimestamp(event.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (event.executionDuration != null) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.timer,
                          size: 12,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(event.executionDuration!),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                      if (event.listenerCount != null && event.listenerCount! > 0) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.hearing,
                          size: 12,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${event.listenerCount}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Error Message (if any)
                  if (event.error != null) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        event.error.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.red,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],

                  // Event Data Preview
                  const SizedBox(height: 4),
                  Text(
                    _getEventDataPreview(event),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[700],
                      fontFamily: 'monospace',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Copy Button
            if (onCopy != null)
              IconButton(
                icon: const Icon(Icons.copy, size: 16),
                onPressed: onCopy,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                tooltip: 'Copy Details',
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(EventStatus status) {
    switch (status) {
      case EventStatus.fired:
        return Colors.blue;
      case EventStatus.executed:
        return Colors.green;
      case EventStatus.error:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(EventStatus status) {
    switch (status) {
      case EventStatus.fired:
        return Icons.send;
      case EventStatus.executed:
        return Icons.check_circle;
      case EventStatus.error:
        return Icons.error;
    }
  }

  String _formatEventType(String eventType) {
    // Remove "Event" suffix if present
    String formatted = eventType.replaceAll('Event', '');

    // Add spaces between camelCase words
    formatted = formatted.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (Match m) => '${m[1]} ${m[2]}',
    );

    return formatted;
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}.${timestamp.millisecond.toString().padLeft(3, '0')}';
    }
  }

  String _formatDuration(Duration duration) {
    final microseconds = duration.inMicroseconds;
    if (microseconds < 1000) {
      return '${microseconds}μs';
    } else if (microseconds < 1000000) {
      return '${(microseconds / 1000).toStringAsFixed(1)}ms';
    } else {
      return '${(microseconds / 1000000).toStringAsFixed(2)}s';
    }
  }

  String _getEventDataPreview(TrackedEvent event) {
    final data = event.toMap()['eventData']?.toString() ?? '';
    if (data.isEmpty) return 'No data';

    // Truncate and clean up the data preview
    String preview = data.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ');
    if (preview.length > 100) {
      preview = '${preview.substring(0, 100)}...';
    }

    return preview;
  }
}