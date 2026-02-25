import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:uchat/core/infrastructure/app/app.dart';
import 'package:uchat/core/infrastructure/orchestrator/orchestrator.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';
import 'package:uchat/core/domain/services/app_version_service.dart';
// import 'package:uchat/features/profile/presentation/views/screens/mobile/my_profile_screen.dart';
// import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/contact/data/data_source/local/contact_db.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_subscription_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_file_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_folder/domain/repositories/chat_folder_local_repository.dart';
import 'package:uchat/features/auth/domain/repositories/social_auth_provider_repository.dart';
import 'package:uchat/features/sync/domain/repositories/firebase_realtime_database_repository.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_remote_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/sticker_search_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/features/sync/domain/services/sync_service.dart';
//import 'package:uchat/features/auth/domain/use_cases/update_is_master_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/register_use_case.dart';
// import 'package:uchat/core/domain/entities/user_entity.dart';
// import 'package:uchat/features/auth/data/models/requests/auth_register_request.dart';
// import 'package:uchat/core/infrastructure/orchestrator/tasks/singleton_dependencies.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:patrol/patrol.dart';
import 'package:html/parser.dart' show parse;
import 'package:crypto/crypto.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
//import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mocktail/mocktail.dart';

import 'mongodb/find_db.util.dart';

import 'package:uchat/core/presentation/widgets/button/passcode_num_pad.dart';

class MockLoggerService extends Mock implements LoggerService {}

class MockPerformanceService extends Mock implements PerformanceService {}

class MockTaxonomyService extends Mock implements TaxonomyService {}

class MockNativeMethodChannelService extends Mock implements NativeMethodChannelService {}

class MockAppVersionService extends Mock implements AppVersionService {}

class MockSyncService extends Mock implements SyncService {}

class MockRoomDb extends Mock implements RoomDb {}

class MockRoomMemberDb extends Mock implements RoomMemberDb {}

class MockContactDb extends Mock implements ContactDb {}

class MockRoomSubscriptionDb extends Mock implements RoomSubscriptionDb {}

class MockRoomFileDb extends Mock implements RoomFileDb {}

class MockSocialAuthProviderRepository extends Mock implements SocialAuthProviderRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class MockChatRoomLocalCompatRepository extends Mock implements ChatRoomLocalCompatRepository {}

class MockChatFolderLocalRepository extends Mock implements ChatFolderLocalRepository {}

class MockRoomSubscriptionLocalRepository extends Mock implements RoomSubscriptionLocalRepository {}

class MockRoomFileLocalRepository extends Mock implements RoomFileLocalRepository {}

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class MockRoomMemberLocalRepository extends Mock implements RoomMemberLocalRepository {}

class MockFirebaseRealtimeDatabaseRepository extends Mock implements FirebaseRealtimeDatabaseRepository {}

class MockPinMessageLocalRepository extends Mock implements PinMessageLocalRepository {}

class MockProfileServerRepository extends Mock implements ProfileServerRepository {}

class MockProfileLocalRepository extends Mock implements ProfileLocalRepository {}

class MockMyStickerLocalRepository extends Mock implements MyStickerLocalRepository {}

class MockMyStickerRemoteRepository extends Mock implements MyStickerRemoteRepository {}

class MockStoreStickerLocalRepository extends Mock implements StoreStickerLocalRepository {}

class MockStoreStickerRemoteRepository extends Mock implements StoreStickerRemoteRepository {}

class MockStickerSearchLocalRepository extends Mock implements StickerSearchLocalRepository {}

//class MockUpdateIsMasterUseCase extends Mock implements UpdateIsMasterUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

//class MockUserEntity extends Mock implements UserEntity {}

