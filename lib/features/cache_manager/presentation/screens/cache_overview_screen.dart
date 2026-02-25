import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cache_manager_controller.dart';
import '../widgets/cache_pie_chart_widget.dart';
import '../widgets/file_type_menu_widget.dart';

class CacheOverviewScreen extends StatelessWidget {
  const CacheOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CacheManagerController>(
      init: CacheManagerController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Cache Manager'.tr,
              style: context.textTheme.titleSmall,
            ),
            backgroundColor: context.theme.appBarTheme.backgroundColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refreshData,
                tooltip: 'Refresh'.tr,
              ),
            ],
          ),
          body: Column(
            children: [
              // Tab Bar
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Obx(() => Row(
                      children: [
                        Expanded(
                          child: _buildTabButton(
                            context,
                            'Temporary Directory',
                            0,
                            controller.selectedTabIndex == 0,
                            controller.temporaryDirectoryStats?.formattedTotalSize ?? '0 B',
                            () => controller.setSelectedTab(0),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 60,
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: _buildTabButton(
                            context,
                            'Application Support',
                            1,
                            controller.selectedTabIndex == 1,
                            controller.applicationSupportDirectoryStats?.formattedTotalSize ?? '0 B',
                            () => controller.setSelectedTab(1),
                          ),
                        ),
                      ],
                    )),
              ),
              // Content
              Expanded(
                child: Obx(() {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.error.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error'.tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              controller.error,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: controller.refreshData,
                            child: Text('Retry'.tr),
                          ),
                        ],
                      ),
                    );
                  }

                  final currentStats = controller.currentDirectoryStats;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // Summary Card
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                controller.selectedTabIndex == 0
                                    ? 'Temporary Directory'
                                    : 'Application Support Directory',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Pie Chart
                              CachePieChartWidget(
                                directoryStats: currentStats,
                              ),
                              const SizedBox(height: 16),
                              // Clear All Button
                              if (currentStats != null && !currentStats.isEmpty)
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () => _showClearAllConfirmation(context, controller),
                                    icon: const Icon(Icons.clear_all),
                                    label: const Text('Clear All Cache'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // File Type Menu
                        FileTypeMenuWidget(
                          directoryStats: currentStats,
                          directoryName: controller.selectedTabIndex == 0
                              ? 'Temporary Directory'
                              : 'Application Support Directory',
                          onClearFileType: controller.clearCacheByType,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    String title,
    int index,
    bool isSelected,
    String size,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              size,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey[500],
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Container(
                height: 2,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showClearAllConfirmation(BuildContext context, CacheManagerController controller) {
    final currentStats = controller.currentDirectoryStats;
    if (currentStats == null) return;

    final directoryName = controller.selectedTabIndex == 0 ? 'Temporary Directory' : 'Application Support Directory';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clear All Cache'.tr),
          content: Text(
            'Are you sure you want to delete all files from the @dirName?\n\n This will delete @currentState files (@totalState).'
                .trParams(
              {
                'dirName': directoryName,
                'currentState': currentStats.totalFiles.toString(),
                'totalState': currentStats.formattedTotalSize,
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.clearAllCache();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Delete All'.tr),
            ),
          ],
        );
      },
    );
  }
}
