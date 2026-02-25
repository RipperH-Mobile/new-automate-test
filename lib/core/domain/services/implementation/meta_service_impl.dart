import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

import '../meta_service.dart';

/// Constants for device types and operating systems
class _DeviceConstants {
  static const String android = 'ANDROID';
  static const String ios = 'IOS';
  static const String macos = 'MACOS';
  static const String windows = 'WINDOWS';
  static const String unknown = 'UNKNOWN';

  // Default fallback values
  static const String fallbackAppName = 'UChat Messenger';
  static const String fallbackAppVersion = '1.0.0';
  static const String fallbackAppBuildNumber = '1';
  static const String fallbackAppId = 'social.uchat';
}

class MetaServiceImpl implements MetaService {
  String _appName = _DeviceConstants.fallbackAppName;
  String _appNameUtf8 = '';
  String _appVersion = _DeviceConstants.fallbackAppVersion;
  String _appVersionUtf8 = '';
  String _appBuildNumber = _DeviceConstants.fallbackAppBuildNumber;
  String _appBuildNumberUtf8 = '';
  String _appId = _DeviceConstants.fallbackAppId;
  String _appIdUtf8 = '';
  String? _deviceName;
  String _deviceNameUtf8 = '';
  String? _deviceModel;
  String _deviceModelUtf8 = '';
  String _deviceOs = _DeviceConstants.unknown;
  String _deviceOsUtf8 = '';
  String? _deviceOsVersion;
  String _deviceOsVersionUtf8 = '';
  String _deviceType = _DeviceConstants.unknown;
  String _deviceTypeUtf8 = '';

  /// Encodes a string to Base64 UTF-8 format.
  /// Returns empty string if input is null or empty.
  String _encodeToBase64(String? value) {
    if (value == null || value.isEmpty) return '';
    return base64Encode(utf8.encode(value));
  }

  /// Sanitizes input string by replacing non-ASCII characters with underscores.
  String _sanitizeString(String input) {
    return input.replaceAll(RegExp('[^\u0001-\u007F]'), '_');
  }

  /// Sets fallback values when initialization fails.
  void _setFallbackValues() {
    _appName = _DeviceConstants.fallbackAppName;
    _appVersion = _DeviceConstants.fallbackAppVersion;
    _appBuildNumber = _DeviceConstants.fallbackAppBuildNumber;
    _appId = _DeviceConstants.fallbackAppId;
    _deviceName = _DeviceConstants.unknown;
    _deviceModel = _DeviceConstants.unknown;
    _deviceOs = _DeviceConstants.unknown;
    _deviceOsVersion = _DeviceConstants.unknown;
    _deviceType = _DeviceConstants.unknown;
  }

  /// Caches UTF-8 encoded versions of all metadata.
  void _cacheUtf8Values() {
    _appNameUtf8 = _encodeToBase64(_appName);
    _appVersionUtf8 = _encodeToBase64(_appVersion);
    _appBuildNumberUtf8 = _encodeToBase64(_appBuildNumber);
    _appIdUtf8 = _encodeToBase64(_appId);
    _deviceNameUtf8 = _encodeToBase64(_deviceName);
    _deviceModelUtf8 = _encodeToBase64(_deviceModel);
    _deviceOsUtf8 = _encodeToBase64(_deviceOs);
    _deviceOsVersionUtf8 = _encodeToBase64(_deviceOsVersion);
    _deviceTypeUtf8 = _encodeToBase64(_deviceType);
  }

  /// Logs initialization results for debugging purposes.
  void _logInitializationResult() {
    useLogger().d(
      'MetaService Initialized:\n'
      'App ID: $_appId\n'
      'Device Name: $_deviceName\n'
      'Device Name UTF8: $_deviceNameUtf8\n'
      'Device Model: $_deviceModel\n'
      'Device Model UTF8: $_deviceModelUtf8\n'
      'Device OS: $_deviceOs\n'
      'Device OS UTF8: $_deviceOsUtf8\n'
      'Device OS Version: $_deviceOsVersion\n'
      'Device OS Version UTF8: $_deviceOsVersionUtf8\n'
      'Device Type: $_deviceType\n'
      'Device Type UTF8: $_deviceTypeUtf8',
    );
  }

