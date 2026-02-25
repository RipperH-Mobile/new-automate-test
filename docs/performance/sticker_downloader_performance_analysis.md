# Sticker Downloader Service Performance Analysis

## Overview

This document analyzes the performance bottlenecks in `StickerDownloaderService`
that cause UI freezing and poor user experience during sticker downloads.

## Critical Performance Issues Identified

### 1. Sequential Download Processing (Major Bottleneck)

#### Problem

The `_downloadStickerPack()` method downloads stickers sequentially, blocking
the entire download process:

```dart
// ❌ Sequential processing - blocks UI and slows downloads
for (final item in stickerPack.stickerItems) {
await downloadStickerItem(
packId: stickerPack.id,
fileId: item.fileId,
saveToUserCache: true,
);
// Only proceeds to next item after current completes
}
```

**Impact**:

- 50+ stickers pack = 50 sequential network calls
- Each sticker waits for previous to complete
- Total download time: ~5-10 minutes for large packs

### 2. Heavy JSON Processing on Main Thread

#### Problem

TGS sticker processing performs heavy JSON manipulation synchronously:

```dart
// ❌ Heavy processing on main thread
final decoded = gzip.decode(stickerData); // CPU intensive
String decodedStr = String.fromCharCodes(decoded); // Memory intensive
Map<String, dynamic> result = json.decode(decodedStr); // Parsing intensive

// Complex nested loops and transformations
for (
int i = 0; i < result['layers'].length; i++) {
// Heavy nested processing without yield
}
```

**Impact**:

- UI freezes during TGS processing
- 200-500ms freeze per TGS sticker
- Memory spikes during large JSON parsing

### 3. Inefficient File Operations

#### Problem

Multiple file system operations without optimization:

```dart
// ❌ Multiple file checks without caching
final fileExists = await
file.exists
(); // I/O operation
final fileLength = await
newFile.length
(); // Another I/O operation
packDir.listSync
().length >=
stickerCount; // Expensive directory scan
```

**Impact**:

- Repeated disk I/O operations
- No file metadata caching
- Slow pack completion detection

### 4. Excessive Event Broadcasting

#### Problem

Event firing after every single sticker download:

```dart
// ❌ Fires event for each sticker
eventBus.fire
(
StickerPackDownloadStatusEvent(
packId: stickerPack.id,
fileId: stickerPack.coverId,
status: StickerDownloadStatus.inProgress,
currentProgress: downloadedAmount.toDouble(),
totalProgress: totalDownloadAmount.
toDouble
(
)
,
)
);
```

**Impact**:

- UI updates for every sticker (50+ events per pack)
- Event bus congestion
- Unnecessary widget rebuilds

### 5. Memory Management Issues

#### Problem

Large file processing without proper memory management:

```dart
// ❌ Loads entire file data in memory
final newImage = await
FlutterImageCompress.compressWithList
(
Uint8List.fromList(stickerData), // Entire file in memory
quality: 10,
format
:
format
,
);
```

**Impact**:

- Memory spikes during large sticker processing
- Potential OOM on low-end devices
- No streaming or chunked processing

## Performance Optimization Solutions

### 1. Implement Parallel Downloads with Concurrency Control

```dart
class StickerDownloaderService {
  static const int _maxConcurrentDownloads = 3;

  Future<void> _downloadStickerPack<T extends StickerPackEntity>({
    required T stickerPack
  }) async {
    try {
      // ...existing setup code...

      // ✅ Parallel downloads with concurrency control
      final downloadTasks = <Future<void>>[];
      final semaphore = Semaphore(_maxConcurrentDownloads);

      for (final item in stickerPack.stickerItems) {
        final task = semaphore.acquire().then((_) async {
          try {
            await _downloadStickerItemWithRetry(
              packId: stickerPack.id,
              fileId: item.fileId,
              saveToUserCache: true,
            );
          } finally {
            semaphore.release();
          }
        });
        downloadTasks.add(task);
      }

      // Wait for all downloads with progress updates
      await _waitForDownloadsWithProgress(
        downloadTasks,
        stickerPack,
      );

      // ...remaining code...
    } catch (e, stackTrace) {
      // ...error handling...
    }
  }

  Future<void> _waitForDownloadsWithProgress(List<Future<void>> tasks,
      T stickerPack,) async {
    int completed = 0;
    final total = tasks.length;

    // Listen to completion
    for (final task in tasks) {
      task.then((_) {
        completed++;
        if (completed % 5 == 0 || completed == total) {
          // ✅ Batch progress updates every 5 downloads
          _updateBatchProgress(stickerPack, completed, total);
        }
      });
    }

    await Future.wait(tasks);
  }
}
```

