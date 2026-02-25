import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../../utils/common.util.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

import '../../pages/login.page.dart';
import '../../pages/register.page.dart';
import '../../pages/chat_message.page.dart';

import '../../workflows/api/api_create_account.workflow.dart';
import '../../workflows/ui/ui_create_new_group.workflow.dart';
import '../../workflows/ui/ui_join_new_group.workflow.dart';
import '../../workflows/ui/ui_delete_account.workflow.dart';

class GroupInfoManagementStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiCreateNewGroupWorkflow _createNewGroupWorkflow = UiCreateNewGroupWorkflow();
  final UiJoinNewGroupWorkflow _joinNewGroupWorkflow = UiJoinNewGroupWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final RegisterPage _registerPage = RegisterPage();
  final ChatMessagePage _chatPage = ChatMessagePage();
  late LoginPage _loginPage;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = GroupInfoManagementTestConfig.fromRow(dataRow);

    try {
      // 1. Registration Flow
      if (config.isRegister) {
        await _performRegistration($, config);
      }

      // 2. Login Main User (Owner/Admin)
      await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);

      // 3. Add Friend Flow
      if (config.isAddFriend) {
        await _performAddFriends($, config);
      }

      // 4. Create Group Flow
      if (config.isCreateGroup) {
        await _performCreateGroup($, config);
        await CommonUtil.tapNavigationBarWith($, 'Menu');
        await _loginPage.proceedLogout($);
        await _performJoinGroup($, _loginPage, config);
        if (config.whoAssignToAdmin.isNotEmpty ?? false) {
          await _performAssignAdmin($, config);
        }
      }

      // 5. Execute test
      if (config.isEditGroupName) {
        await _performEditGroupNameAction($, config);
      }
      if (config.isChangeGroupPicture) {
        await _performChangeGroupProfileAction($, config);
      }

      // 6. Expected
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
      // 7. Cleanup (Delete Account)
      if (config.isDeleteAfterRun) {
        await _performCleanup($, config);
      }

      // Update Metadata
      await _updateResultMetadata(dataRow);
      resultsData.add(dataRow);
    }
    return resultsData;
  }

  // --- Sub-routines ---

  Future<void> _performRegistration($, GroupInfoManagementTestConfig config) async {
    for (int i = 0; i < config.regPhones.length; i++) {
      final currentPhone = config.getVal(config.regPhones, i);
      final sessionMap = {
        'phoneWithCode': currentPhone,
        'phoneWithoutCode': await CommonUtil.convertE164ToNational(currentPhone),
        'profileName': config.getVal(config.regNames, i),
        'password': config.getVal(config.regPasswords, i),
        'confirmPassword': config.getVal(config.regPasswords, i),
        'uchatId': config.getVal(config.regUchatIds, i),
        'isLoginByPhone': true,
      };
      await _apiCreateAccountWorkflow.createAccount(currentPhone, config.getVal(config.regNames, i),
          config.getVal(config.regUchatIds, i), config.getVal(config.regPasswords, i));
    }
  }

  Future<void> _performAddFriends($, GroupInfoManagementTestConfig config) async {
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

  Future<void> _performCreateGroup($, GroupInfoManagementTestConfig config) async {
    await _createNewGroupWorkflow.proceedCreateGroup($, config.addMemberDetail, config.groupName);
  }

  Future<void> _performJoinGroup($, LoginPage _loginPage, GroupInfoManagementTestConfig config) async {
    await _joinNewGroupWorkflow.proceedJoinNewGroup($, _loginPage, config);
  }

  Future<void> _performAssignAdmin($, GroupInfoManagementTestConfig config) async {
    await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);
    await CommonUtil.tapNavigationBarWith($, 'Contact');
    await $.pump();
    final friendNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    final targetButtonText = 'Chat';
    final targetButtonFinder = find.text(targetButtonText);
    bool found = false;
    for (int i = 0; i < 50; i++) {
      await $.pump(const Duration(seconds: 3));
      if (find.text(targetButtonText).evaluate().isNotEmpty) {
        found = true;
        break;
      }
    }
    if (!found) {
      await $.pumpAndSettle();
    }
    await CommonUtil.tapButton($, targetNameButton: targetButtonFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Administrators');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Add');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: config.whoAssignToAdmin);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Done');
    await $.pump(const Duration(seconds: 1));
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performEditGroupNameAction($, GroupInfoManagementTestConfig config) async {
    if (config.expectedIsLoginByAdmin) {
      await _loginUser($, config.loginByAdminPhone, config.loginByAdminPassword, true);
    } else if (config.expectedIsLoginByMember) {
      await _loginUser($, config.loginByMemberPhone, config.loginByMemberPassword, true);
    } else if (config.expectedIsLoginByOwner) {
      await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);
    }
    await CommonUtil.tapNavigationBarWith($, 'Contact');
    await $.pump();
    final friendNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    final targetButtonText = 'Chat';
    final targetButtonFinder = find.text(targetButtonText);
    bool found = false;
    for (int i = 0; i < 50; i++) {
      await $.pump(const Duration(seconds: 3));
      if (find.text(targetButtonText).evaluate().isNotEmpty) {
        found = true;
        break;
      }
    }
    if (!found) {
      await $.pumpAndSettle();
    }
    await CommonUtil.tapButton($, targetNameButton: targetButtonFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Edit Group Name');
    await $.pump();
    // await CommonUtil.fillTextInput(
    //   $,
    //   targetNameInput: 'Enter your name',
    //   text: config.newGroupName,
    // );
    await CommonUtil.fillTextInput(
      $,
      targetNameInput: 'Name',
      text: config.newGroupName,
    );
    await CommonUtil.tapButton($, targetNameButton: 'Done');
    await $.pump();
  }

  Future<void> _performChangeGroupProfileAction($, GroupInfoManagementTestConfig config) async {}

  Future<void> _performExpectedSuccess($, GroupInfoManagementTestConfig config) async {
    if (config.isEditGroupName) {
      await CommonUtil.tapButton($, targetNameButton: 'Back');
      await $(find.textContaining(config.newGroupName)).waitUntilExists();
      await CommonUtil.tapIconBack($);
      await $.pump();
      await CommonUtil.tapNavigationBarWith($, 'Menu');
      await _loginPage.proceedLogout($);
    }
  }

  Future<void> _performExpectedFail($, GroupInfoManagementTestConfig config) async {}

  Future<void> _performCleanup($, GroupInfoManagementTestConfig config) async {
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

    // final targets = config.regPhones;
    // final passwords = config.regPasswords;

    // for (int i = 0; i < targets.length; i++) {
    //   final currentPhone = config.getVal(targets, i);
    //   final password = config.getVal(passwords, i);

    //   if (currentPhone.isEmpty) continue;

    //   // Ensure logged in before delete
    //   await _loginUser($, currentPhone, password, true);
    //   await CommonUtil.tapNavigationBarWith($, 'Contact');
    //   final groupNameFinder = find.textContaining(config.groupName);
    //   await CommonUtil.dragLeft($, groupNameFinder);
    //   await CommonUtil.tapButton($, targetNameButton: 'Leave');
    //   await $.pump();
    //   await CommonUtil.tapButton($, targetNameButton: 'Leave');
    //   await $.pump();
    //   await _deleteWorkflow.proceedDeleteAccount($, password);
    // }
  }

  Future<void> _loginUser($, String phoneWithCode, String password, bool isPhoneLogin) async {
    await _loginPage.proceedLogin(
      isPhoneLogin: isPhoneLogin,
      phoneWithoutCode: await CommonUtil.convertE164ToNational(phoneWithCode),
      phoneWithCode: phoneWithCode,
      password: password,
    );
  }

  Future<void> _updateResultMetadata(Map<String, dynamic> dataRow) async {
    final packageInfo = await CommonUtil.getActualCurrentAppVersion();
    final osVersion = await CommonUtil.getActualDeviceInfo();
    dataRow['actual_version'] = 'app version ${packageInfo.version} | $osVersion | ${DateTime.now()}';
  }
}

class GroupInfoManagementTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool? isLoginByPhone;

  // Login Details
  final String loginByAdminPhone;
  final String loginByAdminPassword;
  final String loginByOwnerPhone;
  final String loginByOwnerPassword;
  final String loginByMemberPhone;
  final String loginByMemberPassword;

  // Feature Flags & Details
  final bool isAddFriend;
  final String addFriendDetail;
  final String whoAssignToAdmin;
  final bool isCreateGroup;
  final String groupName;
  final String addMemberDetail;
  final bool isEditGroupName;
  final String newGroupName;
  final bool isChangeGroupPicture;
  final bool isChoosePictureFromDevice;

  // Expectations
  final bool expectedIsLoginByOwner;
  final bool expectedIsLoginByAdmin;
  final bool expectedIsLoginByMember;
  final String expectedNavigatePage;
  final bool isExpectedSuccess;
  final String expectedMessage;

  // Registration Data Lists
  final List<String> regPhones;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  GroupInfoManagementTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = null,
        loginByAdminPhone = row['login_by_admin_phone_number'] ?? '',
        loginByAdminPassword = row['login_by_admin_password'] ?? '',
        loginByOwnerPhone = row['login_by_owner_phone_number'] ?? '',
        loginByOwnerPassword = row['login_by_owner_password'] ?? '',
        loginByMemberPhone = row['login_by_member_phone_number'] ?? '',
        loginByMemberPassword = row['login_by_member_password'] ?? '',
        isAddFriend = CommonUtil.convertStringToBoolean(row['is_add_friend']),
        addFriendDetail = row['add_friend_detail'] ?? '',
        whoAssignToAdmin = row['who_assign_to_admin'] ?? '',
        isCreateGroup = CommonUtil.convertStringToBoolean(row['is_create_group']),
        groupName = row['group_name'] ?? '',
        addMemberDetail = row['add_member_detail'] ?? '',
        isEditGroupName = CommonUtil.convertStringToBoolean(row['is_edit_group_name']),
        newGroupName = row['new_group_name'] ?? '',
        isChangeGroupPicture = CommonUtil.convertStringToBoolean(row['is_change_group_picture']),
        isChoosePictureFromDevice = CommonUtil.convertStringToBoolean(row['is_choose_picture_from_device']),
        expectedIsLoginByOwner = CommonUtil.convertStringToBoolean(row['expected_is_login_by_owner']),
        expectedIsLoginByAdmin = CommonUtil.convertStringToBoolean(row['expected_is_login_by_admin']),
        expectedIsLoginByMember = CommonUtil.convertStringToBoolean(row['expected_is_login_by_member']),
        expectedNavigatePage = row['expected_navigate_page'] ?? '',
        isExpectedSuccess = CommonUtil.convertStringToBoolean(row['expected_result']),
        expectedMessage = row['expected_message'] ?? '',
        regPhones = row['register_phone_number']?.split('|') ?? [],
        regNames = row['register_profile_name']?.split('|') ?? [],
        regPasswords = row['register_password']?.split('|') ?? [],
        regUchatIds = row['register_uchat_id']?.split('|') ?? [];

  String getVal(List<String> list, int index) {
    if (list.isEmpty) return "";
    return index >= list.length ? list.last : list[index];
  }
}

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
// import '../../steps/account/user_setting.step.dart';

