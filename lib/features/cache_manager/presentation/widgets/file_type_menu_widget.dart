import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/directory_stats.dart';
import '../../domain/entities/file_info.dart';
import '../screens/file_type_detail_screen.dart';

class FileTypeMenuWidget extends StatelessWidget {
  final DirectoryStats? directoryStats;
  final String directoryName;
  final Function(FileType)? onClearFileType;

  const FileTypeMenuWidget({
    super.key,
    this.directoryStats,
    required this.directoryName,
    this.onClearFileType,
  });

  @override
  Widget build(BuildContext context) {
    if (directoryStats == null || directoryStats!.isEmpty) {
      return _buildEmptyState();
    }

    final fileTypeStats = directoryStats!.fileTypeStatsList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'File Types'.tr,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...fileTypeStats.map((stats) => _buildFileTypeItem(context, stats)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'File Types'.tr,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No files to display'.tr,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileTypeItem(BuildContext context, FileTypeStats stats) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getColorForFileType(stats.type),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getIconForFileType(stats.type),
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          stats.type.displayName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${stats.count} files • ${stats.formattedSize}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: stats.percentage / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getColorForFileType(stats.type),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  stats.formattedPercentage,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onPressed: () => _navigateToFileDetail(context, stats),
          tooltip: 'View files'.tr,
        ),
        onTap: () => _navigateToFileDetail(context, stats),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
    );
  }

  void _navigateToFileDetail(BuildContext context, FileTypeStats stats) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FileTypeDetailScreen(
          fileTypeStats: stats,
          directoryName: directoryName,
          onClearFileType: onClearFileType,
        ),
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
