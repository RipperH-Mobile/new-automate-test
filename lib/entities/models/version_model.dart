class VersionModel {
  final int major;
  final int minor;
  final int patch;

  VersionModel(this.major, this.minor, this.patch);

  factory VersionModel.fromString(String version) {
    final parts = version.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid version format. Expected format: major.minor.patch');
    }

    try {
      return VersionModel(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    } catch (e) {
      throw const FormatException('Invalid version number format');
    }
  }

  bool needsUpdate(VersionModel other) {
    return major < other.major ||
        (major == other.major && minor < other.minor) ||
        (major == other.major && minor == other.minor && patch < other.patch);
  }

  @override
  String toString() => '$major.$minor.$patch';
}