  @override
  Future<void> initialize() async {
    try {
      await _initializeDeviceInfo();
      _cacheUtf8Values();
      _logInitializationResult();
    } catch (e, stackTrace) {
      useLogger().e('Failed to initialize MetaService', e, stackTrace);
      _setFallbackValues();
      _cacheUtf8Values();
    }
  }

  /// Initializes device and application information.
  Future<void> _initializeDeviceInfo() async {
    final package = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();
    final deviceNames = DeviceMarketingNames();

    _appName = package.appName;
    _appVersion = package.version;
    _appBuildNumber = package.buildNumber;
    _appId = package.packageName;
    _deviceModel = await deviceNames.getSingleName();

    if (GetPlatform.isAndroid) {
      final android = await deviceInfo.androidInfo;

      _deviceName = android.name;
      _deviceModel ??= '${android.brand} (${android.model})';

      final baseOS = android.version.baseOS;
      if (baseOS == null || baseOS.isEmpty) {
        _deviceOs = '${_DeviceConstants.android} (SDK ${android.version.sdkInt})';
      } else {
        _deviceOs = '${_DeviceConstants.android} $baseOS (SDK ${android.version.sdkInt})';
      }

      _deviceOsVersion = android.version.release;
      _deviceType = _DeviceConstants.android;
    } else if (GetPlatform.isIOS) {
      final iosOs = await deviceInfo.iosInfo;
      final modelName = await DeviceMarketingNames().getSingleName();

      _deviceName = _sanitizeString(modelName);
      _deviceModel = iosOs.model;
      _deviceOs = iosOs.systemName;
      _deviceOsVersion = iosOs.systemVersion;
      _deviceType = _DeviceConstants.ios;
    } else if (GetPlatform.isMacOS) {
      final macOs = await deviceInfo.macOsInfo;

      _deviceName = _sanitizeString(macOs.computerName);
      _deviceModel = macOs.model;
      _deviceOs = '${macOs.osRelease} (macOS)';
      _deviceOsVersion = '${macOs.majorVersion}.${macOs.minorVersion}.${macOs.patchVersion} ${macOs.osRelease}';
      _deviceType = _DeviceConstants.macos;
    } else if (GetPlatform.isWindows) {
      final windowsOs = await deviceInfo.windowsInfo;

      _deviceName = windowsOs.computerName;
      _deviceModel ??= windowsOs.productName;
      _deviceOs = _DeviceConstants.windows;
      _deviceOsVersion =
          '${windowsOs.majorVersion}.${windowsOs.minorVersion}.${windowsOs.buildNumber} ${windowsOs.displayVersion}';
      _deviceType = _DeviceConstants.windows;
    }
  }

  @override
  String get appId {
    return _appId;
  }

  @override
  String get appIdUtf8 {
    return _appIdUtf8;
  }

  @override
  String get appName {
    return _appName;
  }

  @override
  String get appNameUtf8 {
    return _appNameUtf8;
  }

  @override
  String get appVersion {
    return _appVersion;
  }

  @override
  String get appVersionUtf8 {
    return _appVersionUtf8;
  }

  @override
  String get appBuildNumber {
    return _appBuildNumber;
  }

  @override
  String get appBuildNumberUtf8 {
    return _appBuildNumberUtf8;
  }

  @override
  String? get deviceName {
    return _deviceName;
  }

  @override
  String get deviceNameUtf8 {
    return _deviceNameUtf8;
  }

  @override
  String? get deviceModel {
    return _deviceModel;
  }

  @override
  String get deviceModelUtf8 {
    return _deviceModelUtf8;
  }

  @override
  String get deviceOs {
    return _deviceOs;
  }

  @override
  String get deviceOsUtf8 {
    return _deviceOsUtf8;
  }

  @override
  String? get deviceOsVersion {
    return _deviceOsVersion;
  }

  @override
  String get deviceOsVersionUtf8 {
    return _deviceOsVersionUtf8;
  }

  @override
  String get deviceType {
    return _deviceType;
  }

  @override
  String get deviceTypeUtf8 {
    return _deviceTypeUtf8;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'appId': appId,
      'browserName': appName,
      'browserVersion': appVersion,
      'browserMajor': appBuildNumber,
      'deviceName': deviceNameUtf8,
      'deviceModel': deviceModelUtf8,
      'deviceOs': deviceOs,
      'deviceOsVersion': deviceOsVersion,
      'deviceType': deviceType,
    };
  }
}
