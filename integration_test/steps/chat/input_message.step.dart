import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

import '../../utils/common.util.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

import '../../pages/login.page.dart';
import '../../pages/password_form.page.dart';
import '../../pages/chat_message.page.dart';
import '../../pages/account_setting.page.dart';

import '../../workflows/api/api_create_account.workflow.dart';
import '../../workflows/ui/ui_delete_account.workflow.dart';

// class InputMessageStep {
//   Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
//     var inputMessageMap = Map<String, dynamic>();
//     inputMessageMap['isDeleteAfterRun'] = CommonUtil.convertStringToBoolean(dataRow['is_delete_after_run']);
//     inputMessageMap['isRegister'] = CommonUtil.convertStringToBoolean(dataRow['is_register']);
//     inputMessageMap['isLoginByPhone'] = CommonUtil.convertStringToBoolean(dataRow['is_login_by_phone']);
//     inputMessageMap['loginByMePhoneNumber'] = dataRow['login_by_me_phone_number'];
//     inputMessageMap['loginByMePassword'] = dataRow['login_by_me_password'];
//     inputMessageMap['isAddFriend'] = CommonUtil.convertStringToBoolean(dataRow['is_add_friend']);
//     inputMessageMap['addFriendDetail'] = dataRow['add_friend_detail'];
//     inputMessageMap['isCreateGroup'] = CommonUtil.convertStringToBoolean(dataRow['is_create_group']);
//     inputMessageMap['groupFriendListTarget'] = dataRow['group_friend_list_target'];
//     inputMessageMap['isSendMessage'] = CommonUtil.convertStringToBoolean(dataRow['is_send_message']);
//     inputMessageMap['message'] = dataRow['message'];
//     inputMessageMap['expectedMessage'] = dataRow['expected_message'];
//     inputMessageMap['expectedNavigatePage'] = dataRow['expected_navigate_page'];
//     inputMessageMap['expectedResult'] = CommonUtil.convertStringToBoolean(dataRow['expected_result']);
//     inputMessageMap['expectedMessage'] = dataRow['expected_message'];
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
//       if (inputMessageMap['isRegister']) {
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
//         //   currentSessionMap['isLoginByPhone'] = inputMessageMap['isLoginByPhone'];
//         //   currentSessionMap['expectedNavigatePage'] = inputMessageMap['expectedNavigatePage'];
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
//       await loginPage.proceedLogin($, findDbUtil, inputMessageMap);
//       if (inputMessageMap['isAddFriend']) {
//         final List<String> dataSetList = rawData.split(',');
//         for (final dataSet in dataSetList) {
//           inputMessageMap['phoneWithCode'] = dataRow['login_by_me_phone_number'];
//           inputMessageMap['phoneWithoutCode'] = await CommonUtil.convertE164ToNational(
//             dataRow['login_by_me_phone_number'],
//           );
//           inputMessageMap['password'] = dataRow['login_by_me_password'];
//           final List<String> fields = dataSet.trim().split('|');
//           if (fields.length < 3) continue;
//           final String inputPhoneWithCode = fields[0];
//           final String inputPassword = fields[1];
//           final String inputUchatId = fields[2];
//           final String inputPhoneNational = await CommonUtil.convertE164ToNational(inputPhoneWithCode);
//           await chatMessagePage.proceedAddFriend($, inputPhoneNational);
//         }
//       }
//       await CommonUtil.tapNavigationBarWith($, 'Chat');
//       final friendNameFinder = find.textContaining('testqa2');
//       await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
//       await $.pump();
//       await $.pumpAndSettle();
//       // input text max
//       // var textInput = await CommonUtil.generateTestString(5121);
//       // await $(TextField).enterText(textInput);
//       // final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
//       //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//       //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//       //     return loader.assetName == 'assets/vectors/send.svg';
//       //   }
//       //   return false;
//       // });
//       // expect(sendSvgFinder, findsOneWidget);
//       // await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);

//       // input emoji
//       // var emojiInput = await CommonUtil.generateEmojiString(5120);
//       // await $(TextField).enterText(emojiInput);
//       // final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
//       //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//       //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//       //     return loader.assetName == 'assets/vectors/send.svg';
//       //   }
//       //   return false;
//       // });
//       // expect(sendSvgFinder, findsOneWidget);
//       // await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);