class CommonUtil {
  static Future<void> openApplication($) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      DartPluginRegistrant.ensureInitialized();
      await Orchestrator.run(OrchestratorTaskType.initializeApp);
      await App.initialize();
      await $.pumpWidget(App.buildApp());
      if (Platform.isAndroid) {
        //await $.native.grantPermissionWhenInUse();
      }
      await Orchestrator.run(OrchestratorTaskType.launchApp);
      //await $.pumpAndSettle();
    } catch (e, stackTrace) {
      // 🛑 Catch Error Here
      debugPrint('❌ ERROR during createMockLoggerService Setup:');
      debugPrint('---------------------------------------------------');
      debugPrint('Error: $e');
      debugPrint('---------------------------------------------------');
      debugPrint('StackTrace: $stackTrace');
      debugPrint('---------------------------------------------------');
      rethrow;
    }
  }

  static Future<void> createMockLoggerService() async {
    late MockLoggerService mockLogger;
    late MockPerformanceService mockPerformanceService;
    late MockTaxonomyService mockTaxonomyService;
    late MockNativeMethodChannelService mockNativeMethodChannelService;
    late MockAppVersionService mockAppVersionService;
    late MockSyncService mockSyncService;
    late MockRoomDb mockRoomDb;
    late MockRoomMemberDb mockRoomMemberDb;
    late MockContactDb mockContactDb;
    late MockRoomSubscriptionDb mockRoomSubscriptionDb;
    late MockRoomFileDb mockRoomFileDb;
    late MockSocialAuthProviderRepository mockSocialAuthProviderRepository;
    late MockChatRoomLocalCompatRepository mockChatRoomLocalCompatRepository;
    late MockChatRoomLocalRepository mockChatRoomLocalRepository;
    late MockChatFolderLocalRepository mockChatFolderLocalRepository;
    late MockRoomSubscriptionLocalRepository mockRoomSubscriptionLocalRepository;
    late MockRoomFileLocalRepository mockRoomFileLocalRepository;
    late MockMessageLocalRepository mockMessageLocalRepository;
    late MockRoomMemberLocalRepository mockRoomMemberLocalRepository;
    late MockFirebaseRealtimeDatabaseRepository mockFirebaseRealtimeDatabaseRepository;
    late MockPinMessageLocalRepository mockPinMessageLocalRepository;
    late MockProfileServerRepository mockProfileServerRepository;
    late MockProfileLocalRepository mockProfileLocalRepository;
    late MockMyStickerLocalRepository mockMyStickerLocalRepository;
    late MockMyStickerRemoteRepository mockMyStickerRemoteRepository;
    late MockStoreStickerLocalRepository mockStoreStickerLocalRepository;
    late MockStoreStickerRemoteRepository mockStoreStickerRemoteRepository;
    late MockStickerSearchLocalRepository mockStickerSearchLocalRepository;
    //late MockUpdateIsMasterUseCase mockUpdateIsMasterUseCase;
    late MockRegisterUseCase mockRegisterUseCase;
    //late MockUserEntity mockUserEntity;
    mockTaxonomyService = MockTaxonomyService();
    mockNativeMethodChannelService = MockNativeMethodChannelService();
    mockAppVersionService = MockAppVersionService();
    mockSyncService = MockSyncService();
    mockSocialAuthProviderRepository = MockSocialAuthProviderRepository();
    mockChatRoomLocalCompatRepository = MockChatRoomLocalCompatRepository();
    mockChatRoomLocalRepository = MockChatRoomLocalRepository();
    mockChatFolderLocalRepository = MockChatFolderLocalRepository();
    mockRoomSubscriptionLocalRepository = MockRoomSubscriptionLocalRepository();
    mockRoomFileLocalRepository = MockRoomFileLocalRepository();
    mockMessageLocalRepository = MockMessageLocalRepository();
    mockRoomMemberLocalRepository = MockRoomMemberLocalRepository();
    mockFirebaseRealtimeDatabaseRepository = MockFirebaseRealtimeDatabaseRepository();
    mockPinMessageLocalRepository = MockPinMessageLocalRepository();
    mockProfileServerRepository = MockProfileServerRepository();
    mockProfileLocalRepository = MockProfileLocalRepository();
    mockMyStickerLocalRepository = MockMyStickerLocalRepository();
    mockMyStickerRemoteRepository = MockMyStickerRemoteRepository();
    mockStoreStickerLocalRepository = MockStoreStickerLocalRepository();
    mockStoreStickerRemoteRepository = MockStoreStickerRemoteRepository();
    mockStickerSearchLocalRepository = MockStickerSearchLocalRepository();
    //mockUpdateIsMasterUseCase = MockUpdateIsMasterUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    //mockUserEntity = MockUserEntity();
    final getIt = GetIt.instance;
    getIt.allowReassignment = true;
    await Firebase.initializeApp();
    getIt.registerLazySingleton<LoggerService>(() => LoggerService());
    getIt.registerLazySingleton<PerformanceService>(() => PerformanceService());
    getIt.registerLazySingleton<RoomDb>(() => RoomDb());
    getIt.registerLazySingleton<RoomMemberDb>(() => RoomMemberDb());
    getIt.registerLazySingleton<ContactDb>(() => ContactDb());
    getIt.registerLazySingleton<RoomSubscriptionDb>(() => RoomSubscriptionDb());
    getIt.registerLazySingleton<RoomFileDb>(() => RoomFileDb());
    // getIt.registerSingleton<TaxonomyService>(mockTaxonomyService);
    // getIt.registerSingleton<NativeMethodChannelService>(mockNativeMethodChannelService);
    // getIt.registerSingleton<AppVersionService>(mockAppVersionService);
    // getIt.registerSingleton<SyncService>(mockSyncService);
    // getIt.registerSingleton<SocialAuthProviderRepository>(mockSocialAuthProviderRepository);
    // getIt.registerSingleton<ChatRoomLocalCompatRepository>(mockChatRoomLocalCompatRepository);
    // getIt.registerSingleton<ChatRoomLocalRepository>(mockChatRoomLocalRepository);
    // getIt.registerSingleton<ChatFolderLocalRepository>(mockChatFolderLocalRepository);
    // getIt.registerSingleton<RoomSubscriptionLocalRepository>(mockRoomSubscriptionLocalRepository);
    // getIt.registerSingleton<RoomFileLocalRepository>(mockRoomFileLocalRepository);
    // getIt.registerSingleton<MessageLocalRepository>(mockMessageLocalRepository);
    // getIt.registerSingleton<RoomMemberLocalRepository>(mockRoomMemberLocalRepository);
    // getIt.registerSingleton<FirebaseRealtimeDatabaseRepository>(mockFirebaseRealtimeDatabaseRepository);
    // getIt.registerSingleton<PinMessageLocalRepository>(mockPinMessageLocalRepository);
    // getIt.registerSingleton<ProfileServerRepository>(mockProfileServerRepository);
    // getIt.registerSingleton<ProfileLocalRepository>(mockProfileLocalRepository);
    // getIt.registerSingleton<MyStickerLocalRepository>(mockMyStickerLocalRepository);
    // getIt.registerSingleton<MyStickerRemoteRepository>(mockMyStickerRemoteRepository);
    // getIt.registerSingleton<StoreStickerLocalRepository>(mockStoreStickerLocalRepository);
    // getIt.registerSingleton<StoreStickerRemoteRepository>(mockStoreStickerRemoteRepository);
    // getIt.registerSingleton<StickerSearchLocalRepository>(mockStickerSearchLocalRepository);
    // getIt.registerSingleton<UpdateIsMasterUseCase>(mockUpdateIsMasterUseCase);
    // getIt.registerSingleton<RegisterUseCase>(mockRegisterUseCase);

    //getIt.registerSingleton<UserEntity>(mockUserEntity);
    //final fakeUserEntity = UserEntity(id: "test_user_id", username: "TestUser", token: "");
    //final fakeAuthResponse = AuthRegisterResponse(id: "test_user_id", username: "TestUser", token: "fake_token_1234");
    //when(() => mockUpdateIsMasterUseCase.call(any())).thenAnswer((_) async => fakeUserEntity);
    //when(() => mockRegisterUseCase.call(any())).thenAnswer((_) async => fakeAuthResponse);
    //Get.put(UChatCallController());
  }

  // static Future<void> createMockLoggerService() async {
  //   try {
  //     debugPrint('🚀 Starting Setup: createMockLoggerService...');
  //     final getIt = GetIt.instance;
  //     getIt.allowReassignment = true;

  //     // 1. Init Firebase
  //     debugPrint('🔥 Initializing Firebase...');
  //     await Firebase.initializeApp();

  //     // 2. Register Core Services (Logger/Perf)
  //     debugPrint('📦 Registering Logger & Performance Service...');
  //     getIt.registerLazySingleton<LoggerService>(() => LoggerService());
  //     getIt.registerLazySingleton<PerformanceService>(() => PerformanceService());

  //     // 3. Load App Singletons (Async)
  //     debugPrint('⚙️ Running initSingletons()...');
  //     await registerSingletonDependencies();

  //     // 5. Override with specific Mocks
  //     debugPrint('🎭 Registering specific Mocks...');
  //     getIt.registerSingleton<AppVersionService>(MockAppVersionService());
  //     getIt.registerSingleton<NativeMethodChannelService>(MockNativeMethodChannelService());

  //     // 6. Setup GetX Controllers
  //     debugPrint('🎮 Setting up GetX Controllers...');
  //     Get.put(UChatCallController());

  //     debugPrint('✅ Setup Completed Successfully!');
  //   } catch (e, stackTrace) {
  //     // 🛑 Catch Error Here
  //     debugPrint('❌ ERROR during createMockLoggerService Setup:');
  //     debugPrint('---------------------------------------------------');
  //     debugPrint('Error: $e');
  //     debugPrint('---------------------------------------------------');
  //     debugPrint('StackTrace: $stackTrace');
  //     debugPrint('---------------------------------------------------');
  //     rethrow;
  //   }
  // }

  static Future<String> convertNationalToE164(String nationalNumber, IsoCode defaultRegion) async {
    try {
      final phoneNumber = PhoneNumber.parse(nationalNumber, destinationCountry: defaultRegion);
      if (phoneNumber.isValid()) {
        return phoneNumber.international;
      } else {
        return '';
      }
    } catch (e) {
      debugPrint('Error parsing national number: $e');
      return '';
    }
  }

  static Future<String> convertE164ToNational(String internationalNumber) async {
    try {
      final phoneNumber = PhoneNumber.parse(internationalNumber);
      if (phoneNumber.isValid()) {
        final formattedNational = phoneNumber.formatNsn();
        return formattedNational.replaceAll(' ', '');
      } else {
        return '';
      }
    } catch (e) {
      debugPrint('Error parsing E.164 number: $e');
      return '';
    }
  }

  static Future<void> tapButton($, {required targetNameButton}) async {
    await $(targetNameButton).tap();
  }

  static Future<void> tapButtonLongPressV1($, {required targetNameButton}) async {
    await $(targetNameButton).longPress();
  }

  static Future<void> tapButtonLongPressV2($, {required targetNameButton}) async {
    final Offset bubbleLocation = $.tester.getCenter(targetNameButton);
    final gesture = await $.tester.startGesture(bubbleLocation);
    await $.pump(kLongPressTimeout + const Duration(seconds: 1));
    await gesture.moveBy(const Offset(5, 0));
    await $.pump(const Duration(seconds: 1));
    await gesture.up();
    //await $.pumpAndSettle();
  }

  static Future<void> tapIconBack($) async {
    final backSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/icon_arrow_app_bar.svg';
      }
      return false;
    });
    await CommonUtil.tapButton($, targetNameButton: backSvgFinder);
    //await $.pumpAndSettle();
  }

  static Future<void> tapIconSendMessage($) async {
    final sendSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/send.svg';
      }
      return false;
    });

    expect(sendSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: sendSvgFinder);
    //await $.pumpAndSettle();
  }

  static Future<void> tapIconCheckboxSelected($) async {
    final checkboxSelectedSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/check_box_selected.svg';
      }
      return false;
    });

    expect(checkboxSelectedSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: checkboxSelectedSvgFinder);
    //await $.pumpAndSettle();
  }

  static Future<void> tapIconHambergerBar($) async {
    final hambergerBarSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/icon_hamberger_bar.svg';
      }
      return false;
    });

    expect(hambergerBarSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: hambergerBarSvgFinder);
    //await $.pumpAndSettle();
  }

  static Future<void> tapIconClose($) async {
    final closeSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/x_close.svg';
      }
      return false;
    });

    expect(closeSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: closeSvgFinder);
    //await $.pumpAndSettle();
  }

  static Future<void> tapIconQrcode($) async {
    final qrcodeSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/qr_code.svg';
      }
      return false;
    });

    expect(qrcodeSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: qrcodeSvgFinder);
    //await $.pumpAndSettle();
  }

  static Future<void> tapIconPinned($) async {
    final iconPinnedSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/icon_pinned.svg';
      }
      return false;
    });

    expect(iconPinnedSvgFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: iconPinnedSvgFinder);
    //await $.pumpAndSettle();
  }

  static Future<void> tapCreateNewGroup($) async {
    final createGroupSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/icon_create_group.svg';
      }
      return false;
    });
    await CommonUtil.tapButton($, targetNameButton: createGroupSvgFinder);
  }

  static Future<void> tapToggleButton($, {required targetNameFinder}) async {
    final toggleButtonFinder = $(targetNameFinder).$(find.byType(CupertinoSwitch));
    expect(toggleButtonFinder, findsOneWidget);
    await CommonUtil.tapButton($, targetNameButton: toggleButtonFinder);
  }

  static Future<void> tapPasscode($, {required dynamic targetPasscode}) async {
    String passcodeString = targetPasscode.toString();
    for (var digit in passcodeString.split('')) {
      var passcodeNumPadFinder = $(PasscodeNumPad).$(find.text(digit));
      await CommonUtil.tapButton($, targetNameButton: passcodeNumPadFinder);
    }
  }

  static Future<void> fillTextInput($, {required String targetNameInput, required String text}) async {
    final parentFinder = find.ancestor(of: find.text(targetNameInput), matching: find.byType(Column));
    final textFieldFinder = find.descendant(of: parentFinder, matching: find.byType(TextField));
    //expect($(targetNameInput), findsOneWidget);
    await $(textFieldFinder).enterText(text);
  }

  static Future<void> fillOtp($, {required targetNameType, required String text}) async {
    await $.tester.enterText(find.byType(targetNameType), text);
  }

  static Future<void> fillDateOfBirth($, {required String targetDobInput}) async {
    DateTime parsedDate = DateFormat('d MMM yyyy').parse(targetDobInput);
    final targetDay = DateFormat('d').format(parsedDate);
    final targetMonth = DateFormat('MMMM').format(parsedDate);
    final targetYear = DateFormat('yyyy').format(parsedDate);
    await $(find.text('Date of Birth')).tap();
    await $(find.byType(CupertinoDatePicker)).waitUntilVisible();
    await CommonUtil.spinYear($, targetYear);
    await CommonUtil.spinWheel($, 1, targetMonth);
    await CommonUtil.spinWheel($, 0, targetDay);
    await $(find.text('Done')).tap();
  }

  static Future<void> spinYear($, String targetYear) async {
    final int targetYearInt = int.parse(targetYear);
    final yearWheelFinder = find.byType(ListWheelScrollView).at(2);
    bool scrollDown = false;
    try {
      final finder = find
          .descendant(
            of: find.byType(CupertinoDatePicker),
            matching: find.byWidgetPredicate((widget) {
              if (widget is Text && widget.data != null) {
                return RegExp(r'^\d{4}$').hasMatch(widget.data!);
              }
              return false;
            }),
          )
          .first;
      if (await $(finder).exists) {
        final String currentYearStr = ($.tester.widget(finder) as Text).data!;
        final int currentYearInt = int.parse(currentYearStr);
        debugPrint('Current Year on screen: $currentYearInt, Target: $targetYearInt');
        if (targetYearInt < currentYearInt) {
          scrollDown = true;
        } else {
          scrollDown = false;
        }
      }
    } catch (e) {
      debugPrint('Could not detect current year, using default direction.');
    }
    double dragStep = scrollDown ? 400.0 : -400.0;
    int maxScrolls = 30;
    int scrolls = 0;
    debugPrint('Spinning Year to $targetYear (Fast Mode)...');
    while (scrolls < maxScrolls) {
      if (await $(find.text(targetYear)).exists) {
        await $(find.text(targetYear)).tap();
        //await $.pumpAndSettle();
        await $.pump();
        debugPrint('Found & Selected Year $targetYear!');
        return;
      }
      await $.tester.drag(yearWheelFinder, Offset(0, dragStep));
      await $.tester.pump(const Duration(milliseconds: 100));
      scrolls++;
    }
    debugPrint('Target not found in primary direction. Switching direction...');
    scrolls = 0;
    dragStep = -dragStep;
    while (scrolls < maxScrolls) {
      if (await $(find.text(targetYear)).exists) {
        await $(find.text(targetYear)).tap();
        //await $.pumpAndSettle();
        await $.pump();
        debugPrint('Found & Selected Year $targetYear (Reverse)!');
        return;
      }
      await $.tester.drag(yearWheelFinder, Offset(0, dragStep));
      await $.tester.pump(const Duration(milliseconds: 100));
      scrolls++;
    }
    debugPrint('Error: Could not find year $targetYear');
  }

  static Future<void> spinWheel($, int index, String text, {bool scrollDown = false}) async {
    final wheelFinder = find.byType(ListWheelScrollView).at(index);
    final double dragStep = scrollDown ? 32.0 : -32.0;
    int maxScrolls = 60;
    int scrolls = 0;
    debugPrint('Spinning wheel $index looking for "$text"...');
    while (scrolls < maxScrolls) {
      final itemFinder = find.text(text).hitTestable();
      final isFound = await $(itemFinder).exists;
      if (isFound) {
        await $(itemFinder).tap();
        //await $.pumpAndSettle();
        await $.pump();
        debugPrint('Selected "$text"');
        return;
      }
      await $.tester.drag(wheelFinder, Offset(0, dragStep));
      //await $.pumpAndSettle();
      await $.pump();
      scrolls++;
    }
    debugPrint('Warning: Could not find "$text" after $maxScrolls scrolls.');
  }

  static Future<void> tapNavigationBarWith($, name) async {
    final parentButtonNavigationBarFinder = find.byType(BottomNavigationBar);
    var targetTextNavBarFinder;
    if (Platform.isAndroid) {
      targetTextNavBarFinder = find.descendant(of: parentButtonNavigationBarFinder, matching: find.text(name));
    } else {
      targetTextNavBarFinder = find.descendant(of: find.byType(RotatedBox), matching: find.text(name));
    }
    final targetButtonFinder = find.ancestor(of: targetTextNavBarFinder, matching: find.byType(Column));
    await CommonUtil.tapButton($, targetNameButton: targetButtonFinder);
    //await $.pumpAndSettle();
  }

  static Future<void> dragLeft($, nameFinder) async {
    await $.tester.drag(nameFinder, const Offset(-300, 0));
  }

  static Future<String> extractOtpTextFromDb(bool isPhone, otpData) async {
    final otpMessage = otpData?['message'];
    debugPrint('---otpMessage---${otpMessage}');
    String otpOutput = '';
    if (isPhone) {
      RegExp regex = RegExp(r'\d{6}');
      Match? match = regex.firstMatch(otpMessage);
      otpOutput = (match != null) ? (match[0] ?? '') : '';
    } else {
      var document = parse(otpMessage);
      var h2Element = document.querySelector('h2');
      if (h2Element != null) {
        String rawText = h2Element.text;
        List<String> parts = rawText.trim().split(' ');
        if (parts.isNotEmpty) {
          otpOutput = parts[0];
        }
      }
    }
    return otpOutput;
  }

  static Future<void> getOtpTextFromDb($, FindDbUtil findDbUtil, String phoneNo) async {
    //await tapButton($, targetNameButton: 'Get OTP');
    final isGodMode = await $('Ref: GOD MODE').exists;
    String otpNo = '999999';
    if (!isGodMode) {
      otpNo = await findDbUtil.getOtpByPhone(phoneNo, isGetLatest: true);
    }
    await CommonUtil.fillOtp($, targetNameType: PinCodeTextField, text: otpNo);
    //await $.pumpAndSettle();
    await $.pump(const Duration(seconds: 2));
  }

  static Future<String> getActualDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    String osVersion = 'Unknown';
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      osVersion = 'Android ${androidInfo.version.release}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      osVersion = 'iOS ${iosInfo.systemVersion}';
    }
    return osVersion;
  }

  static Future<dynamic> getActualCurrentAppVersion() async {
    return await PackageInfo.fromPlatform();
  }

  static String hashPassword(String password, salt) {
    final key = utf8.encode(salt);
    final bytes = utf8.encode(password);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);
    return digest.toString();
  }

  static bool convertStringToBoolean(String? text) {
    final Set<String> trueValues = {'true', 'yes', 'success', 'ok', '1'};
    if (text == null || text.isEmpty) {
      return false;
    }
    final bool isTrue = trueValues.contains(text.toLowerCase());
    return isTrue;
  }

  static int convertStringToInt(String? text) {
    if (text == null || text.isEmpty) {
      return 0;
    }
    String cleanText = text.replaceAll(',', '').trim();
    return int.tryParse(cleanText) ?? 0;
  }

  static String generateTextString(int length, String text) {
    if (length <= 0) return '';
    var buffer = StringBuffer();
    try {
      buffer.write(text * length);
    } catch (e) {
      debugPrint('Error generating string (maybe out of memory?): $e');
      return 'Error';
    }
    return buffer.toString();
  }
}
