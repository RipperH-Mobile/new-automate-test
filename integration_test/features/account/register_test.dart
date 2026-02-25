import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:path_provider/path_provider.dart';
import '../../utils/common.util.dart';
import '../../utils/memory_helper.util.dart';
import '../../utils/test_data.util.dart';
import '../../utils/mongodb/base/base_db.util.dart';
import '../../steps/account/register.step.dart';

void main() {
  late List<Map<String, dynamic>> testData;
  late List<Map<String, dynamic>> resultsData = [];
  setUpAll(() async {
    final dataPath = 'assets/temp_test_data/register.csv';
    testData = await TestDataUtil.loadData(dataPath);
    await CommonUtil.createMockLoggerService();
  });
  patrolTest('Register scenario', ($) async {
    try {
      await CommonUtil.openApplication($);
      try {
        await mongoUtil.connectDb();
      } catch (e) {
        debugPrint('---connectDb error ---${e}');
      }
      for (final dataRow in testData) {
        resultsData = await RegisterStep().proceedTest($, dataRow, resultsData);
        await MemoryHelper.purge();
      }
      var failedCases = resultsData.where((row) => row['actual_result'] != 'PASSED').toList();
      if (failedCases.isEmpty) {
        debugPrint('✅ Passed all');
      } else {
        debugPrint('❌ Failed test case ${failedCases.length} :');
        for (var row in failedCases) {
          debugPrint(' - Case: ${row['test_case']} (${row['test_description']})');
        }
      }
    } catch (e) {
      debugPrint('--- patrolTest error ---${e}');
    }
  });
  tearDownAll(() async {
    const String outputFilename = String.fromEnvironment('RESULT_FILENAME', defaultValue: 'default_results.csv');
    final directory = await getApplicationDocumentsDirectory();
    final newFilePath = '${directory.path}/$outputFilename';
    await TestDataUtil.updateResultInFile(newFilePath, resultsData);
    await mongoUtil.disconnectDb();
    debugPrint('---tearDownAll---');
  });
}

void runTests() {
  late List<Map<String, dynamic>> resultsData = [];
  patrolTest('Register scenario', ($) async {
    try {
      final dataPath = 'assets/temp_test_data/register.csv';
      late List<Map<String, dynamic>> testData;
      testData = await TestDataUtil.loadData(dataPath);
      await CommonUtil.createMockLoggerService();
      await CommonUtil.openApplication($);
      for (final dataRow in testData) {
        resultsData = await RegisterStep().proceedTest($, dataRow, resultsData);
        await MemoryHelper.purge();
      }
    } catch (e) {
      debugPrint('--- patrolTest error ---${e}');
    }
  });
  tearDown(() async {
    const String envTarget = String.fromEnvironment('ENV');
    const String deviceTarget = String.fromEnvironment('DEVICE');
    const String outputFilename = 'feature_account_register_test_${deviceTarget}_${envTarget}_batch.csv';
    Directory directory;
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
    }
    final customDirectory = Directory('${directory.path}/temp_automate_result');
    if (!await customDirectory.exists()) {
      await customDirectory.create(recursive: true);
    }
    debugPrint('--- outputFilename ---$outputFilename');
    final newFilePath = '${customDirectory.path}/$outputFilename';
    await TestDataUtil.updateResultInFile(newFilePath, resultsData);
    debugPrint('---tearDown---');
  });
}