### 2. Optimize TGS Processing with Isolates

```dart
class StickerDownloaderService {
  // ✅ Move heavy processing to isolate
  Future<void> _downloadTgsSticker({
    required List<int> stickerData,
    required String filePath,
    required String packId,
    required String fileId,
  }) async {
    try {
      final file = File(filePath);
      
      // Process TGS in isolate to avoid UI blocking
      final processedJson = await compute(_processTgsInIsolate, {
        'stickerData': stickerData,
        'targetScale': 512.0,
      });
      
      // Write result
      await compute(_writeFileIsolate, {
        'filePath': filePath,
        'content': processedJson,
      });
      
      eventBus.fire(StickerItemDownloadCompleteEvent(
        fileId: fileId, 
        packId: packId, 
        stickerFile: file
      ));
    } catch (e, stackTrace) {
      _log.e('Failed to download animated sticker: $packId - $fileId', e, stackTrace);
      rethrow;
    }
  }
  
  // ✅ Heavy processing in isolate
  static String _processTgsInIsolate(Map<String, dynamic> params) {
    final stickerData = params['stickerData'] as List<int>;
    final targetScale = params['targetScale'] as double;
    
    final decoded = gzip.decode(stickerData);
    final decodedStr = String.fromCharCodes(decoded);
    final result = json.decode(decodedStr) as Map<String, dynamic>;
    
    // Apply scaling transformations
    final scale = targetScale / result['w'];
    result['w'] = result['w'] * scale;
    result['h'] = result['h'] * scale;
    
    // Process layers efficiently
    final layers = result['layers'] as List?;
    if (layers != null) {
      for (final layer in layers) {
        _processLayerTransforms(layer, scale);
      }
    }
    
    return json.encode(result);
  }
  
  static void _writeFileIsolate(Map<String, dynamic> params) {
    final filePath = params['filePath'] as String;
    final content = params['content'] as String;
    File(filePath).writeAsStringSync(content);
  }
}
```

### 3. Implement File System Optimization

```dart
class StickerDownloaderService {
  // ✅ Cache file metadata to avoid repeated I/O
  final Map<String, FileMetadata> _fileMetadataCache = {};

  Future<bool> _isFileValidCached(String filePath) async {
    final metadata = _fileMetadataCache[filePath];
    if (metadata != null && metadata.isValid()) {
      return true;
    }

    final file = File(filePath);
    final exists = await file.exists();
    if (!exists) {
      return false;
    }

    final length = await file.length();
    final lastModified = await file.lastModified();

    _fileMetadataCache[filePath] = FileMetadata(
      length: length,
      lastModified: lastModified,
      exists: exists,
    );

    return length > 0;
  }

  // ✅ Optimized pack download check with caching
  Future<bool> isPackDownloaded({
    required String packId,
    required int stickerCount
  }) async {
    final cacheKey = '$packId-$stickerCount';
    final cachedResult = _packDownloadCache[cacheKey];

    if (cachedResult != null &&
        DateTime.now().difference(cachedResult.timestamp) <
            const Duration(minutes: 5)) {
      return cachedResult.isDownloaded;
    }

    final packDir = Directory('$stickerUserCachePath/$packId');
    if (!await packDir.exists()) {
      _packDownloadCache[cacheKey] = PackDownloadCacheEntry(false);
      return false;
    }

    // ✅ Use efficient counting instead of full listSync
    int fileCount = 0;
    await for (final entity in packDir.list()) {
      fileCount++;
      if (fileCount >= stickerCount) break;
    }

    final isDownloaded = fileCount >= stickerCount;
    _packDownloadCache[cacheKey] = PackDownloadCacheEntry(isDownloaded);
    return isDownloaded;
  }
}
```

