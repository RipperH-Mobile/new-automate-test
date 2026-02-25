import 'package:intl/intl.dart';

/// Extension on DateFormat to support Buddhist calendar with Thai era abbreviation
extension BuddhistDateFormat on DateFormat {
  /// Convert AD year to BE year (add 543)
  static int toBuddhistYear(int year) => year + 543;

  /// Convert BE year to AD year (subtract 543)
  static int toGregorianYear(int year) => year - 543;

  /// Format date to Buddhist calendar string with Thai era abbreviation
  String formatBuddhist(DateTime date) {
    // Get the pattern from DateFormat instance
    String pattern = this.pattern ?? '';

    // Create a copy of the date to modify
    DateTime tempDate = DateTime(
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );

    // Handle different year patterns and add Buddhist era abbreviation
    if (pattern.contains('GGGGG')) {
      // Ultra short era - พ.ศ.
      pattern = pattern.replaceAll('GGGGG', 'พ.ศ.');
    } else if (pattern.contains('GGGG')) {
      // Long era - พุทธศักราช
      pattern = pattern.replaceAll('GGGG', 'พุทธศักราช');
    } else if (pattern.contains('GGG')) {
      // Abbreviated era - พ.ศ.
      pattern = pattern.replaceAll('GGG', 'พ.ศ.');
    } else if (pattern.contains('GG')) {
      // Short era - พ.ศ.
      pattern = pattern.replaceAll('GG', 'พ.ศ.');
    } else if (pattern.contains('G')) {
      // Ultra short era - พ.ศ.
      pattern = pattern.replaceAll('G', 'พ.ศ.');
    }

    // Replace year patterns with Buddhist year
    if (pattern.contains('yyyy')) {
      pattern = pattern.replaceAll('yyyy', toBuddhistYear(tempDate.year).toString().padLeft(4, '0'));
    } else if (pattern.contains('yyy')) {
      pattern = pattern.replaceAll('yyy', toBuddhistYear(tempDate.year).toString().padLeft(3, '0'));
    } else if (pattern.contains('yy')) {
      pattern = pattern.replaceAll('yy', (toBuddhistYear(tempDate.year) % 100).toString().padLeft(2, '0'));
    } else if (pattern.contains('y')) {
      pattern = pattern.replaceAll('y', toBuddhistYear(tempDate.year).toString());
    }

    // Create new DateFormat with modified pattern
    return DateFormat(pattern, 'th_TH').format(tempDate);
  }
}

extension TimeFormat on String {
  /// Converts localized AM/PM indicators to English format (AM/PM)
  /// Supports Thai, Japanese, Chinese, and Lao locale formats
  String to12HourFormat() {
    const amPmMap = {
      // Thai
      'ก่อนเที่ยง': 'AM',
      'หลังเที่ยง': 'PM',
      // Japanese
      '午前': 'AM',
      '午後': 'PM',
      // Chinese
      '上午': 'AM',
      '下午': 'PM',
      // Lao
      'ກ່ອນທ່ຽງ': 'AM',
      'ຫຼັງທ່ຽງ': 'PM',
    };

    final pattern = amPmMap.keys.map(RegExp.escape).join('|');
    return replaceAllMapped(RegExp(pattern), (match) => amPmMap[match.group(0)] ?? '');
  }
}