// import '../../workflows/ui/ui_delete_account.workflow.dart';

// class GroupInfoManagementStep {
//   Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
//     var groupInfoManagementMap = Map<String, dynamic>();
//     groupInfoManagementMap['isDeleteAfterRun'] = CommonUtil.convertStringToBoolean(dataRow['is_delete_after_run']);
//     groupInfoManagementMap['isRegister'] = CommonUtil.convertStringToBoolean(dataRow['is_register']);
//     groupInfoManagementMap['isLoginByPhone'] = CommonUtil.convertStringToBoolean(dataRow['is_login_by_phone']);
//     groupInfoManagementMap['loginByAdminPhoneNumber'] = dataRow['login_by_admin_phone_number'];
//     groupInfoManagementMap['loginByAdminPassword'] = dataRow['login_by_admin_password'];
//     groupInfoManagementMap['loginByOwnerPhoneNumber'] = dataRow['login_by_owner_phone_number'];
//     groupInfoManagementMap['loginByOwnerPassword'] = dataRow['login_by_owner_password'];
//     groupInfoManagementMap['loginByMemberPhoneNumber'] = dataRow['login_by_member_phone_number'];
//     groupInfoManagementMap['loginByMemberPassword'] = dataRow['login_by_member_password'];
//     groupInfoManagementMap['isAddFriend'] = CommonUtil.convertStringToBoolean(dataRow['is_add_friend']);
//     groupInfoManagementMap['addFriendDetail'] = dataRow['add_friend_detail'];
//     groupInfoManagementMap['isCreateGroup'] = CommonUtil.convertStringToBoolean(dataRow['is_create_group']);
//     groupInfoManagementMap['groupName'] = dataRow['group_name'];
//     groupInfoManagementMap['addMemberDetail'] = dataRow['add_member_detail'];
//     groupInfoManagementMap['adminMessageList'] = dataRow['admin_message_list'];
//     groupInfoManagementMap['ownerMessageList'] = dataRow['owner_message_list'];
//     groupInfoManagementMap['memberMessageList'] = dataRow['member_message_list'];
//     groupInfoManagementMap['isEditGroupName'] = CommonUtil.convertStringToBoolean(dataRow['is_edit_group_name']);
//     groupInfoManagementMap['newGroupName'] = dataRow['new_group_name'];
//     groupInfoManagementMap['isChangeGroupPicture'] = CommonUtil.convertStringToBoolean(
//       dataRow['is_change_group_picture'],
//     );
//     groupInfoManagementMap['isChoosePictureFromDevice'] = CommonUtil.convertStringToBoolean(
//       dataRow['is_choose_picture_from_device'],
//     );
//     groupInfoManagementMap['expectedNavigatePage'] = dataRow['expected_navigate_page'];
//     groupInfoManagementMap['expectedResult'] = CommonUtil.convertStringToBoolean(dataRow['expected_result']);
//     groupInfoManagementMap['expectedMessage'] = dataRow['expected_message'];
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
//       if (groupInfoManagementMap['isRegister']) {
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
//         //   currentSessionMap['isLoginByPhone'] = groupInfoManagementMap['isLoginByPhone'];
//         //   currentSessionMap['expectedNavigatePage'] = groupInfoManagementMap['expectedNavigatePage'];
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
//       await loginPage.proceedLogin($, findDbUtil, groupInfoManagementMap);
//       if (groupInfoManagementMap['isAddFriend']) {
//         final List<String> dataSetList = groupInfoManagementMap['addFriendDetail'].split(',');
//         for (final dataSet in dataSetList) {
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
//       if (groupInfoManagementMap['isCreateGroup']) {
//         final createGroupSvgFinder = find.byWidgetPredicate((Widget widget) {
//           if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//             final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//             return loader.assetName == 'assets/vectors/icon_create_group.svg';
//           }
//           return false;
//         });
//         await CommonUtil.tapButton($, targetNameButton: createGroupSvgFinder);
//         await $.pumpAndSettle();

