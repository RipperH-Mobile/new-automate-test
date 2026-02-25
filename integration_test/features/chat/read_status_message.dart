// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:patrol/patrol.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:csv/csv.dart';
// import '../../utils/common.util.dart';
// import '../../utils/config-env.util.dart';
// import '../../utils/test_data.util.dart';
// import '../../utils/mongodb/base/base_db.util.dart';
// import '../../utils/mongodb/find_db.util.dart';
// import '../../pages/login.page.dart';
// import '../../steps/account/login.step.dart';
// import '../../steps/chat/pin_message.step.dart';
// import 'package:uchat/features/call/call_controller.dart';

// void main() {
//   late List<Map<String, dynamic>> testData;
//   late List<Map<String, dynamic>> resultsData = [];
//   setUpAll(() async {
//     //await ConfigEnvUtil().initialize();
//     final dataPath = 'assets/temp_test_data/read_status_message.csv';
//     testData = await TestDataUtil.loadData(dataPath);
//     // try {
//     //   await ConfigEnvUtil().getDotEnv();
//     //   await mongoUtil.connectDb();
//     // } catch (e) {
//     //   print('---setUpAll error ---${e}');
//     // }
//     await CommonUtil.createMockLoggerService();
//   });
//   patrolTest('Read message successful', ($) async {
//     LoginPage loginPage = new LoginPage();
//     ChatMessagePage chatMessagePage = new ChatMessagePage();
//     FindDbUtil findDbUtil = new FindDbUtil();
//     IsarFindMessageUtil isarFindMessageUtil = new IsarFindMessageUtil();
//     await CommonUtil.openApplication($);
//     final List<Map<String, dynamic>> resultsData = [];
//     var loginByMap = Map<String, String>();
//     loginByMap['phoneWithCode'] = '+66633132475';
//     loginByMap['phoneWithoutCode'] = await CommonUtil.convertE164ToNational('+66633132475');
//     //await loginPage.proceedLogin($, findDbUtil, true, loginByMap, 'Qa@12345');
//     // await chatMessagePage.proceedChatWithMessage($, 'Sorawit(Md)-2477');
//     // final isarMessage = await isarFindMessageUtil.getDetailByAccountIdInMessages(isarFindMessageUtil.getUserId);
//     // final String? sourceMessage = isarMessage?.message;
//     // final String? sourceSentTime = isarMessage?.sentTime;

//     await CommonUtil.tapNavigationBarWith($, 'Chat');
//     final friendNameFinder = find.textContaining('qatest01');
//     await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
//     await $.pump();
//     await $.pumpAndSettle();
//     final readSvgFinder = find.byWidgetPredicate((Widget widget) {
//       if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//         final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//         return loader.assetName == 'assets/vectors/icon_check.svg';
//       }
//       return false;
//     });
//     final targetFinder = find.descendant(of: find.byType(MessageStatusV2), matching: readSvgFinder);
//     expect(targetFinder, findsOneWidget);
//   });
// }
