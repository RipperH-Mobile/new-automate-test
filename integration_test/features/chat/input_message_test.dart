import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:get_it/get_it.dart';
import 'package:patrol/patrol.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/common.util.dart';
import '../../utils/memory_helper.util.dart';
import '../../utils/test_data.util.dart';
import '../../utils/mongodb/base/base_db.util.dart';
import '../../steps/chat/input_message.step.dart';

/*
void main() {
  late List<Map<String, dynamic>> testData;
  var dataPath;
  // setUpAll(() async {
  //   dataPath = 'assets/temp_test_data/chat_message.csv';
  //   testData = await TestDataUtil.loadData(dataPath);
  // });
  patrolTest('Search message successful', ($) async {
    LoginPage loginPage = new LoginPage();
    ChatMessagePage chatMessagePage = new ChatMessagePage();
    FindDbUtil findDbUtil = new FindDbUtil();
    IsarFindMessageUtil isarFindMessageUtil = new IsarFindMessageUtil();
    await CommonUtil.openApplication($);
    final List<Map<String, dynamic>> resultsData = [];
    var loginByMap = Map<String, String>();
    loginByMap['phoneWithCode'] = '+66613909911';
    loginByMap['phoneWithoutCode'] = await CommonUtil.convertE164ToNational('+66613909911');
    //await loginPage.proceedLogin($, findDbUtil, true, loginByMap, 'Qa@12345');
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    final friendNameFinder = find.textContaining('testqa2');
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    await $.pump();
    await $.pumpAndSettle();
    // input text max
    // var textInput = await CommonUtil.generateTestString(5121);
    // await $(TextField).enterText(textInput);
    // final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
    //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
    //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
    //     return loader.assetName == 'assets/vectors/send.svg';
    //   }
    //   return false;
    // });
    // expect(sendSvgFinder, findsOneWidget);
    // await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);

    // input emoji
    // var emojiInput = await CommonUtil.generateEmojiString(5120);
    // await $(TextField).enterText(emojiInput);
    // final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
    //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
    //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
    //     return loader.assetName == 'assets/vectors/send.svg';
    //   }
    //   return false;
    // });
    // expect(sendSvgFinder, findsOneWidget);
    // await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);

    // attachement file
    // final moreSvgFinder = find.byWidgetPredicate((Widget widget) {
    //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
    //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
    //     return loader.assetName == 'assets/vectors/more.svg';
    //   }
    //   return false;
    // });
    // expect(moreSvgFinder, findsOneWidget);
    // await CommonUtil.tapButton($, targetNameButton: moreSvgFinder);
    // await $.pumpAndSettle();
    // await CommonUtil.tapButton($, targetNameButton: 'Share a file');
    // await $.pumpAndSettle();
    // final bool isButtonVisible = await $('Continue').visible;
    // if (isButtonVisible) {
    //   await CommonUtil.tapButton($, targetNameButton: 'Continue');
    // }
    // bool isRequestPermission = await $.native.isPermissionDialogVisible();
    // if (isRequestPermission) {
    //   await $.native.tap(Selector(text: 'Allow all'));
    // }
    // await $.native.tap(Selector(text: 'Documents'));
    // await $.native.tap(Selector(textContains: '.pdf'));
    // await $.pumpAndSettle();

    // //attachement picture
    // final pictureSvgFinder = find.byWidgetPredicate((Widget widget) {
    //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
    //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
    //     return loader.assetName == 'assets/vectors/photo_outlined.svg';
    //   }
    //   return false;
    // });
    // expect(pictureSvgFinder, findsOneWidget);
    // await CommonUtil.tapButton($, targetNameButton: pictureSvgFinder);
    // final bool isButtonVisible = await $('Continue').visible;
    // if (isButtonVisible) {
    //   await CommonUtil.tapButton($, targetNameButton: 'Continue');
    // }
    // bool isRequestPermission = await $.native.isPermissionDialogVisible();
    // if (isRequestPermission) {
    //   await $.native.tap(Selector(text: 'Allow all'));
    // }
    // await $.pumpAndSettle();
    // final targetTextNavBarFinder = find.descendant(of: find.byType(MediaGallery), matching: find.byType(ExtendedImage));
    // await CommonUtil.tapButton($, targetNameButton: targetTextNavBarFinder);
    // final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
    //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
    //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
    //     return loader.assetName == 'assets/vectors/send.svg';
    //   }
    //   return false;
    // });
    // expect(sendSvgFinder, findsOneWidget);
    // await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);
    // await $.pumpAndSettle();

    //send location
    // final moreSvgFinder = find.byWidgetPredicate((Widget widget) {
    //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
    //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
    //     return loader.assetName == 'assets/vectors/more.svg';
    //   }
    //   return false;
    // });
    // expect(moreSvgFinder, findsOneWidget);
    // await CommonUtil.tapButton($, targetNameButton: moreSvgFinder);
    // await $.pumpAndSettle();
    // await CommonUtil.tapButton($, targetNameButton: 'Location');
    // await $.pumpAndSettle();
    // bool isRequestPermission = await $.native.isPermissionDialogVisible();
    // if (isRequestPermission) {
    //   await $.native.tap(Selector(text: 'While using the app'));
    // }
    // bool isRequestGpsPermission = await $.native.isPermissionDialogVisible();
    // if (isRequestGpsPermission) {
    //   await $.native.tap(Selector(text: 'Turn on'));
    // }
    // await CommonUtil.tapButton($, targetNameButton: 'Share');
    // await $.pumpAndSettle();

    //attachement media
    final pictureSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/photo_outlined.svg';
      }
      return false;
    });
    expect(pictureSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: pictureSvgFinder);
    final bool isButtonVisible = await $('Continue').visible;
    if (isButtonVisible) {
      await CommonUtil.tapButton($, targetNameButton: 'Continue');
    }
    bool isRequestPermission = await $.native.isPermissionDialogVisible();
    if (isRequestPermission) {
      await $.native.tap(Selector(text: 'Allow all'));
    }
    await $.pumpAndSettle();
    final targetTextNavBarFinder = find.descendant(of: find.byType(MediaGallery), matching: find.byType(ExtendedImage));
    await CommonUtil.tapButton($, targetNameButton: targetTextNavBarFinder);
    final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/send.svg';
      }
      return false;
    });
    expect(sendSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);
    await $.pumpAndSettle();
  });
}
*/
void main() {
  late List<Map<String, dynamic>> testData;
  late List<Map<String, dynamic>> resultsData = [];
  setUpAll(() async {
    final dataPath = 'assets/temp_test_data/input_message.csv';
    testData = await TestDataUtil.loadData(dataPath);
    await CommonUtil.createMockLoggerService();
  });
  patrolTest('Message input control scenario', ($) async {
    try {
      await CommonUtil.openApplication($);
      try {
        await mongoUtil.connectDb();
      } catch (e) {
        debugPrint('---connectDb error ---${e}');
      }
      for (final dataRow in testData) {
        resultsData = await InputMessageStep().proceedTest($, dataRow, resultsData);
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
  patrolTest('Message input control scenario', ($) async {
    try {
      final dataPath = 'assets/temp_test_data/input_message.csv';
      late List<Map<String, dynamic>> testData;
      testData = await TestDataUtil.loadData(dataPath);
      await CommonUtil.createMockLoggerService();
      await CommonUtil.openApplication($);
      for (final dataRow in testData) {
        resultsData = await InputMessageStep().proceedTest($, dataRow, resultsData);
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
  tearDown(() async {
    const String envTarget = String.fromEnvironment('ENV');
    const String deviceTarget = String.fromEnvironment('DEVICE');
    const String outputFilename = 'feature_chat_input_message_test_${deviceTarget}_${envTarget}_batch.csv';
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
    final newFilePath = '${customDirectory.path}/$outputFilename';
    await TestDataUtil.updateResultInFile(newFilePath, resultsData);
    debugPrint('---tearDown---');
  });
}
