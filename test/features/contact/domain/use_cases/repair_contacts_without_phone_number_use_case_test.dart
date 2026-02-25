import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/repair_contacts_without_phone_number_use_case.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

class MockProfileServerRepository extends Mock implements ProfileServerRepository {}

class MockLoggerService extends Mock implements LoggerService {}

class FakeContactEntity extends Fake implements ContactEntity {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

class FakeAccountSettingsModel extends Fake implements AccountSettingsModel {}

void main() {
  group('RepairContactsWithoutPhoneNumberUseCase', () {
    late RepairContactsWithoutPhoneNumberUseCase useCase;
    late MockContactLocalRepository mockContactLocalRepository;
    late MockProfileServerRepository mockProfileServerRepository;
    late MockLoggerService mockLoggerService;

    // Test data
    late ContactEntity testContactWithoutPhone;
    late ProfileEntity testProfile;
    late List<ContactEntity> emptyContactsList;
    late List<ContactEntity> contactsWithoutPhoneList;

    setUpAll(() {
      // Register fallback values for custom types used with any() or captureAny()
      registerFallbackValue(FakeContactEntity());
      registerFallbackValue(FakeProfileEntity());
      registerFallbackValue(FakeAccountSettingsModel());
      registerFallbackValue(OnlineStatus.offline);
    });

    setUp(() {
      mockContactLocalRepository = MockContactLocalRepository();
      mockProfileServerRepository = MockProfileServerRepository();
      mockLoggerService = MockLoggerService();

      useCase = RepairContactsWithoutPhoneNumberUseCase(
        contactLocalRepository: mockContactLocalRepository,
        profileServerRepository: mockProfileServerRepository,
        log: mockLoggerService,
      );

      // Initialize test data
      testContactWithoutPhone = ContactEntity(
        id: 'contact1',
        displayName: 'Test Contact',
        username: 'testcontact',
        phoneNumber: null, // This is the key condition for repair
        onlineStatus: OnlineStatus.offline,
        settings: AccountSettingsModel(),
      );


      testProfile = ProfileEntity(
        id: 'contact1',
        username: 'testcontact',
        phoneNumber: '+1234567890',
        displayName: 'Test Contact Updated',
        statusMessage: 'Updated status',
        avatarId: 'avatar123',
        onlineStatus: OnlineStatus.online,
        settings: AccountSettingsModel(),
        isFriend: true,
        friendNickname: 'Buddy',
      );

      emptyContactsList = [];
      contactsWithoutPhoneList = [testContactWithoutPhone];

      // Reset mocks before each test
      reset(mockContactLocalRepository);
      reset(mockProfileServerRepository);
      reset(mockLoggerService);
    });

    test('Given contacts without phone numbers, When use case is called, Then repairs contacts with profile data', () async {
      // Given
      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenAnswer((_) async => contactsWithoutPhoneList);
      
      when(() => mockProfileServerRepository.getProfile('contact1'))
          .thenAnswer((_) async => testProfile);
      
      when(() => mockContactLocalRepository.putAllContact(any()))
          .thenAnswer((_) async => 0);

      // When
      await useCase();

      // Then
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      verify(() => mockProfileServerRepository.getProfile('contact1')).called(1);
      
      // Verify updated contact was passed to putAllContact
      final capturedContacts = verify(() => mockContactLocalRepository.putAllContact(captureAny())).captured.first as List<ContactEntity>;
      expect(capturedContacts.length, 1);
      
      final updatedContact = capturedContacts.first;
      expect(updatedContact.id, equals(testProfile.id));
      expect(updatedContact.username, equals(testProfile.username));
      expect(updatedContact.phoneNumber, equals(testProfile.phoneNumber));
      expect(updatedContact.displayName, equals(testProfile.displayName));
      expect(updatedContact.originalStatusMessage, equals(testProfile.statusMessage));
      expect(updatedContact.avatarId, equals(testProfile.avatarId));
      expect(updatedContact.onlineStatus, equals(testProfile.onlineStatus));
      expect(updatedContact.settings, equals(testProfile.settings));
      expect(updatedContact.nickname, equals(testProfile.friendNickname));
      
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });

    test('Given empty contacts list, When use case is called, Then returns early without calling putAllContact', () async {
      // Given
      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenAnswer((_) async => emptyContactsList);

      // When
      await useCase();

      // Then
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      verifyNever(() => mockProfileServerRepository.getProfile(any()));
      verifyNever(() => mockContactLocalRepository.putAllContact(any()));
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });

    test('Given multiple contacts without phone numbers, When use case is called, Then repairs all contacts', () async {
      // Given
      final contact2WithoutPhone = ContactEntity(
        id: 'contact2',
        displayName: 'Test Contact 2',
        username: 'testcontact2',
        phoneNumber: null,
        onlineStatus: OnlineStatus.offline,
        settings: AccountSettingsModel(),
      );

      final profile2 = ProfileEntity(
        id: 'contact2',
        username: 'testcontact2',
        phoneNumber: '+0987654321',
        displayName: 'Test Contact 2 Updated',
        statusMessage: 'Status 2',
        avatarId: 'avatar456',
        onlineStatus: OnlineStatus.busy,
        settings: AccountSettingsModel(),
        isFriend: false,
        friendNickname: null,
      );

      final multipleContacts = [testContactWithoutPhone, contact2WithoutPhone];

      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenAnswer((_) async => multipleContacts);
      
      when(() => mockProfileServerRepository.getProfile('contact1'))
          .thenAnswer((_) async => testProfile);
      
      when(() => mockProfileServerRepository.getProfile('contact2'))
          .thenAnswer((_) async => profile2);
      
      when(() => mockContactLocalRepository.putAllContact(any()))
          .thenAnswer((_) async => 0);

      // When
      await useCase();

      // Then
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      verify(() => mockProfileServerRepository.getProfile('contact1')).called(1);
      verify(() => mockProfileServerRepository.getProfile('contact2')).called(1);
      
      // Verify both updated contacts were passed to putAllContact
      final capturedContacts = verify(() => mockContactLocalRepository.putAllContact(captureAny())).captured.first as List<ContactEntity>;
      expect(capturedContacts.length, 2);
      
      // Verify first contact was updated correctly
      final updatedContact1 = capturedContacts.firstWhere((c) => c.id == 'contact1');
      expect(updatedContact1.phoneNumber, equals(testProfile.phoneNumber));
      expect(updatedContact1.displayName, equals(testProfile.displayName));
      
      // Verify second contact was updated correctly
      final updatedContact2 = capturedContacts.firstWhere((c) => c.id == 'contact2');
      expect(updatedContact2.phoneNumber, equals(profile2.phoneNumber));
      expect(updatedContact2.displayName, equals(profile2.displayName));
      
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });

    test('Given contact with null ID, When use case is called, Then handles gracefully', () async {
      // Given
      final contactWithNullId = ContactEntity(
        id: null, // Null ID
        displayName: 'Test Contact',
        username: 'testcontact',
        phoneNumber: null,
        onlineStatus: OnlineStatus.offline,
        settings: AccountSettingsModel(),
      );

      final contactsWithNullId = [contactWithNullId];

      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenAnswer((_) async => contactsWithNullId);
      
      when(() => mockProfileServerRepository.getProfile(''))
          .thenAnswer((_) async => testProfile);
      
      when(() => mockContactLocalRepository.putAllContact(any()))
          .thenAnswer((_) async => 0);

      // When
      await useCase();

      // Then
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      verify(() => mockProfileServerRepository.getProfile('')).called(1);
      
      final capturedContacts = verify(() => mockContactLocalRepository.putAllContact(captureAny())).captured.first as List<ContactEntity>;
      expect(capturedContacts.length, 1);
      
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });

    test('Given getContactsWithoutPhoneNumber throws exception, When use case is called, Then propagates exception', () async {
      // Given
      final testException = Exception('Database error');
      
      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenThrow(testException);

      // When & Then
      expect(() async => await useCase(), throwsA(isA<Exception>()));
      
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      verifyNever(() => mockProfileServerRepository.getProfile(any()));
      verifyNever(() => mockContactLocalRepository.putAllContact(any()));
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });

    test('Given getProfile throws exception, When use case is called, Then logs warning and continues with other contacts', () async {
      // Given
      final testException = Exception('Network error');
      
      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenAnswer((_) async => contactsWithoutPhoneList);
      
      when(() => mockProfileServerRepository.getProfile('contact1'))
          .thenThrow(testException);

      // When
      await useCase();

      // Then
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      verify(() => mockProfileServerRepository.getProfile('contact1')).called(1);
      verifyNever(() => mockContactLocalRepository.putAllContact(any()));
      
      // Verify warning was logged (not error)
      verify(() => mockLoggerService.w('Failed to repair contact with id: ${testContactWithoutPhone.id}', testException, any())).called(1);
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });

    test('Given putAllContact throws exception, When use case is called, Then propagates exception', () async {
      // Given
      final testException = Exception('Save error');
      
      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenAnswer((_) async => contactsWithoutPhoneList);
      
      when(() => mockProfileServerRepository.getProfile('contact1'))
          .thenAnswer((_) async => testProfile);
      
      when(() => mockContactLocalRepository.putAllContact(any()))
          .thenThrow(testException);

      // When & Then
      expect(() async => await useCase(), throwsA(isA<Exception>()));
      
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      
      // Note: We can't verify putAllContact or getProfile calls because the exception prevents verification
      // but we know they were called because the exception was thrown from putAllContact
      
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });

    test('Given profile has null values, When use case is called, Then copies available values only', () async {
      // Given
      final profileWithNulls = ProfileEntity(
        id: 'contact1',
        username: 'testcontact',
        phoneNumber: '+1234567890',
        displayName: 'Test Contact',
        statusMessage: null, // Null status message
        avatarId: null, // Null avatar ID
        onlineStatus: OnlineStatus.offline,
        settings: AccountSettingsModel(),
        isFriend: false,
        friendNickname: null, // Null nickname
      );

      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenAnswer((_) async => contactsWithoutPhoneList);
      
      when(() => mockProfileServerRepository.getProfile('contact1'))
          .thenAnswer((_) async => profileWithNulls);
      
      when(() => mockContactLocalRepository.putAllContact(any()))
          .thenAnswer((_) async => 0);

      // When
      await useCase();

      // Then
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      verify(() => mockProfileServerRepository.getProfile('contact1')).called(1);
      
      final capturedContacts = verify(() => mockContactLocalRepository.putAllContact(captureAny())).captured.first as List<ContactEntity>;
      expect(capturedContacts.length, 1);
      
      final updatedContact = capturedContacts.first;
      expect(updatedContact.id, equals(profileWithNulls.id));
      expect(updatedContact.username, equals(profileWithNulls.username));
      expect(updatedContact.phoneNumber, equals(profileWithNulls.phoneNumber));
      expect(updatedContact.displayName, equals(profileWithNulls.displayName));
      expect(updatedContact.originalStatusMessage, equals(profileWithNulls.statusMessage)); // Should be null
      expect(updatedContact.avatarId, equals(profileWithNulls.avatarId)); // Should be null
      expect(updatedContact.onlineStatus, equals(profileWithNulls.onlineStatus));
      expect(updatedContact.settings, equals(profileWithNulls.settings));
      expect(updatedContact.nickname, equals(profileWithNulls.friendNickname)); // Should be null
      
      verifyNever(() => mockLoggerService.w(any(), any(), any()));
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });

    test('Given multiple contacts where some fail to repair, When use case is called, Then repairs successful contacts and logs warnings for failures', () async {
      // Given
      final contact2WithoutPhone = ContactEntity(
        id: 'contact2',
        displayName: 'Test Contact 2',
        username: 'testcontact2',
        phoneNumber: null,
        onlineStatus: OnlineStatus.offline,
        settings: AccountSettingsModel(),
      );

      final multipleContacts = [testContactWithoutPhone, contact2WithoutPhone];
      final networkException = Exception('Network timeout');

      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenAnswer((_) async => multipleContacts);
      
      // First contact succeeds, second fails
      when(() => mockProfileServerRepository.getProfile('contact1'))
          .thenAnswer((_) async => testProfile);
      when(() => mockProfileServerRepository.getProfile('contact2'))
          .thenThrow(networkException);
      
      when(() => mockContactLocalRepository.putAllContact(any()))
          .thenAnswer((_) async => 0);

      // When
      await useCase();

      // Then
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      verify(() => mockProfileServerRepository.getProfile('contact1')).called(1);
      verify(() => mockProfileServerRepository.getProfile('contact2')).called(1);
      
      // Verify only successful contact was passed to putAllContact
      final capturedContacts = verify(() => mockContactLocalRepository.putAllContact(captureAny())).captured.first as List<ContactEntity>;
      expect(capturedContacts.length, 1);
      expect(capturedContacts.first.id, equals('contact1'));
      
      // Verify warning was logged for failed contact
      verify(() => mockLoggerService.w('Failed to repair contact with id: contact2', networkException, any())).called(1);
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });

    test('Given all contacts fail to repair, When use case is called, Then logs warnings for all and updates none', () async {
      // Given
      final contact2WithoutPhone = ContactEntity(
        id: 'contact2',
        displayName: 'Test Contact 2',
        username: 'testcontact2',
        phoneNumber: null,
        onlineStatus: OnlineStatus.offline,
        settings: AccountSettingsModel(),
      );

      final multipleContacts = [testContactWithoutPhone, contact2WithoutPhone];
      final exception1 = Exception('Network error 1');
      final exception2 = Exception('Network error 2');

      when(() => mockContactLocalRepository.getContactsWithoutPhoneNumber())
          .thenAnswer((_) async => multipleContacts);
      
      // Both contacts fail
      when(() => mockProfileServerRepository.getProfile('contact1'))
          .thenThrow(exception1);
      when(() => mockProfileServerRepository.getProfile('contact2'))
          .thenThrow(exception2);

      // When
      await useCase();

      // Then
      verify(() => mockContactLocalRepository.getContactsWithoutPhoneNumber()).called(1);
      verify(() => mockProfileServerRepository.getProfile('contact1')).called(1);
      verify(() => mockProfileServerRepository.getProfile('contact2')).called(1);
      
      // Verify putAllContact was never called since no contacts were successfully repaired
      verifyNever(() => mockContactLocalRepository.putAllContact(any()));
      
      // Verify warnings were logged for both failed contacts
      verify(() => mockLoggerService.w('Failed to repair contact with id: ${testContactWithoutPhone.id}', exception1, any())).called(1);
      verify(() => mockLoggerService.w('Failed to repair contact with id: contact2', exception2, any())).called(1);
      verifyNever(() => mockLoggerService.e(any(), any(), any()));
    });
  });
}