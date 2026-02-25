import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class TestDataUtil {
  static Future<List<Map<String, dynamic>>> loadData(String filePath) async {
    try {
      final String rawCsv = await rootBundle.loadString(filePath);
      final converter = const CsvToListConverter(shouldParseNumbers: false, eol: '\n');
      final List<List<dynamic>> csvTable = converter.convert(rawCsv);
      if (csvTable.length < 2) return [];
      final List<Map<String, dynamic>> records = [];
      final List<dynamic> headers = csvTable[0];
      for (int i = 1; i < csvTable.length; i++) {
        final record = <String, dynamic>{};
        final row = csvTable[i];
        for (int j = 0; j < headers.length; j++) {
          record[headers[j].toString()] = row[j];
        }
        records.add(record);
      }
      return records;
    } catch (e) {
      debugPrint('An error occurred while reading the CSV file : $e');
      return [];
    }
  }

  static Future<bool> updateResultInFile(String filePath, List<Map<String, dynamic>> resultsData) async {
    bool isSuccess = false;
    if (resultsData.isNotEmpty) {
      final headers = resultsData.first.keys.toList();
      final List<List<dynamic>> rows = [
        headers,
        ...resultsData.map((row) => headers.map((header) => row[header]).toList()),
      ];
      final csvString = const ListToCsvConverter().convert(rows);
      final file = File(filePath);
      await file.writeAsString(csvString);
      debugPrint('✅ Results file saved on device at: $filePath');
      isSuccess = true;
    } else {
      debugPrint('⚠️ No results data to write.');
    }
    return isSuccess;
  }
}