//         List<String> members = groupInfoManagementMap['addMemberDetail'].split('|');
//         for (var member in members) {
//           final friendNameFinder = find.textContaining(member);
//           await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
//         }
//         await CommonUtil.tapButton($, targetNameButton: 'Next');
//         await $.pumpAndSettle();
//         final groupName = groupInfoManagementMap['groupName'];
//         await CommonUtil.fillTextInput($, targetNameInput: 'Enter your group name', text: groupName);
//         await CommonUtil.tapButton($, targetNameButton: 'Create');
//         await $.pumpAndSettle();
//         await $(find.textContaining(groupName)).waitUntilExists();
//         final backSvgFinder = find.byWidgetPredicate((Widget widget) {
//           if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//             final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//             return loader.assetName == 'assets/vectors/icon_arrow_app_bar.svg';
//           }
//           return false;
//         });
//         await CommonUtil.tapButton($, targetNameButton: backSvgFinder);
//         await $.pumpAndSettle();
//       }

//       // Edit group name
//       if (groupInfoManagementMap['isEditGroupName']) {
//         await CommonUtil.tapButton($, targetNameButton: 'Edit Group Name');
//         await $.pumpAndSettle();
//         await CommonUtil.fillTextInput(
//           $,
//           targetNameInput: 'Enter your name',
//           text: groupInfoManagementMap['newGroupName'],
//         );
//         await CommonUtil.tapButton($, targetNameButton: 'Done');
//         await $.pumpAndSettle();
//         await CommonUtil.tapButton($, targetNameButton: 'Back');
//         await $(find.textContaining(groupInfoManagementMap['newGroupName'])).waitUntilExists();
//       }

