import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/troubleshoot/event_monitor/presentation/controllers/event_monitor_controller.dart';
import 'package:uchat/features/troubleshoot/event_monitor/presentation/widgets/event_list_item.dart';
import 'package:uchat/features/troubleshoot/event_monitor/presentation/widgets/event_statistics_card.dart';
import 'package:uchat/features/troubleshoot/event_monitor/presentation/widgets/event_type_filter_chip.dart';

class EventMonitorScreen extends GetView<EventMonitorController> {
  const EventMonitorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EventMonitorController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Monitor'),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isPaused.value ? Icons.play_arrow : Icons.pause,
                  color: controller.isPaused.value ? Colors.green : Colors.orange,
                ),
                onPressed: controller.togglePause,
                tooltip: controller.isPaused.value ? 'Resume' : 'Pause',
              )),
          Obx(() => IconButton(
                icon: Icon(
                  controller.autoScroll.value ? Icons.vertical_align_bottom : Icons.vertical_align_top,
                  color: controller.autoScroll.value ? Colors.blue : Colors.grey,
                ),
                onPressed: controller.toggleAutoScroll,
                tooltip: 'Auto Scroll',
              )),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'export_json':
                  controller.exportAsJson();
                  break;
                case 'export_csv':
                  controller.exportAsCsv();
                  break;
                case 'clear':
                  controller.clearHistory();
                  break;
                case 'toggle_tracking':
                  controller.toggleTracking();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'toggle_tracking',
                child: Obx(() => Text(
                      controller.isTracking.value ? 'Disable Tracking' : 'Enable Tracking',
                    )),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'export_json',
                child: Text('Export as JSON'),
              ),
              const PopupMenuItem(
                value: 'export_csv',
                child: Text('Export as CSV'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'clear',
                child: Text('Clear History'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistics Card
          Obx(() => controller.isTracking.value
              ? EventStatisticsCard(controller: controller)
              : Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.orange.withOpacity(0.1),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text('Event tracking is disabled'),
                      ),
                      ElevatedButton(
                        onPressed: controller.toggleTracking,
                        child: const Text('Enable'),
                      ),
                    ],
                  ),
                )),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Search events...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => controller.updateSearchQuery(''),
                      )
                    : const SizedBox.shrink()),
              ),
              onChanged: controller.updateSearchQuery,
            ),
          ),

          // Filter Chips
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                // Error Filter Toggle
                Obx(() => FilterChip(
                      label: Text('Errors (${controller.errorCount})'),
                      selected: controller.showOnlyErrors.value,
                      onSelected: (_) => controller.toggleErrorFilter(),
                      selectedColor: Colors.red.withOpacity(0.2),
                      avatar: const Icon(Icons.error, size: 16),
                    )),
                const SizedBox(width: 8),

                // Event Type Filters
                Expanded(
                  child: Obx(() => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.availableEventTypes.length,
                        itemBuilder: (context, index) {
                          final eventType = controller.availableEventTypes[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: EventTypeFilterChip(
                              eventType: eventType,
                              isSelected: controller.selectedEventTypes.contains(eventType),
                              onSelected: () => controller.toggleEventTypeFilter(eventType),
                            ),
                          );
                        },
                      )),
                ),

                // Clear Filters
                Obx(() => controller.selectedEventTypes.isNotEmpty ||
                        controller.showOnlyErrors.value ||
                        controller.searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_all),
                        onPressed: controller.clearSelectedFilters,
                        tooltip: 'Clear Filters',
                      )
                    : const SizedBox.shrink()),
              ],
            ),
          ),

          const Divider(),

          // Event List
          Expanded(
            child: Obx(() {
              final events = controller.filteredEvents;

              if (events.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        controller.isTracking.value ? Icons.hourglass_empty : Icons.stop_circle_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.isTracking.value ? 'No events captured' : 'Event tracking is disabled',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (!controller.isTracking.value) ...[
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: controller.toggleTracking,
                          child: const Text('Enable Tracking'),
                        ),
                      ],
                    ],
                  ),
                );
              }

              return ListView.builder(
                reverse: controller.autoScroll.value,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[controller.autoScroll.value ? events.length - 1 - index : index];
                  return EventListItem(
                    event: event,
                    onTap: () => _showEventDetails(context, event),
                    onCopy: () => controller.copyEventDetails(event),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(BuildContext context, TrackedEvent event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Event Details',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      controller.copyEventDetails(event);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Event Type', event.eventType),
                    _buildDetailRow('Status', event.status.toString().split('.').last),
                    _buildDetailRow('Timestamp', event.timestamp.toString()),
                    _buildDetailRow(
                      'Duration',
                      controller.formatDuration(event.executionDuration),
                    ),
                    _buildDetailRow(
                      'Listener Count',
                      event.listenerCount?.toString() ?? 'N/A',
                    ),
                    if (event.error != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Error',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.red,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SelectableText(
                          event.error.toString(),
                          style: const TextStyle(fontFamily: 'monospace'),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      'Event Data',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SelectableText(
                        event.toMap()['eventData']?.toString() ?? 'N/A',
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SelectableText(value),
          ),
        ],
      ),
    );
  }
}
