import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';

class WordSplitting {
  static Future<List<String>> split(
    String text, {
    Locale? locale,
  }) async {
    locale ??= Locale(Get.locale?.languageCode ?? 'en');

    if (GetPlatform.isAndroid) {
      final words = await GetIt.I<NativeMethodChannelService>().invokeMethod('androidWordSegmentation', {
        'text': text,
        'locale': locale,
      });
      return words;
    } else if (GetPlatform.isIOS) {
      final words = await GetIt.I<NativeMethodChannelService>().invokeMethod('iOSWordSegmentation', {
        'text': text,
        'language': locale.languageCode,
      });
      return words;
    }
    // Split the text into words using whitespace as a delimiter
    return text.split(RegExp(r'\s+'));
  }
}
