import 'file_info.dart';

class DirectoryStats {
  final String directoryPath;
  final String directoryName;
  final List<FileInfo> files;
  final Map<FileType, List<FileInfo>> filesByType;
  final Map<FileType, int> fileSizeByType;
  final int totalSize;
  final int totalFiles;

  const DirectoryStats({
    required this.directoryPath,
    required this.directoryName,
    required this.files,
    required this.filesByType,
    required this.fileSizeByType,
    required this.totalSize,
    required this.totalFiles,
  });

  factory DirectoryStats.fromFiles(String directoryPath, String directoryName, List<FileInfo> files) {
    final Map<FileType, List<FileInfo>> filesByType = {};
    final Map<FileType, int> fileSizeByType = {};

    // Initialize maps
    for (FileType type in FileType.values) {
      filesByType[type] = [];
      fileSizeByType[type] = 0;
    }

    // Group files by type and calculate sizes
    for (FileInfo file in files) {
      filesByType[file.type]!.add(file);
      fileSizeByType[file.type] = fileSizeByType[file.type]! + file.size;
    }

    final totalSize = files.fold<int>(0, (sum, file) => sum + file.size);

    return DirectoryStats(
      directoryPath: directoryPath,
      directoryName: directoryName,
      files: files,
      filesByType: filesByType,
      fileSizeByType: fileSizeByType,
      totalSize: totalSize,
      totalFiles: files.length,
    );
  }

  List<FileTypeStats> get fileTypeStatsList {
    return FileType.values
        .map((type) {
          final files = filesByType[type] ?? [];
          final size = fileSizeByType[type] ?? 0;
          final percentage = totalSize > 0 ? (size / totalSize) * 100 : 0.0;

          return FileTypeStats(
            type: type,
            count: files.length,
            size: size,
            percentage: percentage,
            files: files,
          );
        })
        .where((stats) => stats.count > 0)
        .toList();
  }

  String get formattedTotalSize {
    const int kb = 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;

    if (totalSize >= gb) {
      return '${(totalSize / gb).toStringAsFixed(2)} GB';
    } else if (totalSize >= mb) {
      return '${(totalSize / mb).toStringAsFixed(2)} MB';
    } else if (totalSize >= kb) {
      return '${(totalSize / kb).toStringAsFixed(2)} KB';
    } else {
      return '$totalSize B';
    }
  }

  bool get isEmpty => totalFiles == 0;
}

class FileTypeStats {
  final FileType type;
  final int count;
  final int size;
  final double percentage;
  final List<FileInfo> files;

  const FileTypeStats({
    required this.type,
    required this.count,
    required this.size,
    required this.percentage,
    required this.files,
  });

  String get formattedSize {
    const int kb = 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;

    if (size >= gb) {
      return '${(size / gb).toStringAsFixed(2)} GB';
    } else if (size >= mb) {
      return '${(size / mb).toStringAsFixed(2)} MB';
    } else if (size >= kb) {
      return '${(size / kb).toStringAsFixed(2)} KB';
    } else {
      return '$size B';
    }
  }

  String get formattedPercentage => '${percentage.toStringAsFixed(1)}%';
}
