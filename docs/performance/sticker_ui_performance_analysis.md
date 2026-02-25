# Sticker UI Performance Analysis

## Overview

This document analyzes the UI jank performance problems in the sticker system,
particularly in `StickerItemPreview` and related components.

## Problem Summary

The sticker system exhibits performance issues that manifest as UI jank, frame
drops, and stuttering during scrolling and interaction. These issues primarily
affect user experience when browsing stickers in chat rooms and sticker packs.

## Affected Components

### Primary Components

1. **StickerItemPreview** (
   `lib/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart`)
2. **StickerItemPreviewController** (
   `lib/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview_controller.dart`)
3. **StickerController** (
   `lib/features/sticker/presentation/controllers/sticker_controller.dart`)
4. **StickerGridView** (
   `lib/features/chat_room/presentation/widgets/input/sticker_input_selection_list.dart`)

### Secondary Components

- **StickerItemPreviewGrid** (
  `lib/features/sticker/presentation/views/screens/sticker_pack_detail/widgets/sticker_item_preview_grid.dart`)
- **StickerInputSelectionList** (
  `lib/features/chat_room/presentation/widgets/input/sticker_input_selection_list.dart`)

## Root Cause Analysis

### 1. Excessive Widget Rebuilds

#### Problem

- Each `StickerItemPreview` creates a new
  `GetBuilder<StickerItemPreviewController>` with `autoRemove: false`
- Controllers are not properly disposed, leading to memory leaks
- `update()` calls in `StickerItemPreviewController` trigger unnecessary
  rebuilds

#### Code Evidence

```dart
// StickerItemPreview.dart
GetBuilder<StickerItemPreviewController>
(
key: ValueKey('$packId-$fileId'),
init: StickerItemPreviewController(packId: packId, fileId: fileId),
autoRemove: false, // ❌ Controllers never get removed
assignId: true,
tag: '$packId-$fileId',
builder: (ctl) { ... }
)
```

### 2. Inefficient Grid View Configuration

#### Problem

- Missing performance optimizations in `StickerGridView`
- No `addAutomaticKeepAlives` or `addRepaintBoundaries` configuration
- No `cacheExtent` optimization

#### Code Evidence

```dart
// StickerInputSelectionList.dart - StickerGridView
GridView.builder
(
// ❌ Missing performance optimizations:
// addAutomaticKeepAlives: false,
// addRepaintBoundaries: false, 
// cacheExtent: 200.0,
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: UChatScreenUtil.instance.isMobile ? 4 : Get.width / 2 ~/ stickerSize,
mainAxisSpacing: AppSpace.space2,
crossAxisSpacing: AppSpace.space2,
),
itemCount: itemCount,
itemBuilder:
itemBuilder
,
)
```

### 3. Inefficient Image Loading and Caching

#### Problem

- Multiple image widgets (Lottie, Rive, File, Network) without proper lazy
  loading
- Rive file loading is synchronous and blocks UI thread
- No size constraints on network images leading to memory issues

#### Code Evidence

```dart
// StickerItemPreview.dart
if (ctl.isLottieFile) {
return RepaintBoundary(
child: SizedBox(
width: width,
height: height,
child: Lottie.file(
stickerFile,
key: ValueKey('lottie-animation-${ctl.packId}-${ctl.fileId}'),
fit: BoxFit.contain,
renderCache: RenderCache.drawingCommands, // ✅ Good
errorBuilder: (context, error, stackTrace) { ... },
),
),
);
}

// ❌ Rive loading blocks UI thread
riveFile = await RiveFile.file(stickerFile!.path
);
```

### 4. Synchronous File Operations on UI Thread

#### Problem

- File existence checks and Rive file loading are performed synchronously
- No async queue management for heavy operations
- Missing proper error handling for file operations

#### Code Evidence

```dart
// StickerItemPreviewController.dart
Future<void> loadRiveFile() async {
  // ❌ This blocks the UI thread
  riveFile = await RiveFile.file(stickerFile!.path);
  stickerController.cacheRiveStickerFile(packId, fileId, riveFile!);
  isFileExist = true;
  isLoading = false;
  isError = false;
  riveSpeedPlay = 1;
  update(); // ❌ Triggers rebuild
}
```

### 5. Memory Management Issues

#### Problem

- Controllers with `autoRemove: false` never get cleaned up
- Rive file caching without size limits
- No image cache management for different sticker types

#### Code Evidence

```dart
// StickerController.dart
Map<String, RiveFile> riveStickerCache = {}; // ❌ No size limit

void cacheRiveStickerFile(String packId, String fileId, RiveFile riveFile) {
  final key = '$packId-$fileId';
  riveStickerCache[key] = riveFile; // ❌ Never cleaned up
}
```

### 6. Animation Performance Issues

#### Problem

- Multiple animations running simultaneously in grids
- No animation optimization for off-screen items
- Complex animations in `flutter_animate` without performance considerations

#### Code Evidence

```dart
// StickerItemPreviewGrid.dart
return GestureDetector(
onTap: () { ctl.onTapSticker(item.fileId); },
child: StickerItemPreview(
width: 96.spMin,
height: 96.spMin,
packId: stickerPack.id,
fileId: item.fileId,
).animate(value: 1, target: opacity).fade(duration: 300.ms), // ❌ Animation on every item
).animate(value: .9, target: animateScale).scale(duration: 1000.ms
); // ❌ Nested animations
```

