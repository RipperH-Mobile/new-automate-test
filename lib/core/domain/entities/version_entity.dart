class VersionEntity {
  final int major;
  final int minor;
  final int patch;

  VersionEntity({required this.major, required this.minor, required this.patch});

  factory VersionEntity.fromString(String version) {
    final parts = version.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid version format. Expected format: major.minor.patch');
    }

    try {
      final major = int.parse(parts[0]);
      final minor = int.parse(parts[1]);
      final patch = int.parse(parts[2]);
      
      if (major < 0 || minor < 0 || patch < 0) {
        throw const FormatException('Version numbers cannot be negative');
      }
      
      return VersionEntity(
        major: major,
        minor: minor,
        patch: patch,
      );
    } catch (e) {
      if (e is FormatException) {
        rethrow;
      }
      throw const FormatException('Invalid version number format');
    }
  }

  bool needsUpdate(VersionEntity other) {
    return major < other.major ||
        (major == other.major && minor < other.minor) ||
        (major == other.major && minor == other.minor && patch < other.patch);
  }

  @override
  String toString() => '$major.$minor.$patch';
}
