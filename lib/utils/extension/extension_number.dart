import 'dart:math';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension NumberExtension on num {
  /// Format number to string with pattern
  /// default pattern is `#,###`
  ///
  /// if you want to format number to currency format
  /// use pattern `#,###.##`
  ///
  /// if you want to format number to currency format with currency symbol
  /// use pattern `#,###.## \u{0E3F}`
  ///
  /// if you want to show fixed decimal point
  /// use pattern `#,###.00`
  String toNumberFormat({String pattern = '#,###'}) {
    return NumberFormat(pattern).format(this);
  }

  int get cacheSize {
    return (this * Get.pixelRatio).round();
  }

  String get toDurationStr {
    final duration = Duration(seconds: toInt());

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  int get sizeInKB {
    return (this / 1024).round();
  }

  int get sizeInMB {
    return (this / 1024 / 1024).round();
  }

  int get sizeInGB {
    return (this / 1024 / 1024 / 1024).round();
  }

  String get sizeInKBStr {
    if (this <= 0) return '0 B';
    const units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(this) / log(1024)).floor();
    final value = this / pow(1024, i);
    // Use 0 decimal places for Bytes (i == 0) or for integer values.
    final precision = (i == 0 || value == value.truncateToDouble()) ? 0 : 2;
    return '${value.toStringAsFixed(precision)} ${units[i]}';
  }

  String get sizeInMBStr {
    return '${sizeInMB.toNumberFormat()} MB';
  }

  String get sizeInGBStr {
    return '${sizeInGB.toNumberFormat()} GB';
  }
}
