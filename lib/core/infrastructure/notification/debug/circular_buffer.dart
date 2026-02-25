/// A fixed-size circular buffer that automatically overwrites the oldest elements
/// when the capacity is reached. This is useful for maintaining a rolling log of
/// debug information without consuming unbounded memory.
class CircularBuffer<T> {
  /// The maximum number of items the buffer can hold
  final int capacity;

  /// Internal storage for the items
  final List<T?> _buffer;

  /// Index of the next write position
  int _writeIndex = 0;

  /// Current number of items in the buffer
  int _size = 0;

  /// Creates a new circular buffer with the specified capacity
  CircularBuffer(this.capacity) : _buffer = List<T?>.filled(capacity, null);

  /// Adds an item to the buffer. If the buffer is full, the oldest item is overwritten.
  void add(T item) {
    _buffer[_writeIndex] = item;
    _writeIndex = (_writeIndex + 1) % capacity;

    if (_size < capacity) {
      _size++;
    }
  }

  /// Returns the item at the specified index, where 0 is the oldest item
  /// and [size - 1] is the newest item.
  /// Returns null if the index is out of bounds.
  T? operator [](int index) {
    if (index < 0 || index >= _size) {
      return null;
    }

    // Calculate the actual index in the buffer, ensuring it's always non-negative
    final readIndex = (_writeIndex - _size + index + capacity) % capacity;
    return _buffer[readIndex];
  }

  /// Returns the current number of items in the buffer
  int get size => _size;

  /// Returns true if the buffer is empty
  bool get isEmpty => _size == 0;

  /// Returns true if the buffer is full
  bool get isFull => _size == capacity;

  /// Clears all items from the buffer
  void clear() {
    for (int i = 0; i < capacity; i++) {
      _buffer[i] = null;
    }
    _writeIndex = 0;
    _size = 0;
  }

  /// Returns a list containing all items in the buffer, from oldest to newest
  List<T> toList() {
    final result = <T>[];
    for (int i = 0; i < _size; i++) {
      final item = this[i];
      if (item != null) {
        result.add(item);
      }
    }
    return result;
  }

  /// Returns the newest item in the buffer, or null if the buffer is empty
  T? get newest {
    if (_size == 0) return null;
    return this[_size - 1];
  }

  /// Returns the oldest item in the buffer, or null if the buffer is empty
  T? get oldest {
    if (_size == 0) return null;
    return this[0];
  }

  /// Returns the last [count] items in the buffer, from newest to oldest
  /// If [count] is greater than the buffer size, all items are returned
  List<T> getLast(int count) {
    if (count <= 0 || _size == 0) return [];

    final actualCount = count > _size ? _size : count;
    final result = <T>[];

    for (int i = 0; i < actualCount; i++) {
      final item = this[_size - 1 - i];
      if (item != null) {
        result.add(item);
      }
    }

    return result;
  }

  /// Returns the first [count] items in the buffer, from oldest to newest
  /// If [count] is greater than the buffer size, all items are returned
  List<T> getFirst(int count) {
    if (count <= 0 || _size == 0) return [];

    final actualCount = count > _size ? _size : count;
    final result = <T>[];

    for (int i = 0; i < actualCount; i++) {
      final item = this[i];
      if (item != null) {
        result.add(item);
      }
    }

    return result;
  }

  @override
  String toString() {
    return 'CircularBuffer<T>('
        'capacity: $capacity, '
        'size: $_size, '
        'items: ${toList()}'
        ')';
  }
}
