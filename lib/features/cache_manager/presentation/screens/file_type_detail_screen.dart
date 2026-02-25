import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/directory_stats.dart';
import '../../domain/entities/file_info.dart';

class FileTypeDetailScreen extends StatelessWidget {
  final FileTypeStats fileTypeStats;
  final String directoryName;
  final Function(FileType)? onClearFileType;

  const FileTypeDetailScreen({
    super.key,
    required this.fileTypeStats,
    required this.directoryName,
    this.onClearFileType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '@type Files'.trParams(
                {
                  'type': fileTypeStats.type.displayName,
                },
              ),
              style: context.textTheme.titleSmall,
            ),
            Text(
              '$directoryName • ${fileTypeStats.formattedSize}',
              style: context.textTheme.labelSmall,
            ),
          ],
        ),
        backgroundColor: context.theme.appBarTheme.backgroundColor,
        actions: [
          if (onClearFileType != null && fileTypeStats.files.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: () => _showClearAllConfirmation(context),
              tooltip: 'Clear all @type files'.trParams(
                {
                  'type': fileTypeStats.type.displayName.toLowerCase(),
                },
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Summary Card
          Container(
            width: double.infinity,
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
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getColorForFileType(fileTypeStats.type),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIconForFileType(fileTypeStats.type),
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileTypeStats.type.displayName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${fileTypeStats.count} files • ${fileTypeStats.formattedSize}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${fileTypeStats.formattedPercentage} of total',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Files List
          Expanded(
            child: fileTypeStats.files.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No files found'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: fileTypeStats.files.length,
                    itemBuilder: (context, index) {
                      final file = fileTypeStats.files[index];
                      return _buildFileItem(context, file, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileItem(BuildContext context, FileInfo file, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getColorForFileType(file.type).withOpacity(0.1),
          child: Icon(
            _getIconForFileType(file.type),
            color: _getColorForFileType(file.type),
            size: 20,
          ),
        ),
        title: Text(
          file.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              file.formattedSize,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _getRelativePath(file.path),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              'Modified: ${_formatDate(file.lastModified)}',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 11,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'info') {
              _showFileInfo(context, file);
            } else if (value == 'delete') {
              _showDeleteConfirmation(context, file);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'info',
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 20),
                  const SizedBox(width: 8),
                  Text('File Info'.tr),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                  const SizedBox(width: 8),
                  Text('Delete'.tr, style: const TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        onTap: () => _showFileInfo(context, file),
      ),
    );
  }

  void _showFileInfo(BuildContext context, FileInfo file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('File Information'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoRow('Name:', file.name),
              _buildInfoRow('Size:', file.formattedSize),
              _buildInfoRow('Type:',
                  '${file.type.displayName} (${file.extension.isEmpty ? 'No extension' : '.${file.extension}'})'),
              _buildInfoRow('Modified:', _formatDate(file.lastModified)),
              _buildInfoRow('Path:', file.path),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, FileInfo file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete File'.tr),
        content: Text('Are you sure you want to delete "@name"?'.trParams(
          {
            'name': file.name,
          },
        )),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteFile(file);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteFile(FileInfo file) {
    // TODO: Implement individual file deletion
    Get.snackbar(
      'File Deletion'.tr,
      'Individual file deletion will be implemented'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _showClearAllConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear All @type'.trParams(
          {
            'type': fileTypeStats.type.displayName.toLowerCase(),
          },
        )),
        content: Text(
          'Are you sure you want to delete all @count @type files (@size)?\n\nThis action cannot be undone.'.trParams(
            {
              'type': fileTypeStats.type.displayName.toLowerCase(),
              'count': fileTypeStats.count.toString(),
              'size': fileTypeStats.formattedSize,
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onClearFileType?.call(fileTypeStats.type);
              Navigator.of(context).pop(); // Go back to overview screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Delete All'.tr),
          ),
        ],
      ),
    );
  }

  String _getRelativePath(String fullPath) {
    // Extract just the directory part after the base directory
    final parts = fullPath.split('/');
    if (parts.length > 3) {
      return '.../${parts.sublist(parts.length - 2).join('/')}';
    }
    return fullPath;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}m ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min ago';
    } else {
      return 'Just now';
    }
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
