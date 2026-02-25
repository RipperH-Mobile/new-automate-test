import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/account/delete_account.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/delete_account_use_case.dart';

// Mock classes
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

class MockUserDb extends Mock implements UserDb {}

class FakeDeleteAccountRequest extends Fake implements DeleteAccountRequest {}

void main() {
  late DeleteAccountUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;
  late MockUserDb mockUserDb;

  setUpAll(() {
    registerFallbackValue(FakeDeleteAccountRequest());
  });

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    mockUserDb = MockUserDb();
    useCase = DeleteAccountUseCase(
      authServerRepository: mockAuthServerRepository,
      userDb: mockUserDb,
    );
  });

  final tDeleteAccountRequest = DeleteAccountRequest(
    actionToken: 'test_action_token',
    isarId: 12345,
  );

  final tDeleteAccountRequestNullIsarId = DeleteAccountRequest(
    actionToken: 'test_action_token',
  );

  final tException = Exception('Something wrong');

  group('DeleteAccountUseCase', () {
    test('Given delete account successfully, When call is executed, Then completes successfully', () async {
      // Given
      when(() => mockUserDb.deleteUser(any())).thenAnswer((_) async {});
      when(() => mockAuthServerRepository.deleteAccount(any())).thenAnswer((_) async {});

      // When
      await useCase(tDeleteAccountRequest);

      // Then
      verify(() => mockAuthServerRepository.deleteAccount(tDeleteAccountRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test(
        'Given delete account successfully but still had data in local, When call is executed, Then completes successfully',
        () async {
      // Given
      when(() => mockAuthServerRepository.deleteAccount(any())).thenAnswer((_) async {});

      // When
      await useCase(tDeleteAccountRequestNullIsarId);

      // Then
      verifyNever(() => mockUserDb.deleteUser(any()));
      verify(() => mockAuthServerRepository.deleteAccount(tDeleteAccountRequestNullIsarId)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });

    test('Given AuthServerRepository throws an exception, When call is executed, Then throws the exception', () async {
      // Given
      when(() => mockUserDb.deleteUser(any())).thenAnswer((_) async {});
      when(() => mockAuthServerRepository.deleteAccount(any())).thenThrow(tException);

      // When
      final call = useCase(tDeleteAccountRequest);

      // Then
      await expectLater(call, throwsA(equals(tException)));
      verify(() => mockAuthServerRepository.deleteAccount(tDeleteAccountRequest)).called(1);
      verifyNoMoreInteractions(mockAuthServerRepository);
    });
  });
}
