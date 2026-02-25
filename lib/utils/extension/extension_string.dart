import 'dart:math';

import 'package:emoji_extension/emoji_extension.dart' as emojis;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/utils/uchat_utils.dart';

import 'extension_color.dart';

/// ```
/// [limitLength] should get from acceptable width screen multiple with font width size
/// ```
/// ```
/// For example
/// ```
/// acceptable width screen 20% of max width size and font width size is 6px
/// [limitLength] = Get.width * 0.2 / 6
/// if [original.length] > limitLength
/// this function will show substring of [original] 0 to limitLength with overflow dot [...]
String overflowStr(int limitLength, String original) {
  if (original.length > limitLength) {
    return '${original.substring(0, limitLength)}...';
  }
  return original;
}

bool isMatchPrefixMentionPattern(String str) {
  if (str.length > 2) {
    return str.startsWith('@[_');
  } else {
    return str.startsWith('@[');
  }
}

extension StringExtension on String {
  String overflowStr({int limitLength = 25}) {
    String str = this;
    return str.length > limitLength ? '${str.substring(0, limitLength)}...' : str;
  }

  int get effectiveLength {
    int length = 0;
    final runes = this.runes.iterator;

    while (runes.moveNext()) {
      final currentRune = runes.current;
      if (String.fromCharCode(currentRune) == '@') {
        String tempResult = '@';
        int moveCount = 0;
        RegExp customRegExp = RegExp(UChatConstant.mentionRegexPattern);
        while (customRegExp.firstMatch(tempResult) == null) {
          runes.moveNext();
          moveCount++;
          final nextRune = runes.current;
          if (nextRune == -1) {
            length += tempResult.length;
            break;
          }
          tempResult += String.fromCharCode(nextRune);
          final isMatchPrefix = isMatchPrefixMentionPattern(tempResult);
          if (isMatchPrefix == false) {
            break;
          }
        }

        final isMatchPrefix = isMatchPrefixMentionPattern(tempResult);
        if (isMatchPrefix == false) {
          length += '@'.length;
          for (var index = 0; index < moveCount; index++) {
            runes.movePrevious();
          }
          continue;
        }

        final fm = customRegExp.firstMatch(tempResult);

        if (fm == null) {
          if (tempResult.length > 1) {
            for (var index = 0; index < tempResult.length; index++) {
              runes.movePrevious();
            }
          }
        } else {
          length += 1;
        }
        tempResult = '';
      } else if (UChatUtils.instance.isThaiCharacter(currentRune)) {
        /// Thai character is counted as one character
        length++;
      } else if (UChatUtils.instance.isRegionalIndicatorSymbol(currentRune)) {
        if (runes.moveNext() && UChatUtils.instance.isRegionalIndicatorSymbol(runes.current)) {
          // Count the pair of regional indicators (flag) as one character
          length++;
        } else {
          // If the next rune is not a regional indicator, count both runes
          length += 2;
        }
      } else if (UChatUtils.instance.isEmoji(currentRune)) {
        runes.moveNext();
        final nextRune = runes.current;

        if (UChatUtils.instance.isComplexEmoji(currentRune, nextRune)) {
          UChatUtils.instance.strComplexEmoji(runes);
          length++;
        } else {
          runes.movePrevious();
          length++;
        }
      } else {
        length++;
      }
    }

    return length;
  }

  String lastChars(int n) => substring(length - n);

  String subStr(int limitLength) {
    String str = this;
    String result = '';
    String tempResult = '';
    final runes = str.runes.iterator;

    int countString = 0;

    while (runes.moveNext()) {
      final currentRune = runes.current;
      if (String.fromCharCode(currentRune) == '@') {
        tempResult = '@';
        int moveCount = 0;
        RegExp customRegExp = RegExp(UChatConstant.mentionRegexPattern);
        while (customRegExp.firstMatch(tempResult) == null) {
          runes.moveNext();
          moveCount++;
          final nextRune = runes.current;
          if (nextRune == -1) {
            break;
          }
          tempResult += String.fromCharCode(nextRune);
          final isMatchPrefix = isMatchPrefixMentionPattern(tempResult);
          if (isMatchPrefix == false) {
            break;
          }
        }
        final isMatchPrefix = isMatchPrefixMentionPattern(tempResult);
        if (isMatchPrefix == false) {
          result += '@';
          countString++;
          for (var index = 0; index < moveCount; index++) {
            runes.movePrevious();
          }
          continue;
        }

        final fm = customRegExp.firstMatch(tempResult);

        if (fm == null) {
          if (tempResult.length > 1) {
            for (var index = 0; index < tempResult.length; index++) {
              runes.movePrevious();
            }
          }
        } else {
          result += tempResult;
          countString += 1;
        }
        tempResult = '';
      } else if (UChatUtils.instance.isThaiCharacter(currentRune)) {
        /// Thai character is counted as one character
        result += String.fromCharCode(currentRune);
        countString++;
      } else if (UChatUtils.instance.isRegionalIndicatorSymbol(currentRune)) {
        if (runes.moveNext() && UChatUtils.instance.isRegionalIndicatorSymbol(runes.current)) {
          // Count the pair of regional indicators (flag) as one character
          result += String.fromCharCode(currentRune);
          countString++;
        } else {
          // If the next rune is not a regional indicator, count both runes
          result += String.fromCharCode(currentRune);
          countString++;
        }
      } else if (UChatUtils.instance.isEmoji(currentRune)) {
        runes.moveNext();
        final nextRune = runes.current;

        if (UChatUtils.instance.isComplexEmoji(currentRune, nextRune)) {
          final complexEmoji = UChatUtils.instance.strComplexEmoji(runes);
          result += complexEmoji;
          countString++;
        } else {
          runes.movePrevious();
          result += String.fromCharCode(currentRune);
          countString++;
        }
      } else {
        // normal character
        result += String.fromCharCode(currentRune);
        countString++;
      }

      if (countString >= limitLength) {
        break;
      }
    }

    return result;
  }

