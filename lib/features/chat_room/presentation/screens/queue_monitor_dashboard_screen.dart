import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/queue_monitor_dashboard_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/queue_monitor/queue_status_card.dart';
import 'package:uchat/features/chat_room/presentation/widgets/queue_monitor/queue_metrics_card.dart';
import 'package:uchat/features/chat_room/presentation/widgets/queue_monitor/queue_jobs_list.dart';

/// Queue Monitor Dashboard Screen
class QueueMonitorDashboardScreen extends GetView<QueueMonitorDashboardController> {
  const QueueMonitorDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.togglePause();
            await Future.delayed(const Duration(milliseconds: 100));
            controller.togglePause();
          },
          child: CustomScrollView(
            slivers: [
              // Status Card (Always visible at top)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: QueueStatusCard(controller: controller),
                ),
              ),

              // Metrics Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: QueueMetricsCard(controller: controller),
                ),
              ),

              // Filter Chips
              SliverToBoxAdapter(
                child: _buildFilterChips(),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: _buildSearchBar(),
              ),

              // Jobs List Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jobs History',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${controller.filteredJobs.length} items',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),

              // Jobs List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: QueueJobsList(controller: controller),
              ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          ),
        );
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Queue Monitor'),
          Text(
            controller.roomName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        // Pause/Resume button
        Obx(() => IconButton(
          icon: Icon(
            controller.isPaused.value ? Icons.play_arrow : Icons.pause,
          ),
          onPressed: controller.togglePause,
          tooltip: controller.isPaused.value ? 'Resume' : 'Pause',
        )),

        // Auto-scroll toggle
        Obx(() => IconButton(
          icon: Icon(
            controller.autoScroll.value
              ? Icons.vertical_align_bottom
              : Icons.vertical_align_center,
            color: controller.autoScroll.value ? Colors.blue : null,
          ),
          onPressed: controller.toggleAutoScroll,
          tooltip: 'Auto-scroll',
        )),

        // Menu
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'export_json':
                controller.exportToJson();
                break;
              case 'export_csv':
                controller.exportToCsv();
                break;
              case 'clear':
                controller.clearHistory();
                break;
              case 'refresh':
                controller.togglePause();
                Future.delayed(const Duration(milliseconds: 100), () {
                  controller.togglePause();
                });
                break;
              case 'debug':
                controller.debugJobsState();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'export_json',
              child: ListTile(
                leading: Icon(Icons.code),
                title: Text('Export as JSON'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'export_csv',
              child: ListTile(
                leading: Icon(Icons.table_chart),
                title: Text('Export as CSV'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'clear',
              child: ListTile(
                leading: Icon(Icons.clear_all, color: Colors.orange),
                title: Text('Clear History'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'refresh',
              child: ListTile(
                leading: Icon(Icons.refresh),
                title: Text('Refresh'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'debug',
              child: ListTile(
                leading: Icon(Icons.bug_report, color: Colors.purple),
                title: Text('Debug Jobs State'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8.0,
        children: [
          Obx(() => FilterChip(
            label: const Text('All'),
            selected: controller.selectedFilter.value == 'all',
            onSelected: (_) => controller.applyFilter('all'),
          )),
          Obx(() => FilterChip(
            label: const Text('Active'),
            selected: controller.selectedFilter.value == 'active',
            onSelected: (_) => controller.applyFilter('active'),
            avatar: const CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 6,
            ),
          )),
          Obx(() => FilterChip(
            label: const Text('Completed'),
            selected: controller.selectedFilter.value == 'completed',
            onSelected: (_) => controller.applyFilter('completed'),
            avatar: const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 6,
            ),
          )),
          Obx(() => FilterChip(
            label: const Text('Failed'),
            selected: controller.selectedFilter.value == 'failed',
            onSelected: (_) => controller.applyFilter('failed'),
            avatar: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 6,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: controller.searchJobs,
        decoration: InputDecoration(
          hintText: 'Search jobs by label or ID...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.searchQuery.value.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => controller.searchJobs(''),
              )
            : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}