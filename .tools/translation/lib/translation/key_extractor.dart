import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:translation/env/env.dart';
import 'package:translation/logger.dart';
import 'package:translation/map/sort.dart';
import 'package:translation/translation/key_match_model.dart';

import 'key_extractor_result_model.dart';
import 'key_model.dart';

typedef ScanTranslationKeys = Map<String, TranslationKeyModel>;

const isDebug = false; // Env.isDebug;

final regexReplaceEndLine = RegExp("['\"]\n?\$");
final regexReplaceBeginLine = RegExp("^['\"]");
final regexLineHasTranslationKey = RegExp(r"\.tr(?![a-z])|\.trParams\(");

class TranslationKeyExtractor {
  static void debugPrint(String message) {
    if (isDebug) {
      logger.info(message, style: debugInfoStyle);
    }
  }

  static void greenPrint(String message) {
    if (isDebug) {
      logger.info(message, style: greenStyle);
    }
  }

  static void matchPrint(String message) {
    if (isDebug) {
      logger.info(message, style: debugDetailStyle);
    }
  }

  static TranslationKeyContextModel matchContext(String key) {
    final regex = RegExp(r'\|__(.+?)__\|(.+)');

    final match1 = regex.firstMatch(key);
    if (match1 != null) {
      return TranslationKeyContextModel(
        context: match1.group(1),
        key: match1.group(2) ?? key,
      );
    }

    return TranslationKeyContextModel(
      key: key,
    );
  }

  static List<KeyMatchModel> extractText(String input) {
    final pattern = RegExp(r"'([^'\\]*(?:\\.[^'\\]*)*)'\.tr");

    // Clean up the input
    input = input.replaceAll('\${"', '\${\'');
    input = input.replaceAll('".tr', '\'.tr');

    final matches = pattern.allMatches(input);

    return matches.map((match) {
      matchPrint('GroupCount: ${match.groupCount}');
      for (int i = 0; i <= match.groupCount; i++) {
        matchPrint('Match$i: ${match.group(i)}');
      }

      final startIndex = match.start + 1; // +1 to skip the opening quote
      final endIndex = match.start + 1 + match.group(1)!.length;
      final content = match.group(1)?.replaceFirst('\${\'', '') ?? '';

      return KeyMatchModel(
        key: content,
        startIndex: startIndex,
        endIndex: endIndex,
      );
    }).toList();
  }

  static Future<KeyExtractorResult?> processFile(String filePath) async {
    final ScanTranslationKeys translationKeys = {};

    try {
      // Read file content
      final file = File(filePath);
      final lines = await file.readAsLines();

      // Split content into lines and process each line

      int trCount = 0;
      for (int i = 0; i < lines.length; i++) {
        final startLine = i;
        final lineTrimmed = lines[i].trim();
        if (lineTrimmed.startsWith('//')) {
          // debugPrint('[$i] Skip start with "//".');
          continue;
        }

        if (regexLineHasTranslationKey.allMatches(lineTrimmed).isEmpty) {
          // debugPrint('[$i] Skip not contain ".tr" or ".trParams".');
          continue;
        }
        trCount++;

        final lineLastChar = lineTrimmed[lineTrimmed.length - 1];

        // debugPrint('[$i] ---------------------------------------------------->>>');
        // debugPrint('[$i] Content: "$lineTrimmed"');
        // debugPrint('[$i] -----');

        String? combinedLines;

        int j = i;
        while (j < lines.length && j > 0) {
          final currentLineTrimmed = lines[j].trim();
          if (combinedLines != null &&
              (!currentLineTrimmed.endsWith('\'') && !currentLineTrimmed.endsWith('"')) &&
              j < i) {
            // debugPrint('[$i][$j] BreakLine: endWIth \' or ", ($currentLineTrimmed)');
            // debugPrint('[$i] -----');
            // debugPrint('[$i] Break: $combinedLines');
            // debugPrint('[$i] ----->>>');
            break;
          }

          if (currentLineTrimmed.isEmpty) {
            break;
          }

          final currentLineLastChar = currentLineTrimmed[currentLineTrimmed.length - 1];

          // Checking for multiline text or normal case
          if (lineLastChar == "'" || lineLastChar == '"') {
            debugPrint('[$i][$j] C1: $currentLineTrimmed');
            combinedLines = combinedLines == null
                ? currentLineTrimmed
                : combinedLines.replaceFirst(regexReplaceEndLine, '') +
                    currentLineTrimmed.replaceFirst(regexReplaceBeginLine, '');
            j++;
          } else {
            debugPrint('[$i][$j] C2: $currentLineTrimmed');

            if (combinedLines == null) {
              combinedLines = currentLineTrimmed;
            } else {
              if (combinedLines.startsWith('\'') || combinedLines.startsWith('"')) {
                combinedLines = currentLineTrimmed.replaceFirst(regexReplaceEndLine, '') +
                    combinedLines.replaceFirst(regexReplaceBeginLine, '');
              } else {
                combinedLines = currentLineTrimmed + combinedLines;
              }
            }

            // debugPrint('[$i][$j] Combined: $combinedLines');
            j--;
          }

          if (currentLineLastChar == ';' && !lineTrimmed.startsWith('.tr')) {
            // debugPrint('[$i] -----');
            // debugPrint('[$i] Break: $combinedLines');
            // debugPrint('[$i] ----->>>');

            // If we are on the different line of current line, we need to set i to the last processed line (j variable).
            if (j > i) {
              i = j - 1;
            }

            break;
          }
        }

        if (combinedLines == null) {
          // print('Continue: $combinedLines');
          // print('=====================');
          continue;
        }

        final List<KeyMatchModel> currentExtractedTexts = extractText(combinedLines);
        // if (combinedLines.contains('print(')) {
        //   currentExtractedTexts.addAll(extractPrintText(combinedLines));
        // } else if (combinedLines.contains('.tr')) {
        //   currentExtractedTexts.addAll(extractSimpleText(combinedLines));
        // }
        // else if (combinedLines.contains('.trParams')) {
        //   currentExtractedTexts.add(extractParamsText(combinedLines));
        // }

        greenPrint('[$i] > Found <${currentExtractedTexts.length}>');
        for (int k = 0; k < currentExtractedTexts.length; k++) {
          greenPrint('[$i] > (Key$k) __${currentExtractedTexts[k].key}__');
        }

        if (currentExtractedTexts.isNotEmpty) {
          final relativeFilePath = path.relative(file.path, from: Env.projectPath);

          for (final currentExtractedText in currentExtractedTexts) {
            if (currentExtractedText.key.isNotEmpty) {
              final keyContext = matchContext(currentExtractedText.key);

              translationKeys[currentExtractedText.key] ??= TranslationKeyModel(
                key: keyContext.key,
                context: keyContext.context,
                createdAt: DateTime.now(),
                files: [],
              );

              // Confirm update model
              translationKeys[currentExtractedText.key]!.key = keyContext.key;
              translationKeys[currentExtractedText.key]!.context = keyContext.context;

              final translationKey = TranslationKeyFileModel(
                name: relativeFilePath,
                start: currentExtractedText.startIndex,
                end: currentExtractedText.endIndex,
                line: startLine + 1,
                createdAt: DateTime.now(),
              );

              translationKeys[currentExtractedText.key]!.files.add(translationKey);
            }
          }
        }
      }

      return KeyExtractorResult(trCount: trCount, translationKeys: translationKeys.sortedByKey());
    } catch (e) {
      debugPrint('Error processing file: $e');
      return null;
    }
  }
}
