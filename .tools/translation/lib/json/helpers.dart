import 'dart:convert';
import 'dart:io';

import 'package:translation/logger.dart';

import 'cast.dart';

Future<TypedData<T>> loadJsonToModel<T>(
  String filePath, {
  bool throwError = false,
}) async {
  try {
    final file = File(filePath);

    if (!await file.exists()) {
      throw 'File not found: $filePath';
    }

    final jsonString = await file.readAsString();
    final clearedJson = jsonString.trim().replaceAll(RegExp(r'^\uFEFF'), '');
    final json = jsonDecode(clearedJson) as Map<String, dynamic>;

    return TypedData<T>.fromJson(json);
  } catch (e) {
    if (throwError) {
      throw 'Failed to load JSON file: $e';
    } else {
      logger.warn('Failed to load JSON file: $e');
    }

    return TypedData<T>.fromJson({});
  }
}

Future<void> saveMapToJson<T>(
  Map<String, T> data,
  String filePath, {
  bool pretty = false,
}) async {
  try {
    final file = File(filePath);

    final jsonString = pretty ? JsonEncoder.withIndent('  ').convert(data) : json.encode(data);

    await file.writeAsString(jsonString);
  } catch (e) {
    throw 'Failed to save JSON file: $e';
  }
}
