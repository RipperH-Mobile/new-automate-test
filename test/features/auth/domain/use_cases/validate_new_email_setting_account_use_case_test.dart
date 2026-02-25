import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_email_setting_account_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_new_email_setting_account_use_case.dart';

// Mock Definitions
class MockAuthServerRepository extends Mock implements AuthServerRepository {}

void main() {
  late ValidateNewEmailSettingAccountUseCase useCase;
  late MockAuthServerRepository mockAuthServerRepository;

  setUp(() {
    mockAuthServerRepository = MockAuthServerRepository();
    useCase = ValidateNewEmailSettingAccountUseCase(authServerRepository: mockAuthServerRepository);
    reset(mockAuthServerRepository); // Reset mock before each test
  });

  final tRequest = ValidateNewEmailSettingAccountRequest(
    newEmail: 'test@example.com',
  );

  test(
      'Given repository completes successfully, When ValidateNewEmailSettingAccountUseCase is called, Then completes without error',
      () async {
    // Given
    when(() => mockAuthServerRepository.validateNewEmailSettingAccount(tRequest)).thenAnswer((_) async {});

    // When
    final call = useCase.call(tRequest);

    // Then
    await expectLater(call, completes);
    verify(() => mockAuthServerRepository.validateNewEmailSettingAccount(tRequest)).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });

  test(
      'Given repository throws an exception, When ValidateNewEmailSettingAccountUseCase is called, Then throws the same exception',
      () async {
    // Given
    final tException = Exception('Server error');
    when(() => mockAuthServerRepository.validateNewEmailSettingAccount(tRequest)).thenThrow(tException);

    // When
    final call = useCase.call(tRequest);

    // Then
    await expectLater(call, throwsA(equals(tException)));
    verify(() => mockAuthServerRepository.validateNewEmailSettingAccount(tRequest)).called(1);
    verifyNoMoreInteractions(mockAuthServerRepository);
  });
}
