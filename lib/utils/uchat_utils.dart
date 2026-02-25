import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/utils/vibrate.dart';

class UChatUtils {
  static final UChatUtils instance = UChatUtils._internal();

  factory UChatUtils() => instance;

  UChatUtils._internal();

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    GetIt.I<VibrateUtil>().vibrateSuccess();
    EasyDebounce.debounce(
      'triggerCopyToClipBoard',
      const Duration(milliseconds: 500),
      () async {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Copy'.tr,
            message: 'Info copied'.tr,
            icon: const Icon(
              Icons.copy_rounded,
              color: Colors.grey,
            ),
            duration: const Duration(milliseconds: 1000),
            borderRadius: 20.0,
            margin: const EdgeInsets.all(8.0),
          ),
        );
      },
    );
  }

  void closeKeyboard() {
    if (FocusScope.of(Get.context!).hasFocus) {
      FocusScope.of(Get.context!).unfocus();
    }
  }

  bool isThaiCharacter(int rune) {
    // Range for Thai characters (0x0E00 to 0x0E7F)
    return rune >= 0x0E00 && rune <= 0x0E7F;
  }

  bool isRegionalIndicatorSymbol(int rune) {
    // Range for Regional Indicator Symbols (0x1F1E6 to 0x1F1FF)
    return rune >= 0x1F1E6 && rune <= 0x1F1FF;
  }

  bool isEmoji(int rune) {
    // Basic check for emojis; expand to cover all emoji ranges
    return (rune >= 0x1F600 && rune <= 0x1F64F) || // Emoticons
        (rune >= 0x2600 && rune <= 0x26FF) || // Miscellaneous Symbols
        (rune >= 0x2700 && rune <= 0x27BF) || // Dingbats
        (rune >= 0x1F300 && rune <= 0x1F5FF); // Other emojis
    // Add more ranges if ppp does not handle
  }

  bool isComplexEmoji(int currentRune, int nextRune) {
    if (isEmoji(currentRune) && (nextRune == 8205 || nextRune == 65039)) {
      return true;
    }
    return false;
  }

  String strComplexEmoji(RuneIterator runes) {
    String str = '';

    runes.movePrevious();
    runes.movePrevious();

    while (runes.moveNext()) {
      final currentRune = runes.current;
      runes.moveNext();
      final nextRune = runes.current;

      if (isEmoji(currentRune) && nextRune == 8205 || currentRune == 8205 && isEmoji(nextRune)) {
        str += String.fromCharCodes([currentRune, nextRune]);
      } else {
        str += String.fromCharCode(currentRune);
        break;
      }
    }

    runes.movePrevious();

    return str;
  }

  void closeAllDialogs() {
    Get.until((route) => Get.isDialogOpen == false);
  }
}
