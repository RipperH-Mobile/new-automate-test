import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_account_from_member_response.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/get_contact_name_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_name_use_case.dart';

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

void main() {
  late GetContactNameUseCase useCase;
  late MockContactLocalRepository mockContactRepository;
  late MockChatRoomLocalRepository mockChatRoomRepository;

  setUpAll(() {
    // Register fallback value for GetAccountFromMemberRequest
    registerFallbackValue(GetAccountFromMemberRequest(
      roomId: 'fallback-room-id',
      accountId: 'fallback-account-id',
    ));
  });

  setUp(() {
    mockContactRepository = MockContactLocalRepository();
    mockChatRoomRepository = MockChatRoomLocalRepository();
    useCase = GetContactNameUseCase(
      contactLocalRepository: mockContactRepository,
      chatRoomLocalRepository: mockChatRoomRepository,
    );
  });

  group('GetContactNameUseCase', () {
    const accountId = 'test-account-id';
    const roomId = 'test-room-id';

    final mockContact = ContactEntity(
      id: accountId,
      nickname: 'John',
      displayName: 'John Doe',
    );

    final mockRoomMember = RoomMemberEntity(
      roomId: roomId,
      roomType: RoomType.group,
      account: ContactModel(
        id: accountId,
        nickname: 'Jane',
        displayName: 'Jane Smith',
      ),
    );

    group('when contact is found in contact repository', () {
      test('should return nickname when isShowFullName is true and nickname exists', () {
        // Arrange
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: true,
        );
        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(mockContact);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('John')); // nickname takes priority over displayName
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verifyNever(() => mockChatRoomRepository.getOneMemberInRoomSync(any()));
      });

      test('should return shortNickname when isShowFullName is false and nickname exists', () {
        // Arrange
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: false,
        );
        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(mockContact);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('John')); // shortNickname returns full nickname since it's short
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verifyNever(() => mockChatRoomRepository.getOneMemberInRoomSync(any()));
      });

      test('should return truncated shortNickname when nickname is long', () {
        // Arrange
        final contactWithLongNickname = ContactEntity(
          id: accountId,
          nickname: 'VeryLongNicknameHere', // 19 characters > 15
          displayName: 'John Doe',
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: false,
        );
        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(contactWithLongNickname);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('VeryLongNi...')); // shortNickname truncated to 10 chars + ...
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verifyNever(() => mockChatRoomRepository.getOneMemberInRoomSync(any()));
      });

      test('should return displayName when isShowFullName is true and nickname is null', () {
        // Arrange
        final contactWithoutNickname = ContactEntity(
          id: accountId,
          nickname: null,
          displayName: 'John Doe',
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: true,
        );
        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(contactWithoutNickname);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('John Doe')); // fallback to displayName
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verifyNever(() => mockChatRoomRepository.getOneMemberInRoomSync(any()));
      });

      test('should return shortDisplayName when isShowFullName is false and nickname is null', () {
        // Arrange
        final contactWithoutNickname = ContactEntity(
          id: accountId,
          nickname: null,
          displayName: 'John Doe',
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: false,
        );
        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(contactWithoutNickname);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('John Doe')); // shortDisplayName returns full displayName since it's short
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verifyNever(() => mockChatRoomRepository.getOneMemberInRoomSync(any()));
      });

      test('should return truncated shortDisplayName when displayName is long and nickname is null', () {
        // Arrange
        final contactWithLongDisplayName = ContactEntity(
          id: accountId,
          nickname: null,
          displayName: 'Very Long Display Name Here', // 27 characters > 15
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: false,
        );
        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(contactWithLongDisplayName);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('Very Long ...')); // shortDisplayName truncated to 10 chars + ...
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verifyNever(() => mockChatRoomRepository.getOneMemberInRoomSync(any()));
      });

      test('should return displayName when isShowFullName is true and nickname is empty', () {
        // Arrange
        final contactWithEmptyNickname = ContactEntity(
          id: accountId,
          nickname: '',
          displayName: 'John Doe',
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: true,
        );
        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(contactWithEmptyNickname);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('John Doe')); // fallback to displayName when nickname is empty
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verifyNever(() => mockChatRoomRepository.getOneMemberInRoomSync(any()));
      });

      test('should return shortDisplayName when isShowFullName is false and nickname is empty', () {
        // Arrange
        final contactWithEmptyNickname = ContactEntity(
          id: accountId,
          nickname: '',
          displayName: 'John Doe',
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: false,
        );
        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(contactWithEmptyNickname);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('John Doe')); // shortDisplayName returns full displayName since it's short
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verifyNever(() => mockChatRoomRepository.getOneMemberInRoomSync(any()));
      });
    });

    group('when contact is not found in contact repository', () {
      setUp(() {
        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(null);
      });

      test('should return room member nickname when isShowFullName is true', () {
        // Arrange
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: true,
        );
        when(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).thenReturn(mockRoomMember);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('Jane')); // room member's nickname
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verify(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).called(1);
      });

      test('should return room member shortNickname when isShowFullName is false', () {
        // Arrange
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: false,
        );
        when(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).thenReturn(mockRoomMember);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('Jane')); // room member's shortNickname (full nickname since it's short)
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verify(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).called(1);
      });

      test('should return room member shortDisplayName when nickname is null and isShowFullName is false', () {
        // Arrange
        final roomMemberWithoutNickname = RoomMemberEntity(
          roomId: roomId,
          roomType: RoomType.group,
          account: ContactModel(
            id: accountId,
            nickname: null,
            displayName: 'Jane Smith',
          ),
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: false,
        );
        when(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).thenReturn(roomMemberWithoutNickname);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('Jane Smith')); // room member's shortDisplayName
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verify(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).called(1);
      });

      test('should return null when both contact and room member are not found', () {
        // Arrange
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: true,
        );
        when(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).thenReturn(null);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, isNull);
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verify(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).called(1);
      });
    });

    group('when contact has null/empty name properties', () {
      test('should fallback to room member when contact name is null', () {
        // Arrange
        final contactWithNullName = ContactEntity(
          id: accountId,
          nickname: null,
          displayName: null,
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: true,
        );

        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(contactWithNullName);
        when(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).thenReturn(mockRoomMember);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('Jane')); // fallback to room member's nickname
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verify(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).called(1);
      });

      test('should fallback to room member when contact shortName is empty', () {
        // Arrange
        final contactWithEmptyShortName = ContactEntity(
          id: accountId,
          nickname: null, // shortNickname will return ''
          displayName: null, // shortDisplayName will return ''
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: false,
        );

        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(contactWithEmptyShortName);
        when(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).thenReturn(mockRoomMember);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('Jane')); // fallback to room member's shortNickname
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verify(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).called(1);
      });

      test('should fallback to room member when contact has empty nickname and null displayName', () {
        // Arrange
        final contactWithEmptyNicknameNullDisplay = ContactEntity(
          id: accountId,
          nickname: '', // shortNickname will return ''
          displayName: null, // shortDisplayName will return ''
        );
        final params = const ContactNameParams(
          accountId: accountId,
          roomId: roomId,
          isShowFullName: false,
        );

        when(() => mockContactRepository.getContactSync(accountId)).thenReturn(contactWithEmptyNicknameNullDisplay);
        when(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).thenReturn(mockRoomMember);

        // Act
        final result = useCase(params);

        // Assert
        expect(result, equals('Jane')); // fallback to room member's shortNickname
        verify(() => mockContactRepository.getContactSync(accountId)).called(1);
        verify(() => mockChatRoomRepository.getOneMemberInRoomSync(any())).called(1);
      });
    });
  });
}
