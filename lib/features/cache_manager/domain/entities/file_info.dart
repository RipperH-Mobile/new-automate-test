import 'dart:io';

class FileInfo {
  final String path;
  final String name;
  final String extension;
  final int size; // in bytes
  final DateTime lastModified;
  final FileType type;

  const FileInfo({
    required this.path,
    required this.name,
    required this.extension,
    required this.size,
    required this.lastModified,
    required this.type,
  });

  factory FileInfo.fromFile(File file) {
    final stats = file.statSync();
    final path = file.path;
    final name = file.uri.pathSegments.last;

    // Improved extension detection
    String extension = '';
    if (name.contains('.')) {
      final parts = name.split('.');
      // Handle hidden files (starting with .) and files with multiple dots
      if (parts.length > 1 && !(name.startsWith('.') && parts.length == 2)) {
        extension = parts.last.toLowerCase().trim();
      } else if (name.startsWith('.') && parts.length > 2) {
        // Hidden files with extensions like .DS_Store, .gitignore
        extension = parts.last.toLowerCase().trim();
      }
    }

    return FileInfo(
      path: path,
      name: name,
      extension: extension,
      size: stats.size,
      lastModified: stats.modified,
      type: _determineFileType(extension, name, path),
    );
  }

  static FileType _determineFileType(String extension, String fileName, [String? filePath]) {
    // Normalize extension to lowercase
    final ext = extension.toLowerCase().trim();
    final lowerFileName = fileName.toLowerCase();
    final lowerFilePath = filePath?.toLowerCase() ?? '';

    // Check for specific cache image directories first
    if (lowerFilePath.contains('/cacheimage/') ||
        lowerFilePath.contains('\\cacheimage\\') ||
        lowerFilePath.endsWith('/cacheimage') ||
        lowerFilePath.endsWith('\\cacheimage') ||
        lowerFilePath.contains('/image_cache/') ||
        lowerFilePath.contains('\\image_cache\\') ||
        lowerFilePath.contains('/cached_images/') ||
        lowerFilePath.contains('\\cached_images\\') ||
        lowerFilePath.contains('/imageCache/') ||
        lowerFilePath.contains('\\imageCache\\') ||
        lowerFilePath.contains('/images/cache/') ||
        lowerFilePath.contains('\\images\\cache\\') ||
        lowerFilePath.contains('flutter_cached_network_images') ||
        lowerFilePath.contains('network_images') ||
        lowerFilePath.contains('photo_cache') ||
        lowerFilePath.contains('thumbnail_cache')) {
      return FileType.image;
    }

    // Handle special files by name first
    if (lowerFileName.startsWith('.ds_store') ||
        lowerFileName.contains('thumbs.db') ||
        lowerFileName.contains('.tmp') ||
        lowerFileName.contains('.cache') ||
        lowerFileName.contains('cached_') ||
        lowerFileName.contains('_cache') ||
        lowerFileName.contains('flutter_assets') ||
        lowerFileName.contains('image_picker') ||
        lowerFileName.contains('libcachedimagedata') ||
        lowerFileName.endsWith('.etag') ||
        lowerFileName.endsWith('.metadata') ||
        lowerFileName.contains('network_image')) {
      return FileType.misc;
    }

    // Check for image cache patterns (often without proper extensions)
    if (lowerFileName.contains('image') ||
        lowerFileName.contains('photo') ||
        lowerFileName.contains('picture') ||
        lowerFileName.contains('thumbnail') ||
        lowerFileName.contains('avatar') ||
        (ext.isEmpty && lowerFileName.length > 20 && lowerFileName.contains('_'))) {
      // Many cached images have long hash-like names
      return FileType.image;
    }

    // If no extension, check by file name patterns
    if (ext.isEmpty) {
      if (lowerFileName.contains('cache') ||
          lowerFileName.contains('temp') ||
          lowerFileName.contains('log') ||
          lowerFileName.startsWith('.') ||
          lowerFileName.contains('preferences') ||
          lowerFileName.contains('settings') ||
          lowerFileName.contains('config')) {
        return FileType.misc;
      }
      // Files without extension are likely misc
      return FileType.misc;
    }

    switch (ext) {
      // Images
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
      case 'svg':
      case 'ico':
      case 'tiff':
      case 'tif':
      case 'heic':
      case 'heif':
        return FileType.image;

      // Videos
      case 'mp4':
      case 'mov':
      case 'avi':
      case 'mkv':
      case 'wmv':
      case 'flv':
      case '3gp':
      case 'webm':
      case 'm4v':
      case 'ogv':
      case 'f4v':
        return FileType.video;

      // Audio
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
      case 'ogg':
      case 'm4a':
      case 'wma':
      case 'opus':
      case 'oga':
        return FileType.audio;

      // Documents
      case 'pdf':
      case 'doc':
      case 'docx':
      case 'txt':
      case 'rtf':
      case 'xls':
      case 'xlsx':
      case 'ppt':
      case 'pptx':
      case 'odt':
      case 'ods':
      case 'odp':
      case 'pages':
      case 'numbers':
      case 'keynote':
      case 'csv':
      case 'md':
      case 'html':
      case 'htm':
      case 'xml':
      case 'json':
      case 'yaml':
      case 'yml':
        return FileType.document;

      // Archives
      case 'zip':
      case 'rar':
      case '7z':
      case 'tar':
      case 'gz':
      case 'bz2':
      case 'xz':
      case 'dmg':
      case 'pkg':
      case 'deb':
      case 'rpm':
        return FileType.archive;

      // Common cache and system files - categorize as misc but they're identifiable
      case 'tmp':
      case 'temp':
      case 'cache':
      case 'log':
      case 'db':
      case 'sqlite':
      case 'sqlite3':
      case 'plist':
      case 'cfg':
      case 'config':
      case 'ini':
      case 'bak':
      case 'backup':
      case 'lock':
      case 'pid':
      case 'class':
      case 'jar':
      case 'war':
      case 'ear':
      case 'so':
      case 'dll':
      case 'dylib':
      case 'framework':
      case 'app':
      case 'exe':
      case 'bin':
        return FileType.misc;

      default:
        return FileType.misc;
    }
  }

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
}

enum FileType {
  image,
  video,
  audio,
  document,
  archive,
  misc,
}

extension FileTypeExtension on FileType {
  String get displayName {
    switch (this) {
      case FileType.image:
        return 'Images';
      case FileType.video:
        return 'Videos';
      case FileType.audio:
        return 'Audio';
      case FileType.document:
        return 'Documents';
      case FileType.archive:
        return 'Archives';
      case FileType.misc:
        return 'Others';
    }
  }

  String get iconPath {
    switch (this) {
      case FileType.image:
        return 'assets/vectors/image_icon.svg';
      case FileType.video:
        return 'assets/vectors/video_icon.svg';
      case FileType.audio:
        return 'assets/vectors/audio_icon.svg';
      case FileType.document:
        return 'assets/vectors/document_icon.svg';
      case FileType.archive:
        return 'assets/vectors/archive_icon.svg';
      case FileType.misc:
        return 'assets/vectors/file_icon.svg';
    }
  }
}
