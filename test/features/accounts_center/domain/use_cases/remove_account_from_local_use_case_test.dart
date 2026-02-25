import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/remove_account_from_local_use_case.dart';

class MockUserLocalRepository extends Mock implements UserLocalRepository {}

void main() {
  late RemoveAccountFromLocalUseCase useCase;
  late MockUserLocalRepository mockUserLocalRepository;

  setUp(() {
    mockUserLocalRepository = MockUserLocalRepository();
    useCase = RemoveAccountFromLocalUseCase(userLocalRepository: mockUserLocalRepository);
    reset(mockUserLocalRepository);
  });

  test(
    'Given a valid accountId, When call is invoked, Then deleteUserById is called with correct id and completes',
    () async {
      // Given
      const accountId = 'test_account_id';
      final params = RemoveAccountFromLocalParams(accountId: accountId);
      when(() => mockUserLocalRepository.deleteUserById(accountId)).thenAnswer((_) async {});

      // When
      final call = useCase.call(params);

      // Then
      await expectLater(call, completes);
      verify(() => mockUserLocalRepository.deleteUserById(accountId)).called(1);
      verifyNoMoreInteractions(mockUserLocalRepository);
    },
  );

  test(
    'Given deleteUserById throws, When call is invoked, Then the exception is propagated',
    () async {
      // Given
      const accountId = 'error_account_id';
      final params = RemoveAccountFromLocalParams(accountId: accountId);
      when(() => mockUserLocalRepository.deleteUserById(accountId)).thenThrow(Exception('delete error'));

      // When
      final call = useCase.call(params);

      // Then
      await expectLater(call, throwsA(isA<Exception>()));
      verify(() => mockUserLocalRepository.deleteUserById(accountId)).called(1);
      verifyNoMoreInteractions(mockUserLocalRepository);
    },
  );
}
