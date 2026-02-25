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
// import 'package:uchat/utils/online_status_util.dart';

// import 'package:uchat/controllers/real_time_database_controller.dart';
// import 'package:uchat/entities/enum/online_status.dart';

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
//     final targetId = '692571b8921764610cbece9f';
//     print('Injecting...');
//     RealTimeDatabaseController.instance.onlineUsers[targetId] = 'online';
//     await $.pump();
//     print('Online Users: ${RealTimeDatabaseController.instance.onlineUsers}');
//     final status = OnlineStatusUtil.getRxOnlineStatusDirectRoom(accountId: targetId);
//     expect(status.value, OnlineStatus.online);
//   });
// }
