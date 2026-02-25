import 'package:flutter/material.dart';

class EventTypeFilterChip extends StatelessWidget {
  final String eventType;
  final bool isSelected;
  final VoidCallback onSelected;

  const EventTypeFilterChip({
    Key? key,
    required this.eventType,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayName = _formatEventTypeName(eventType);

    return FilterChip(
      label: Text(
        displayName,
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? Colors.white : null,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: _getEventTypeColor(eventType),
      backgroundColor: _getEventTypeColor(eventType).withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  String _formatEventTypeName(String eventType) {
    // Extract the main part of the event name
    String name = eventType.replaceAll('Event', '');

    // Handle common patterns
    if (name.startsWith('Room')) {
      name = name.substring(4);
    } else if (name.startsWith('Message')) {
      name = name.substring(7);
    } else if (name.startsWith('User')) {
      name = name.substring(4);
    } else if (name.startsWith('Contact')) {
      name = name.substring(7);
    }

    // Add spaces between camelCase words
    name = name.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (Match m) => '${m[1]} ${m[2]}',
    );

    // Truncate if too long
    if (name.length > 15) {
      name = '${name.substring(0, 12)}...';
    }

    return name;
  }

  Color _getEventTypeColor(String eventType) {
    final lowerType = eventType.toLowerCase();

    if (lowerType.contains('room')) {
      return Colors.blue;
    } else if (lowerType.contains('message')) {
      return Colors.green;
    } else if (lowerType.contains('user')) {
      return Colors.purple;
    } else if (lowerType.contains('contact')) {
      return Colors.orange;
    } else if (lowerType.contains('error')) {
      return Colors.red;
    } else if (lowerType.contains('socket')) {
      return Colors.indigo;
    } else if (lowerType.contains('sync')) {
      return Colors.teal;
    } else if (lowerType.contains('notification')) {
      return Colors.amber;
    } else if (lowerType.contains('file')) {
      return Colors.brown;
    } else if (lowerType.contains('call')) {
      return Colors.cyan;
    }

    // Default color for unknown types
    return Colors.grey;
  }
}