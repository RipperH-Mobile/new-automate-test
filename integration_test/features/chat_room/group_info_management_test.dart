import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:path_provider/path_provider.dart';
import '../../utils/common.util.dart';
import '../../utils/memory_helper.util.dart';
import '../../utils/test_data.util.dart';
import '../../utils/mongodb/base/base_db.util.dart';
import '../../steps/chat_room/group_info_management.step.dart';

void main() {
  late List<Map<String, dynamic>> testData;
  late List<Map<String, dynamic>> resultsData = [];
  setUpAll(() async {
    final dataPath = 'assets/temp_test_data/group_info_management.csv';
    testData = await TestDataUtil.loadData(dataPath);
    await CommonUtil.createMockLoggerService();
  });
  patrolTest('Group info management scenario', ($) async {
    try {
      await CommonUtil.openApplication($);
      try {
        await mongoUtil.connectDb();
      } catch (e) {
        debugPrint('---connectDb error ---${e}');
      }
      for (final dataRow in testData) {
        resultsData = await GroupInfoManagementStep().proceedTest($, dataRow, resultsData);
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
  patrolTest('Group info management scenario', ($) async {
    try {
      final dataPath = 'assets/temp_test_data/group_info_management.csv';
      late List<Map<String, dynamic>> testData;
      testData = await TestDataUtil.loadData(dataPath);
      await CommonUtil.createMockLoggerService();
      await CommonUtil.openApplication($);
      for (final dataRow in testData) {
        resultsData = await GroupInfoManagementStep().proceedTest($, dataRow, resultsData);
        await MemoryHelper.purge();
      }
    } catch (e) {
      debugPrint('--- patrolTest error ---${e}');
    }
  });
  tearDown(() async {
    const String envTarget = String.fromEnvironment('ENV');
    const String deviceTarget = String.fromEnvironment('DEVICE');
    const String outputFilename = 'feature_chat_room_group_info_management_test_${deviceTarget}_${envTarget}_batch.csv';
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

// import 'package:flutter_test/flutter_test.dart';
// import 'package:patrol/patrol.dart';
// import '../../utils/common.util.dart';
// import '../../utils/config-env.util.dart';
// import '../../utils/test_data.util.dart';
// import '../../utils/mongodb/find_db.util.dart';
// import '../../utils/isar/find/isar-find-message.util.dart';
// import '../../pages/login.page.dart';
// import '../../pages/chat_message.page.dart';

// import '../../utils/isar/find/isar-find-message.util.dart';

// import 'package:uchat/core/presentation/widgets/app_search_box.dart';
// import 'package:uchat/features/chat_room_list/presentation/views/widgets/search/chat_list_search_room_message_list.dart';
// import 'package:uchat/features/chat_room_list/presentation/views/widgets/search/searched_message_item.dart';
// import 'package:flutter/widgets.dart';

// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:path_provider/path_provider.dart';
// import 'package:csv/csv.dart';

// import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_v2.dart';
// import 'package:uchat/features/contact/presentation/views/widgets/basic_text_button.dart';
// import 'package:uchat/features/chat_room/presentation/widgets/message_item_v2.dart';
// import 'package:uchat/widgets/popup_menu/message_popup_menu/message_popup_menu_item.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_type_regular_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:animated_flip_counter/animated_flip_counter.dart';

// import 'package:extended_image/extended_image.dart';
// import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';

// /*
// void main() {
//   late List<Map<String, dynamic>> testData;
//   var dataPath;
//   setUpAll(() async {
//     dataPath = 'assets/temp_test_data/chat_message.csv';
//     testData = await TestDataUtil.loadData(dataPath);
//     await CommonUtil.createMockLoggerService();
//   });
//   patrolTest('Search message successful', ($) async {
//     LoginPage loginPage = new LoginPage();
//     ChatMessagePage chatMessagePage = new ChatMessagePage();
//     FindDbUtil findDbUtil = new FindDbUtil();
//     IsarFindMessageUtil isarFindMessageUtil = new IsarFindMessageUtil();
//     await CommonUtil.openApplication($);
//     final List<Map<String, dynamic>> resultsData = [];
//     var loginByMap = Map<String, dynamic>();
//     loginByMap['phoneWithCode'] = '+66611111111';
//     loginByMap['phoneWithoutCode'] = await CommonUtil.convertE164ToNational('+66611111111');
//     loginByMap['password'] = 'Qa@12345';
//     loginByMap['isLoginByPhone'] = true;
//     //await loginPage.proceedLogin($, findDbUtil, loginByMap);
//     await CommonUtil.tapNavigationBarWith($, 'Chat');
//     final createGroupSvgFinder = find.byWidgetPredicate((Widget widget) {
//       if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//         final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//         return loader.assetName == 'assets/vectors/icon_create_group.svg';
//       }
//       return false;
//     });
//     await CommonUtil.tapButton($, targetNameButton: createGroupSvgFinder);
//     await $.pumpAndSettle();
//     final friendNameFinder = find.textContaining('testqa01');
//     await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
//     final friendNameFinder2 = find.textContaining('testqa2');
//     await CommonUtil.tapButton($, targetNameButton: friendNameFinder2);
//     await CommonUtil.tapButton($, targetNameButton: 'Next');
//     await $.pumpAndSettle();
//     final groupName = 'newgroup';
//     await CommonUtil.fillTextInput($, targetNameInput: 'Enter your group name', text: groupName);
//     await CommonUtil.tapButton($, targetNameButton: 'Create');
//     await $.pumpAndSettle();
//     await CommonUtil.tapButton($, targetNameButton: find.textContaining(groupName));
//     await $.pumpAndSettle();

//     // Edit group name
//     // await CommonUtil.tapButton($, targetNameButton: 'Edit Group Name');
//     // await $.pumpAndSettle();
//     // await CommonUtil.fillTextInput($, targetNameInput: 'Enter your name', text: 'newnewgroup');
//     // await CommonUtil.tapButton($, targetNameButton: 'Done');
//     // await $.pumpAndSettle();
//     // await CommonUtil.tapButton($, targetNameButton: 'Back');
//     // await $(find.textContaining('newnewgroup')).waitUntilExists();

//     // Change profile picture
//     // await $(ExtendedImage).waitUntilVisible();
//     // final ExtendedImage oldWidget = $.tester.widget(find.byType(ExtendedImage).first);
//     // final oldImageProvider = oldWidget.image;
//     // print('Old Image: $oldImageProvider');
//     // final cameraIconSvgFinder = find.byWidgetPredicate((Widget widget) {
//     //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//     //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//     //     return loader.assetName == 'assets/vectors/icon_camera.svg';
//     //   }
//     //   return false;
//     // });
//     // await CommonUtil.tapButton($, targetNameButton: cameraIconSvgFinder);
//     // await $.pumpAndSettle();
//     // await $(ExtendedImage).waitUntilVisible();
//     // final imageWidgets = $.tester.widgetList(find.byType(ExtendedImage));
//     // final count = imageWidgets.length;
//     // print('Found $count images in grid. Selecting one randomly...');
//     // if (count > 0) {
//     //   final randomIndex = Random().nextInt(count);
//     //   await $(ExtendedImage).at(randomIndex).tap();
//     //   print('Tapped image at index: $randomIndex');
//     // } else {
//     //   print('Error: No ExtendedImage widgets found to select.');
//     // }
//     // await $.pumpAndSettle();
//     // final ExtendedImage newWidget = $.tester.widget(find.byType(ExtendedImage).first);
//     // final newImageProvider = newWidget.image;
//     // print('New Image: $newImageProvider');
//     // expect(oldImageProvider, isNot(equals(newImageProvider)));
//     // print('SUCCESS: Profile picture has been changed!');

//     // final cameraIconSvgFinder = find.byWidgetPredicate((Widget widget) {
//     //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//     //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//     //     return loader.assetName == 'assets/vectors/icon_camera.svg';
//     //   }
//     //   return false;
//     // });
//     // await CommonUtil.tapButton($, targetNameButton: cameraIconSvgFinder);
//     // await $.pumpAndSettle();
//     // await CommonUtil.tapButton($, targetNameButton: 'Choose from Library');
//     // // final pictureSvgFinder = find.byWidgetPredicate((Widget widget) {
//     // //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//     // //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//     // //     return loader.assetName == 'assets/vectors/photo_outlined.svg';
//     // //   }
//     // //   return false;
//     // // });
//     // // expect(pictureSvgFinder, findsOneWidget);
//     // // await CommonUtil.tapButton($, targetNameButton: pictureSvgFinder);

//     // final bool isButtonVisible = await $('Continue').visible;
//     // if (isButtonVisible) {
//     //   await CommonUtil.tapButton($, targetNameButton: 'Continue');
//     // }
//     // bool isRequestPermission = await $.native.isPermissionDialogVisible();
//     // if (isRequestPermission) {
//     //   await $.native.tap(Selector(text: 'Allow all'));
//     // }
//     // await $.pumpAndSettle();
//     // final targetTextNavBarFinder = find.descendant(of: find.byType(MediaGallery), matching: find.byType(ExtendedImage));
//     // await CommonUtil.tapButton($, targetNameButton: targetTextNavBarFinder);
//     // await Future.delayed(const Duration(seconds: 3));
//     // print('Attempting to tap Native Crop button...');
//     // // try {
//     // //   await $.native.tap(Selector(resourceId: 'com.yalantis.ucrop.ucrop:id/menu_crop'));
//     // // } catch (e) {
//     // //   print('First attempt failed, trying alternative ID...');
//     // //   await $.native.tap(Selector(resourceId: 'menu_crop'));
//     // // }
//     // try {
//     //   print('Trying to tap by text "Crop"...');
//     //   await $.native.tap(Selector(text: 'Crop'));
//     // } catch (e1) {
//     //   // ถ้าไม่เจอ ลองหาจาก Content Description
//     //   try {
//     //     print('Trying to tap by contentDescription "Crop"...');
//     //     await $.native.tap(Selector(contentDescription: 'Crop'));
//     //   } catch (e2) {
//     //     // ถ้าไม่เจอ ลองคำว่า Done
//     //     print('Trying to tap by text "Done"...');
//     //     await $.native.tap(Selector(text: 'Done'));
//     //   }
//     // }
//     // //await $.pumpAndSettle();

//     // // final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
//     // //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//     // //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//     // //     return loader.assetName == 'assets/vectors/send.svg';
//     // //   }
//     // //   return false;
//     // // });
//     // // expect(sendSvgFinder, findsOneWidget);
//     // // await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);
//     // // await $.pumpAndSettle();
//   });
// }
// */
// void main() {
//   late List<Map<String, dynamic>> testData;
//   late List<Map<String, dynamic>> resultsData = [];
//   setUpAll(() async {
//     await ConfigEnvUtil().initialize();
//     final dataPath = 'assets/temp_test_data/group_info_management.csv';
//     testData = await TestDataUtil.loadData(dataPath);
//     try {
//       await ConfigEnvUtil().getDotEnv();
//       await mongoUtil.connectDb();
//     } catch (e) {
//       print('---setUpAll error ---${e}');
//     }
//     await CommonUtil.createMockLoggerService();
//   });
//   patrolTest('Group info management scenario', ($) async {
//     ChatMessageStep chatMessageStep = new ChatMessageStep();
//     await CommonUtil.openApplication($);
//     try {
//       await mongoUtil.connectDb();
//     } catch (e) {
//       print('---connectDb error ---${e}');
//     }
//     for (final dataRow in testData) {
//       resultsData = await chatMessageStep.proceedTest($, dataRow, resultsData);
//     }
//   });
//   tearDownAll(() async {
//     const String outputFilename = String.fromEnvironment('RESULT_FILENAME', defaultValue: 'default_results.csv');
//     final directory = await getApplicationDocumentsDirectory();
//     final newFilePath = '${directory.path}/$outputFilename';
//     await TestDataUtil.updateResultInFile(newFilePath, resultsData);
//     await mongoUtil.disconnectDb();
//     print('---tearDownAll---');
//   });
// }
