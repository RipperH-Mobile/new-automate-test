import 'package:get/get.dart';
import 'package:intl/intl.dart';

DateTime? strToDateTime(String? forParse) {
  if (forParse != null) {
    return DateTime.parse(forParse);
  }
  return null;
}

//String time = formatTime(3700); // 01:01:11
String formatTime(int seconds) {
  return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
}

// Format duration into time result example: 01:23:45
String getFormattedTime(Duration duration, {bool? isVideo}) {
  String returnValue = '';
  String oneDigits(int n) => n.toString().padLeft(1, '0');
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  if (duration.inHours > 0) {
    returnValue = '${twoDigits(duration.inHours)}:';
  }
  String twoDigitMinutes =
      (isVideo ?? false) ? oneDigits(duration.inMinutes.remainder(60)) : twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  returnValue += '$twoDigitMinutes:$twoDigitSeconds';
  return returnValue;
}

/// Return String with abbreviate month and year from [dateTime]
String getMonthAbbrAndYear(DateTime dateTime) {
  return "${DateFormat('MMM').format(dateTime).tr} ${DateFormat('y').format(dateTime)}";
}

extension DurationExtension on Duration {
  String _oneDigits(int n) => n.toString().padLeft(1, '0');
  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  /// Format duration into time result example: 01:23:45
  /// If the duration is more than [1 hour], the result will be [01:23:45]
  /// If the duration is less than [1 hour], the result will be [23:45]
  /// If the duration is less than [1 minute], the result will be [0:45]
  String get formattedVideoTime {
    String returnValue = '';
    if (inHours > 0) {
      returnValue = '${_twoDigits(inHours)}:';
    }
    String twoDigitMinutes = _oneDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _twoDigits(inSeconds.remainder(60));
    returnValue += '$twoDigitMinutes:$twoDigitSeconds';
    return returnValue;
  }

  /// Return String with a time unit
  /// Currently support up to days.
  /// Example 1 : Duration(seconds: 30) -> '30 seconds'
  /// Example 2 : Duration(minutes: 1) -> '1 minute'
  /// Example 3 : Duration(minutes: 5) -> '5 minute'
  /// Example 4 : Duration(hours: 1) -> '1 hour'
  /// Example 5 : Duration(days: 1) -> '1 day'
  String get durationTextWithUnit {
    if (inSeconds < 60) {
      return '@seconds sec'.trPluralParams(
        '@seconds secs',
        inSeconds,
        {
          'seconds': inSeconds.toString(),
        },
      );
    } else if (inSeconds >= 60 && inSeconds < 3600) {
      return '@seconds min'.trPluralParams(
        '@seconds mins',
        inSeconds ~/ 60,
        {
          'seconds': (inSeconds ~/ 60).toString(),
        },
      );
    } else if (inSeconds >= 3600 && inSeconds < 86400) {
      return '@seconds hour'.trPluralParams(
        '@seconds hours',
        inSeconds ~/ 3600,
        {
          'seconds': (inSeconds ~/ 3600).toString(),
        },
      );
    } else if (inSeconds >= 86400 && inSeconds < 604800) {
      return '@seconds day'.trPluralParams(
        '@seconds days',
        inSeconds ~/ 86400,
        {
          'seconds': (inSeconds ~/ 86400).toString(),
        },
      );
    } else if (inSeconds >= 604800) {
      return '@seconds week'.trPluralParams(
        '@seconds weeks',
        inSeconds ~/ 604800,
        {
          'seconds': (inSeconds ~/ 604800).toString(),
        },
      );
    } else {
      return inSeconds.toString();
    }
  }
}