  Color get hexToColor {
    return HexColor.fromHex(this);
  }

  String get pricingFormat {
    try {
      NumberFormat formatter = NumberFormat.decimalPatternDigits(
        locale: 'en_us',
        decimalDigits: 2,
      );
      return formatter.format(double.parse(this));
    } catch (_) {
      return '0.00';
    }
  }

  Map<String, String> mentionMap({
    String pattern = UChatConstant.mentionRegexPattern,
  }) {
    UserController userController = UserController.instance;
    Map<String, String> map = <String, String>{};
    RegExp customRegExp = RegExp(pattern);
    RegExpMatch match = customRegExp.firstMatch(this)!;

    var displayNameIndex = 3;
    var valueIndex = 2;
    var userId = match.group(2);
    String? displayName;

    if (match.groupCount == 2) {
      displayNameIndex = 2;
      valueIndex = 1;
      userId = match.group(1);
    }

    if (userController.currentUser()?.id == userId) {
      displayName = UserCollection.fromEntity(userController.currentUser()!).shortDisplayName;
    } else if (userId == UChatConstant.mentionAllId) {
      displayName = 'All@mention'.trParams({'mention': ''});
    } else {
      final contact = GetIt.I<GetContactSyncUseCase>().call(userId ?? '');
      displayName = contact?.shortName ?? match.group(displayNameIndex) ?? '';
    }

    if (displayName.isEmpty == true) {
      map['display'] = '@UNKNOWN';
    } else {
      map['display'] = '@$displayName';
    }

    map['value'] = match.group(valueIndex) ?? 'UNKNOWN';

    if (userId == UChatConstant.lessMoreId) {
      map['display'] = '${match.group(displayNameIndex)}';
      map['value'] = match.group(valueIndex) ?? '';
    }
    return map;
  }

  /// Show display mark up if [String] is regex pattern
  ///
  /// Example:
  ///
  /// ```dart
  /// // pattern ==> [__id__](__displayName__)
  /// final msg = '[__0123456789__](__abcdef__)';
  /// print(msg) // [__0123456789__](__abcdef__)
  /// print(msg.displayMarkUp(getDisplay: true)) // abcdef
  /// print(msg.displayMarkUp()) // @0123456789
  /// ```
  String displayMention({
    String pattern = UChatConstant.mentionRegexPattern,
    bool getDisplay = false,
  }) {
    return splitMapJoin(
      RegExp(
        pattern,
        multiLine: true,
        caseSensitive: true,
        dotAll: false,
        unicode: false,
      ),
      onMatch: (m) {
        if (getDisplay) {
          return m[0]?.mentionMap()['display'] ?? '';
        } else {
          return '@${m[0]?.mentionMap()["value"]}';
        }
      },
      onNonMatch: (nm) {
        return nm;
      },
    );
  }

  bool get isHex {
    final regExp = RegExp(r'^[0-9a-f]{34,}$');
    return regExp.hasMatch(this);
  }

  bool get hasOnlyEmoji {
    return this.emojis.only;
  }

  bool get containsEmoji {
    return this.emojis.contains;
  }

  int get countEmoji {
    return this.emojis.count;
  }

  /// Checks if the string is a valid UChat QR code URL
  ///
  /// Returns `true` if the string can be parsed as a URI and contains 'uchat.social'
  ///
  /// Example:
  /// ```dart
  /// 'https://uchat.social/profile/123'.isUChatQRCode; // true
  /// 'https://example.com'.isUChatQRCode; // false
  /// 'invalid-url'.isUChatQRCode; // false
  /// ```
  bool get isUChatQRCode {
    final uri = Uri.tryParse(this);
    if (uri == null) {
      return false;
    }
    // Handle schemeless URLs like "uchat.social/profile/123"
    if (uri.host.isEmpty && uri.path.toLowerCase().startsWith('uchat.social')) {
      return true;
    }
    return uri.host.toLowerCase().endsWith('uchat.social');
  }
}

extension PhoneOrEmailExtension on String {
  String shortPhoneNumber() {
    if (isEmpty) return '';

    if (length > 17) {
      return '${substring(0, 17)}...';
    }

    return this;
  }

  String shortEmail() {
    if (isEmpty) return 'Unregistered'.tr;

    if (length > 20) {
      return '${substring(0, 20)}...';
    }

    return this;
  }

  String maskPhoneNumber() {
    if (isEmpty) {
      return '';
    }

    final firstPart = substring(0, 3);
    final lastPart = substring(length - 4);
    return ' $firstPart ** *** $lastPart';
  }

  String phoneNumberFormatDisplay() {
    if (isEmpty) {
      return '';
    }

    final firstPart = substring(0, 3);
    final secondPart = substring(3, 5);
    final thirdPart = substring(5, 8);
    final lastPart = substring(length - 4);
    return ' $firstPart $secondPart $thirdPart $lastPart';
  }

  String random({int amount = 10}) {
    if (isEmpty) {
      return '';
    }

    final random = Random();
    final chars = this;

    return String.fromCharCodes(
      Iterable.generate(
        amount,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }
}
