import 'package:get/get_utils/get_utils.dart';

extension StringExtension on String {
  String readableDuration() {
    String? str = this;
    String duration = '@second second'.trPluralParams(
      '@second seconds',
      0,
      {
        'second': 0.toString(),
      },
    );
    final durationList = str.split(':');
    if (durationList.length == 3) {
      final hour = int.parse(durationList[0]);
      final minute = int.parse(durationList[1]);
      final second = int.parse(durationList[2]);
      String sHour = '@hour hour'.trPluralParams(
        '@hour hours',
        hour,
        {
          'hour': hour.toString(),
        },
      );

      String sMinute = '@minute minute'.trPluralParams(
        '@minute minutes',
        minute,
        {
          'minute': minute.toString(),
        },
      );

      String sSecond = '@second second'.trPluralParams(
        '@second seconds',
        second,
        {
          'second': second.toString(),
        },
      );
      if (hour > 0) {
        duration = '$sHour $sMinute $sSecond';
      } else if (minute > 0) {
        duration = '$sMinute $sSecond';
      } else {
        duration = sSecond;
      }
    }
    return 'Duration @duration'.trParams({'duration': duration});
  }

  // /// Duration to string format: 00:00 (HH:MM)
  // String durationString() {
  //   String str = this;
  //    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
  //   final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
  //   return '$minutes:$seconds';
  // }
}
