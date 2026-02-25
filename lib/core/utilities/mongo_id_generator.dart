import 'dart:math';
import 'dart:typed_data';

/// A utility class to generate MongoDB ObjectId
/// MongoDB ObjectId is a 12-byte value consisting of:
/// - 4-byte timestamp (seconds since the Unix epoch)
/// - 3-byte machine identifier
/// - 2-byte process id
/// - 3-byte counter (starting with a random value)
class MongoIdGenerator {
  // Static instance for singleton pattern
  static final MongoIdGenerator _instance = MongoIdGenerator._internal();

  // Internal random number generator
  final Random _random = Random();

  // Counter that gets incremented for each ID
  int _counter = 0;

  // Machine identifier (random 3 bytes)
  late final List<int> _machineId;

  // Process identifier (random 2 bytes)
  late final int _processId;

  // Private constructor
  MongoIdGenerator._internal() {
    // Generate random machine identifier (3 bytes)
    _machineId = List.generate(3, (_) => _random.nextInt(256));

    // Generate random process identifier (2 bytes)
    _processId = _random.nextInt(65536); // 2^16

    // Initialize counter with random value
    _counter = _random.nextInt(16777216); // 2^24
  }

  // Factory constructor to return the singleton instance
  factory MongoIdGenerator() {
    return _instance;
  }

  /// Generates a new MongoDB ObjectId
  /// Returns a String representation of the ObjectId in hexadecimal
  String generate() {
    // Get current timestamp (seconds since Unix epoch)
    final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000);

    // Create a buffer for the 12 bytes
    final buffer = ByteData(12);

    // Write timestamp (4 bytes, big-endian)
    buffer.setUint32(0, timestamp, Endian.big);

    // Write machine identifier (3 bytes)
    buffer.setUint8(4, _machineId[0]);
    buffer.setUint8(5, _machineId[1]);
    buffer.setUint8(6, _machineId[2]);

    // Write process identifier (2 bytes, big-endian)
    buffer.setUint16(7, _processId, Endian.big);

    // Increment and write counter (3 bytes, big-endian)
    _counter = (_counter + 1) % 16777216;
    buffer.setUint8(9, (_counter >> 16) & 0xFF);
    buffer.setUint8(10, (_counter >> 8) & 0xFF);
    buffer.setUint8(11, _counter & 0xFF);

    // Convert to hexadecimal string
    final bytes = Uint8List.view(buffer.buffer);
    return _bytesToHex(bytes);
  }

  /// Converts a Uint8List to a hexadecimal string
  String _bytesToHex(Uint8List bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Checks if a string is a valid MongoDB ObjectId
  /// A valid ObjectId is a 24-character hexadecimal string
  static bool isValid(String id) {
    if (id.length != 24) return false;

    // Check if all characters are valid hexadecimal digits
    for (int i = 0; i < id.length; i++) {
      final c = id.codeUnitAt(i);
      final isDigit = c >= 48 && c <= 57;        // 0-9
      final isLowerHex = c >= 97 && c <= 102;    // a-f
      final isUpperHex = c >= 65 && c <= 70;     // A-F

      if (!(isDigit || isLowerHex || isUpperHex)) {
        return false;
      }
    }

    return true;
  }

  /// Gets the timestamp part from an ObjectId string
  /// Returns a DateTime object
  static DateTime getTimestamp(String id) {
    if (!isValid(id)) {
      throw FormatException('Invalid ObjectId: $id');
    }

    // Extract the timestamp part (first 8 characters, 4 bytes)
    final timestampHex = id.substring(0, 8);
    final timestamp = int.parse(timestampHex, radix: 16);

    // Convert to DateTime
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}