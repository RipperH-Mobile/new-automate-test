// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:patrol/patrol.dart';

// import '../../utils/common.util.dart';
// import '../../utils/mongodb/find_db.util.dart';
// import '../../utils/isar/find/isar-find-message.util.dart';

// import '../../pages/login.page.dart';
// import '../../pages/register.page.dart';
// import '../../pages/password_form.page.dart';
// import '../../pages/chat_message.page.dart';
// import '../../pages/account_setting.page.dart';

// import '../../steps/account/register.step.dart';
// import '../account/user_setting_edit_detail.step.dart';

// import '../../workflows/ui/ui_delete_account.workflow.dart';

// class SortingChatStep {
//   Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
//     var sortingChatMap = Map<String, dynamic>();
//     sortingChatMap['isDeleteAfterRun'] = CommonUtil.convertStringToBoolean(dataRow['is_delete_after_run']);
//     sortingChatMap['isRegister'] = CommonUtil.convertStringToBoolean(dataRow['is_register']);
//     sortingChatMap['isLoginByPhone'] = CommonUtil.convertStringToBoolean(dataRow['is_login_by_phone']);
//     sortingChatMap['loginByMePhoneNumber'] = dataRow['login_by_me_phone_number'];
//     sortingChatMap['loginByMePassword'] = dataRow['login_by_me_password'];
//     sortingChatMap['isAddFriend'] = CommonUtil.convertStringToBoolean(dataRow['is_add_friend']);
//     sortingChatMap['addFriendDetail'] = dataRow['add_friend_detail'];
//     sortingChatMap['isTimeReceivedLatest'] = CommonUtil.convertStringToBoolean(dataRow['is_time_received_latest']);
//     sortingChatMap['isTimeReceivedOldest'] = CommonUtil.convertStringToBoolean(dataRow['is_time_received_oldest']);
//     sortingChatMap['isNameAZ'] = CommonUtil.convertStringToBoolean(dataRow['is_name_a_z']);
//     sortingChatMap['isNameZA'] = CommonUtil.convertStringToBoolean(dataRow['is_name_z_a']);
//     sortingChatMap['isUnreadMessages'] = CommonUtil.convertStringToBoolean(dataRow['is_unread_messages']);
//     sortingChatMap['expectedNavigatePage'] = dataRow['expected_navigate_page'];
//     sortingChatMap['expectedResult'] = CommonUtil.convertStringToBoolean(dataRow['expected_result']);
//     sortingChatMap['expectedMessage'] = dataRow['expected_message'];
//     final packageInfo = await CommonUtil.getActualCurrentAppVersion();
//     final osVersion = await CommonUtil.getActualDeviceInfo();
//     RegisterPage registerPage = new RegisterPage();
//     PasswordFormPage passwordFormPage = new PasswordFormPage();
//     LoginPage loginPage = new LoginPage();
//     ChatMessagePage chatMessagePage = new ChatMessagePage();
//     AccountSettingPage accountSettingPage = new AccountSettingPage();
//     FindDbUtil findDbUtil = new FindDbUtil();
//     IsarFindMessageUtil isarFindMessageUtil = new IsarFindMessageUtil();
//     UiDeleteAccountWorkflow uiDeleteAccountWorkflow = new UiDeleteAccountWorkflow();
//     try {
//       if (sortingChatMap['isRegister']) {
//         // final phoneList = dataRow['register_phone_number']?.split('|') ?? [];
//         // final emailList = dataRow['register_email']?.split('|') ?? [];
//         // final nameList = dataRow['register_profile_name']?.split('|') ?? [];
//         // final passList = dataRow['register_password']?.split('|') ?? [];
//         // final confirmPassList = dataRow['register_confirm_password']?.split('|') ?? [];
//         // final uchatIdList = dataRow['register_uchat_id']?.split('|') ?? [];
//         // int dataCount = phoneList.length;
//         // for (int i = 0; i < dataCount; i++) {
//         //   Map<String, dynamic> currentSessionMap = {};
//         //   String currentPhone = _getVal(phoneList, i);
//         //   currentSessionMap['phoneWithCode'] = currentPhone;
//         //   currentSessionMap['phoneWithoutCode'] = await CommonUtil.convertE164ToNational(currentPhone);
//         //   currentSessionMap['email'] = _getVal(emailList, i);
//         //   currentSessionMap['profileName'] = _getVal(nameList, i);
//         //   currentSessionMap['password'] = _getVal(passList, i);
//         //   currentSessionMap['confirmPassword'] = _getVal(confirmPassList, i);
//         //   currentSessionMap['uchatId'] = _getVal(uchatIdList, i);
//         //   currentSessionMap['isLoginByPhone'] = sortingChatMap['isLoginByPhone'];
//         //   currentSessionMap['expectedNavigatePage'] = sortingChatMap['expectedNavigatePage'];
//         //   await registerPage.proceedRegister($, findDbUtil, currentSessionMap);
//         //   if (currentSessionMap['isLoginByPhone'] != true) {
//         //     await accountSettingPage.proceedAddEmail(
//         //       $,
//         //       findDbUtil,
//         //       passwordFormPage,
//         //       currentSessionMap['password'],
//         //       currentSessionMap['email'],
//         //     );
//         //   }
//         //   await CommonUtil.tapNavigationBarWith($, 'Menu');
//         //   await loginPage.proceedLogout($);
//       }
//       await loginPage.proceedLogin($, findDbUtil, sortingChatMap);
//       if (sortingChatMap['isAddFriend']) {
//         final List<String> dataSetList = sortingChatMap['addFriendDetail'].split(',');
//         for (final dataSet in dataSetList) {
//           sortingChatMap['phoneWithCode'] = dataRow['login_by_me_phone_number'];
//           sortingChatMap['phoneWithoutCode'] = await CommonUtil.convertE164ToNational(
//             dataRow['login_by_me_phone_number'],
//           );
//           sortingChatMap['password'] = dataRow['login_by_me_password'];
//           final List<String> fields = dataSet.trim().split('|');
//           if (fields.length < 4) continue;
//           final String inputPhoneWithCode = fields[0];
//           final String inputPassword = fields[1];
//           final String inputUchatId = fields[2];
//           final String inputMessage = fields[3];
//           final String inputPhoneNational = await CommonUtil.convertE164ToNational(inputPhoneWithCode);
//           await chatMessagePage.proceedAddFriend($, inputPhoneNational);
//           await chatMessagePage.proceedChatWithMessage($, false, inputUchatId, inputMessage);
//         }
//       }
//       await CommonUtil.tapNavigationBarWith($, 'Chat');
//       final hambergerBarSvgFinder = find.byWidgetPredicate((Widget widget) {
//         if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//           final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//           return loader.assetName == 'assets/vectors/icon_hamberger_bar.svg';
//         }
//         return false;
//       });
//       await CommonUtil.tapButton($, targetNameButton: hambergerBarSvgFinder);
//       await $.pump();
//       await CommonUtil.tapButton($, targetNameButton: 'Sorting');
//       await $.pump();
//       if (sortingChatMap['isTimeReceivedLatest']) {
//         await CommonUtil.tapButton($, targetNameButton: find.textContaining('Time received: Latest'));
//         await $.pump();
//       } else if (sortingChatMap['isTimeReceivedOldest']) {
//         await CommonUtil.tapButton($, targetNameButton: find.textContaining('Time received: Oldest'));
//         await $.pump();
//       } else if (sortingChatMap['isNameAZ']) {
//         await CommonUtil.tapButton($, targetNameButton: find.textContaining('A-Z'));
//         await $.pump();
//       } else if (sortingChatMap['isNameZA']) {
//         await CommonUtil.tapButton($, targetNameButton: find.textContaining('A-Z'));
//         await $.pump();
//       } else if (sortingChatMap['isUnreadMessages']) {
//         await CommonUtil.tapButton($, targetNameButton: find.textContaining('Unread messages'));
//         await $.pump();
//       }
//       dataRow['actual_result'] = 'PASSED';
//     } catch (e, stackTrace) {
//       print('---error---${stackTrace}');
//       dataRow['actual_result'] = 'FAILED';
//     } finally {
//       if (sortingChatMap['isDeleteAfterRun']) {
//         //await uiDeleteAccountWorkflow.proceedDeleteAccount($, sortingChatMap['password']);
//       }
//       DateTime currentTime = DateTime.now();
//       dataRow['actual_version'] = 'app version ${packageInfo.version} | $osVersion | $currentTime';
//       resultsData.add(dataRow);
//     }
//     return resultsData;
//   }

//   String _getVal(List<String> list, int index) {
//     if (list.isEmpty) return "";
//     if (index >= list.length) return list.last;
//     return list[index];
//   }
// }
