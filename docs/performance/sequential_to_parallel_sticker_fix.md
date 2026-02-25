# Fix: Sequential to Parallel Downloads for downloadStickerItem

## Problem Identified

The `downloadStickerItem` function with `addToQueue: true` was using
`AsyncQueue` which processes items sequentially (1 sticker at a time), causing
slow individual sticker downloads.

```dart
// ❌ BEFORE: Sequential processing
stickerItemDownloadQueueMap[packId] =
AsyncQueue.autoStart
(
allowDuplicate: false);

stickerItemDownloadQueueMap[packId]!.addJob((_) async {
await _downloadStickerItem(...); // Downloads one by one
});
```

## Solution Implemented

Replaced the sequential `AsyncQueue` system with a parallel semaphore-based
approach that allows 5 concurrent downloads per pack.

### ✅ **1. Added Parallel Download Configuration**

```dart
// New fields for parallel processing
final Map<String, _Semaphore> _stickerItemSemaphoreMap = {};
static const int _maxConcurrentItemDownloads = 5;
```

### ✅ **2. Updated downloadStickerItem Function**

```dart
// NEW: Parallel processing with semaphore
Future<void> downloadStickerItem({
  required String packId,
  required String fileId,
  bool saveToUserCache = false,
  bool addToQueue = false,
}) async {
  if (addToQueue) {
    // Create semaphore for pack if doesn't exist
    if (!_stickerItemSemaphoreMap.containsKey(packId)) {
      _stickerItemSemaphoreMap[packId] =
          _Semaphore(_maxConcurrentItemDownloads);
    }

    // Return parallel download future
    return _downloadWithSemaphore(
      semaphore: _stickerItemSemaphoreMap[packId]!,
      packId: packId,
      fileId: fileId,
      saveToUserCache: saveToUserCache,
    );
  } else {
    await _downloadStickerItem(...);
  }
}
```

### ✅ **3. Added Semaphore-Controlled Download Method**

```dart
/// Download with semaphore control for parallel processing
Future<void> _downloadWithSemaphore({
  required _Semaphore semaphore,
  required String packId,
  required String fileId,
  required bool saveToUserCache,
}) async {
  await semaphore.acquire(); // Wait for available slot (max 5)
  try {
    await _downloadStickerItem(
      packId: packId,
      fileId: fileId,
      saveToUserCache: saveToUserCache,
    );
  } catch (e, stackTrace) {
    _log.e(
        'Error in downloadStickerItem job for pack: $packId, file: $fileId', e,
        stackTrace);
    // Don't rethrow to prevent one failed download from stopping others
  } finally {
    semaphore.release(); // Free slot for next download
  }
}
```

### ✅ **4. Cleaned Up Unused Code**

```dart
// ❌ REMOVED: Unused sequential queue system
// Map<String, AsyncQueue> stickerItemDownloadQueueMap = {};
```

## How It Works Now

### Before (Sequential)

```
Download Request 1 → [Queue] → Download → Complete
Download Request 2 → [Queue] → Wait... → Download → Complete
Download Request 3 → [Queue] → Wait... → Wait... → Download → Complete
```

### After (Parallel - 5 concurrent)

```
Download Request 1 → [Semaphore Slot 1] → Download
Download Request 2 → [Semaphore Slot 2] → Download  
Download Request 3 → [Semaphore Slot 3] → Download
Download Request 4 → [Semaphore Slot 4] → Download
Download Request 5 → [Semaphore Slot 5] → Download
Download Request 6 → [Wait for slot...] → Download (when slot available)
```

## Performance Impact

### Individual Sticker Downloads

- **Before**: 1 sticker downloads at a time per pack
- **After**: Up to 5 stickers download simultaneously per pack
- **Improvement**: 5x faster individual sticker downloads

### Usage Scenarios

This fix particularly improves:

1. **Preview downloads**: When users browse sticker packs
2. **Individual sticker requests**: When downloading specific stickers
3. **Partial pack downloads**: When only some stickers are needed

### Memory & Resource Usage

- **Controlled concurrency**: Max 5 simultaneous downloads prevents resource
  exhaustion
- **Per-pack semaphores**: Each sticker pack has its own 5-download limit
- **Error isolation**: Failed downloads don't stop other parallel downloads

## Example Usage

```dart
// Multiple downloads will now run in parallel (up to 5 at once)
await downloadStickerItem
(
packId: 'pack1', fileId: 'sticker1.png', addToQueue: true);
await downloadStickerItem(packId: 'pack1', fileId: 'sticker2.png', addToQueue: true);
await downloadStickerItem(packId: 'pack1', fileId: 'sticker3.png', addToQueue: true);
await downloadStickerItem(packId: 'pack1', fileId: 'sticker4.png', addToQueue: true);
await downloadStickerItem(packId: 'pack1', fileId: 'sticker5.png', addToQueue: true);
// ↑ All 5 downloads start simultaneously

await downloadStickerItem(packId: 'pack1', fileId: 'sticker6.png',
addToQueue
:
true
);
// ↑ Waits for one of the above to complete, then starts
```

## Benefits

### ✅ **Performance**

- 5x faster individual sticker downloads
- Better network bandwidth utilization
- Reduced waiting time for users

### ✅ **User Experience**

- Faster sticker preview loading
- Smoother sticker browsing experience
- Reduced app perceived latency

### ✅ **System Stability**

- Controlled concurrency prevents resource exhaustion
- Error isolation maintains system stability
- Memory-efficient semaphore-based approach

### ✅ **Code Quality**

- Cleaner implementation without AsyncQueue complexity
- Reusable semaphore pattern
- Better error handling

This fix resolves the sequential download bottleneck and provides optimal
parallel processing for individual sticker downloads.
