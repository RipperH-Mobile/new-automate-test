import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/directory_stats.dart';
import '../../domain/entities/file_info.dart';

class CachePieChartWidget extends StatelessWidget {
  final DirectoryStats? directoryStats;

  const CachePieChartWidget({
    super.key,
    this.directoryStats,
  });

  @override
  Widget build(BuildContext context) {
    if (directoryStats == null || directoryStats!.isEmpty) {
      return _buildEmptyState();
    }

    final fileTypeStats = directoryStats!.fileTypeStatsList;

    return SizedBox(
      height: 300,
      width: 300,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 80,
              sections: _buildPieChartSections(fileTypeStats),
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  // Handle touch events if needed
                },
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  directoryStats!.formattedTotalSize,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${directoryStats!.totalFiles} files',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 300,
      width: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No files found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(List<FileTypeStats> fileTypeStats) {
    return fileTypeStats.map((stats) {
      return PieChartSectionData(
        color: _getColorForFileType(stats.type),
        value: stats.percentage,
        title: '${stats.formattedPercentage}',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        badgeWidget: _buildBadge(stats.type),
        badgePositionPercentageOffset: 1.3,
      );
    }).toList();
  }

  Widget _buildBadge(FileType fileType) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: _getColorForFileType(fileType),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(
        _getIconForFileType(fileType),
        size: 12,
        color: Colors.white,
      ),
    );
  }

  Color _getColorForFileType(FileType fileType) {
    switch (fileType) {
      case FileType.image:
        return Colors.blue;
      case FileType.video:
        return Colors.red;
      case FileType.audio:
        return Colors.purple;
      case FileType.document:
        return Colors.orange;
      case FileType.archive:
        return Colors.green;
      case FileType.misc:
        return Colors.grey;
    }
  }

  IconData _getIconForFileType(FileType fileType) {
    switch (fileType) {
      case FileType.image:
        return Icons.image;
      case FileType.video:
        return Icons.videocam;
      case FileType.audio:
        return Icons.audiotrack;
      case FileType.document:
        return Icons.description;
      case FileType.archive:
        return Icons.archive;
      case FileType.misc:
        return Icons.insert_drive_file;
    }
  }
}
