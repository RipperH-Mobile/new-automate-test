import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/entities/enum/room_member_role.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/features/contact/contact_barrel.dart';
import 'package:uchat/features/setting/domain/use_cases/generate_data_for_stress_test_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets/loading/loading.dart';
import 'package:uuid/uuid.dart';

// Mocks
class MockLoggerService extends Mock implements LoggerService {}

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class MockRoomMemberLocalRepository extends Mock implements RoomMemberLocalRepository {}

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class MockContactsController extends Mock implements ContactsController {}

class MockMessageService extends Mock implements MessageService {}

class MockUChatLoadingTestMode extends Mock implements IUChatLoading {}

// Fakes
class FakeContactEntity extends Fake implements ContactEntity {}

class FakeRoomEntity extends Fake implements RoomEntity {}

class FakeRoomMemberEntity extends Fake implements RoomMemberEntity {}

class FakeRoomSubscriptionEntity extends Fake implements RoomSubscriptionEntity {}

class FakeMessageEntity extends Fake implements MessageEntity {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up test mode for UChatLoading to avoid EasyLoading initialization issues
  setUpAll(() {
    final mockTestMode = MockUChatLoadingTestMode();

    // Stub all UChatLoading methods to avoid EasyLoading issues in tests
    when(() => mockTestMode.showProgress(any(), message: any(named: 'message'), markType: any(named: 'markType')))
        .thenAnswer((_) async {});
    when(() => mockTestMode.show(status: any(named: 'status'))).thenAnswer((_) async {});
    when(() => mockTestMode.hide()).thenAnswer((_) async {});
    when(() => mockTestMode.failed(message: any(named: 'message'))).thenAnswer((_) async {});
    when(() => mockTestMode.successWithNoIcon(message: any(named: 'message'))).thenAnswer((_) async {});
    when(() => mockTestMode.showWithMessage(message: any(named: 'message'))).thenAnswer((_) async {});
    when(() => mockTestMode.showCustomOfflineMode()).thenAnswer((_) async {});
    when(() => mockTestMode.showWithIconForManageFolder(status: any(named: 'status'))).thenAnswer((_) async {});
    when(() => mockTestMode.showTextAndIcon(status: any(named: 'status'), assetPath: any(named: 'assetPath')))
        .thenAnswer((_) async {});
    when(() =>
            mockTestMode.showMessageAndCustomDuration(message: any(named: 'message'), duration: any(named: 'duration')))
        .thenAnswer((_) async {});
    when(() => mockTestMode.clearToast()).thenReturn(null);

    UChatLoading.testMode = mockTestMode;
  });

  tearDownAll(() {
    UChatLoading.testMode = null;
  });

