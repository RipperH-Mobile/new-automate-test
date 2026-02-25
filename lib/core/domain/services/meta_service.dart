abstract class MetaService {
  Future<void> initialize();

  String get appId;

  String get appIdUtf8;

  String get appName;

  String get appNameUtf8;

  String get appVersion;

  String get appVersionUtf8;

  String get appBuildNumber;

  String get appBuildNumberUtf8;

  String? get deviceName;

  String get deviceNameUtf8;

  String? get deviceModel;

  String get deviceModelUtf8;

  String get deviceOs;

  String get deviceOsUtf8;

  String? get deviceOsVersion;

  String get deviceOsVersionUtf8;

  String get deviceType;

  String get deviceTypeUtf8;

  Map<String, dynamic> toMap();
}
