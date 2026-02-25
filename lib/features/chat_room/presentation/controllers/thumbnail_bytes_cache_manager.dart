import 'dart:collection';
import 'dart:typed_data';

class ThumbnailBytesCacheManager {
  final _cache = LinkedHashMap<String, Uint8List?>(
    equals: (a, b) => a == b,
    hashCode: (key) => key.hashCode,
  );

  final int _maxSize = 20; // Keep only 20 images in cache

  bool contains(String refFile) => _cache.containsKey(refFile);

  Uint8List? getThumbnail(String refFile) => _cache[refFile];

  void saveThumbnail(String refFile, Uint8List? imageData) {
    if (_cache.length >= _maxSize) {
      _cache.remove(_cache.keys.first); // Remove the oldest item
    }
    _cache[refFile] = imageData;
  }

  void clear() {
    _cache.clear();
  }

  remove(String refFile) {
    _cache.remove(refFile);
  }
}