  late GenerateDataForStressTestUseCase useCase;
  late MockLoggerService mockLoggerService;
  late MockContactLocalRepository mockContactLocalRepository;
  late MockChatRoomLocalRepository mockChatRoomLocalRepository;
  late MockRoomMemberLocalRepository mockRoomMemberLocalRepository;
  late MockMessageLocalRepository mockMessageLocalRepository;
  late MockContactsController mockContactsController;
  late MockMessageService mockMessageService;
  late UserEntity currentUser;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
    registerFallbackValue(FakeRoomEntity());
    registerFallbackValue(FakeRoomMemberEntity());
    registerFallbackValue(FakeRoomSubscriptionEntity());
    registerFallbackValue(FakeMessageEntity());
    registerFallbackValue([]); // For list parameters
    registerFallbackValue(NoParams());
    registerFallbackValue(RoomType.direct);
    registerFallbackValue(RoomAccessType.private);
    registerFallbackValue(RoomMemberRole.member);
    registerFallbackValue(MessageType.text);
    registerFallbackValue(DateTime.now());
    registerFallbackValue(ContactModel(
      id: 'any',
      displayName: 'any',
      username: 'any',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));
  });

  setUp(() {
    mockLoggerService = MockLoggerService();
    mockContactLocalRepository = MockContactLocalRepository();
    mockChatRoomLocalRepository = MockChatRoomLocalRepository();
    mockRoomMemberLocalRepository = MockRoomMemberLocalRepository();
    mockMessageLocalRepository = MockMessageLocalRepository();
    mockContactsController = MockContactsController();
    mockMessageService = MockMessageService();

    currentUser = UserEntity(
      id: 'current-user-id',
      displayName: 'Current User',
      username: 'currentuser',
    );

    useCase = GenerateDataForStressTestUseCase(
      log: mockLoggerService,
      currentUser: currentUser,
      contactLocalRepository: mockContactLocalRepository,
      chatRoomLocalRepository: mockChatRoomLocalRepository,
      roomMemberLocalRepository: mockRoomMemberLocalRepository,
      messageLocalRepository: mockMessageLocalRepository,
      contactsController: mockContactsController,
      messageService: mockMessageService,
    );

    // Stub common mock behaviors
    when(() => mockContactLocalRepository.putAllContact(any())).thenAnswer((_) async => 0);
    when(() => mockChatRoomLocalRepository.putAllRoom(any())).thenAnswer((_) async => 0);
    when(() => mockRoomMemberLocalRepository.putAllRoomMember(any())).thenAnswer((_) async => 0);
    when(() => mockChatRoomLocalRepository.putAllRoomSub(any())).thenAnswer((_) async => 0);
    when(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages'))).thenAnswer((_) async {});
    when(() => mockContactsController.initGroupListDataFromLocal()).thenAnswer((_) async {});
    when(() => mockContactsController.initFriendListDataFromLocal()).thenAnswer((_) async {});
    when(() => mockContactsController.initOAListDataFromLocal()).thenAnswer((_) async {});
    when(() => mockMessageService.generateMsgUid()).thenReturn(const Uuid().v4());
    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);

    // Stub repository methods for limit checking
    when(() => mockContactLocalRepository.getFriendContacts()).thenAnswer((_) async => []);
    when(() => mockContactLocalRepository.getOfficialContacts()).thenAnswer((_) async => []);
    when(() => mockChatRoomLocalRepository.getRoomTypeGroup()).thenAnswer((_) async => []);
  });

  group('GenerateDataForStressTestUseCase', () {
    test('Given no params, When call is invoked, Then it should generate and save data successfully', () async {
      // Given
      // All mocks are stubbed in setUp

      // When
      await useCase(NoParams());

      // Then
      verify(() => mockContactLocalRepository.getFriendContacts())
          .called(2); // Called twice: once for limit checking, once for indexing
      verify(() => mockContactLocalRepository.getOfficialContacts()).called(1);
      verify(() => mockChatRoomLocalRepository.getRoomTypeGroup()).called(2);
      verify(() => mockContactLocalRepository.putAllContact(any())).called(2);
      verify(() => mockChatRoomLocalRepository.putAllRoom(any())).called(greaterThan(0));
      verify(() => mockRoomMemberLocalRepository.putAllRoomMember(any())).called(greaterThan(0));
      verify(() => mockChatRoomLocalRepository.putAllRoomSub(any())).called(greaterThan(0));
      verify(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages'))).called(greaterThan(0));
      verify(() => mockContactsController.initGroupListDataFromLocal()).called(1);
      verify(() => mockContactsController.initFriendListDataFromLocal()).called(1);
      verify(() => mockContactsController.initOAListDataFromLocal()).called(1);
      verify(() => mockLoggerService.d(any())).called(greaterThan(0));
    });

    test(
        'Given an exception occurs during data generation, When call is invoked, Then it should log the error and rethrow',
        () async {
      // Given
      final exception = Exception('Test error');
      when(() => mockContactLocalRepository.putAllContact(any())).thenThrow(exception);

      // When
      await expectLater(
        () async => await useCase(NoParams()),
        throwsA(equals(exception)),
      );

      // Then
      verify(() => mockLoggerService.e('💥 Fatal error in stress test data generation: $exception', exception, any()))
          .called(1);
    });
  });
}