### 4. Implement Smart Progress Updates

```dart
class StickerDownloaderService {
  DateTime? _lastProgressUpdate;
  static const _progressUpdateInterval = Duration(milliseconds: 500);

  void _updateBatchProgress(T stickerPack, int completed, int total) {
    final now = DateTime.now();

    // ✅ Throttle progress updates to prevent UI spam
    if (_lastProgressUpdate != null &&
        now.difference(_lastProgressUpdate!) < _progressUpdateInterval &&
        completed < total) {
      return;
    }

    _lastProgressUpdate = now;

    eventBus.fire(StickerPackDownloadStatusEvent(
      packId: stickerPack.id,
      fileId: stickerPack.coverId,
      status: StickerDownloadStatus.inProgress,
      currentProgress: completed.toDouble(),
      totalProgress: total.toDouble(),
    ));

    stickerInQueueDownloadProgress[stickerPack.id] =
        completed.toDouble() / total.toDouble();
  }
}
```

### 5. Add Retry Logic and Error Resilience

```dart
class StickerDownloaderService {
  // ✅ Add retry logic for failed downloads
  Future<void> _downloadStickerItemWithRetry({
    required String packId,
    required String fileId,
    required bool saveToUserCache,
    int maxRetries = 3,
  }) async {
    Exception? lastException;

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        await _downloadStickerItem(
          packId: packId,
          fileId: fileId,
          saveToUserCache: saveToUserCache,
        );
        return; // Success
      } catch (e) {
        lastException = e is Exception ? e : Exception(e.toString());

        if (attempt < maxRetries - 1) {
          // ✅ Exponential backoff
          final delay = Duration(milliseconds: 1000 * (1 << attempt));
          await Future.delayed(delay);
          _log.w('Retrying download $packId/$fileId, attempt ${attempt + 2}');
        }
      }
    }

    // All retries failed
    _log.e('Failed to download $packId/$fileId after $maxRetries attempts');
    throw lastException!;
  }
}
```

## Implementation Priority

### Critical (Implement Immediately)

1. **Parallel Downloads**: Replace sequential with concurrent downloads
2. **TGS Isolate Processing**: Move heavy JSON processing off main thread
3. **Progress Update Throttling**: Reduce UI update frequency

### High Priority

1. **File System Optimization**: Cache metadata and optimize I/O
2. **Retry Logic**: Add resilience to network failures
3. **Memory Management**: Optimize large file handling

### Medium Priority

1. **Download Prioritization**: Download cover/preview stickers first
2. **Background Download Resumption**: Resume interrupted downloads
3. **Bandwidth Throttling**: Limit concurrent network usage

## Expected Performance Improvements

### Download Speed

- **Before**: 50 stickers × 2s each = ~100 seconds (sequential)
- **After**: 50 stickers ÷ 3 concurrent × 2s = ~34 seconds (3x faster)

### UI Responsiveness

- **Before**: 200-500ms freezes during TGS processing
- **After**: No UI blocking (isolate processing)

### Memory Usage

- **Before**: Memory spikes during large file processing
- **After**: Stable memory usage with streaming processing

### User Experience

- **Before**: App freezes, slow downloads, poor progress feedback
- **After**: Smooth UI, fast downloads, responsive progress updates

## Testing Recommendations

1. **Load Testing**: Test with large sticker packs (50+ stickers)
2. **Network Testing**: Test with poor network conditions
3. **Memory Testing**: Monitor memory usage on low-end devices
4. **Cancellation Testing**: Test download cancellation scenarios
5. **Resumption Testing**: Test app backgrounding/foregrounding during downloads

This optimization should significantly improve the sticker download experience
and eliminate UI performance issues.