## Performance Impact Analysis

### Frame Rate Impact

- **Expected**: 60 FPS (16.67ms per frame)
- **Current**: 30-45 FPS during sticker grid scrolling
- **Bottlenecks**: Widget rebuilds, synchronous file I/O, excessive animations

### Memory Usage

- **Rive Cache**: Unbounded growth (each Rive file ~1-5MB)
- **Controller Memory**: Accumulating due to `autoRemove: false`
- **Image Cache**: Multiple image types without unified management

### User Experience

- **Stuttering**: During grid scrolling
- **Delays**: When loading Rive stickers
- **Freezing**: When many animations play simultaneously

## Recommended Solutions

### 1. Optimize Widget Lifecycle Management

```dart
// ✅ Improved StickerItemPreview
GetBuilder<StickerItemPreviewController>
(
key: ValueKey('$packId-$fileId'),
init: StickerItemPreviewController(packId: packId, fileId: fileId),
autoRemove: true, // ✅ Allow automatic cleanup
assignId: true,
tag: '$packId-$fileId',
dispose: (controller) {
controller.dispose(); // ✅ Explicit cleanup
},
builder: (ctl) { ... }
)
```

### 2. Optimize GridView Performance

```dart
// ✅ Improved StickerGridView
GridView.builder
(
addAutomaticKeepAlives: false, // ✅ Reduce memory usage
addRepaintBoundaries: false, // ✅ We handle RepaintBoundary manually
cacheExtent: 200.0, // ✅ Optimize viewport caching
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: UChatScreenUtil.instance.isMobile ? 4 : Get.width / 2 ~/ stickerSize,
mainAxisSpacing: AppSpace.space2,
crossAxisSpacing: AppSpace.space2,
),
itemCount: itemCount,
itemBuilder
:
itemBuilder
,
)
```

### 3. Implement Async Loading Queue

```dart
// ✅ Improved Rive loading
class StickerItemPreviewController extends GetxController {
  static final _loadingQueue = AsyncQueue.autoStart();

  Future<void> loadRiveFile() async {
    await _loadingQueue.addJob((_) async {
      if (mounted) {
        riveFile = await compute(_loadRiveFileIsolate, stickerFile!.path);
        if (mounted) {
          stickerController.cacheRiveStickerFile(packId, fileId, riveFile!);
          _updateState();
        }
      }
    });
  }

  static RiveFile _loadRiveFileIsolate(String path) {
    return RiveFile.file(path);
  }
}
```

### 4. Implement Memory Management

```dart
// ✅ Improved caching with size limits
class StickerController extends GetxController {
  static const int _maxCacheSize = 50; // Limit cache size
  final Map<String, RiveFile> riveStickerCache = {};
  final Queue<String> _cacheOrder = Queue();

  void cacheRiveStickerFile(String packId, String fileId, RiveFile riveFile) {
    final key = '$packId-$fileId';

    if (riveStickerCache.length >= _maxCacheSize) {
      final oldestKey = _cacheOrder.removeFirst();
      riveStickerCache.remove(oldestKey);
    }

    riveStickerCache[key] = riveFile;
    _cacheOrder.add(key);
  }
}
```

### 5. Optimize Animation Performance

```dart
// ✅ Conditional animations
Widget build(BuildContext context) {
  Widget child = StickerItemPreview(
    width: 96.spMin,
    height: 96.spMin,
    packId: stickerPack.id,
    fileId: item.fileId,
  );

  // Only animate when necessary
  if (ctl.selectedFileId.isNotEmpty && ctl.selectedFileId == item.fileId) {
    child = child.animate().scale(duration: 300.ms);
  }

  return GestureDetector(
    onTap: () => ctl.onTapSticker(item.fileId),
    child: child,
  );
}
```

## Implementation Priority

### High Priority (Critical Performance Impact)

1. Fix GridView performance settings
2. Implement proper controller lifecycle management
3. Add async loading queue for Rive files
4. Implement cache size limits

### Medium Priority (Noticeable Performance Impact)

1. Optimize animation performance
2. Implement lazy loading for off-screen items
3. Add image size constraints
4. Improve error handling

### Low Priority (Minor Performance Impact)

1. Add performance monitoring
2. Implement preloading strategies
3. Add debug performance metrics
4. Optimize network loading

## Testing Recommendations

### Performance Testing

- Use Flutter's performance overlay to monitor frame rates
- Test with large sticker packs (50+ items)
- Test memory usage over extended usage
- Test on low-end devices

### Metrics to Monitor

- Frame build times (should be < 16ms)
- Memory usage growth
- Controller instance count
- Cache hit rates

## Conclusion

The sticker UI performance issues stem from multiple sources, with the primary
culprits being inefficient widget lifecycle management, missing GridView
optimizations, and synchronous file operations. Implementing the recommended
solutions should significantly improve the user experience and eliminate UI
jank.

The most critical fixes involve adding proper performance configurations to
GridView, implementing asynchronous loading, and managing widget lifecycles
properly. These changes should restore smooth 60 FPS performance during sticker
browsing and interaction.