//       // attachement file
//       // final moreSvgFinder = find.byWidgetPredicate((Widget widget) {
//       //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//       //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//       //     return loader.assetName == 'assets/vectors/more.svg';
//       //   }
//       //   return false;
//       // });
//       // expect(moreSvgFinder, findsOneWidget);
//       // await CommonUtil.tapButton($, targetNameButton: moreSvgFinder);
//       // await $.pumpAndSettle();
//       // await CommonUtil.tapButton($, targetNameButton: 'Share a file');
//       // await $.pumpAndSettle();
//       // final bool isButtonVisible = await $('Continue').visible;
//       // if (isButtonVisible) {
//       //   await CommonUtil.tapButton($, targetNameButton: 'Continue');
//       // }
//       // bool isRequestPermission = await $.native.isPermissionDialogVisible();
//       // if (isRequestPermission) {
//       //   await $.native.tap(Selector(text: 'Allow all'));
//       // }
//       // await $.native.tap(Selector(text: 'Documents'));
//       // await $.native.tap(Selector(textContains: '.pdf'));
//       // await $.pumpAndSettle();

//       // //attachement picture
//       // final pictureSvgFinder = find.byWidgetPredicate((Widget widget) {
//       //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//       //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//       //     return loader.assetName == 'assets/vectors/photo_outlined.svg';
//       //   }
//       //   return false;
//       // });
//       // expect(pictureSvgFinder, findsOneWidget);
//       // await CommonUtil.tapButton($, targetNameButton: pictureSvgFinder);
//       // final bool isButtonVisible = await $('Continue').visible;
//       // if (isButtonVisible) {
//       //   await CommonUtil.tapButton($, targetNameButton: 'Continue');
//       // }
//       // bool isRequestPermission = await $.native.isPermissionDialogVisible();
//       // if (isRequestPermission) {
//       //   await $.native.tap(Selector(text: 'Allow all'));
//       // }
//       // await $.pumpAndSettle();
//       // final targetTextNavBarFinder = find.descendant(of: find.byType(MediaGallery), matching: find.byType(ExtendedImage));
//       // await CommonUtil.tapButton($, targetNameButton: targetTextNavBarFinder);
//       // final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
//       //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//       //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//       //     return loader.assetName == 'assets/vectors/send.svg';
//       //   }
//       //   return false;
//       // });
//       // expect(sendSvgFinder, findsOneWidget);
//       // await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);
//       // await $.pumpAndSettle();

//       //send location
//       // final moreSvgFinder = find.byWidgetPredicate((Widget widget) {
//       //   if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//       //     final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//       //     return loader.assetName == 'assets/vectors/more.svg';
//       //   }
//       //   return false;
//       // });
//       // expect(moreSvgFinder, findsOneWidget);
//       // await CommonUtil.tapButton($, targetNameButton: moreSvgFinder);
//       // await $.pumpAndSettle();
//       // await CommonUtil.tapButton($, targetNameButton: 'Location');
//       // await $.pumpAndSettle();
//       // bool isRequestPermission = await $.native.isPermissionDialogVisible();
//       // if (isRequestPermission) {
//       //   await $.native.tap(Selector(text: 'While using the app'));
//       // }
//       // bool isRequestGpsPermission = await $.native.isPermissionDialogVisible();
//       // if (isRequestGpsPermission) {
//       //   await $.native.tap(Selector(text: 'Turn on'));
//       // }
//       // await CommonUtil.tapButton($, targetNameButton: 'Share');
//       // await $.pumpAndSettle();

//       //attachement media
//       final pictureSvgFinder = find.byWidgetPredicate((Widget widget) {
//         if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//           final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//           return loader.assetName == 'assets/vectors/photo_outlined.svg';
//         }
//         return false;
//       });
//       expect(pictureSvgFinder, findsOneWidget);
//       await CommonUtil.tapButton($, targetNameButton: pictureSvgFinder);
//       final bool isButtonVisible = await $('Continue').visible;
//       if (isButtonVisible) {
//         await CommonUtil.tapButton($, targetNameButton: 'Continue');
//       }
//       bool isRequestPermission = await $.native.isPermissionDialogVisible();
//       if (isRequestPermission) {
//         await $.native.tap(Selector(text: 'Allow all'));
//       }
//       await $.pumpAndSettle();
//       final targetTextNavBarFinder = find.descendant(
//         of: find.byType(MediaGallery),
//         matching: find.byType(ExtendedImage),
//       );
//       await CommonUtil.tapButton($, targetNameButton: targetTextNavBarFinder);
//       final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
//         if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//           final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//           return loader.assetName == 'assets/vectors/send.svg';
//         }
//         return false;
//       });
//       expect(sendSvgFinder, findsOneWidget);
//       await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);
//       await $.pumpAndSettle();
//       dataRow['actual_result'] = 'PASSED';
//     } catch (e, stackTrace) {
//       print('---error---${stackTrace}');
//       dataRow['actual_result'] = 'FAILED';
//     } finally {
//       if (inputMessageMap['isDeleteAfterRun']) {
//         //await uiDeleteAccountWorkflow.proceedDeleteAccount($, inputMessageMap['password']);
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

class InputMessageStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final PasswordFormPage _passwordPage = PasswordFormPage();
  final ChatMessagePage _chatPage = ChatMessagePage();
  final AccountSettingPage _settingPage = AccountSettingPage();
  late LoginPage _loginPage;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = InputMessageTestConfig.fromRow(dataRow);

    try {
      // 1. Registration Flow
      if (config.isRegister) {
        await _performRegistration($, config);
      }

      // 2. Login Main User
      await _loginUser($, config.loginByMePhone, config.loginByMePassword, config.isLoginByPhone);

      // 3. Add Friend Flow
      if (config.isAddFriend) {
        await _performAddFriend($, config);
      }

      // 4. Send Message Flow (Main Test Logic)
      if (config.isSendMessage) {
        await _performSendMessage($, config);
      }
      if (config.isSendPicture) {
        await _performSendPicture($, config);
      }
      if (config.isSendFile) {
        await _performSendFile($, config);
      }
      if (config.isSendLocation) {
        await _performSendLocation($, config);
      }
      if (config.isSendUchatFriend) {
        await _performSendUchatFriend($, config);
      }

      // 5. Expected
      if (config.isExpectedSuccess) {
        await _performExpectedSuccess($, config);
      } else {
        await _performExpectedFail($, config);
      }

      dataRow['actual_result'] = 'PASSED';
    } catch (e, stackTrace) {
      debugPrint('---error---$e\n$stackTrace');
      dataRow['actual_result'] = 'FAILED';
    } finally {
      try {
        // 6. Cleanup (Delete Account)
        if (config.isDeleteAfterRun) {
          await _performCleanup($, config);
        }
      } catch (e, stackTrace) {
        debugPrint('---error delete account---$e\n$stackTrace');
      }

      // 7. Update Metadata
      await _updateResultMetadata(dataRow);
      resultsData.add(dataRow);
    }
    return resultsData;
  }

  // --- Sub-routines ---

  Future<void> _performRegistration($, InputMessageTestConfig config) async {
    for (int i = 0; i < config.regPhones.length; i++) {
      final currentPhone = config.getVal(config.regPhones, i);
      final sessionMap = {
        'phoneWithCode': currentPhone,
        'phoneWithoutCode': await CommonUtil.convertE164ToNational(currentPhone),
        'email': config.getVal(config.regEmails, i),
        'profileName': config.getVal(config.regNames, i),
        'password': config.getVal(config.regPasswords, i),
        'confirmPassword': config.getVal(config.regPasswords, i),
        'uchatId': config.getVal(config.regUchatIds, i),
        'isLoginByPhone': config.isLoginByPhone,
      };

      await _apiCreateAccountWorkflow.createAccount(currentPhone, config.getVal(config.regNames, i),
          config.getVal(config.regUchatIds, i), config.getVal(config.regPasswords, i));

      if (!config.isLoginByPhone) {
        await _settingPage.proceedAddEmail(
          $,
          _findDbUtil,
          _passwordPage,
          sessionMap['password'] as String,
          sessionMap['email'] as String,
        );
      }
    }
  }

  Future<void> _performAddFriend($, InputMessageTestConfig config) async {
    final dataSetList = config.addFriendDetail.split(',');
    for (final dataSet in dataSetList) {
      final fields = dataSet.trim().split('|');
      if (fields.length < 3) continue;
      final inputPhoneWithCode = fields[0];
      final inputPassword = fields[1];
      final inputUchatId = fields[2];
      final inputPhoneNational = await CommonUtil.convertE164ToNational(inputPhoneWithCode);
      await _chatPage.proceedAddFriend($, inputPhoneNational);
    }
  }

  Future<void> _performSendMessage($, InputMessageTestConfig config) async {
    await $.pump();
    final friendNameFinder = find.textContaining(config.uchatFriendListTarget);
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    final targetButtonFinder = find.text('Chat');
    bool found = false;
    for (int i = 0; i < 50; i++) {
      await $.pump(const Duration(seconds: 3));
      if (find.text('Chat').evaluate().isNotEmpty) {
        found = true;
        break;
      }
    }
    if (!found) {
      await $.pumpAndSettle();
    }
    await CommonUtil.tapButton($, targetNameButton: targetButtonFinder);

    await $.pump();
    var textInput =
        CommonUtil.generateTextString(CommonUtil.convertStringToInt(config.totalMessage), config.messageText);
    await $(TextField).enterText(textInput);
    // try {
    //   await CommonUtil.tapIconSendMessage($);
    // } catch (e) {}
  }

  Future<void> _performSendPicture($, InputMessageTestConfig config) async {
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
  }

  Future<void> _performSendFile($, InputMessageTestConfig config) async {
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
  }

  Future<void> _performSendLocation($, InputMessageTestConfig config) async {
    final moreSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/more.svg';
      }
      return false;
    });
    expect(moreSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: moreSvgFinder);
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Location');
    await $.pumpAndSettle();
    bool isRequestPermission = await $.native.isPermissionDialogVisible();
    if (isRequestPermission) {
      await $.native.tap(Selector(text: 'While using the app'));
    }
    bool isRequestGpsPermission = await $.native.isPermissionDialogVisible();
    if (isRequestGpsPermission) {
      await $.native.tap(Selector(text: 'Turn on'));
    }
    await CommonUtil.tapButton($, targetNameButton: 'Share');
    await $.pumpAndSettle();
  }

  Future<void> _performSendUchatFriend($, InputMessageTestConfig config) async {}

  // Future<void> _sendMediaAttachment($) async {
  //   // 1. Click Photo Icon
  //   final pictureSvgFinder = find.byWidgetPredicate((Widget widget) {
  //     if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
  //       final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
  //       return loader.assetName == 'assets/vectors/photo_outlined.svg';
  //     }
  //     return false;
  //   });
  //   expect(pictureSvgFinder, findsOneWidget);
  //   await CommonUtil.tapButton($, targetNameButton: pictureSvgFinder);

  //   // 2. Handle Permissions/Tutorials
  //   final bool isButtonVisible = await $('Continue').visible;
  //   if (isButtonVisible) {
  //     await CommonUtil.tapButton($, targetNameButton: 'Continue');
  //   }

  //   bool isRequestPermission = await $.native.isPermissionDialogVisible();
  //   if (isRequestPermission) {
  //     await $.native.tap(Selector(text: 'Allow all'));
  //   }
  //   await $.pumpAndSettle();

  //   // 3. Select Image
  //   final targetTextNavBarFinder = find.descendant(of: find.byType(MediaGallery), matching: find.byType(ExtendedImage));
  //   await CommonUtil.tapButton($, targetNameButton: targetTextNavBarFinder);

  //   // 4. Click Send
  //   final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
  //     if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
  //       final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
  //       return loader.assetName == 'assets/vectors/send.svg';
  //     }
  //     return false;
  //   });
  //   expect(sendSvgFinder, findsOneWidget);
  //   await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);
  //   await $.pumpAndSettle();
  // }

  Future<void> _loginUser($, String phoneWithCode, String password, bool isPhoneLogin) async {
    await _loginPage.proceedLogin(
      isPhoneLogin: isPhoneLogin,
      phoneWithoutCode: await CommonUtil.convertE164ToNational(phoneWithCode),
      phoneWithCode: await CommonUtil.convertE164ToNational(phoneWithCode),
      password: password,
    );
  }

  Future<void> _performExpectedSuccess($, InputMessageTestConfig config) async {
    if (config.isSendLocation) {}
    if (config.isSendUchatFriend) {}
  }

  Future<void> _performExpectedFail($, InputMessageTestConfig config) async {
    if (config.isSendMessage) {
      final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
        if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
          final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
          return loader.assetName == 'assets/vectors/send.svg';
        }
        return false;
      });
      expect(sendSvgFinder, findsNothing);
      await CommonUtil.tapIconBack($);
      await $.pump();
      await CommonUtil.tapNavigationBarWith($, 'Menu');
      await _loginPage.proceedLogout($);
    }
  }

  Future<void> _performCleanup($, InputMessageTestConfig config) async {
    List<String> phoneList = [];
    phoneList.addAll(config.regPhones);
    final getListDetailAccounts = await _findDbUtil.getListDetailByPhoneInAccount(phoneList);
    List<Map<String, dynamic>> reusableAccountList = [];
    if (getListDetailAccounts != null && getListDetailAccounts is List) {
      for (int i = 0; i < config.regPhones.length; i++) {
        var dbRecord = getListDetailAccounts[i];
        reusableAccountList.add({
          'documentId': dbRecord['_id'],
          'username': '',
          'hashedPassword': '',
          'phoneNumber': '',
          'displayName': 'Deleted User',
          'deleted': true
        });
      }
    }
    if (getListDetailAccounts.isNotEmpty) {
      await _updateDbUtil.updateListReuseDeletedUserInAccount(reusableAccountList);
      debugPrint('Updated ${reusableAccountList.length} users successfully.');
    }

    // for (int i = 0; i < config.regPhones.length; i++) {
    //   final currentPhone = config.getVal(config.regPhones, i);
    //   final phoneWithoutCode = await CommonUtil.convertE164ToNational(currentPhone);
    //   final password = config.getVal(config.regPasswords, i);

    //   // Login to delete
    //   await _loginUser($, currentPhone, password, config.isLoginByPhone);
    //   await _deleteWorkflow.proceedDeleteAccount($, password);
    // }
  }

  Future<void> _updateResultMetadata(Map<String, dynamic> dataRow) async {
    final packageInfo = await CommonUtil.getActualCurrentAppVersion();
    final osVersion = await CommonUtil.getActualDeviceInfo();
    dataRow['actual_version'] = 'app version ${packageInfo.version} | $osVersion | ${DateTime.now()}';
  }
}

class InputMessageTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool isLoginByPhone;
  final String loginByMePhone;
  final String loginByMeProfileName;
  final String loginByMePassword;
  final String loginByFriendPhone;
  final String loginByFriendProfileName;
  final String loginByFriendPassword;
  final bool isAddFriend;
  final String addFriendDetail;

  final bool isSendMessage;
  final String totalMessage;
  final String messageText;
  final bool isSendPicture;
  final bool isSendFile;
  final bool isSendLocation;
  final bool isSendUchatFriend;
  final String uchatFriendListTarget;

  final String expectedMessage;
  final String expectedNavigatePage;
  final bool isExpectedSuccess;

  // Registration Data Lists
  final List<String> regPhones;
  final List<String> regEmails;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regConfirmPasswords;
  final List<String> regUchatIds;

  InputMessageTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = CommonUtil.convertStringToBoolean(row['is_login_by_phone']),
        loginByMePhone = row['login_by_me_phone_number'] ?? '',
        loginByMeProfileName = row['login_by_me_profile_name'] ?? '',
        loginByMePassword = row['login_by_me_password'] ?? '',
        loginByFriendPhone = row['login_by_friend_phone_number'] ?? '',
        loginByFriendProfileName = row['login_by_friend_profile_name'] ?? '',
        loginByFriendPassword = row['login_by_friend_password'] ?? '',
        isAddFriend = CommonUtil.convertStringToBoolean(row['is_add_friend']),
        addFriendDetail = row['add_friend_detail'] ?? '',
        isSendMessage = CommonUtil.convertStringToBoolean(row['is_send_message']),
        totalMessage = row['total_message'] ?? '',
        messageText = row['message_text'] ?? '',
        isSendPicture = CommonUtil.convertStringToBoolean(row['is_send_picture']),
        isSendFile = CommonUtil.convertStringToBoolean(row['is_send_file']),
        isSendLocation = CommonUtil.convertStringToBoolean(row['is_send_location']),
        isSendUchatFriend = CommonUtil.convertStringToBoolean(row['is_send_uchat_friend']),
        uchatFriendListTarget = row['uchat_friend_list_target'] ?? '',
        expectedMessage = row['expected_message'] ?? '',
        expectedNavigatePage = row['expected_navigate_page'] ?? '',
        isExpectedSuccess = CommonUtil.convertStringToBoolean(row['expected_result']),
        // List parsing
        regPhones = row['register_phone_number']?.split('|') ?? [],
        regEmails = row['register_email']?.split('|') ?? [],
        regNames = row['register_profile_name']?.split('|') ?? [],
        regPasswords = row['register_password']?.split('|') ?? [],
        regConfirmPasswords = row['register_confirm_password']?.split('|') ?? [],
        regUchatIds = row['register_uchat_id']?.split('|') ?? [];

  String getVal(List<String> list, int index) {
    if (list.isEmpty) return "";
    return index >= list.length ? list.last : list[index];
  }
}