//       //Change profile picture
//       if (groupInfoManagementMap['isChangeGroupPicture']) {
//         await $(ExtendedImage).waitUntilVisible();
//         final ExtendedImage oldWidget = $.tester.widget(find.byType(ExtendedImage).first);
//         final oldImageProvider = oldWidget.image;
//         print('Old Image: $oldImageProvider');
//         final cameraIconSvgFinder = find.byWidgetPredicate((Widget widget) {
//           if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//             final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//             return loader.assetName == 'assets/vectors/icon_camera.svg';
//           }
//           return false;
//         });
//         await CommonUtil.tapButton($, targetNameButton: cameraIconSvgFinder);
//         await $.pumpAndSettle();
//         if (!groupInfoManagementMap['isChoosePictureFromDevice']) {
//           await $(ExtendedImage).waitUntilVisible();
//           final imageWidgets = $.tester.widgetList(find.byType(ExtendedImage));
//           final count = imageWidgets.length;
//           print('Found $count images in grid. Selecting one randomly...');
//           if (count > 0) {
//             final randomIndex = Random().nextInt(count);
//             await $(ExtendedImage).at(randomIndex).tap();
//             print('Tapped image at index: $randomIndex');
//           } else {
//             print('Error: No ExtendedImage widgets found to select.');
//           }
//           await $.pumpAndSettle();
//           final ExtendedImage newWidget = $.tester.widget(find.byType(ExtendedImage).first);
//           final newImageProvider = newWidget.image;
//           print('New Image: $newImageProvider');
//           expect(oldImageProvider, isNot(equals(newImageProvider)));
//           print('SUCCESS: Profile picture has been changed!');
//           final cameraIconSvgFinder = find.byWidgetPredicate((Widget widget) {
//             if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//               final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//               return loader.assetName == 'assets/vectors/icon_camera.svg';
//             }
//             return false;
//           });
//           await CommonUtil.tapButton($, targetNameButton: cameraIconSvgFinder);
//           await $.pumpAndSettle();
//         } else {
//           await CommonUtil.tapButton($, targetNameButton: 'Choose from Library');
//           final pictureSvgFinder = find.byWidgetPredicate((Widget widget) {
//             if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//               final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//               return loader.assetName == 'assets/vectors/photo_outlined.svg';
//             }
//             return false;
//           });
//           expect(pictureSvgFinder, findsOneWidget);
//           await CommonUtil.tapButton($, targetNameButton: pictureSvgFinder);

//           final bool isButtonVisible = await $('Continue').visible;
//           if (isButtonVisible) {
//             await CommonUtil.tapButton($, targetNameButton: 'Continue');
//           }
//           bool isRequestPermission = await $.native.isPermissionDialogVisible();
//           if (isRequestPermission) {
//             await $.native.tap(Selector(text: 'Allow all'));
//           }
//           await $.pumpAndSettle();
//           final targetTextNavBarFinder = find.descendant(
//             of: find.byType(MediaGallery),
//             matching: find.byType(ExtendedImage),
//           );
//           await CommonUtil.tapButton($, targetNameButton: targetTextNavBarFinder);
//           await Future.delayed(const Duration(seconds: 3));
//           print('Attempting to tap Native Crop button...');
//           try {
//             await $.native.tap(Selector(resourceId: 'com.yalantis.ucrop.ucrop:id/menu_crop'));
//           } catch (e) {
//             print('First attempt failed, trying alternative ID...');
//             await $.native.tap(Selector(resourceId: 'menu_crop'));
//           }
//           try {
//             print('Trying to tap by text "Crop"...');
//             await $.native.tap(Selector(text: 'Crop'));
//           } catch (e1) {
//             // ถ้าไม่เจอ ลองหาจาก Content Description
//             try {
//               print('Trying to tap by contentDescription "Crop"...');
//               await $.native.tap(Selector(contentDescription: 'Crop'));
//             } catch (e2) {
//               // ถ้าไม่เจอ ลองคำว่า Done
//               print('Trying to tap by text "Done"...');
//               await $.native.tap(Selector(text: 'Done'));
//             }
//           }
//           await $.pumpAndSettle();

//           final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
//             if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
//               final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
//               return loader.assetName == 'assets/vectors/send.svg';
//             }
//             return false;
//           });
//           expect(sendSvgFinder, findsOneWidget);
//           await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);
//           await $.pumpAndSettle();
//         }
//       }
//       dataRow['actual_result'] = 'PASSED';
//     } catch (e, stackTrace) {
//       print('---error---${stackTrace}');
//       dataRow['actual_result'] = 'FAILED';
//     } finally {
//       if (groupInfoManagementMap['isDeleteAfterRun']) {
//         //await uiDeleteAccountWorkflow.proceedDeleteAccount($, groupInfoManagementMap['password']);
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
