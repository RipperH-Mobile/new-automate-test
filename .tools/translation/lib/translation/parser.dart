import 'dart:io';

import 'package:translation/lang.dart';
import 'package:translation/logger.dart';
import 'package:translation/translation/model.dart';

/// Parses the translation file and returns a Map of key-value pairs
TranslationCollection parseTranslationFile(
  String filePath, {
  bool throwError = false,
}) {
  try {
    final file = File(filePath);
    final content = file.readAsStringSync();

    // Regular expression to match key-value pairs
    final RegExp pattern = RegExp(
      r"'((?:[^'\\]|\\.)*)':\s*'((?:[^'\\]|\\.)*)'",
      multiLine: true,
    );

    final Map<String, TranslationModel> translations = {};

    // Find all matches in the content
    pattern.allMatches(content).forEach((match) {
      if (match.groupCount == 2) {
        final key = match.group(1)!;
        final value = match.group(2)!;

        translations[key] = TranslationModel(
          key: key,
          translatedText: value,
          createdAt: DateTime.now(),
        );
      }
    });

    return translations;
  } on FileSystemException catch (e) {
    if (throwError) {
      print('Error reading file: ${e.message}');
      rethrow;
    } else {
      logger.warn('Failed to load JSON file: $e');
    }

    return {};
  }
}

/// Write translations to a file in Dart map format
Future<void> writeTranslationFile(String filePath, Map<String, String> translations, LangData lang) async {
  try {
    final file = File(filePath);
    final buffer = StringBuffer();

    buffer.writeln("// GENERATED CODE - DO NOT MODIFY BY HAND");
    buffer.writeln("");
    buffer.writeln("// **************************************************************************");
    buffer.writeln("// UChat Language Translation Generator");
    buffer.writeln("// **************************************************************************");
    buffer.writeln("");
    buffer.writeln("// coverage:ignore-file");
    buffer.writeln(
        "// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types");
    buffer.writeln("");
    buffer.writeln("part of 'lang.dart';");
    buffer.writeln("");

    buffer.writeln("const ${lang.langConstName} = {");

    translations.forEach((key, value) {
      // Escape any single quotes in the strings
      final escapedKey = replaceUnnecessaryText(key);
      final escapedValue = replaceUnnecessaryText(value);
      buffer.writeln("  '$escapedKey': '$escapedValue',");
    });

    buffer.writeln("};");

    await file.writeAsString(buffer.toString());
  } on FileSystemException catch (e) {
    print('Error writing file: ${e.message}');
    rethrow;
  }
}

String replaceUnnecessaryText(String input) {
  return input
      .replaceAllMapped(RegExp(r'(?<!\\)\n'), (match) => '\\n')
      .replaceAllMapped(RegExp(r"(?<!\\)'"), (match) => "\\'");
}
